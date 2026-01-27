/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "tsd/tsd_client.h"
#include "inc/log.h"
#include "inc/client_manager.h"
#include "inc/msg_parse_reg.h"
#include "inc/internal_api.h"

uint32_t TsdOpen(const uint32_t logicDeviceId, const uint32_t rankSize)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for open.");
    const tsd::TSD_StatusT ret = clientManager->Open(rankSize);
    if (ret != tsd::TSD_OK) {
        if (!clientManager->IsAdcEnv()) {
            TSD_ERROR("TsdOpen failed, deviceId[%u].", logicDeviceId);
        }
        clientManager->Destroy();
    }
    return ret;
}

uint32_t TsdOpenEx(const uint32_t logicDeviceId, const uint32_t rankSize, const uint32_t deviceMode)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    const ::std::shared_ptr<tsd::ClientManager> clientManager =
        tsd::ClientManager::GetInstance(logicDeviceId, deviceMode);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for open.");
    const tsd::TSD_StatusT ret = clientManager->Open(rankSize);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdOpenEx failed, deviceId[%u].", logicDeviceId);
        clientManager->Destroy();
    }
    return ret;
}

uint32_t TsdOpenAicpuSd(const uint32_t logicDeviceId)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for openAicpuSd.");
    const tsd::TSD_StatusT ret = clientManager->OpenAicpuSd();
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdOpenAicpuSd failed, deviceId[%u].", logicDeviceId);
        clientManager->Destroy();
    }
    return ret;
}

uint32_t TsdClose(const uint32_t logicDeviceId)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for close.");
    const uint32_t flag = 0;
    const tsd::TSD_StatusT ret = clientManager->Close(flag);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdClose failed, deviceId[%u].", logicDeviceId);
        clientManager->Destroy();
    }
    return ret;
}

uint32_t TsdCloseEx(const uint32_t logicDeviceId, const uint32_t flag)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_CLOSEEX_FAILED, "Get ClientManager failed for close.");
    const tsd::TSD_StatusT ret = clientManager->Close(flag);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdCloseEx failed, deviceId[%u], flag[%u].", logicDeviceId, flag);
        clientManager->Destroy();
    }
    return ret;
}

uint32_t UpdateProfilingMode(const uint32_t logicDeviceId, const uint32_t flag)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for UpdateProfilingMode.");
    const tsd::TSD_StatusT ret = clientManager->UpdateProfilingConf(flag);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("UpdateProfilingMode failed, deviceId[%u].", logicDeviceId);
    }
    return ret;
}

uint32_t TsdSetMsprofReporterCallback(const MsprofReporterCallback callback)
{
    tsd::ClientManager::SetProfilingCallback(callback);
    return tsd::TSD_OK;
}

uint32_t TsdInitQs(const uint32_t logicDeviceId, const char_t * const groupName)
{
    const InitFlowGwInfo tmpFlowGwInfo = {groupName, 0U, 0U, {}};
    return TsdInitFlowGw(logicDeviceId, &tmpFlowGwInfo);
}

uint32_t TsdInitFlowGw(const uint32_t logicDeviceId, const InitFlowGwInfo * const initInfo)
{
    TSD_RUN_INFO("TsdInitFlowGw Begin.");
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        return tsd::TSD_OK;
    }
    if (initInfo == nullptr) {
        TSD_ERROR("TsdInitQs failed, initInfo is nullptr.");
        return tsd::TSD_INTERNAL_ERROR;
    }

    // get client instance
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for TsdInitQs.");
    const tsd::TSD_StatusT ret = clientManager->InitQs(initInfo);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdInitQs failed, deviceId[%u]", logicDeviceId);
        clientManager->Destroy();
    }
    return ret;
}

uint32_t GetHdcConctStatus(const uint32_t logicDeviceId, int32_t *hdcSessStat)
{
    if (hdcSessStat == nullptr) {
        return tsd::TSD_OK;
    }
    if ((tsd::ClientManager::CheckDestructFlag(logicDeviceId)) ||
        (tsd::ClientManager::GetInstance(logicDeviceId) == nullptr)) {
        // CheckDestructFlag true can not print log, resource(errDesc_) for tdt log may be destructed.
        *hdcSessStat = HDC_SESSION_STATUS_CONNECT;
        return tsd::TSD_OK;
    }
    return tsd::ClientManager::GetInstance(logicDeviceId)->GetHdcConctStatus(*hdcSessStat);
}

uint32_t TsdSetAttr(const char_t * const attrKey, const char_t * const attrValue)
{
    tsd::TSD_StatusT ret = tsd::TSD_OK;
    if ((attrKey == nullptr) || (attrValue == nullptr)) {
        TSD_ERROR("[TsdClient] set attr failed, either key or value is null ptr!");
        return tsd::TSD_INTERNAL_ERROR;
    }
    const std::string keyStr(attrKey);
    const std::string valueStr(attrValue);
    if (keyStr == "RunMode") {
        ret = tsd::ClientManager::SetRunMode(valueStr);
    } else {
        TSD_RUN_INFO("[TsdClient] set attr is not supported, key is [%s].", keyStr.c_str());
    }
    return ret;
}

uint32_t SetAicpuSchedMode(const uint32_t schedMode)
{
    return static_cast<uint32_t>(tsd::ClientManager::SetAicpuSchedMode(schedMode));
}

uint32_t TsdCapabilityGet(const uint32_t logicDeviceId, const int32_t type, const uint64_t ptr)
{
    TSD_RUN_INFO("TsdCapabilityGet Begin.");
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }
    if (type >= TSD_CAPABILITY_BUT) {
        TSD_ERROR("capability type is error");
        return tsd::TSD_CLT_OPEN_FAILED;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for TsdCapabilityGet.");
    const tsd::TSD_StatusT ret = clientManager->CapabilityGet(type, ptr);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdCapabilityGet failed, type[%d].", type);
        if (type != TSD_CAPABILITY_LEVEL) {
            clientManager->Destroy();
        }
    }
    return ret;
}

uint32_t TsdFileLoad(const uint32_t logicDeviceId, const char_t *filePath, const uint64_t pathLen,
                     const char_t *fileName, const uint64_t fileNameLen)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_CLT_OPEN_FAILED, "Get ClientManager failed for TsdFileLoad.");
    const tsd::TSD_StatusT ret = clientManager->LoadFileToDevice(filePath, pathLen, fileName, fileNameLen);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdFileLoad failed, pathLen[%llu], fileNameLen[%llu].", pathLen, fileNameLen);
    }
    return ret;
}

uint32_t TsdProcessOpen(const uint32_t logicDeviceId, ProcOpenArgs *openArgs)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdProcessOpen.");
    const tsd::TSD_StatusT ret = clientManager->ProcessOpenSubProc(openArgs);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdProcessOpen failed.");
    }
    return ret;
}

uint32_t TsdProcessClose(const uint32_t logicDeviceId, const pid_t closePid)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdProcessClose.");
    const tsd::TSD_StatusT ret = clientManager->ProcessCloseSubProc(closePid);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdProcessClose failed");
    }
    return ret;
}

uint32_t TsdFileUnLoad(const uint32_t logicDeviceId, const char_t *filePath, const uint64_t pathLen)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdFileUnLoad.");
    const tsd::TSD_StatusT ret = clientManager->RemoveFileOnDevice(filePath, pathLen);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdFileUnLoad failed");
    }
    return ret;
}

uint32_t TsdGetProcStatus(const uint32_t logicDeviceId, ProcStatusInfo *pidInfo, const uint32_t arrayLen)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdGetProcStatus.");
    const tsd::TSD_StatusT ret = clientManager->GetSubProcStatus(pidInfo, arrayLen);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdGetProcStatus failed");
    }
    return ret;
}

uint32_t NotifyPmToStartTsdaemon(const uint32_t logicDeviceId)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }
    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for NotifyPmToStartTsdaemon.");
    const tsd::TSD_StatusT ret = clientManager->NotifyPmToStartTsdaemon();
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("NotifyPmToStartTsdaemon failed");
    }
    return ret;
}

uint32_t ProcessCloseSubProcList(const uint32_t logicDeviceId, const ProcStatusParam *closeList,
                                 const uint32_t listSize)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for ProcessCloseSubProcList.");
    const tsd::TSD_StatusT ret = clientManager->ProcessCloseSubProcList(closeList, listSize);
    if ((ret != tsd::TSD_OK) && (ret != tsd::TSD_HDC_CLIENT_CLOSED_EXTERNAL)) {
        TSD_ERROR("ProcessCloseSubProcList failed");
    }
    return ret;
}

uint32_t TsdGetProcListStatus(const uint32_t logicDeviceId, ProcStatusParam *pidInfo, const uint32_t arrayLen)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdGetProcListStatus.");
    const tsd::TSD_StatusT ret = clientManager->GetSubProcListStatus(pidInfo, arrayLen);
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdGetProcListStatus failed");
    }
    return ret;
}

uint32_t TsdOpenNetService(const uint32_t logicDeviceId, const NetServiceOpenArgs *args)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdOpenNetService.");
    const tsd::TSD_StatusT ret = clientManager->OpenNetService(args);
    if (ret != tsd::TSD_OK) {
        if (ret == tsd::ErroCodeExt::TSD_OPEN_DEFAULT_NET_SERVICE_FAILED) {
            clientManager->Destroy();
        }
        TSD_ERROR("TsdOpenNetService failed");
    }
    return ret;
}

uint32_t TsdCloseNetService(const uint32_t logicDeviceId)
{
    if (tsd::ClientManager::CheckDestructFlag(logicDeviceId)) {
        return tsd::TSD_OK;
    }

    const std::shared_ptr<tsd::ClientManager> clientManager = tsd::ClientManager::GetInstance(logicDeviceId);
    TSD_CHECK_NULLPTR(clientManager, tsd::TSD_INTERNAL_ERROR, "Get ClientManager failed for TsdCloseNetService.");
    const tsd::TSD_StatusT ret = clientManager->CloseNetService();
    if (ret != tsd::TSD_OK) {
        TSD_ERROR("TsdCloseNetService failed");
    }
    return ret;
}