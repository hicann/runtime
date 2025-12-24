# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := msnpureport
LOCAL_SRC_FILES := msnpureport.c \
                   ../shared/log_level_parse.cpp

LOCAL_C_INCLUDES := $(LOCAL_PATH)/ \
                    abl/libc_sec/include \
                    inc/mmpa \
                    inc/toolchain \
                    inc/driver \
                    toolchain/ide/ide-daemon/external \
                    toolchain/log/shared

LOCAL_LDFLAGS := -ldl -Wl,-z,relro -Wl,-z,now -Wl,-z,noexecstack -pie -lrt

ifneq (,$(wildcard $(PWD)/$($(HOST_DEFAULT_COMPILER)_TOOLS_PREFIX)gcc))
CROSS_COMPILE_PREFIX := $(PWD)/$($(HOST_DEFAULT_COMPILER)_TOOLS_PREFIX)
else
CROSS_COMPILE_PREFIX := $($(HOST_DEFAULT_COMPILER)_TOOLS_PREFIX)
endif
GCC_VERSION := $(shell ($(CROSS_COMPILE_PREFIX)gcc --version | head -n1 | cut -d" " -f4))
GCC_VERSION_FLAG := \
$(shell if [[ "$(GCC_VERSION)" > "4.9" ]];then echo 1; else echo 0; fi)
ifeq ($(GCC_VERSION_FLAG), 1)
LOCAL_CFLAGS := -fstack-protector-strong
else
LOCAL_CFLAGS := -fstack-protector-all
endif

LOCAL_CFLAGS += -DOS_TYPE=0 -Wall -O0 -fPIC -Werror -g -fvisibility=hidden

LOCAL_STATIC_LIBRARIES := libc_sec libmmpa libadcore libslog libbbox_dump libadcore

LOCAL_SHARED_LIBRARIES := libascend_hal

include $(BUILD_HOST_EXECUTABLE)

