/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __CCE_RUNTIME_ERRCODE_MANAGE_HPP__
#define __CCE_RUNTIME_ERRCODE_MANAGE_HPP__

#include <map>
#include <utility>
#include <string>
#include "base.hpp"
#include "driver/ascend_hal.h"

#define RT_GET_DRV_ERRCODE(drvErrCode) \
    ErrorcodeManage::Instance().GetDrvErrCode(drvErrCode)

#define RT_GET_ERRDESC(rtErrCode) \
    ErrorcodeManage::Instance().GetErrorDesc(rtErrCode)

#define RT_GET_EXT_ERRCODE(rtErrCode) \
    ErrorcodeManage::Instance().GetRtExtErrCode(rtErrCode)

#define RT_TRANS_EXT_ERRCODE(rtErrCode) \
    ErrorcodeManage::Instance().TransExtErrCode(rtErrCode)

#define RT_GET_ERRREASON(rtErrCode) \
    ErrorcodeManage::Instance().GetErrorReason(rtErrCode)

#define RT_GET_MODULE_NAME(moduleId) \
    ErrorcodeManage::Instance().GetModuleName(moduleId)

namespace cce {
namespace runtime {
using DrvErrcodeType = drvError_t;
using RtInnerErrcodeType = rtError_t;
using RtExtErrcodeType = rtError_t;

class ErrorcodeManage {
public:
    static ErrorcodeManage &Instance();

    std::string GetErrorDesc(const RtInnerErrcodeType errcode);

    std::string GetErrorReason(const RtInnerErrcodeType errcode);

    const std::string& GetModuleName(const uint16_t moduleId);

    RtInnerErrcodeType GetDrvErrCode(const DrvErrcodeType drvErrcode);

    RtExtErrcodeType GetRtExtErrCode(const RtInnerErrcodeType errcode);

    RtExtErrcodeType TransExtErrCode(const RtInnerErrcodeType errcode);
    ErrorcodeManage();

    ~ErrorcodeManage() = default;

private:
    void InitRtErrCodeMap();

    void InitDrvErrCodeMap();

    std::map<RtInnerErrcodeType, std::pair<RtExtErrcodeType, const char_t*>> rtErrMap_;
    std::map<DrvErrcodeType, RtInnerErrcodeType>  drvErrMap_;
};

}
}

#endif // __CCE_RUNTIME_ERRCODE_MANAGE_HPP__