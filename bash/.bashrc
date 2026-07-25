#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 自动启动Hyprland（仅在tty1）
if [ -z "$WAYLAND_DISPLAY" ] && [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    exec /home/singdile/.config/hypr/autostart-hyprland.sh
fi

alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '


## 配置yazi,使用y启动yazi,使用q退出并切换目录，使用Q退出不切换目录
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
### 终端配置代理
export HTTP_PROXY=http://127.0.0.1:7897
export HTTPS_PROXY=http://127.0.0.1:7897
export NO_PROXY=localhost,127.0.0.1,::1,.cn #不走代理的地址列表，所有以.cn结尾的域名,::1表示本地回环地址

alias proxyoff='unset HTTP_PROXY HTTPS_PROXY NO_PROXY'
### doom emacs
export PATH="$HOME/.config/emacs/bin:$PATH"
alias ec='emacsclient -c -a "" &'
alias et='emacsclient -nw'

### Go,GOROOT指向编译器，GOPATH指向用户保存的第三方工具等，PATH用于系统导航找东西
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


# wget 代理配置
alias wget='wget --config ~/.config/wget/wgetrc'

#yay 配置代理
alias yay='ALL_PROXY=socks5h://127.0.0.1:7890 yay'

####################################################################################################################
# carapace shell命令补全
# 1. 确保加载系统基础补全
[[ -r "/usr/share/bash-completion/bash_completion" ]] && . "/usr/share/bash-completion/bash_completion"

# 2. 激活 Carapace (核心命令)
# export CARAPACE_LENIENT=1  # 如果你想让它更“宽容”，即使没写完也不报错，可以取消注释
source <(carapace _carapace bash)

# 补全时忽略大小写
bind "set completion-ignore-case on"

# 开启菜单模式：按一下 Tab 补全，按两下出现可选择的菜单
bind 'TAB:menu-complete'
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

# 让选中的条目高亮 (取决于你的 LS_COLORS)
bind "set colored-stats on"

####################################################################################################################
# docker 进入redis内部执行命令 
alias myredis='docker exec -it myredis redis-cli'
. "$HOME/.local/bin/env"


#####################################################################################################################
export EMACS_USER_DIRECTORY="~/.emacs.d/"


###############################################################################################
eval "$(starship init bash)"
. "$HOME/.cargo/env"
eval "$(zoxide init bash)"


################################################################################################
alias mirrors-update='rate-mirrors arch | sudo tee /etc/pacman.d/mirrorlist'


#########################
alias jet-toolbox='/home/singdile/.local/share/JetBrains/Toolbox/bin/jetbrains-toolbox '
