source $HOME/.config/fish/appimage-env.fish

# Path to Oh My Fish install.
set -gx OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG $HOME/.config/omf

# FZF command
set -x FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -Ux FZF_DEFAULT_OPTS '--height=90% --layout=reverse --info=inline --border --margin=1 --padding=1 --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8'

set -x EDITOR 'nvim'

# Load oh-my-fish configuration.
test -f $OMF_PATH/init.fish; and source $OMF_PATH/init.fish

# Starship
if type -q starship
  function starship_transient_rprompt_func
    starship module time
  end
  starship init fish | source
  enable_transience
end

# Zoxide
if type -q zoxide
  zoxide init fish | source
end

# Atuin
if type -q atuin
  set -gx ATUIN_NOBIND "true"
  atuin init fish | source

  bind \cr _atuin_search
  bind -M insert \cr _atuin_search
end

# Mise
if type -q mise
  mise activate fish | source
end

set -gx  LC_ALL en_US.UTF-8

set -x GPG_TTY (tty)

# Load secrets
test -f $HOME/.config/fish/secrets.fish; and source $HOME/.config/fish/secrets.fish

set -x HOST (hostname)

fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.config/bin

fish_add_path $HOME/.opencode/bin

# plannotator
fish_add_path $HOME/.local/bin

set -x ANDROID_HOME $HOME/Android/Sdk
fish_add_path $ANDROID_HOME/emulator
fish_add_path $ANDROID_HOME/platform-tools
fish_add_path $ANDROID_HOME/tools
fish_add_path $ANDROID_HOME/tools/bin

set -x ANDROID_AVD_HOME $HOME/.config/.android/avd

test -d /usr/lib/jvm/java-17-openjdk; and set -x JAVA_HOME /usr/lib/jvm/java-17-openjdk

