# Path to Oh My Fish install.
set -gx OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG $HOME/.config/omf

# FZF command
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -Ux FZF_DEFAULT_OPTS '--height=90% --layout=reverse --info=inline --border --margin=1 --padding=1 --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'

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

# Mise
$HOME/.local/bin/mise activate fish | source

set -gx  LC_ALL en_US.UTF-8

set -x GPG_TTY (tty)

# Load secrets
source $HOME/.config/fish/secrets.fish

set -x HOST (hostname)

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.config/bin
