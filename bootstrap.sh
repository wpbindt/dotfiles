#!/usr/bin/env bash
set -eu
set -o pipefail
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

function add_midnight_cron_job {
    set -o noglob
    # prevent duplication and clobbering by using
    # crontab -l, sort, and uniq
    commands+=("(crontab -l ; echo '0 0 * * * $1') \
        | sort - | uniq - | crontab -")
    set +o noglob
}

function set_up_auto_pull {
    pull_command="$(command -v git) --git-dir=$repo/.git --work-tree=$repo pull -q"
    add_midnight_cron_job "$pull_command"
}

set_up_auto_pull

for cmd in "${commands[@]}"
do
    set -o noglob
    echo $cmd
    # A nontrivial positional argument means we do
    # a dry run, so no command should be executed.
    [ -z $1 ] && eval $cmd
    set +o noglob
done

