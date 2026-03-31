#!/usr/bin/env python3
import json, sys, subprocess, re, os
from concurrent.futures import ThreadPoolExecutor

data = json.load(sys.stdin)
model = data["model"]["display_name"]
cwd = data.get("workspace", {}).get("current_dir", "")
pct = int(data.get("context_window", {}).get("used_percentage", 0) or 0)
cost = data.get("cost", {}).get("total_cost_usd", 0) or 0
duration_ms = data.get("cost", {}).get("total_duration_ms", 0) or 0

CYAN, YELLOW, GREEN, RED, RESET = "\033[36m", "\033[33m", "\033[32m", "\033[31m", "\033[0m"

def get_branch():
    try:
        return subprocess.check_output(
            ["git", "-C", cwd, "--no-optional-locks", "rev-parse", "--abbrev-ref", "HEAD"],
            stderr=subprocess.DEVNULL, text=True, timeout=2
        ).strip()
    except Exception:
        return ""

def get_remote():
    try:
        return subprocess.check_output(
            ["git", "-C", cwd, "--no-optional-locks", "remote", "get-url", "origin"],
            stderr=subprocess.DEVNULL, text=True, timeout=2
        ).strip()
    except Exception:
        return ""

with ThreadPoolExecutor(max_workers=2) as ex:
    f_branch = ex.submit(get_branch)
    f_remote = ex.submit(get_remote)
    branch = f_branch.result()
    raw_remote = f_remote.result()

# Clickable repo link via OSC 8
if raw_remote:
    remote = re.sub(r"^git@github\.com:", "https://github.com/", raw_remote)
    remote = re.sub(r"\.git$", "", remote)
    repo_name = remote.split("/")[-1]
    project = f"\033]8;;{remote}\a{repo_name}\033]8;;\a"
else:
    project = os.path.basename(cwd) if cwd else ""

# Context bar
bar_color = RED if pct >= 90 else YELLOW if pct >= 70 else GREEN
filled = pct // 10
bar = f"{bar_color}{'█' * filled}{'░' * (10 - filled)}{RESET} {pct}%"

# Duration
mins, secs = duration_ms // 60000, (duration_ms % 60000) // 1000
duration = f"{mins}m{secs:02d}s" if mins else f"{secs}s"

parts = [f"{CYAN}{model}{RESET}", project]
if branch:
    parts.append(f"{CYAN}{branch}{RESET}")
parts += [bar, f"{YELLOW}${cost:.3f}{RESET}", duration]

print(" | ".join(parts))
