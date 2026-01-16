/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "error_message_manage.hpp"
#include <map>
#include "task.hpp"
#include "driver.hpp"
#include "runtime.hpp"
#include "tsch_defines.h"
#include "ttlv.hpp"
#if (!defined CFG_DEV_PLATFORM_PC)
#include "error_manager.h"
#endif

namespace cce {
namespace runtime {
void ErrorMessageUtils::RuntimeErrorMessage(const int32_t errCode,
                                            const std::vector<std::string> &errMsgKey,
                                            const std::vector<std::string> &errMsgValue)
{
    UNUSED(errCode);
    UNUSED(errMsgKey);
    UNUSED(errMsgValue);
#if (!defined CFG_DEV_PLATFORM_PC)
    REPORT_ENV_ERROR(GetViewErrorCodeStr(errCode), errMsgKey, errMsgValue);
#endif
}

void ErrorMessageUtils::RuntimeErrorMessage(const std::string &errCode,
                                            const std::vector<std::string> &errMsgKey,
                                            const std::vector<std::string> &errMsgValue)
{
    UNUSED(errCode);
    UNUSED(errMsgKey);
    UNUSED(errMsgValue);
#if (!defined CFG_DEV_PLATFORM_PC)
    REPORT_ENV_ERROR(errCode, errMsgKey, errMsgValue);
#endif
}

void ErrorMessageUtils::FuncErrorReason(const RtInnerErrcodeType rtErrCode, const char_t * const funcName)
{
    switch(rtErrCode) {
        case RT_ERROR_INVALID_VALUE:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "%s execution failed.", funcName);
            break;
        case RT_ERROR_CONTEXT_NULL:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "%s execution failed, %s.", funcName,
                            RT_GET_ERRREASON(rtErrCode).c_str());
            break;
        case RT_ERROR_FEATURE_NOT_SUPPORT:
            RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "%s execution failed, %s.", funcName,
                            RT_GET_ERRREASON(rtErrCode).c_str());
            break;
        case RT_ERROR_STREAM_SYNC_TIMEOUT:
            RT_LOG_OUTER_MSG(RT_STREAM_SYNC_TIMEOUT_INNER_ERROR, "%s execution failed.", funcName);
            break;
        default:
            RT_LOG_CALL_MSG(ERR_MODULE_GE, "%s execution failed, reason=%s", funcName, RT_GET_ERRREASON(rtErrCode).c_str());
            break;
    }
}
}
}
