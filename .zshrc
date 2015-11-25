source ~/.zprezto/init.zsh

export EDITOR="vim"
export BUNDLE_EDITOR="vim"

# Example aliases
alias zshconfig="mvim ~/.zshrc"
alias glog="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
alias passgen='ruby ~/code/rb/password_generator/password_generator.rb'

alias tmux="tmux -2"
alias vim="nvim"
alias vi=vim
alias v=vim
alias archey="archey -c"
alias l="ls -al"
alias rguard="bin/guard"
alias gst="git status"
alias gph="git push heroku master"
alias be="bundle exec"

alias chrome='open -a Google\ Chrome --args --disable-async-dns'

# http://linhmtran168.github.io/blog/2013/12/15/ditching-oh-my-zsh-for-prezto/
alias tma='tmux attach -d -t'
alias tmn='tmux new -s $(basename $(pwd))'
alias tml='tmux list-sessions'
alias tmk="tmux kill-session -t $1"

# https://jonsuh.com/blog/bash-command-line-shortcuts/
alias clr="clear" # Clear your terminal screen
alias flush="sudo killall -HUP mDNSResponder" # Flush DNS (Yosemite)
alias ip="curl icanhazip.com" # Your public IP address
alias o="open ." # Open the current directory in Finder
alias ut="uptime" # Computer uptime

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:~/bin:~/Users/honzahovorka/pear/bin:$PATH"
export PATH="#{HOMEBREW_PREFIX}/bin:$PATH"
export PATH="/Users/honzahovorka/.composer/vendor/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
if [[ -f /usr/local/opt/pyenv/completions/pyenv.zsh ]]; then
    source /usr/local/opt/pyenv/completions/pyenv.zsh
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# added by travis gem
[ -f /Users/honzahovorka/.travis/travis.sh ] && source /Users/honzahovorka/.travis/travis.sh

# http://superuser.com/a/838840
ulimit -n 65536
ulimit -u 2048

# tmuxinator completion
source ~/.zsh/tmuxinator.zsh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
