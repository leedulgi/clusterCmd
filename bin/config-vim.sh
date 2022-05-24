cd $(dirname $0) 
pwd

echo copy .vimrc
bash ../cltls cp vimrc.default ~/.vimrc
echo done
echo copy .vim
bash ../cltls cp ~/.vim

echo done



