# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_PRODUCT),mini)
ifeq ($(chip_id),hi1951)
    RUNTIME_FEATRUE_CFLAGS += -DFEATURE_NOTIFY -DFEATURE_PCTRACE -DFEATURE_DEBUG
else
    RUNTIME_FEATRUE_CFLAGS +=
endif
else
    RUNTIME_FEATRUE_CFLAGS += -DFEATURE_NOTIFY -DFEATURE_PCTRACE -DFEATURE_DEBUG
endif

include $(CLEAR_VARS)

LOCAL_INC_COV_BLACKLIST := $(LOCAL_PATH)/ut_runtime_black_list.txt
LOCAL_MODULE := driver_stub_utest

LOCAL_SRC_FILES := ../../../../runtime/cmodel_driver/driver_api.c \
                   ../../../../runtime/cmodel_driver/driver_impl.c \
                   ../../../../runtime/cmodel_driver/driver_mem.c \
                   ../../../../runtime/cmodel_driver/driver_queue.c \
                   test/main.cc \
				   test/drv_utest_device.cc\
				   test/drv_utest_event.cc\
				   test/drv_utest_stream.cc\
				   test/drv_utest_model.cc\
				   test/drv_utest_mem.cc\
				   test/drv_utest_dispatch.cc\
                   stub/drv_utest_stub.cc
				   
LOCAL_C_INCLUDES := $(TOPDIR)inc ${TOP_DIR}/inc/external $(TOPDIR) $(TOPDIR)runtime/cmodel_driver abl/libc_sec/include 

LOCAL_STATIC_LIBRARIES := libc_sec

LOCAL_CFLAGS += -DDRIVER_NEW_API $(RUNTIME_FEATRUE_CFLAGS)

include $(BUILD_UT_TEST)
