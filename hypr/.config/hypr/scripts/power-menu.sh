#!/bin/bash
# ~/.config/hypr/scripts/power-menu.sh

# 安装 rofi（如果尚未安装）
if ! command -v rofi &> /dev/null; then
    echo "请先安装 rofi: sudo pacman -S rofi"
    exit 1
fi

# 电源菜单选项
selection=$(echo -e "🔒 Lock\n⏾ Suspend\n🔄 Reboot\n⏻ Shutdown" | \
    rofi -dmenu -i -p "Power Menu" \
    -theme-str '#window { width: 20%; height: 35%; location: 0; }' \
    -theme-str '#listview { lines: 4; cycle: true; layout: vertical; }' \
    -theme-str '#element-text { font: "JetBrainsMono Nerd Font 14"; }' \
    -theme-str '#element selected { background-color: rgba(138, 212, 113, 0.8); color: #ffffff; }')

case "$selection" in
    "🔒 Lock")
        hyprlock
        ;;
    "⏾ Suspend")
        systemctl suspend
        ;;
    "🔄 Reboot")
        systemctl reboot
        ;;
    "⏻ Shutdown")
        systemctl poweroff
        ;;
    *)
        exit 0
        ;;
esac