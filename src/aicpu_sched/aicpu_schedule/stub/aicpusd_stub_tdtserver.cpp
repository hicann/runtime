/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <list>
#include <string>
#include "aicpusd_status.h"
#include "tdt/status.h"
#include "tdt/tdt_device.h"
#include "tdt/train_mode.h"

#ifdef  __cplusplus
namespace tdt {
    int32_t TDTServerInit(const uint32_t deviceID, const std::list<uint32_t>& bindCoreList)
    {
        (void)deviceID;
        (void)bindCoreList;
        aicpusd_debug("In stub function %s", __func__);
        return 0;
    }

    int32_t TDTServerStop()
    {
        aicpusd_debug("In stub function %s", __func__);
        return 0;
    }

    StatusFactory* StatusFactory::GetInstance()
    {
        static StatusFactory instance_;
        return &instance_;
    }

    void StatusFactory::RegisterErrorNo(const uint32_t err, const std::string& desc)
    {
        (void)err;
        (void)desc;
    }

    std::string StatusFactory::GetErrDesc(const uint32_t err)
    {
        (void)err;
        aicpusd_debug("In stub function %s", __func__);
        return "";
    }

    std::string StatusFactory::GetErrCodeDesc(uint32_t errCode)
    {
        (void)errCode;
        aicpusd_debug("In stub function %s", __func__);
        return "";
    }

    StatusFactory::StatusFactory() {}

    int32_t __attribute__((visibility("default"))) TdtDevicePushData(const std::string &channelName, std::vector<DataItem> &items)
    {
        (void)channelName;
        (void)items;
        aicpusd_err("Not support tdt channel");
        return 1;
    }
}

void __attribute__((visibility("default"))) SetTrainMode(TrainMode mode)
{
    (void)mode;
}

#endif