# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/honzahovorka/.local/share/omf"

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG "/Users/honzahovorka/.config/omf"

# FZF command
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# GO
set -x GOPATH $HOME/Code/go
set -x GOROOT /usr/local/opt/go/libexec

set -x PATH $PATH $GOROOT/bin $GOPATH/bin

# LazyGit
set -x LG_CONFIG_FILE "/Users/honzahovorka/.config/lazygit/config.yml"

# Node.js
export N_PREFIX=$HOME/.n
set -x PATH $N_PREFIX/bin:$PATH

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

set -gx  LC_ALL en_US.UTF-8

set PATH $HOME/.cargo/bin $PATH
set PATH $HOME/.config/bin $PATH
