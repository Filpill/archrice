# Filip's Arch Config Files And Scripts

- config folder contains configuration files for particular programs
- cron folder contains desktop cron jobs files
- shell folder includes custom shell scripts for desktop
- dotfiles folder contains configuration for: git, terminal and xinitrc

# Saving System Configs/Scripts/Dots
After making changes to your system files, you can run the script called "copy-config.sh" to save everything to this repository.

```bash
./copy-config.sh
```

# Deploying Dotfiles
Go to the dotfiles folder and execute the apply-dot.sh

```bash
./apply-dot.sh
```

This will copy all the dotfiles from this folder to you desktop home folder.
