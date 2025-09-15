
# Find all .zsh files in ~/.zshrc.d directory and subdirectories
files=($(find ~/.zshrc.d -name '*.zsh'))

# Helper function to extract basename with full path for sorting
basename_with_path() {
  local fullpath="$1"
  echo "$(basename "$fullpath")|$fullpath"
}

# Create file pairs (basename|fullpath) to enable sorting by filename only
# This ensures proper load order regardless of subdirectory structure
file_pairs=()
for file in "${files[@]}"; do
  file_pairs+=($(basename_with_path "$file"))
done

# Sort file pairs alphabetically by basename (e.g., 00_antigen.zsh, 01_oh-my-zsh-plugins.zsh)
sorted_file_pairs=($(for pair in "${file_pairs[@]}"; do
  echo "$pair"
done | sort))

# Extract full paths from sorted pairs
sorted_files=()
for pair in "${sorted_file_pairs[@]}"; do
  sorted_files+=("${pair#*|}")
done

# Source files in alphabetical order by filename
for file in "${sorted_files[@]}"; do
  source "$file"
done
