# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/tobias/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

eval "$(/opt/homebrew/bin/brew shellenv)"

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    # Add this if you experience issues with missing completions or errors mentioning compdef.
    # zgenom compdef

    # Ohmyzsh base library
    zgenom ohmyzsh

    # You can also cherry pick just parts of the base library.
    # Not loading the base set of ohmyzsh libraries might lead to issues.
    # While you can do it, I won't recommend it unless you know how to fix
    # those issues yourself.

    # Remove `zgenom ohmyzsh` and load parts of ohmyzsh like this:
    # `zgenom ohmyzsh path/to/file.zsh`
    # zgenom ohmyzsh lib/git.zsh # load git library of ohmyzsh

    # plugins
    zgenom ohmyzsh plugins/git
    zgenom ohmyzsh plugins/sudo
    # just load the completions
    zgenom ohmyzsh --completion plugins/docker-compose

    # Install ohmyzsh osx plugin if on macOS
    [[ "$(uname -s)" = Darwin ]] && zgenom ohmyzsh plugins/macos

    # prezto options
    zgenom prezto editor key-bindings 'emacs'
    zgenom prezto prompt theme 'sorin'

    # prezto and modules
    # If you use prezto and ohmyzsh - load ohmyzsh first.
    zgenom prezto
    zgenom prezto command-not-found

    # Load prezto tmux when tmux is installed
    if hash tmux &>/dev/null; then
        zgenom prezto tmux
    fi

    zgenom load zsh-users/zsh-syntax-highlighting
    # zgenom load /path/to/super-secret-private-plugin

    zgenom load wfxr/forgit

    # use a plugin file
    # The file must only contain valid parameters for `zgenom load`
    # zgenom loadall < path/to/plugin/file

    # bulk load
    zgenom loadall <<EOPLUGINS
        zsh-users/zsh-history-substring-search
EOPLUGINS
    # ^ can't indent this EOPLUGINS

    # add binaries
    zgenom bin tj/git-extras

    # completions
    zgenom load zsh-users/zsh-completions

    # theme
    zgenom ohmyzsh themes/arrow

    # save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
    # Uncomment if you set ZDOTDIR manually
    # zgenom compile $ZDOTDIR

    # You can perform other "time consuming" maintenance tasks here as well.
    # If you use `zgenom autoupdate` you're making sure it gets
    # executed every 7 days.

    # rbenv rehash
fi
setopt noglob