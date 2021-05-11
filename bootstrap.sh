DOTFILES=$(pwd)/dotfiles

function list_dotfile_contents {
    find $DOTFILES -type $1 -printf '%P\n'
}

for SUBDIR in $(list_dotfile_contents d)
do
    mkdir -p $HOME/$SUBDIR
done

for FILENAME in $(list_dotfile_contents f)
do
    DOTFILE=$DOTFILES/$FILENAME
    ORIGINAL_FILE=$HOME/$FILENAME
    if [ ! $ORIGINAL_FILE -ef $DOTFILE ] ; then
        [ -e $ORIGINAL_FILE ] && mv $ORIGINAL_FILE $ORIGINAL_FILE.local
        touch $ORIGINAL_FILE.local
        ln -s $DOTFILE $ORIGINAL_FILE
    fi
done

