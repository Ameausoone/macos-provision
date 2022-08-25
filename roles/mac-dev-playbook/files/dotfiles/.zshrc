# Activate antigen package manager for zsh plugins
source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

antigen init ~/.antigenrc

antigen apply

for file in ~/.zshrc.d/*.sh;
do
  #echo "~> load $file"
  source $file
  #echo "~> loaded $file"
done

# Done.
antigen apply
