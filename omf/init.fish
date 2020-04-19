set -x EDITOR /usr/local/bin/nvim

balias clr 'clear'

balias l 'ls -al'

balias tmux 'tmux -2'
balias v 'nvim'

# Hub
balias git hub

# git
balias g git
balias gb 'git branch'
balias gbc 'git checkout -b'
balias gbl 'git branch -v'
balias gbx 'git branch -d'
balias gbX 'git branch -D'
balias gbm 'git branch -m'
balias gc 'git commit --verbose'
balias gcm 'git commit --message'
balias gr 'git rebase'
balias gra 'git rebase --abort'
balias grc 'git rebase --continue'
balias gri 'git rebase --interactive'
balias grs 'git rebase --skip'
balias gs 'git stash'
balias gsa 'git stash apply'
balias gsx 'git stash drop'
balias gsl 'git stash list'
balias gsd 'git stash show --patch --stat'
balias gsp 'git stash pop'
balias gsr 'git-stash-recover'
balias gst 'git status'
balias gp 'git push'
balias gph 'git push heroku master'
balias ga 'git add'
balias gA 'git add --all'
balias gpr 'git pull --rebase'
balias gco 'git checkout'
balias gcom 'git checkout master'

# Homebrew
balias brewc 'brew cleanup'
balias brewi 'brew install'
balias brewl 'brew list'
balias brews 'brew search'
balias brewu 'brew update; and brew upgrade'
balias brewx 'brew remove'

# Bundler
balias be 'bundle exec'
balias ber 'bundle exec rails'
balias bi 'bundle install'
balias bu 'bundle update'

# Tmux
balias tma 'tmux attach -d -t'
balias tmn 'tmux new -s (basename (pwd))'
balias tml 'tmux list-sessions'
balias tmk 'tmux kill-session -t $1'
balias mux tmuxinator

# Custom
balias mk 'mkdir $1; cd $1'
balias preview "fzf --preview 'bat --color \"always\" {}'"
balias cat bat
balias du "ncdu --color dark -rr -x --exclude .git --exclude node_modules"
balias help tldr
balias tf terraform

balias md 'glow'
balias c 'clear'

balias l 'exa -l'
balias ll 'exa -l'
balias la 'exa -la'
