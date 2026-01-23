#!/bin/bash
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

set -euo pipefail

run_command() {
    local cmd="$*"
    echo "执行命令：$cmd"

    if ! output=$("$@" 2>&1); then
         local exit_code=$?
         echo -e "\n命令执行失败！"
         echo -e "\n失败的命令：$cmd"
         echo -e "\n错误输出：$output"
         echo -e "\n退出码：$exit_code"
         exit $exit_code
    fi
}

version_ge() {
    # 版本比较，版本形式：xx.xx.xx
    IFS='.' read -r -a curr_arr <<< "$1"
    IFS='.' read -r -a req_arr <<< "$2"

    for ((i=0; i<${#req_arr[@]}; i++)); do
        curr=${curr_arr[i]:-0}
        req=${req_arr[i]}
        if (( curr > req )); then
            return 0
        elif (( curr < req )); then
            return 1
        fi
    done
    return 0
}

detect_os() {
    # 操作系统检查，支持debian(使用apt下载), rhel(使用dnf或者yum)，macos
    if [[ "$(uname -s)" == "Linux" ]]; then
        if [[ -f /etc/debian_version ]]; then
            OS="debian"
            PKG_MANAGER="apt"
        elif [[ -f /etc/redhat-release ]]; then
            OS="rhel"
            if command -v dnf &> /dev/null; then
                PKG_MANAGER="dnf"
            else
                PKG_MANAGER="yum"
            fi
        elif [[ -f /etc/euleros-release ]]; then
            OS="rhel"
            if command -v dnf &> /dev/null; then
                PKG_MANAGER="dnf"
            else
                PKG_MANAGER="yum"
            fi
        else
            echo "自动安装脚本不支持该Linux发行版本，请手动安装依赖"
            exit 1
        fi
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        OS="macos"
        if ! command -v brew &> /dev/null; then
            echo "请先安装Homebrew"
            exit 1
        fi
        PKG_MANAGER="brew"
    else
        echo "不支持的OS类型"
        exit 1
    fi
}

install_python() {
    # python版本号>=3.7.0
    echo -e "\n==== 检查Python ===="
    local req_ver="3.7.0"
    local curr_ver=""

    if command -v python3 &> /dev/null; then
        curr_ver=$(python3 --version 2>&1 | awk '{print $2}')
        echo "当前Python版本：$curr_ver"
        if version_ge "$curr_ver" "$req_ver"; then
            echo "Python满足要求"
            return
        fi
    fi
    echo "安装pyton..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y python3 python3-pip python3-dev
            ;;
        rhel)
            if grep -q "release 7" /etc/redhat-release; then
                run_command sudo $PKG_MANAGER install -y centos-release-scl
                run_command sudo $PKG_MANAGER install -y rh-python38 rh-python38-python-devel
                run_command source /opt/rh/rh-python38/enable
                echo "需要执行 'source /opt/rh/rh-python38/enable' 激活python3.8"
            else
                run_command sudo $PKG_MANAGER install -y python3 python3-pip python3-devel
            fi
            ;;
        macos)
            run_command brew install python@3.11
            echo 'export PATH="/usr/local/opt/python@3.11/bin:$PATH"' >> ~/.zshrc
            run_command source ~/.zshrc
            ;;
    esac

    if command -v python3 &> /dev/null; then
        curr_ver=$(python3 --version 2>&1 | awk '{print $2}')
        if version_ge "$curr_ver" "$req_ver"; then
            echo "Python安装成功（$curr_ver）"
        else
            echo "Python版本仍不满足，请手动安装解决"
            exit 1
        fi
    else
        echo "Python安装失败"
        exit 1
    fi
}

install_gcc() {
    # gcc版本号>=7.3.0
    echo -e "\n==== 检查GCC ===="
    local req_ver="7.3.0"
    local curr_ver=""

    if command -v gcc &> /dev/null; then
        curr_ver=$(gcc --version | awk '/^gcc/ {print $4}')
    elif command -v g++ &> /dev/null; then
        curr_ver=$(g++ --version | awk '/^g\+\+/ {print $4}')
    else
        curr_ver="0.0.0"
    fi
    echo "当前GCC版本: $curr_ver"
    if version_ge "$curr_ver" "$req_ver"; then
        echo "GCC版本满足要求（$curr_ver）"
        return
    fi

    echo "安装GCC..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y gcc-9 g++-9
            run_command sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 \
                --slave /usr/bin/g++ g++ /usr/bin/g++-9
            ;;
        rhel)
            if grep -q "release 7" /etc/redhat-release; then
                run_command sudo $PKG_MANAGER install -y centos-release-scl
                run_command sudo $PKG_MANAGER install -y devtoolset-9-gcc devtoolset-9-gcc-c++
                run_command source /opt/rh/devtoolset-9/enable
                echo "需要执行 'source /opt/rh/devtoolset-9/enable' 激活GCC9"
            else
                run_command sudo $PKG_MANAGER install -y gcc gcc-c++
            fi
            ;;
        macos)
            if ! xcode-select -p &> /dev/null; then
                xcode-select --install
            fi
            run_command brew install gcc@11
            echo 'export CC=/usr/local/bin/gcc-11' >> ~/.zshrc
            echo 'export CXX=/usr/local/bin/g++-11' >> ~/.zshrc
            run_command source ~/.zshrc
            ;;
    esac

    if command -v gcc &> /dev/null; then
        curr_ver=$(gcc --version | awk '/^gcc/ {print $4}')
        if version_ge "$curr_ver" "$req_ver"; then
            echo "GCC安装成功（$curr_ver）"
        else
            echo "GCC版本仍不满足，请手动安装。"
            exit 1
        fi
    else
        echo "GCC安装失败"
        exit 1
    fi
}

install_cmake() {
    # cmake版本号>=3.16.0
    echo -e "\n==== 检查cmake ===="
    local req_ver="3.16.0"
    local curr_ver=""

    if command -v cmake &> /dev/null; then
        curr_ver=$(cmake --version | awk '/^cmake/ {print $3}')
        echo "当前cmake版本: $curr_ver"
        if version_ge "$curr_ver" "$req_ver"; then
            echo "CMake满足要求"
            return
        fi
    fi

    echo "安装CMake..."
    case "$OS" in
        debian)
            if grep -q "Ubuntu 18.04" /etc/os-release; then
                run_command wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
                run_command echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ bionic main' | sudo tee /etc/apt/sources.list.d/kitware.list >/dev/null
                run_command sudo apt update
                run_command sudo apt install -y cmake
            else
                run_command sudo $PKG_MANAGER update
                run_command sudo $PKG_MANAGER install -y cmake
            fi
            ;;
        rhel)
            if grep -q "release 7" /etc/redhat-release; then
                run_command sudo $PKG_MANAGER install -y epel-release
                run_command sudo $PKG_MANAGER install -y cmake3
                run_command sudo ln -s /usr/bin/cmake3 /usr/bin/cmake
            else
                run_command sudo $PKG_MANAGER install -y cmake
            fi
            ;;
        macos)
            run_command brew install cmake
            ;;
    esac

    if command -v cmake &> /dev/null; then
        curr_ver=$(cmake --version | awk '/^cmake/ {print $3}')
        if version_ge "$curr_ver" "$req_ver"; then
            echo "CMake安装成功（$curr_ver）"
        else
            echo "CMake版本仍不满足，请手动安装"
            exit 1
        fi
    else
        echo "CMake安装失败"
        exit 1
    fi
}

install_ccache() {
    echo -e "\n==== 检查ccache ===="

    if command -v ccache &> /dev/null; then
        echo "ccache已安装"
        return
    fi

    echo "安装ccache..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y ccache
            ;;
        rhel)
            run_command sudo $PKG_MANAGER install -y ccache
            ;;
        macos)
            run_command brew install ccache
            ;;
    esac

    if command -v ccache &> /dev/null; then
        echo "ccache安装成功"
    else
        echo "ccache安装失败"
        exit 1
    fi
}

install_autoconf() {
    echo -e "\n==== 检查autoconf ===="

    if command -v autoconf &> /dev/null; then
        echo "autoconf已安装"
        return
    fi

    echo "安装autoconf..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y autoconf
            ;;
        rhel)
            run_command sudo $PKG_MANAGER install -y autoconf
            ;;
        macos)
            run_command brew install autoconf
            ;;
    esac

    if command -v autoconf &> /dev/null; then
        echo "autoconf安装成功"
    else
        echo "autoconf安装失败"
        exit 1
    fi
}

install_gperf() {
    echo -e "\n==== 检查gperf ===="

    if command -v gperf &> /dev/null; then
        echo "gperf已安装"
        return
    fi

    echo "安装gperf..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y gperf
            ;;
        rhel)
            run_command sudo $PKG_MANAGER install -y gperf
            ;;
        macos)
            run_command brew install gperf
            ;;
    esac

    if command -v gperf &> /dev/null; then
        echo "gperf安装成功"
    else
        echo "gperf安装失败"
        exit 1
    fi
}

install_libtool() {
    echo -e "\n==== 检查libtool ===="

    if command -v libtool &> /dev/null; then
        echo "libtool已安装"
        return
    fi

    echo "安装libtool..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y libtool
            run_command sudo $PKG_MANAGER install -y libtool-bin
            ;;
        rhel)
            run_command sudo $PKG_MANAGER install -y libtool
            run_command sudo $PKG_MANAGER install -y libtool-bin
            ;;
        macos)
            run_command brew install libtool
            run_command brew install libtool-bin
            ;;
    esac

    if command -v libtool &> /dev/null; then
        echo "libtool安装成功"
    else
        echo "libtool安装失败"
        exit 1
    fi
}

install_pip3() {
    echo -e "\n==== 检查pip3 ===="

    if command -v pip3 &> /dev/null; then
        echo "pip3已安装"
        return
    fi

    echo "安装pip3..."
    case "$OS" in
        debian)
            run_command sudo $PKG_MANAGER update
            run_command sudo $PKG_MANAGER install -y python3-pip
            ;;
        rhel)
            run_command sudo $PKG_MANAGER install -y python3-pip
            ;;
        macos)
            # macOS 下 pip3 通常随 Python3 一起安装
            if ! command -v pip3 &> /dev/null; then
                run_command python3 -m ensurepip --upgrade
                run_command python3 -m pip install --upgrade pip
            fi
            ;;
    esac

    if command -v pip3 &> /dev/null; then
        echo "pip3安装成功"
    else
        echo "pip3安装失败"
        exit 1
    fi
}

main() {
    echo "===================================================="
    echo "开始安装项目依赖"
    echo "===================================================="

    detect_os
    install_python
    install_pip3
    install_gcc
    install_cmake
    install_ccache
    install_autoconf
    install_gperf
    install_libtool

    echo -e "===================================================="
    echo "所有依赖安装完成！"
    echo "===================================================="
}

main "$@"