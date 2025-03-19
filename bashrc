export QT_QPA_PLATFORMTHEME=qt5ct
export XDG_CONFIG_HOME="/home/tristen/.config"
export XDG_CACHE_HOME="/home/tristen/.cache"
export XDG_DATA_HOME="/home/tristen/.local/share"

# General Shortcuts
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'
alias grep='grep --color=auto'
alias l='ls -CF'         # Compact view
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories
alias ~='cd ~'           # Go to home directory

# Safety & Confirmation
alias cp='cp -i' # Confirm before overwriting
alias mv='mv -i' # Confirm before moving
alias rm='rm -i' # Confirm before deleting

# File & Directory Management
alias mkdir='mkdir -p' # Create parent directories if needed
alias untar='tar -xvf' # Extract tar files
alias zipf='zip -r'    # Create a zip file
alias mkcd='foo() { mkdir -p "" && cd "" || echo "Failed to create and cd into directory "; }; foo'

# Networking
alias myip="curl ifconfig.me"                                                                                   # Show public IP
alias ports='netstat -tulanp'                                                                                   # Show open ports
alias speedtest='curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -' # Speed test

# Package Management (For Arch Linux)
alias update='sudo pacman -Syu'                                                                                                                                           # Update system
alias upgrade='sudo pacman -Syyu'                                                                                                                                         # Force refresh and update
alias install='sudo pacman -S'                                                                                                                                            # Install a package
alias remove='sudo pacman -Rns'                                                                                                                                           # Remove package and dependencies
alias orphan='sudo pacman -Qdtq | sudo pacman -Rns -'                                                                                                                     # Remove orphaned packages
alias cleanup='sudo pacman -Sc'                                                                                                                                           # Clean package cache
alias update-mirrors='sudo reflector --country Canada --latest 50 --protocol https --sort rate --download-timeout 10 --save /etc/pacman.d/mirrorlist && sudo pacman -Syy' # Update and get fasest Arch mirrors
alias yay='paru'
alias aur='paru'

# Misc
alias ff='fastfetch'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias tgsite='cd ~/Github/tristengrant'
alias cbcomic='cd ~/Github/catandbotcomic'
alias suckless='cd ~/Github/suckless && ls'
alias dotfiles='cd ~/Github/dotfiles && ls'
alias scripts='cd ~/Github/scripts && ls'

PS1='\[\033[38;5;214m\]\u\[\033[0m\]@\[\033[38;5;82m\]\h\[\033[0m\] \W$ '
