# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# -----------------------------------------------------------------------------------------------------------
#
# Runtime 开发容器
# 包含编译 runtime 仓及执行 UT 所需的全部工具链依赖。
# 运行 runtime（非 UT）需要 NPU 驱动 + CANN toolkit，请在容器启动后参照 README.md 手动安装。
#
FROM ubuntu:22.04

LABEL maintainer="runtime-dev"
LABEL description="Runtime build & UT environment based on Ubuntu 22.04"

# 避免 apt 交互式提示
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# ── 1. 系统基础依赖 ───────────────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends --fix-missing \
    # 基础工具
    ca-certificates \
    curl \
    wget \
    git \
    unzip \
    xz-utils \
    gnupg \
    lsb-release \
    software-properties-common \
    # 编译工具（gcc-9 满足 >= 7.3.0, <= 13 的要求）
    gcc-9 \
    g++-9 \
    make \
    # CMake（Ubuntu 22.04 自带 3.22+，满足 >= 3.16.0）
    cmake \
    # 构建加速 & 辅助工具
    ccache \
    autoconf \
    automake \
    gperf \
    libtool \
    libtool-bin \
    pkg-config \
    # Python（Ubuntu 22.04 自带 3.10，满足 >= 3.7.0）
    python3 \
    python3-pip \
    python3-dev \
    # UT 覆盖率工具
    lcov \
    # 消毒器运行时（gcc-9：libasan5 / libtsan0 / libubsan1）
    libasan5 \
    libtsan0 \
    libubsan1 \
    # 其他构建依赖
    zlib1g-dev \
    patch \
    perl \
    && rm -rf /var/lib/apt/lists/*

# ── 2. 设置 gcc-9 / g++-9 为默认编译器 ────────────────────────────────────────
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 90 \
        --slave /usr/bin/g++ g++ /usr/bin/g++-9 \
        --slave /usr/bin/gcov gcov /usr/bin/gcov-9 \
    && update-alternatives --install /usr/bin/cc  cc  /usr/bin/gcc-9 90 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++-9 90

# ── 3. pip 工具 ───────────────────────────────────────────────────────────────
RUN pip3 install --no-cache-dir --upgrade pip

# ── 4. 工作目录 ───────────────────────────────────────────────────────────────
WORKDIR /workspace

# ── 5. 关闭 SSL 验证（编译时自动下载第三方包使用，与 build.sh 保持一致）─────
ENV CMAKE_TLS_VERIFY=0

# ── 6. 容器启动时保持 shell 交互 ──────────────────────────────────────────────
CMD ["/bin/bash"]