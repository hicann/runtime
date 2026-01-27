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

# build ut
include $(CLEAR_VARS)

LOCAL_MODULE := aicpu_sharder_utest
LOCAL_CLASSFILE_RULE := aicpu

LOCAL_SRC_FILES :=  ../../../../../../aicpu/aicpu_device/utils/aicpu_sharder/aicpu_sharder.cc \
                    ../../../../../../aicpu/aicpu_device/utils/aicpu_sharder/aicpu_pulse.cc \
                    testcase/aicpu_sharder_ut.cc \
                    testcase/aicpu_pulse_ut.cc \
                    main_ut.cc \

LOCAL_C_INCLUDES := $(TOPDIR)inc \
                    $(TOPDIR)inc/aicpu/aicpu_schedule/aicpu_sharder \
                    $(TOPDIR)llt/third_party/googletest/include \

LOCAL_CFLAGS := -DAICPU_SHARDER_UTST

LOCAL_LDFLAGS :=
LOCAL_SHARED_LIBRARIES := libc_sec
LOCAL_STATIC_LIBRARIES :=

include $(BUILD_UT_TEST)
