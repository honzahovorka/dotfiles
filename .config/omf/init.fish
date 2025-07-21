set -x EDITOR /opt/homebrew/bin/nvim

alias tmux 'tmux -2'
alias vim 'nvim'
alias v 'nvim'

# Hub
alias git hub

# git
alias g git
alias gb 'git branch'
alias gbc 'git checkout -b'
alias gbl 'git branch -v'
alias gbx 'git branch -d'
alias gbX 'git branch -D'
alias gbm 'git branch -m'
alias gc 'git commit --verbose'
alias gcm 'git commit --message'
alias gr 'git rebase'
alias gra 'git rebase --abort'
alias grc 'git rebase --continue'
alias gri 'git rebase --interactive'
alias grs 'git rebase --skip'
alias gs 'git stash'
alias gsa 'git stash apply'
alias gsx 'git stash drop'
alias gsl 'git stash list'
alias gsd 'git stash show --patch --stat'
alias gsp 'git stash pop'
alias gsr 'git-stash-recover'
alias gst 'git status'
alias gp 'git push'
alias gph 'git push heroku master'
alias ga 'git add'
alias gA 'git add --all'
alias gpr 'git pull --rebase'
alias gco 'git checkout'
alias gcom 'git checkout master'

# Homebrew
alias brewc 'brew cleanup'
alias brewi 'brew install'
alias brewl 'brew list'
alias brews 'brew search'
alias brewu 'brew update; and brew upgrade'
alias brewx 'brew remove'

# Bundler
alias be 'bundle exec'
alias ber 'bundle exec rails'
alias bi 'bundle install'
alias bu 'bundle update'

# Tmux
alias tma 'tmux attach -d -t'
alias tmn 'tmux new -s (basename (pwd))'
alias tml 'tmux list-sessions'
alias tmk 'tmux kill-session -t $1'
alias tmp 'tmux attach -t (tmux list-session | sed "s/:.*//" | fzf)'

# Custom
alias mk mkcd # custom fish function
alias cat bat
alias du 'ncdu --color dark -rr -x --exclude .git --exclude node_modules'
alias help tldr
alias tf terraform

alias md 'glow'
alias c 'clear'
alias clr 'clear'

alias ls 'eza -lAh --git --icons=always'
alias l ls
alias lt 'eza -lAh --icons=always --git --tree --level=4 --long --ignore-glob="node_modules|.git"'

# FZF
alias fzfi 'rg --files --hidden --follow -g "!{node_modules,.git}" | fzf --height 40%'
alias preview 'fzfi --preview "bat --color \"always\" {}"'
alias fo 'v (fzfi)'
