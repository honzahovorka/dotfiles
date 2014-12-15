# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export EDITOR="vim"
export BUNDLE_EDITOR="vim"
export JAVA_HOME=`/usr/libexec/java_home -v '1.6*'`
bindkey -v

# vi style incremental search
# bindkey '^R' history-incremental-search-backward
# bindkey '^S' history-incremental-search-forward
# bindkey '^P' history-search-backward
# bindkey '^N' history-search-forward

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
alias zshconfig="mvim ~/.zshrc"
alias ohmyzsh="mvim ~/.oh-my-zsh"
alias glog="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'''
alias passgen='ruby ~/code/rb/password_generator/password_generator.rb'

# PHP-FPM
alias loadphp="sudo launchctl load ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist"
alias unloadphp="sudo launchctl unload ~/Library/LaunchAgents/homebrew-php.josegonzalez.php55.plist"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails git ruby mercurial)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# export PATH=/Users/honzahovorka/.rvm/gems/ruby-1.9.3-p362/bin:/Users/honzahovorka/.rvm/gems/ruby-1.9.3-p362@global/bin:/Users/honzahovorka/.rvm/rubies/ruby-1.9.3-p362/bin:/Users/honzahovorka/.rvm/bin:/usr/bin:/usr/sbin:/bin:/sbin:/opt/X11/bin:/usr/local/bin:/usr/local/sbin:/Users/honzahovorka/.yadr/bin:/Users/honzahovorka/.yadr/bin/yadr:$PATH

export TERM="screen-256color"
alias tmux="tmux -2"
alias vim="mvim -v"
alias archey="archey -c"

export MAGICK_HOME="/usr/local/Cellar/imagemagick/6.8.0-10"
export PATH="/usr/local/sbin:$PATH"
export PATH="$MAGICK_HOME/bin:$PATH"
export PATH="/usr/local/bin:~/bin:~/Users/honzahovorka/pear/bin:$PATH"
export PATH="#{HOMEBREW_PREFIX}/bin:$PATH"
export PATH="/Applications/Android Studio.app/sdk/platform-tools:$PATH"

PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# Powerline
# . /Users/honzahovorka/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

# if [[ -r ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#     source ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
# fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# added by travis gem
[ -f /Users/honzahovorka/.travis/travis.sh ] && source /Users/honzahovorka/.travis/travis.sh

# http://superuser.com/a/838840
ulimit -n 65536
ulimit -u 2048

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
