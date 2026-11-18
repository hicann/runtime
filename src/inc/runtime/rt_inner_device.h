/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_RT_INNER_DEVICE_H
#define CCE_RUNTIME_RT_INNER_DEVICE_H

#include "base.h"

#if defined(__cplusplus)
constexpr uint32_t MAX_DEVICE_SUSPEND_TASK_INTERVAL = 1024U;

extern "C" {
#endif

enum rtDeviceSuspendMode {
    RT_DEVICE_SUSPEND_MODE_DISABLE = 0,
    RT_DEVICE_SUSPEND_MODE_DEVICE = 1,
};

typedef struct rtDeviceSuspendConfig {
    rtDeviceSuspendMode mode;
    uint32_t taskInterval;
    uint32_t reserved[6];
} rtDeviceSuspendConfig;

enum rtAtomicOperationCapability {
    RT_ATOMIC_CAPABILITY_SIGNED = 1U << 0U,
    RT_ATOMIC_CAPABILITY_UNSIGNED = 1U << 1U,
    RT_ATOMIC_CAPABILITY_REDUCATION = 1U << 2U, // DEPRECATED: Use RT_ATOMIC_CAPABILITY_REDUCTION
    RT_ATOMIC_CAPABILITY_REDUCTION = 1U << 2U,
    RT_ATOMIC_CAPABILITY_SCALAR8 = 1U << 3U,
    RT_ATOMIC_CAPABILITY_SCALAR16 = 1U << 4U,
    RT_ATOMIC_CAPABILITY_SCALAR32 = 1U << 5U,
    RT_ATOMIC_CAPABILITY_SCALAR64 = 1U << 6U,
    RT_ATOMIC_CAPABILITY_SCALAR128 = 1U << 7U,
    RT_ATOMIC_CAPABILITY_VECTOR32X4 = 1U << 8U,
};

enum rtAtomicOperation {
    RT_ATOMIC_OPERATION_INTEGER_ADD = 0,
    RT_ATOMIC_OPERATION_INTEGER_MIN = 1,
    RT_ATOMIC_OPERATION_INTEGER_MAX = 2,
    RT_ATOMIC_OPERATION_INTEGER_INCREMENT = 3,
    RT_ATOMIC_OPERATION_INTEGER_DECREMENT = 4,
    RT_ATOMIC_OPERATION_AND = 5,
    RT_ATOMIC_OPERATION_OR = 6,
    RT_ATOMIC_OPERATION_XOR = 7,
    RT_ATOMIC_OPERATION_EXCHANGE = 8,
    RT_ATOMIC_OPERATION_CAS = 9,
    RT_ATOMIC_OPERATION_FLOAT_ADD = 10,
    RT_ATOMIC_OPERATION_FLOAT_MIN = 11,
    RT_ATOMIC_OPERATION_FLOAT_MAX = 12,

    RT_ATOMIC_OPERATION_DMA_ADD = 30,
    RT_ATOMIC_OPERATION_DMA_MIN = 31,
    RT_ATOMIC_OPERATION_DMA_MAX = 32,

    RT_ATOMIC_OPERATION_SIMD_SCALAR_ADD = 40,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_MIN = 41,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_MAX = 42,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_CAS = 43,
    RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH = 44,
};

#ifndef RT_DEVICE_ATTR_DEFINED
#define RT_DEVICE_ATTR_DEFINED
typedef enum {
    RT_DEV_ATTR_AICPU_CORE_NUM = 1U,
    RT_DEV_ATTR_AICORE_CORE_NUM = 101U,
    RT_DEV_ATTR_CUBE_CORE_NUM = 102U,

    RT_DEV_ATTR_VECTOR_CORE_NUM = 201U,
    RT_DEV_ATTR_WARP_SIZE = 202U,
    RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE = 203U,
    RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE RT_DEPRECATED_MESSAGE("Use RT_DEV_ATTR_UBUF_PER_VECTOR_CORE instead") =
        204U, // DEPRECATED: Use RT_DEV_ATTR_UBUF_PER_VECTOR_CORE
    RT_DEV_ATTR_UBUF_PER_VECTOR_CORE = 204U,
    RT_DEV_ATTR_MAX_GRID_DIM_X = 205U,
    RT_DEV_ATTR_MAX_GRID_DIM_Y = 206U,
    RT_DEV_ATTR_MAX_GRID_DIM_Z = 207U,
    RT_DEV_ATTR_MAX_BLOCK_PER_GRID = 208U,
    RT_DEV_ATTR_MAX_THREADS_PER_BLOCK = 209U,
    RT_DEV_ATTR_MAX_BLOCK_DIM_X = 210U,
    RT_DEV_ATTR_MAX_BLOCK_DIM_Y = 211U,
    RT_DEV_ATTR_MAX_BLOCK_DIM_Z = 212U,

    RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE = 301U, /* total available global mem */
    RT_DEV_ATTR_L2_CACHE_SIZE = 302U,

    // MODULE_TYPE_SYSTEM
    RT_DEV_ATTR_SMP_ID = 401U,               // indicates whether devices are on the same OS
    RT_DEV_ATTR_PHY_CHIP_ID = 402U,          // physical chip id
    RT_DEV_ATTR_SUPER_POD_DEVICE_ID = 403U,  // super pod device id
    RT_DEV_ATTR_SUPER_POD_SERVER_ID = 404U,  // super pod server id
    RT_DEV_ATTR_SUPER_POD_ID = 405U,         // super pod id
    RT_DEV_ATTR_CUST_OP_PRIVILEGE = 406U,    // indicates whether the custom operator privilege is enabled
    RT_DEV_ATTR_MAINBOARD_ID = 407U,         // mainboard id
    RT_DEV_ATTR_HD_CONNECT_TYPE = 408U,      // host-device connect type
    RT_DEV_ATTR_DEVICE_FORM_FACTOR = 409U,   // device form factor (pod/server/pcie card)
    RT_DEV_ATTR_SUPER_POD_CHASSIS_ID = 410U, // super pod chassis id
    RT_DEV_ATTR_HOST_NUMA_ID = 411U,         // nearest host NUMA node id

    RT_DEV_ATTR_IS_VIRTUAL = 501U,           // is_virtual

    RT_DEV_ATTR_NPU_ARCH = 601U,             // npu arch

    RT_DEV_ATTR_MAX
} rtDevAttr;
#endif // RT_DEVICE_ATTR_DEFINED

#ifndef RT_DEVICE_GET_INFO_DECLARED
#define RT_DEVICE_GET_INFO_DECLARED
/**
 * @ingroup rts_device
 * @brief get device information.
 * @param [in] device the device id
 * @param [in] attr device attr
 * @param [out] val   the device info
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_DRV_ERR for error
 */
RTS_API RT_DEPRECATED_MESSAGE(RT_RUNTIME_DEPRECATED_MESSAGE) rtError_t
    rtsDeviceGetInfo(uint32_t deviceId, rtDevAttr attr, int64_t* val);
#endif // RT_DEVICE_GET_INFO_DECLARED

/**
 * @ingroup dvrt_dev
 * @brief get h2d atomic capabilities by device id
 * @param [out] capabilities   atomic capabilities
 * @param [in] operations   atomic operations
 * @param [in] count   atomic operations count
 * @param [in] deviceId   device id
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDeviceGetHostAtomicCapabilities(
    uint32_t* capabilities, const rtAtomicOperation* operations, const uint32_t count, int32_t deviceId);

/**
 * @ingroup dvrt_dev
 * @brief get p2p atomic capabilities by device id
 * @param [out] capabilities   atomic capabilities
 * @param [in] operations   atomic operations
 * @param [in] count   atomic operations count
 * @param [in] srcDeviceId   source device id
 * @param [in] dstDeviceId   destination device id
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtDeviceGetP2PAtomicCapabilities(
    uint32_t* capabilities, const rtAtomicOperation* operations, const uint32_t count, int32_t srcDeviceId,
    int32_t dstDeviceId);

/**
 * @ingroup dvrt_dev
 * @brief get device resource limit value
 * @param [in] type   limit type
 * @param [out] val   limit value
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtDeviceGetLimit(rtLimitType_t type, uint32_t* val);

/**
 * @ingroup dvrt_dev
 * @brief Flush L2 cache for current device
 * @param [in] rsv Reserved parameter, must be nullptr
 * @return RT_ERROR_NONE for success
 * @return RT_ERROR_FEATURE_NOT_SUPPORT driver does not support this feature
 */
RTS_API rtError_t rtDeviceL2CacheFlush(void* rsv);

/**
 * @ingroup dvrt_dev
 * @brief Set the synchronization waiting mode of the current context
 * @param [in] flags  synchronization waiting mode, must be RT_DEVICE_SCHEDULE_AUTO, RT_DEVICE_SCHEDULE_SPIN,
 *                   RT_DEVICE_SCHEDULE_YIELD or RT_DEVICE_SCHEDULE_BLOCKING_SYNC.
 * @return RT_ERROR_NONE for success
 * @return Other values for failure
 */
RTS_API rtError_t rtSetDeviceFlags(uint32_t flags);

/**
 * @ingroup dvrt_dev
 * @brief Get the synchronization waiting mode of the current context
 * @param [out] flags  synchronization waiting mode, cannot be NULL
 * @return RT_ERROR_NONE for success
 * @return Other values for failure
 */
RTS_API rtError_t rtGetDeviceFlags(uint32_t* flags);

/**
 * @ingroup dvrt_dev
 * @brief get device confidential computing mode
 * @param [in] deviceId   device id
 * @param [out] mode   cc mode (0=off, 1=on, 2=devtools)
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_FEATURE_NOT_SUPPORT driver does not support this feature
 */
RTS_API rtError_t rtDeviceGetCcMode(int32_t deviceId, int32_t* mode);

/**
 * @ingroup dvrt_dev
 * @brief Set the execution suspend configuration for the specified device in the current process
 * @param [in] deviceId  the logical device ID
 * @param [in] config  configuration, cannot be NULL. mode must be RT_DEVICE_SUSPEND_MODE_DISABLE or
 *                     RT_DEVICE_SUSPEND_MODE_DEVICE. taskInterval must be in [0, 1024]; when enabled,
 *                     0 selects the default interval of 8 operators. All reserved elements must be 0.
 * @return RT_ERROR_NONE for success
 * @return Other values for failure
 */
RTS_API rtError_t rtDeviceSetSuspendConfig(const int32_t deviceId, const rtDeviceSuspendConfig* const config);

/**
 * @ingroup dvrt_dev
 * @brief Get the execution suspend configuration for the specified device in the current process
 * @param [in] deviceId  the logical device ID
 * @param [out] config   configuration, cannot be NULL. All reserved elements are set to 0 on success.
 * @return RT_ERROR_NONE for success
 * @return Other values for failure
 */
RTS_API rtError_t rtDeviceGetSuspendConfig(const int32_t deviceId, rtDeviceSuspendConfig* const config);

/**
 * @ingroup dvrt_dev
 * @brief Suspend execution at gate waits on the specified device in the current process
 * @param [in] deviceId  the logical device ID
 * @param [in] flag  reserved parameter, must be 0
 * @return RT_ERROR_NONE when the gate Reset operation has completed
 * @return Other values for failure
 */
RTS_API rtError_t rtDeviceSuspendExecution(const int32_t deviceId, const uint32_t flag);

/**
 * @ingroup dvrt_dev
 * @brief Resume execution at gate waits on the specified device in the current process
 * @param [in] deviceId  the logical device ID
 * @param [in] flag  reserved parameter, must be 0
 * @return RT_ERROR_NONE when the gate Record operation has completed
 * @return Other values for failure
 */
RTS_API rtError_t rtDeviceResumeExecution(const int32_t deviceId, const uint32_t flag);

#if defined(__cplusplus)
}
#endif
#endif // CCE_RUNTIME_RT_INNER_DEVICE_H
