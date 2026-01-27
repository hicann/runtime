/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "inc/process_mode_manager.h"
namespace tsd {
TSD_StatusT ProcessModeManager::InitDomainSocketClient()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::WaitHostRsp()
{
    return TSD_OK;
}


TSD_StatusT ProcessModeManager::ProcessQueueForAdc()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendOpenMsgInHost()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::OpenInHost()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::CloseInHost()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetDeviceIdForChipMode()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SendCloseMsgInHost()
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::ProcessQueueGrant(const QueueQueryOutputPara &queueInfoOutBuff,
                                                  const QueueQueryOutput * const queueInfoList,
                                                  const pid_t aicpuPid) const
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::SyncQueueAuthority() const
{
    return TSD_OK;
}

TSD_StatusT ProcessModeManager::GetAicpusdPid(pid_t &aicpusdPid) const
{
    return TSD_OK;
}
}