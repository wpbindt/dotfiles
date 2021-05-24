# dotfiles
Configuration files for stuff on Linux. To set this up, run `$ ./bootstrap.sh`. This script does the following:
- back up local config files `.some_config` to `.some_config.local` in the same directory
- replace the local config files with symlinks to the config files in the repo
- add a daily cron job to pull this repo, to keep the config files up to date

Where possible, the config files in this repo include the locally backed up versions. For example, `.zshrc` contains the line `source $HOME/.zshrc.local`. The script is idempotent by design. Running it twice without adding or removing files to/from the repo in between the runs should not have any effect. However, when new files are added to or removed from `dotfiles/dotfiles`, it should be run again for it to take effect.
