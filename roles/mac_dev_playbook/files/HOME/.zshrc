
# List files to source
files=($(find ~/.zshrc.d -name '*.zsh'))

# Fonction pour extraire le nom de fichier
basename_with_path() {
  local fullpath="$1"
  echo "$(basename "$fullpath")|$fullpath"
}

# Create a list of file pairs (basename|fullpath)
file_pairs=()
for file in "${files[@]}"; do
  file_pairs+=($(basename_with_path "$file"))
done

# Sort the file pairs
sorted_file_pairs=($(for pair in "${file_pairs[@]}"; do
  echo "$pair"
done | sort))

# Extract the sorted files
sorted_files=()
for pair in "${sorted_file_pairs[@]}"; do
  sorted_files+=("${pair#*|}")
done

# Source the files
for file in "${sorted_files[@]}"; do
  # echo "Sourcing $file"
  source "$file"
  #echo "PATH value after sourcing $file: $PATH"
  #echo "Done"
  #echo
done
