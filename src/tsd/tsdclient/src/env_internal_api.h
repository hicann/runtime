/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_TSDCLIENT_INC_ENV_INTERNAL_API_H
#define TDT_TSDCLIENT_INC_ENV_INTERNAL_API_H

#include "inc/log.h"
#include "mmpa/mmpa_api.h"

namespace tsd {
    /**
     * @ingroup
     * @brief read env value
     * @param [in] id : env id
     * @param [in] envName : env to get
     * @param [out] envValue : result
     * @return : void
     */
    void GetEnvFromMmSys(mmEnvId id, const char *envName, std::string &envValue);

    /**
     * @ingroup IsFpgaMmSysEnv
     * @brief 读环境变量判断当前是否是FPGA环境
     * @return : true: fpga环境， false: 非fpga环境
     */
    bool IsFpgaMmSysEnv();

    /**
     * @ingroup IsAsanMmSysEnv
     * @brief 读环境变量判断当前是否是ASAN环境
     * @return : true: asan环境， false: 非asan环境
     */
    bool IsAsanMmSysEnv();

    /**
     * @ingroup
     * @brief If the envStr value is same as envValue passed in, return true
     * @param [in] id : env id
     * @param [in] ：envStr：env name
     * @param [in] ：envValue：expected env value
     * @return : true, if value equal to envValue
     */
    bool GetFlagFromMmSys(mmEnvId id, const char_t * const envStr, const char_t * const envValue);
}
#endif  // TDT_TSDCLIENT_INC_ENV_INTERNAL_API_H
