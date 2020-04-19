# Path to Oh My Fish install.
set -gx OMF_PATH "/Users/honzahovorka/.local/share/omf"

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG "/Users/honzahovorka/.config/omf"

# FZF command
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'

# Autojump
[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish

# GO
set -x GOPATH $HOME/projects/go

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# start TMUX with every new session
# if status is-interactive
# and not set -q TMUX
#     exec tmux
# end
# clear

funcsave clean_docker

set -gx  LC_ALL en_US.UTF-8

source $HOME/.cargo/env

set -x THEFUCK_OVERRIDDEN_ALIASES 'git'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish
