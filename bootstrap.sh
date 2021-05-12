dotfiles=$(pwd)/dotfiles

function list_dotfile_contents {
    find $dotfiles -type $1 -printf '%P\n'
}

for subdir in $(list_dotfile_contents d)
do
    mkdir -p $HOME/$subdir
done

for filename in $(list_dotfile_contents f)
do
    dotfile=$dotfiles/$filename
    original_file=$HOME/$filename
    if [ ! $original_file -ef $dotfile ] ; then
        [ -e $original_file ] && mv $original_file $original_file.local
        touch $original_file.local
        ln -s $dotfile $original_file
    fi
done

