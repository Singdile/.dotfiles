#!/bin/bash
# ~/.config/hypr/scripts/launch-bluetui.sh

# 检查bluetui是否安装
if ! command -v bluetui &> /dev/null; then
    notify-send "Error" "bluetui not installed. Run: sudo pacman -S bluetui"
    exit 1
fi

# 检查蓝牙服务是否运行
if ! systemctl --user is-active --quiet bluez; then
    if ! systemctl is-active --quiet bluetooth; then
        notify-send "Bluetooth" "Starting bluetooth service..."
        sudo systemctl start bluetooth
    fi
fi

# 在终端中启动bluetui，使用正确的class参数
alacritty --class "bluetooth-manager,bluetooth-manager" -e sh -c "bluetui" &
