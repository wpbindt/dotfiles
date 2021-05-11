DOTFILES=$(pwd)/dotfiles

for SUBDIR in $(find $DOTFILES -type d -printf '%P\n')
do
    mkdir -p $HOME/$SUBDIR
done

for FILENAME in $(find $DOTFILES -type f -printf '%P\n')
do
    DOTFILE=$DOTFILES$FILENAME
    ORIGINAL_FILE=$HOME/$FILENAME
    if [ ! $ORIGINAL_FILE -ef $DOTFILE ] ; then
        [ -e $ORIGINAL_FILE ] && mv $ORIGINAL_FILE $ORIGINAL_FILE.local
        touch $ORIGINAL_FILE.local
        ln -s $DOTFILE $ORIGINAL_FILE
    fi
done

