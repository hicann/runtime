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


libnpu_drv_common_src_files := driver_api.c \
                               driver_impl.c \
                               driver_mem.c \
                               driver_queue.c

MODEL_VERSION := MODEL_V100
ifeq ($(chip_id),hi1910p)
    MODEL_VERSION := MODEL_V200
else ifeq ($(chip_id),bs9sx1a)
    MODEL_VERSION := MODEL_V210
else ifeq ($(chip_id),npuf10)
    MODEL_VERSION := MODEL_V200
endif

ifeq ($(TARGET_PRODUCT),mini)
    ifeq ($(chip_id),hi1910p)
        MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_MINI_V2
    else
        MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_MINI_V1
    endif
else ifeq ($(TARGET_PRODUCT),cloud)
    MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_CLOUD_V1
else ifeq ($(TARGET_PRODUCT),mdc)
    MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_MINI_V2
else ifeq ($(TARGET_PRODUCT),lhisi)
    MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_LHISI_ES
else ifeq ($(TARGET_PRODUCT),onetrack)
    ifeq ($(chip_id),hi1910p)
        MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_MINI_V2
    else
        MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_MINI_V1
    endif
else
    MODEL_DRV_LOCAL_CFLAGS += -DPLATFORM_MINI_V1
endif

LOCAL_CFLAGS += -DFEATURE_NOTIFY

#compile for host
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_SHARED_LIBRARIES := libc_sec

LOCAL_CFLAGS +=-D__DRV_CFG_DEV_PLATFORM_ESL__ -O3 -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

include $(BUILD_HOST_SHARED_LIBRARY)


#compile for device
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)


LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver
LOCAL_SHARED_LIBRARIES := libc_sec

LOCAL_CFLAGS +=-D__DRV_CFG_DEV_PLATFORM_ESL__ -O3 -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

include $(BUILD_SHARED_LIBRARY)


#compile for cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_SHARED_LIBRARIES := libc_sec libtsch lib_pvmodel

LOCAL_CFLAGS += -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for mini cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := ascend310/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver
LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend310
LOCAL_SHARED_LIBRARIES := libc_sec ascend310/libtsch ascend310/lib_pvmodel

LOCAL_CFLAGS += -DMODEL_V100 -DPLATFORM_MINI_V1

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for cloud cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := ascend910/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend910

LOCAL_SHARED_LIBRARIES := libc_sec ascend910/libtsch ascend910/lib_pvmodel

LOCAL_CFLAGS += -DMODEL_V100 -DPLATFORM_CLOUD_V1

include $(BUILD_HOST_SHARED_LIBRARY)

# for ops llt
include $(CLEAR_VARS)
LOCAL_MODULE := simulator/Ascend910/lib/libnpu_drv_pvmodel
LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver
LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend910
LOCAL_SHARED_LIBRARIES := libc_sec simulator/Ascend910/lib/libtsch simulator/Ascend910/lib/lib_pvmodel
LOCAL_CFLAGS += -DMODEL_V100 -DPLATFORM_CLOUD_V1
include $(BUILD_LLT_SHARED_LIBRARY)

#compile for adc 51 cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := ascend610/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend610

LOCAL_SHARED_LIBRARIES := libc_sec ascend610/libtsch ascend610/lib_pvmodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for adc 51 bs9sx1a cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := bs9sx1a/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/bs9sx1a

LOCAL_SHARED_LIBRARIES := libc_sec bs9sx1a/libtsch bs9sx1a/lib_pvmodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for mini 51 cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := asd710/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/asd710

LOCAL_SHARED_LIBRARIES := libc_sec asd710/libtsch asd710/lib_pvmodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2


include $(BUILD_HOST_SHARED_LIBRARY)

#compile for hi3796cv300es cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := hi3796cv300es/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/hi3796cv300es

LOCAL_SHARED_LIBRARIES := libc_sec hi3796cv300es/libtsch hi3796cv300es/lib_pvmodel

LOCAL_CFLAGS += -O3 -DMODEL_V200 -DPLATFORM_LHISI_ES

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for hi3796cv300cs cmodel
include $(CLEAR_VARS)

LOCAL_MODULE := hi3796cv300cs/libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/hi3796cv300cs

LOCAL_SHARED_LIBRARIES := libc_sec hi3796cv300cs/libtsch hi3796cv300cs/lib_pvmodel

LOCAL_CFLAGS += -O3 -DMODEL_V200 -DPLATFORM_LHISI_ES

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for camodel
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_SHARED_LIBRARIES := libc_sec libtsch_camodel libcamodel

LOCAL_CFLAGS += -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

include $(BUILD_LLT_SHARED_LIBRARY)

#compile for camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_SHARED_LIBRARIES := libc_sec libtsch_camodel libcamodel

LOCAL_CFLAGS += -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for mini camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := ascend310/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend310

LOCAL_SHARED_LIBRARIES := libc_sec ascend310/libtsch_camodel ascend310/libcamodel

LOCAL_CFLAGS += -DMODEL_V100 -DPLATFORM_MINI_V1

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for cloud camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := ascend910/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend910

LOCAL_SHARED_LIBRARIES := libc_sec ascend910/libtsch_camodel ascend910/libcamodel

LOCAL_CFLAGS += -DMODEL_V100 -DPLATFORM_CLOUD_V1

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for adc 51 camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := ascend610/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend610

LOCAL_SHARED_LIBRARIES := libc_sec ascend610/libtsch_camodel ascend610/libcamodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for adc 51 bs9sx1a camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := bs9sx1a/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/bs9sx1a

LOCAL_SHARED_LIBRARIES := libc_sec bs9sx1a/libtsch_camodel bs9sx1a/libcamodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2

include $(BUILD_HOST_SHARED_LIBRARY)


#compile for adc 51 ascend610Lite camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := ascend610Lite/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/ascend610Lite

LOCAL_SHARED_LIBRARIES := libc_sec ascend610Lite/libtsch_camodel ascend610Lite/libcamodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for mini 51 camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := asd710/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/asd710

LOCAL_SHARED_LIBRARIES := libc_sec asd710/libtsch_camodel asd710/libcamodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_MINI_V2

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for hi3796cv300es camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := hi3796cv300es/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/hi3796cv300es

LOCAL_SHARED_LIBRARIES := libc_sec hi3796cv300es/libtsch_camodel hi3796cv300es/libcamodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_LHISI_ES

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for hi3796cv300cs camodel in host
include $(CLEAR_VARS)

LOCAL_MODULE := hi3796cv300cs/libnpu_drv_camodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_LD_DIRS := -L$(HOST_OUT_ROOT)/obj/lib/hi3796cv300cs

LOCAL_SHARED_LIBRARIES := libc_sec hi3796cv300cs/libtsch_camodel hi3796cv300cs/libcamodel

LOCAL_CFLAGS += -DMODEL_V200 -DPLATFORM_LHISI_ES

include $(BUILD_HOST_SHARED_LIBRARY)

#compile for ut/st
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_SHARED_LIBRARIES := libc_sec

LOCAL_CFLAGS += -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

ifeq ($(strip $(FUZZ_TEST)),true)
LOCAL_CFLAGS +=-D__LIBFUZZER_HBM_ASAN__
endif

include $(BUILD_LLT_SHARED_LIBRARY)

#compile for ut/st
include $(CLEAR_VARS)

LOCAL_MODULE := libnpu_drv_pvmodel

LOCAL_SRC_FILES := $(libnpu_drv_common_src_files)

LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../inc \
                    $(LOCAL_PATH)/../../inc/external \
                    $(LOCAL_PATH)/../../abl/libc_sec/include \
                    $(LOCAL_PATH)/../raw_driver

LOCAL_SHARED_LIBRARIES := libc_sec libtsch lib_pvmodel_mini

LOCAL_CFLAGS += -D$(MODEL_VERSION) $(MODEL_DRV_LOCAL_CFLAGS)

include $(BUILD_LLT_SHARED_LIBRARY)


