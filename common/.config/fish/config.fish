# Path to Oh My Fish install.
set -gx OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG $HOME/.config/omf

# FZF command
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -Ux FZF_DEFAULT_OPTS '--height=90% --layout=reverse --info=inline --border --margin=1 --padding=1 --color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284'

set -x EDITOR 'nvim'

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Starship
function starship_transient_rprompt_func
  starship module time
end
starship init fish | source
enable_transience

# Zoxide
zoxide init fish | source

# Atuin
set -gx ATUIN_NOBIND "true"
atuin init fish | source

bind \cr _atuin_search
bind -M insert \cr _atuin_search

set -gx  LC_ALL en_US.UTF-8

set -x GPG_TTY (tty)

# Load secrets
source $HOME/.config/fish/secrets.fish

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.config/bin
