# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/honzahovorka/.local/share/omf"

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG "/Users/honzahovorka/.config/omf"

# FZF command
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -Ux FZF_DEFAULT_OPTS '--height=90% --layout=reverse --info=inline --border --margin=1 --padding=1 --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284'

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# LazyGit
set -x LG_CONFIG_FILE "/Users/honzahovorka/.config/lazygit/config.yml"

# Node.js
export N_PREFIX=$HOME/.n
set -x PATH $N_PREFIX/bin:$PATH

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Oh my Posh
oh-my-posh init fish --config ~/.config/ohmyposh/default.toml | source

# Zoxide
zoxide init fish | source

set -gx  LC_ALL en_US.UTF-8

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.config/bin $PATH
