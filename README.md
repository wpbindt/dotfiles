# dotfiles
Configuration files for stuff on Linux. To set this up, ensure `zsh` and `oh-my-zsh` are installed, and that `git` is configured. Then clone this repo, and run (if you want to do a dry run, add `-d`)
```
$ /wherever/you/cloned/this/repo/to/apply_config.sh
```
This script does the following:
- back up local config files `.some_config` to `.some_config.local` in the same directory (first run only)
- replace the local config files with symlinks to the config files in the repo
- add a daily cron job to pull this repo, to keep the config files up to date

Where possible, the config files in this repo include the locally backed up versions. For example, `.zshrc` contains the line 
```
source "$HOME/.zshrc.local"
```

The script is idempotent by design; running it twice without adding files to the repo in between the runs should not be any different from running it just once. However, when new files are added to `dotfiles/dotfiles`, it should be run again for this to take effect.

### Issues
For a lot of config files, the local backup of the config file is included in the config file itself. For example, `.zshrc` ends with `source .zshrc.local`. This is to enable per-machine customization by editing the local backup. On a first run, this can result in the config file seemingly being ignored. For example, the `.zshrc` that `zsh` has on a first install completely clobbers the one in this repo. To fix this problem, empty the local backup.
