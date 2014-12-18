source ~/.zprezto/init.zsh

export EDITOR="vim"
export BUNDLE_EDITOR="vim"

# Example aliases
alias zshconfig="mvim ~/.zshrc"
alias glog="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
alias passgen='ruby ~/code/rb/password_generator/password_generator.rb'

alias tmux="tmux -2"
alias vim="mvim -v"
alias archey="archey -c"

export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:~/bin:~/Users/honzahovorka/pear/bin:$PATH"
export PATH="#{HOMEBREW_PREFIX}/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# added by travis gem
[ -f /Users/honzahovorka/.travis/travis.sh ] && source /Users/honzahovorka/.travis/travis.sh

# http://superuser.com/a/838840
ulimit -n 65536
ulimit -u 2048

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
