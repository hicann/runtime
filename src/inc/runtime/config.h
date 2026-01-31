/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef CCE_RUNTIME_CONFIG_H
#define CCE_RUNTIME_CONFIG_H

#include "base.h"

#if defined(__cplusplus)
extern "C" {
#endif

#define PLAT_COMBINE(arch, chip, ver) (((arch) << 16U) | ((chip) << 8U) | (ver))
#define PLAT_GET_ARCH(type)           (((type) >> 16U) & 0xffffU)
#define PLAT_GET_CHIP(type)           (((type) >> 8U) & 0xffU)
#define PLAT_GET_VER(type)            ((type) & 0xffU)

typedef enum tagRtAicpuScheType {
    SCHEDULE_SOFTWARE = 0, /* Software Schedule */
    SCHEDULE_SOFTWARE_OPT,
    SCHEDULE_HARDWARE, /* HWTS Schedule */
} rtAicpuScheType;

typedef enum tagRtDeviceCapabilityType {
	RT_SCHEDULE_SOFTWARE = 0, // Software Schedule
	RT_SCHEDULE_SOFTWARE_OPT,
	RT_SCHEDULE_HARDWARE, // HWTS Schedule
	RT_AICPU_BLOCKING_OP_NOT_SUPPORT,
	RT_AICPU_BLOCKING_OP_SUPPORT, // 1910/1980/51 ts support AICPU blocking operation
	RT_MODE_NO_FFTS, // no ffts
	RT_MODE_FFTS, // 81 get ffts work mode, ffts
	RT_MODE_FFTS_PLUS, // 81 get ffts work mode, ffts plus
	RT_DEV_CAP_SUPPORT, // Capability Support
	RT_DEV_CAP_NOT_SUPPORT, // Capability not support
} rtDeviceCapabilityType;

typedef enum tagRtCubeFracMKNFp16 {
    RT_CUBE_MKN_FP16_2_16_16 = 0,
    RT_CUBE_MKN_FP16_4_16_16,
    RT_CUBE_MKN_FP16_16_16_16,
    RT_CUBE_MKN_FP16_Default,
} rtCubeFracMKNFp16_t;

typedef enum tagRtCubeFracMKNInt8 {
    RT_CUBE_MKN_INT8_2_32_16 = 0,
    RT_CUBE_MKN_INT8_4_32_4,
    RT_CUBE_MKN_INT8_4_32_16,
    RT_CUBE_MKN_INT8_16_32_16,
    RT_CUBE_MKN_INT8_Default,
} rtCubeFracMKNInt8_t;

typedef enum tagRtVecFracVmulMKNFp16 {
    RT_VEC_VMUL_MKN_FP16_1_16_16 = 0,
    RT_VEC_VMUL_MKN_FP16_Default,
} rtVecFracVmulMKNFp16_t;

typedef enum tagRtVecFracVmulMKNInt8 {
    RT_VEC_VMUL_MKN_INT8_1_32_16 = 0,
    RT_VEC_VMUL_MKN_INT8_Default,
} rtVecFracVmulMKNInt8_t;

typedef struct tagRtAiCoreSpec {
    uint32_t cubeFreq;
    uint32_t cubeMSize;
    uint32_t cubeKSize;
    uint32_t cubeNSize;
    rtCubeFracMKNFp16_t cubeFracMKNFp16;
    rtCubeFracMKNInt8_t cubeFracMKNInt8;
    rtVecFracVmulMKNFp16_t vecFracVmulMKNFp16;
    rtVecFracVmulMKNInt8_t vecFracVmulMKNInt8;
} rtAiCoreSpec_t;

typedef struct tagRtAiCoreRatesPara {
    uint32_t ddrRate;
    uint32_t l2Rate;
    uint32_t l2ReadRate;
    uint32_t l2WriteRate;
    uint32_t l1ToL0ARate;
    uint32_t l1ToL0BRate;
    uint32_t l0CToUBRate;
    uint32_t ubToL2;
    uint32_t ubToDDR;
    uint32_t ubToL1;
} rtAiCoreMemoryRates_t;

typedef struct tagRtMemoryConfig {
    uint32_t flowtableSize;
    uint32_t compilerSize;
} rtMemoryConfig_t;

typedef struct tagRtPlatformConfig {
    uint32_t platformConfig;
} rtPlatformConfig_t;

typedef enum tagRTTaskTimeoutType {
    RT_TIMEOUT_TYPE_OP_WAIT = 0,
    RT_TIMEOUT_TYPE_OP_EXECUTE,
} rtTaskTimeoutType_t;

typedef enum tagRTLastErrLevel {
    RT_THREAD_LEVEL = 0,
    RT_CONTEXT_LEVEL,
} rtLastErrLevel_t;
/**
 * @ingroup
 * @brief get AI core count
 * @param [in] aiCoreCnt
 * @return aiCoreCnt
 */
RTS_API rtError_t rtGetAiCoreCount(uint32_t *aiCoreCnt);

/**
 * @ingroup
 * @brief get AI cpu count
 * @param [in] aiCpuCnt
 * @return aiCpuCnt
 */
RTS_API rtError_t rtGetAiCpuCount(uint32_t *aiCpuCnt);

/**
 * @ingroup
 * @brief get runtime version. The version is returned as (1000 major + 10 minor). For example, RUNTIME 9.2 would be
 *        represented by 9020.
 * @param [out] runtimeVersion
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetRuntimeVersion(uint32_t *runtimeVersion);


/**
 * @ingroup
 * @brief get device feature ability by device id, such as task schedule ability.
 * @param [in] deviceId
 * @param [in] moduleType
 * @param [in] featureType
 * @param [out] val
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetDeviceCapability(int32_t deviceId, int32_t moduleType, int32_t featureType, int32_t *val);

/**
 * @ingroup
 * @brief set event wait task timeout time.
 * @param [in] timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetOpWaitTimeOut(uint32_t timeout);

/**
 * @ingroup
 * @brief set op execute task timeout time.
 * @param [in] timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetOpExecuteTimeOut(uint32_t timeout);

/**
 * @ingroup
 * @brief set op execute task timeout time with ms.
 * @param [in] timeout/ms
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */

RTS_API rtError_t rtSetOpExecuteTimeOutWithMs(uint32_t timeout);
/**
 * @ingroup
 * @brief get op execute task timeout time.
 * @param [out] timeout
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetOpExecuteTimeOut(uint32_t * const timeout);

/**
 * @ingroup
 * @brief get op execute task timeout interval.
 * @param [out] interval op execute task timeout interval, unit:us
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetOpTimeOutInterval(uint64_t *interval);
 
/**
 * @ingroup
 * @brief set op execute task timeout.
 * @param [in] timeout  op execute task timeout, unit:us
 * @param [out] actualTimeout actual op execute task timeout, unit:us
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtSetOpExecuteTimeOutV2(uint64_t timeout, uint64_t *actualTimeout);

/**
 * @ingroup
 * @brief get the timeout duration for operator execution.
 * @param [out] timeout(ms)
 * @return RT_ERROR_NONE for ok
 * @return RT_ERROR_INVALID_VALUE for error input
 */
RTS_API rtError_t rtGetOpExecuteTimeoutV2(uint32_t *const timeout);

/**
 * @ingroup
 * @brief get is Heterogenous.
 * @param [out] heterogenous=1 Heterogenous Mode: read isHeterogenous=1 in ini file.
 * @param [out] heterogenous=0 NOT Heterogenous Mode:
 *      1:not found ini file, 2:error when reading ini, 3:Heterogenous value is not 1
 * @return RT_ERROR_NONE for ok
 */
RTS_API rtError_t rtGetIsHeterogenous(int32_t *heterogenous);

/**
 * @ingroup
 * @brief get latest errcode and clear it.
 * @param [in] level error level for this api.
 * @return return for error code
 */
RTS_API rtError_t rtGetLastError(rtLastErrLevel_t level);

/**
 * @ingroup
 * @brief get latest errcode.
 * @param [in] level error level for this api.
 * @return return for error code
 */
RTS_API rtError_t rtPeekAtLastError(rtLastErrLevel_t level);
#if defined(__cplusplus)
}
#endif

#endif // CCE_RUNTIME_CONFIG_H
