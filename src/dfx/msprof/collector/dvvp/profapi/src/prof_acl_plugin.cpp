/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "prof_acl_plugin.h"
#include <dlfcn.h>
#include "errno/error_code.h"
using namespace analysis::dvvp::common::error;
namespace ProfAPI {
void ProfAclPlugin::ProfAclApiInit(VOID_PTR handle)
{
    msProfLibHandle_ = handle;
}

int32_t ProfAclPlugin::ProfAclInit(uint32_t type, const char *profilerPath, uint32_t len)
{
    PthreadOnce(&profAclInitFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclInit();});
    if (profAclInit_ != nullptr) {
        return profAclInit_(type, profilerPath, len);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclWarmup(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
    PthreadOnce(&profAclWarmupFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclWarmup();});
    if (profAclWarmup_ != nullptr) {
        return profAclWarmup_(type, profilerConfig);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclStart(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
    PthreadOnce(&profAclStartFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclStart();});
    if (profAclStart_ != nullptr) {
        return profAclStart_(type, profilerConfig);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclStop(uint32_t type, PROFAPI_CONFIG_CONST_PTR profilerConfig)
{
    PthreadOnce(&profAclStopFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclStop();});
    if (profAclStop_ != nullptr) {
        return profAclStop_(type, profilerConfig);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclFinalize(uint32_t type)
{
    PthreadOnce(&profAclFinalizeFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclFinalize();});
    if (profAclFinalize_ != nullptr) {
        return profAclFinalize_(type);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclSetConfig(uint32_t configType, const char *config, size_t configLength)
{
    PthreadOnce(&profAclSetConfigFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclSetConfig();});
    if (profAclSetConfig_ != nullptr) {
        return profAclSetConfig_(configType, config, configLength);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclSubscribe(uint32_t type, uint32_t modelId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR config)
{
    PthreadOnce(&profAclSubscribeFlag_, []() -> void {
        ProfAclPlugin::instance()->LoadProfAclSubscribe();
        ProfAclPlugin::instance()->LoadProfCreateTransport();
        ProfAclPlugin::instance()->LoadProfRegisterTransport();
    });

    if (profRegisterTransport_ != nullptr && profCreateTransport_ != nullptr) {
        profRegisterTransport_(profCreateTransport_());
    }

    if (profAclSubscribe_ != nullptr) {
        return profAclSubscribe_(type, modelId, config);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclUnSubscribe(uint32_t type, uint32_t modelId)
{
    PthreadOnce(&profAclUnSubscribeFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclUnSubscribe();});
    if (profAclUnSubscribe_ != nullptr) {
        return profAclUnSubscribe_(type, modelId);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfOpSubscribe(uint32_t devId, PROFAPI_SUBSCRIBECONFIG_CONST_PTR config)
{
    PthreadOnce(&profOpSubscribeFlag_, []()-> void {
        ProfAclPlugin::instance()->LoadProfOpSubscribe();
        ProfAclPlugin::instance()->LoadProfCreateTransport();
        ProfAclPlugin::instance()->LoadProfRegisterTransport();
    });
    if (profRegisterTransport_ != nullptr && profCreateTransport_ != nullptr) {
        profRegisterTransport_(profCreateTransport_());
    }
    if (profOpSubscribe_ != nullptr) {
        return profOpSubscribe_(devId, config);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfOpUnSubscribe(uint32_t type)
{
    PthreadOnce(&profOpUnSubscribeFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfOpUnSubscribe();});
    if (profOpUnSubscribe_ != nullptr) {
        return profOpUnSubscribe_(type);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclDrvGetDevNum()
{
    PthreadOnce(&profAclDrvGetDevNumFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclDrvGetDevNum();});
    if (profAclDrvGetNum_ != nullptr) {
        return profAclDrvGetNum_();
    }
    return PROFILING_FAILED;
}

uint64_t ProfAclPlugin::ProfAclGetOpTime(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index)
{
    PthreadOnce(&profAclGetOpTimeFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclGetOpTime();});
    if (profAclGetOpTime_ != nullptr) {
        return profAclGetOpTime_(type, opInfo, opInfoLen, index);
    }
    return 0;
}

size_t ProfAclPlugin::ProfAclGetId(uint32_t type, const void *opInfo, size_t opInfoLen, uint32_t index)
{
    PthreadOnce(&profAclGetIdFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclGetId();});
    if (profAclGetId_ != nullptr) {
        return profAclGetId_(type, opInfo, opInfoLen, index);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclGetOpVal(uint32_t type, const void *opInfo, size_t opInfoLen,
                                       uint32_t index, void *data, size_t len)
{
    PthreadOnce(&profAclGetOpValFlag_, []()-> void { ProfAclPlugin::instance()->LoadProfAclGetOpVal();});
    if (profAclGetOpVal_ != nullptr) {
        return profAclGetOpVal_(type, opInfo, opInfoLen, index, data, len);
    }
    return 0;
}

uint64_t ProfAclPlugin::ProfGetOpExecutionTime(const void *data, uint32_t len, uint32_t index)
{
    PthreadOnce(&profGetOpExecutionTimeFlag_,
        []()-> void { ProfAclPlugin::instance()->LoadProfGetOpExecutionTime();});
    if (profGetOpExecutionTime_ != nullptr) {
        return profGetOpExecutionTime_(data, len, index);
    }
    return 0;
}

const char *ProfAclPlugin::ProfGetOpAttriVal(uint32_t type, const void *opInfo, size_t opInfoLen,
    uint32_t index, uint32_t attri)
{
    PthreadOnce(&profAclGetOpAttriValFlag_,
        []()-> void { ProfAclPlugin::instance()->LoadProfGetOpAttriVal();});
    if (profGetOpExecutionTime_ != nullptr) {
        return profGetOpAttriVal_(type, opInfo, opInfoLen, index, attri);
    }
    return nullptr;
}

int32_t ProfAclPlugin::ProfAclGetCompatibleFeatures(size_t *featuresSize, void **featuresData)
{
    PthreadOnce(&profAclGetCompatibleFeaturesFlags_, []()-> void {
        ProfAclPlugin::instance()->LoadProfAclGetCompatibleFeatures();});
    if (profAclGetCompatibleFeatures_ != nullptr) {
        return profAclGetCompatibleFeatures_(featuresSize, featuresData);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclGetCompatibleFeaturesV2(size_t *featuresSize, void **featuresData)
{
    PthreadOnce(&profAclGetCompatibleFeaturesV2Flags_, []()-> void {
        ProfAclPlugin::instance()->LoadProfAclGetCompatibleFeaturesV2();});
    if (profAclGetCompatibleFeaturesV2_ != nullptr) {
        return profAclGetCompatibleFeaturesV2_(featuresSize, featuresData);
    }
    return 0;
}

int32_t ProfAclPlugin::ProfAclRegisterDeviceCallback()
{
    PthreadOnce(&profAclRegisterDeviceCallbackFlag_, []()-> void {
        ProfAclPlugin::instance()->LoadProfAclRegisterDeviceCallback();});
    if (profAclRegisterDeviceCallback_ != nullptr) {
        return profAclRegisterDeviceCallback_();
    }
    return 0;
}

void ProfAclPlugin::LoadProfAclInit()
{
    if (msProfLibHandle_ != nullptr) {
        profAclInit_ = reinterpret_cast<ProfAclInitFunc>(
            dlsym(msProfLibHandle_, "ProfAclInit"));
    }
}

void ProfAclPlugin::LoadProfAclWarmup()
{
    if (msProfLibHandle_ != nullptr) {
        profAclWarmup_ = reinterpret_cast<ProfAclCtrlFunc>(
            dlsym(msProfLibHandle_, "ProfAclWarmup"));
    }
}

void ProfAclPlugin::LoadProfAclStart()
{
    if (msProfLibHandle_ != nullptr) {
        profAclStart_ = reinterpret_cast<ProfAclCtrlFunc>(
            dlsym(msProfLibHandle_, "ProfAclStart"));
    }
}

void ProfAclPlugin::LoadProfAclStop()
{
    if (msProfLibHandle_ != nullptr) {
        profAclStop_ = reinterpret_cast<ProfAclCtrlFunc>(
            dlsym(msProfLibHandle_, "ProfAclStop"));
    }
}

void ProfAclPlugin::LoadProfAclFinalize()
{
    if (msProfLibHandle_ != nullptr) {
        profAclFinalize_ = reinterpret_cast<ProfAclFinalizeFunc>(
            dlsym(msProfLibHandle_, "ProfAclFinalize"));
    }
}

void ProfAclPlugin::LoadProfAclSetConfig()
{
    if (msProfLibHandle_ != nullptr) {
        profAclSetConfig_ = reinterpret_cast<ProfAclSetConfigFunc>(
            dlsym(msProfLibHandle_, "ProfAclSetConfig"));
    }
}

void ProfAclPlugin::LoadProfAclSubscribe()
{
    if (msProfLibHandle_ != nullptr) {
        profAclSubscribe_ = reinterpret_cast<ProfAclSubscribeFunc>(
            dlsym(msProfLibHandle_, "ProfAclSubscribe"));
    }
}

void ProfAclPlugin::LoadProfAclUnSubscribe()
{
    if (msProfLibHandle_ != nullptr) {
        profAclUnSubscribe_ = reinterpret_cast<ProfAclUnSubscribeFunc>(
            dlsym(msProfLibHandle_, "ProfAclUnSubscribe"));
    }
}

void ProfAclPlugin::LoadProfOpSubscribe()
{
    if (msProfLibHandle_ != nullptr) {
        profOpSubscribe_ = reinterpret_cast<ProfOpSubscribeFunc>(
            dlsym(msProfLibHandle_, "ProfOpSubscribe"));
    }
}

void ProfAclPlugin::LoadProfOpUnSubscribe()
{
    if (msProfLibHandle_ != nullptr) {
        profOpUnSubscribe_ = reinterpret_cast<ProfOpUnSubscribeFunc>(
            dlsym(msProfLibHandle_, "ProfOpUnSubscribe"));
    }
}

void ProfAclPlugin::LoadProfAclDrvGetDevNum()
{
    if (msProfLibHandle_ != nullptr) {
        profAclDrvGetNum_ = reinterpret_cast<ProfAclDrvGetDevNumFunc>(
            dlsym(msProfLibHandle_, "ProfAclDrvGetDevNum"));
    }
}

void ProfAclPlugin::LoadProfAclGetOpTime()
{
    if (msProfLibHandle_ != nullptr) {
        profAclGetOpTime_ = reinterpret_cast<ProfAclGetOpTimeFunc>(
            dlsym(msProfLibHandle_, "ProfAclGetOpTime"));
    }
}

void ProfAclPlugin::LoadProfAclGetId()
{
    if (msProfLibHandle_ != nullptr) {
        profAclGetId_ = reinterpret_cast<ProfAclGetIdFunc>(
            dlsym(msProfLibHandle_, "ProfAclGetId"));
    }
}

void ProfAclPlugin::LoadProfAclGetOpVal()
{
    if (msProfLibHandle_ != nullptr) {
        profAclGetOpVal_ = reinterpret_cast<ProfAclGetOpValFunc>(
            dlsym(msProfLibHandle_, "ProfAclGetOpVal"));
    }
}

void ProfAclPlugin::LoadProfGetOpExecutionTime()
{
    if (msProfLibHandle_ != nullptr) {
        profGetOpExecutionTime_ = reinterpret_cast<ProfGetOpExecutionTimeFunc>(
            dlsym(msProfLibHandle_, "ProfGetOpExecutionTime"));
    }
}

void ProfAclPlugin::LoadProfGetOpAttriVal()
{
    if (msProfLibHandle_ != nullptr) {
        profGetOpAttriVal_ = reinterpret_cast<ProfGetOpAttriValFunc>(
            dlsym(msProfLibHandle_, "ProfAclGetOpAttriVal"));
    }
}

void ProfAclPlugin::LoadProfCreateTransport()
{
    if (msProfLibHandle_ != nullptr) {
        profCreateTransport_ = reinterpret_cast<ProfCreateTransportTypeFunc>(
            dlsym(msProfLibHandle_, "ProfCreateParsertransport"));
    }
}

void ProfAclPlugin::LoadProfRegisterTransport()
{
    if (msProfLibHandle_ != nullptr) {
        profRegisterTransport_ = reinterpret_cast<ProfRegisterTransportFunc>(
            dlsym(msProfLibHandle_, "ProfRegisterTransport"));
    }
}

void ProfAclPlugin::LoadProfAclGetCompatibleFeatures()
{
    if (msProfLibHandle_ != nullptr) {
        profAclGetCompatibleFeatures_ = reinterpret_cast<ProfAclGetCompatibleFeaturesFunc>(
            dlsym(msProfLibHandle_, "ProfAclGetCompatibleFeatures"));
    }
}

void ProfAclPlugin::LoadProfAclGetCompatibleFeaturesV2()
{
    if (msProfLibHandle_ != nullptr) {
        profAclGetCompatibleFeaturesV2_ = reinterpret_cast<ProfAclGetCompatibleFeaturesV2Func>(
            dlsym(msProfLibHandle_, "ProfAclGetCompatibleFeaturesV2"));
    }
}

void ProfAclPlugin::LoadProfAclRegisterDeviceCallback()
{
    if (msProfLibHandle_ != nullptr) {
        profAclRegisterDeviceCallback_ = reinterpret_cast<ProfAclRegisterDeviceCallbackFunc>(
            dlsym(msProfLibHandle_, "ProfAclRegisterDeviceCallback"));
    }
}
}