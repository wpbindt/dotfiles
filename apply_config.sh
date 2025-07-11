#!/usr/bin/env bash
set -eo pipefail

# parse options in a clunky way because 
# getopts makes it hard to distinguish
# between illegal and no options
if [ -n "$1" ]; then
    if [ "$1" = "-d" ]; then
        echo performing dry run
        dry_run=1
    else
        echo illegal option $1
        exit 1
    fi
fi

repo=$(cd "$(dirname "$0")"; pwd)
dotfiles="$repo/dotfiles"

# Store commands to be executed in an array
# so we can decide at the end of the script
# if we want to execute or just print them.
commands=()

function list_dotfile_contents {
    find "$dotfiles" -type "$1" -printf '%P\n'
}

for subdir in $(list_dotfile_contents d)
do
    commands+=("mkdir -p "$HOME/$subdir"")
done

for filename in $(list_dotfile_contents f)
do
    dotfile=$dotfiles/$filename
    original_file=$HOME/$filename
    local_file=$original_file.local
    if [ ! "$original_file" -ef "$dotfile" ] ; then
        [ -e "$original_file" ] && commands+=("mv "$original_file" "$local_file"")
        commands+=("touch "$local_file"")
        commands+=("ln -s "$dotfile" "$original_file"")
    fi
done

function add_cron_job {
    set -o noglob
    # prevent duplication and clobbering by using
    # crontab -l, sort, and uniq
    commands+=("(crontab -l ; echo '0 * * * * $1') \
        | sort - | uniq - | crontab -")
    set +o noglob
}

pull_command="$(command -v git) --git-dir=$repo/.git --work-tree=$repo pull -q"
add_cron_job "$pull_command"

for cmd in "${commands[@]}"
do
    set -o noglob
    echo $cmd
    [ -z $dry_run ] && eval $cmd
    set +o noglob
done
