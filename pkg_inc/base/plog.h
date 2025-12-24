/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PLOG_H_
#define PLOG_H_

#ifdef __cplusplus
#ifndef LOG_CPP
extern "C" {
#endif
#endif // __cplusplus

#if defined(_MSC_VER)
#define LOG_FUNC_VISIBILITY _declspec(dllexport)
#else
#define LOG_FUNC_VISIBILITY __attribute__((visibility("default")))
#endif

/**
 * @ingroup plog
 * @brief DlogReportInitialize: init log in service process before all device setting.
 * @return: 0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int DlogReportInitialize(void) __attribute((weak));

/**
 * @ingroup plog
 * @brief DlogReportFinalize: release log resource in service process after all device reset.
 * @return: 0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int DlogReportFinalize(void) __attribute((weak));

/**
 * @ingroup     : plog
 * @brief       : create thread to recv log from device
 * @param[in]   : devId         device id
 * @param[in]   : mode          use macro LOG_SAVE_MODE_XXX in slog.h
 * @return      : 0: SUCCEED, others: FAILED
 */
LOG_FUNC_VISIBILITY int DlogReportStart(int devId, int mode) __attribute((weak));

/**
 * @ingroup     : plog
 * @brief       : stop recv thread
 * @param[in]   : devId         device id
 */
LOG_FUNC_VISIBILITY void DlogReportStop(int devId) __attribute((weak));


#ifdef __cplusplus
#ifndef LOG_CPP
}
#endif // LOG_CPP
#endif // __cplusplus
#endif // PLOG_H_
