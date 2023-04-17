# Activate antigen package manager for zsh plugins

for file in ~/.zshrc.d/*/*.zsh;
do
  #echo "~> load $file"
  source $file
  #echo "~> loaded $file"
done
# Done.
