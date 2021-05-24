#!/usr/bin/env bash
repo=$(cd "$(dirname "$0")"; pwd)
dotfiles="$repo/dotfiles"

function list_dotfile_contents {
    find "$dotfiles" -type "$1" -printf '%P\n'
}

for subdir in $(list_dotfile_contents d)
do
    mkdir -p "$HOME/$subdir"
done

for filename in $(list_dotfile_contents f)
do
    dotfile=$dotfiles/$filename
    original_file=$HOME/$filename
    local_file=$original_file.local
    if [ ! "$original_file" -ef "$dotfile" ] ; then
        [ -e "$original_file" ] && mv "$original_file" "$local_file"
        touch "$local_file"
        ln -s "$dotfile" "$original_file"
    fi
done

function add_midnight_cron_job {
    set -o noglob
    # prevent duplication and clobbering by using
    # crontab -l, sort, and uniq
    (crontab -l ; echo "0 0 * * * $1") \
        | sort - | uniq - | crontab -
    set +o noglob
}

function set_up_auto_pull {
    pull_command="$(command -v git) --git-dir=$repo/.git --work-tree=$repo pull -q"
    add_midnight_cron_job "$pull_command"
}

set_up_auto_pull

