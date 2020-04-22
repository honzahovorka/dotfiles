#!/bin/sh
backup=~/.dotfiles_backup/$(date +%m%d%H%M%Y%S)
mkdir -p $backup
echo "syncing .dotfiles"
for file in $(ls -a | grep '^\.\w')
do
  mv ~/$file $backup 2>/dev/null
  echo " $file"
  ln -s $(pwd)/$file ~
  rm -rf ~/.git
  rm -f ~/LICENSE
done

echo " "
echo "syncing ~/.config folders"
for folder in nvim fish omf vifm alacritty
do
  mv ~/.config/$folder $backup 2>/dev/null
  echo " $folder"
  ln -s $(pwd)/$folder ~/.config/$folder
done
