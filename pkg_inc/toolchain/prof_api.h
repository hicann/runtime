/**
 * @file prof_api.h
 *
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 *
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 *
 */

#ifndef PROF_API_H
#define PROF_API_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "prof_common.h"

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define MSVP_PROF_API __declspec(dllexport)
#else
#define MSVP_PROF_API __attribute__((visibility("default")))
#endif

/*
 * @ingroup libprofapi
 * @name  profRegReporterCallback
 * @brief register report callback interface for atlas
 * @param [in] reporter: reporter callback handle
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t profRegReporterCallback(MsprofReportHandle reporter);

/*
 * @ingroup libprofapi
 * @name  profRegCtrlCallback
 * @brief register control callback, interface for atlas
 * @param [in] handle: control callback handle
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t profRegCtrlCallback(MsprofCtrlHandle handle);

/*
 * @ingroup libprofapi
 * @name  profRegDeviceStateCallback
 * @brief register device state notify callback, interface for atlas
 * @param [in] handle: handle of ProfNotifySetDevice
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t profRegDeviceStateCallback(MsprofSetDeviceHandle handle);

/*
 * @ingroup libprofapi
 * @name  profGetDeviceIdByGeModelIdx
 * @brief get device id by model id, interface for atlas
 * @param [in] modelIdx: ge model id
 * @param [out] deviceId: device id
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t profGetDeviceIdByGeModelIdx(const uint32_t modelIdx, uint32_t *deviceId);

/*
 * @ingroup libprofapi
 * @name  profSetProfCommand
 * @brief register set profiling command, interface for atlas
 * @param [in] command: 0 isn't aging, !0 is aging
 * @param [in] len: api of timestamp data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t profSetProfCommand(VOID_PTR command, uint32_t len);

/*
 * @ingroup libprofapi
 * @name  profSetStepInfo
 * @brief set step info for torch, interface for atlas
 * @param [in] indexId: id of iteration index
 * @param [in] tagId: id of tag
 * @param [in] stream: api of timestamp data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t profSetStepInfo(const uint64_t indexId, const uint16_t tagId, void* const stream);

/*
 * @ingroup libprofapi
 * @name  MsprofRegisterProfileCallback
 * @brief register profile callback by callback type, interface for atlas
 * @param [in] callbackType: type of callback(reporter/ctrl/device state/command)
 * @param [in] callback: callback of profile
 * @param [in] len: callback length
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofRegisterProfileCallback(int32_t callbackType, VOID_PTR callback, uint32_t len);

/**
 * @ingroup libprofapi
 * @name  MsprofSetConfig
 * @brief Set profiling config
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofSetConfig(uint32_t configType, const char *config, size_t configLength);

/**
 * @ingroup libprofapi
 * @name  MsprofReportData
 * @brief report profiling data of module
 * @param [in] moduleId: module id
 * @param [in] type: report type(init/uninit/max length/hash)
 * @param [in] data: profiling data
 * @param [in] len: length of profiling data
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofReportData(uint32_t moduleId, uint32_t type, VOID_PTR data, uint32_t len);

/**
 * @ingroup libprofapi
 * @name  register report interface for atlas
 * @brief report api timestamp
 * @param [in] chipId: multi die's chip
 * @param [in] deviceId: device id
 * @param [in] isOpen: device is open
 * @return 0:SUCCESS, !0:FAILED
 */
MSVP_PROF_API int32_t MsprofNotifySetDevice(uint32_t chipId, uint32_t deviceId, bool isOpen);

/**
 * @ingroup libprofapi
 * @name MsprofStart
 * @brief profiling start
 * @param dataType: MsprofCtrlCallbackType
 * @param data: MsprofConfig
 * @param dataLen: length of MsprofConfig
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t MsprofStart(uint32_t dataType, const void *data, uint32_t length);
 
/**
 * @ingroup libprofapi
 * @name MsprofStop
 * @brief profiling stop
 * @param dataType: MsprofCtrlCallbackType
 * @param data: MsprofConfig
 * @param dataLen: length of MsprofConfig
 * @return 0:SUCCESS, !0:FAILED
 */
int32_t MsprofStop(uint32_t dataType, const void *data, uint32_t length);
#ifdef __cplusplus
}
#endif

#endif
