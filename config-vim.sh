#. nodes.sh
rFileExist=''

for node in $target_nodes; do
  echo $node
  
  rFileExist=$(ssh [[ -f .vimrc ]] && echo "t" || echo "f")
  scp vimrc.default $target_user@$node:~/.vimrc
  if [[ ! -d ~/.vim ]]; then
    scp -r ~/.vim $target_user@$node:~
  fi
done


