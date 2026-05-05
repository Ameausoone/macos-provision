#!/usr/bin/env python3
"""
Starship custom module: GitHub PR / branch hyperlink.

Shows:
  - [#N]  → OSC 8 hyperlink to the open PR  (if one exists)
  - branch name → OSC 8 hyperlink to the branch on GitHub (no PR)
  - repo name   → OSC 8 hyperlink to the repo  (main / master, no PR)

Cache: ~/.starship/github_pr_cache/<hash>  TTL=120s, atomic writes, flock.
"""

import fcntl
import hashlib
import json
import os
import subprocess
import sys
import tempfile
import time
import urllib.parse
from pathlib import Path

TTL = 120  # seconds


# ── OSC 8 hyperlink ──────────────────────────────────────────────────────────

def hyperlink(url: str, text: str) -> str:
    return f"\033]8;;{url}\033\\{text}\033]8;;\033\\"


# ── Git helpers ──────────────────────────────────────────────────────────────

def git(*args) -> str | None:
    try:
        return subprocess.check_output(
            ["git", *args], stderr=subprocess.DEVNULL, text=True
        ).strip()
    except subprocess.CalledProcessError:
        return None


def gh(*args) -> dict | str | None:
    try:
        raw = subprocess.check_output(
            ["gh", *args], stderr=subprocess.DEVNULL, text=True
        ).strip()
        return json.loads(raw) if raw.startswith(("{", "[")) else raw or None
    except (subprocess.CalledProcessError, json.JSONDecodeError):
        return None


# ── Cache ────────────────────────────────────────────────────────────────────

def cache_path(remote: str, branch: str) -> Path:
    key = hashlib.md5(f"{remote}|{branch}".encode()).hexdigest()
    cache_dir = Path.home() / ".starship" / "github_pr_cache"
    cache_dir.mkdir(parents=True, exist_ok=True)
    return cache_dir / key


def read_cache(path: Path) -> str | None:
    try:
        if time.time() - path.stat().st_mtime < TTL:
            return path.read_text()
    except OSError:
        pass
    return None


def write_cache_atomic(path: Path, content: str) -> None:
    tmp = tempfile.NamedTemporaryFile(
        mode="w", dir=path.parent, delete=False, suffix=".tmp"
    )
    try:
        tmp.write(content)
        tmp.flush()
        os.fsync(tmp.fileno())
        tmp.close()
        os.replace(tmp.name, path)  # atomic on POSIX
    except Exception:
        tmp.close()
        Path(tmp.name).unlink(missing_ok=True)


# ── Core logic ───────────────────────────────────────────────────────────────

def compute_output(branch: str) -> str:
    repo_data = gh("repo", "view", "--json", "url,name")
    if not isinstance(repo_data, dict):
        return ""

    repo_url = repo_data.get("url", "")
    if not repo_url:
        return ""

    pr_data = gh("pr", "view", "--json", "number,url")
    if isinstance(pr_data, dict) and pr_data.get("number"):
        return hyperlink(pr_data["url"], f"[#{pr_data['number']}]")

    if branch in ("main", "master"):
        return hyperlink(repo_url, branch)

    encoded = urllib.parse.quote(branch, safe="/")
    return hyperlink(f"{repo_url}/tree/{encoded}", branch)


def main() -> None:
    remote = git("remote", "get-url", "origin")
    if not remote or "github.com" not in remote:
        sys.exit(0)

    branch = git("rev-parse", "--abbrev-ref", "HEAD")
    if not branch or branch == "HEAD":  # detached HEAD
        sys.exit(0)

    cache = cache_path(remote, branch)
    cached = read_cache(cache)
    if cached is not None:
        print(cached, end="")
        sys.exit(0)

    # Acquire lock (non-blocking) — skip background refresh if already running
    lock_path = cache.with_suffix(".lock")
    try:
        lock_fd = open(lock_path, "w")
        fcntl.flock(lock_fd, fcntl.LOCK_EX | fcntl.LOCK_NB)
    except OSError:
        # Another process is already refreshing; show stale cache if available
        if cache.exists():
            print(cache.read_text(), end="")
        sys.exit(0)

    # Fork background refresh so the prompt is never blocked
    pid = os.fork()
    if pid == 0:
        # Child: do the slow gh calls, write cache, release lock
        try:
            result = compute_output(branch)
            write_cache_atomic(cache, result)
        finally:
            fcntl.flock(lock_fd, fcntl.LOCK_UN)
            lock_fd.close()
            lock_path.unlink(missing_ok=True)
        os._exit(0)
    else:
        # Parent: release lock handle (child owns it), show stale/empty
        lock_fd.close()
        if cache.exists():
            print(cache.read_text(), end="")
        sys.exit(0)


if __name__ == "__main__":
    main()
