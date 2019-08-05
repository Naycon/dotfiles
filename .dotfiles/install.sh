#!/usr/bin/env bash

# directory variables
dotfilesGitDir=".dotfiles"
backupDir="dotfiles-backup"

# go home
cd $HOME

# do a bare clone to avoid overwriting existing config files
git clone --bare git@github.com:Naycon/dotfiles.git $HOME/$dotfilesGitDir

# function to run git with home dire as working tree but using the correct git dir
function config {
  git --git-dir=$HOME/$dotfilesGitDir/ --work-tree=$HOME $@
}

# try checking out the config
echo "Checking out dotfiles..."
config checkout
if [ $? = 0 ]; then
  echo "Dotfiles successfully added!"
else
  echo "Backing up existing dotfiles to '$backupDir'..."
  mkdir -p $backupDir
  config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} $backupDir/{}
  echo "Backup complete."
  
  config checkout
  
  if [ $? = 0 ]; then
    echo "Dotfiles successfully added!"
  else
    echo "Checkout failed. Please check above for errors."
    exit 1
  fi;
fi;

echo "Configuring git..."
config config status.showUntrackedFiles no

echo "All done."
