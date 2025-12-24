/**
  * Copyright (c) 2025 Huawei Technologies Co., Ltd.
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
  * CANN Open Software License Agreement Version 2.0 (the "License").
  * Please refer to the License for details. You may not use this file except in compliance with the License.
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
  * See LICENSE in the root of the software repository for the full text of the License.
  */

/*!
 * \file adx_datadump_server.h
 * \brief
*/

#ifndef ADX_DATADUMP_SERVER_H
#define ADX_DATADUMP_SERVER_H
#ifdef __cplusplus
extern "C" {
#endif

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define ADX_API __declspec(dllexport)
#else
#define ADX_API __attribute__((visibility("default")))
#endif

/**
 * @brief initialize server for normal datadump function.
 * @return
 *      IDE_DAEMON_OK:    datadump server init success
 *      IDE_DAEMON_ERROR: datadump server init failed
 */
ADX_API int AdxDataDumpServerInit();

/**
 * @brief uninitialize server for normal datadump function.
 * @return
 *      IDE_DAEMON_OK:    datadump server uninit success
 *      IDE_DAEMON_ERROR: datadump server uninit failed
 */
ADX_API int AdxDataDumpServerUnInit();

#ifdef __cplusplus
}
#endif
#endif

