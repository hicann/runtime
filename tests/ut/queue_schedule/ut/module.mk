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

SRC_PATH := ../../../../../aicpu/aicpu_device/queue_schedule/

# build st
include $(CLEAR_VARS)

LOCAL_MODULE := queue_schedule_ut
LOCAL_CLASSFILE_RULE := aicpu

LOCAL_SRC_FILES :=  proto/easycom_message.proto \
                    main_ut.cpp \
                    testcase/ezcom_client_utest.cpp \
                    testcase/bqs_client_utest.cpp \
                    testcase/bqs_server_utest.cpp \
                    testcase/queue_schedule_utest.cpp \
                    testcase/subscribe_manager_utest.cpp \
                    testcase/bind_cpu_utils_utest.cpp \
                    testcase/bind_relation_utest.cpp \
                    testcase/bqs_queue_manager_utest.cpp \
                    testcase/statistic_manager_utest.cpp \
                    ../stub/easy_comm_stub.cpp \
                    ../stub/queue_api.cpp \
                    ../stub/driver_stub.cpp \
                    ../stub/event_sched_api.cpp \
                    ../stub/drv_buf_api.cpp \
                    ../stub/profile_stub.cpp \
                    $(SRC_PATH)client/bqs_client.cpp \
                    $(SRC_PATH)client/ezcom_client.cpp \
                    $(SRC_PATH)server/bqs_server.cpp \
                    $(SRC_PATH)server/bind_relation.cpp \
                    $(SRC_PATH)server/bind_cpu_utils.cpp \
                    $(SRC_PATH)server/queue_schedule.cpp \
                    $(SRC_PATH)server/queue_manager.cpp \
                    $(SRC_PATH)server/subscribe_manager.cpp \
                    $(SRC_PATH)server/statistic_manager.cpp \
                    $(SRC_PATH)server/profile_manager.cpp \

LOCAL_C_INCLUDES += $(TOPDIR)aicpu/aicpu_device/queue_schedule/server
LOCAL_C_INCLUDES += $(TOPDIR)aicpu/aicpu_device/queue_schedule/client
LOCAL_C_INCLUDES += $(TOPDIR)aicpu/aicpu_device/queue_schedule/common
LOCAL_C_INCLUDES += $(TOPDIR)aicpu/aicpu_device/queue_schedule/stub
LOCAL_C_INCLUDES += $(TOPDIR)aicpu/aicpu_device/queue_schedule
LOCAL_C_INCLUDES += $(TOPDIR)third_party/protobuf/include
LOCAL_C_INCLUDES += $(TOPDIR)abl/libc_sec/include
LOCAL_C_INCLUDES += $(TOPDIR)inc/toolchain
LOCAL_C_INCLUDES += $(TOPDIR)inc/aicpu/queue_schedule
LOCAL_C_INCLUDES += $(TOPDIR)inc
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../stub
LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(TOPDIR)build/bin/os/yueying/based_linux_sdk/include
LOCAL_C_INCLUDES += $(TOPDIR)toolchain/profiler_ext/include/profiler

LOCAL_CFLAGS := -rdynamic -fpermissive -DSTATISTIC -Dgoogle=ascend_private

LOCAL_LDFLAGS := -rdynamic

LOCAL_SHARED_LIBRARIES := \
    libascend_protobuf \
    libc_sec \

LOCAL_STATIC_LIBRARIES :=

include $(BUILD_UT_TEST)

