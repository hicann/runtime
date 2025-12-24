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
 * \file adx_datadump_server_soc.h
 * \brief
*/

#ifndef ADX_DATADUMP_SERVER_SOC_H
#define ADX_DATADUMP_SERVER_SOC_H
#include <stdint.h>
#include <string>
namespace Adx {
/**
 * @brief initialize server for soc datadump function.
 * @param [in]  hostPid : app pid
 * @return
 *      IDE_DAEMON_OK:    datadump server init success
 *      IDE_DAEMON_ERROR: datadump server init failed
 */
int32_t AdxSocDataDumpInit(const std::string &hostPid);

/**
 * @brief uninitialize server for soc datadump function.
 * @return
 *      IDE_DAEMON_OK:    datadump server uninit success
 *      IDE_DAEMON_ERROR: datadump server uninit failed
 */
int32_t AdxSocDataDumpUnInit();
}
#endif
