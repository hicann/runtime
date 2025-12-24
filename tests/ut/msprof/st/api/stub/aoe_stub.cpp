/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <future>
#include <stdio.h>
#include <unistd.h>
#include <string>
#include <sys/epoll.h>
#include <thread>
#include "aoe_stub.h"
#include "prof_acl_api.h"
#include "msprof_stub.h"
#include "data_report_manager.h"

using namespace std;
const uint32_t WAIT_FOR_DURATION        = 1;
const uint32_t OP_NAME_LENGTH           = 512;
const uint32_t OP_TYPE_LENGTH           = 512;
const uint32_t SELECT_TIMEOUT           = 1000;

bool CheckRunModelResult(std::future<bool> &fret, bool &flag)
{
    if (fret.valid() &&
        fret.wait_for(std::chrono::microseconds(WAIT_FOR_DURATION)) == std::future_status::ready) {
        auto readRetCode = fret.get();
        if (readRetCode != true) {
            MSPROF_LOGE("Run model failed, skip waiting for profiling data");
            return false;
        }
        MSPROF_LOGI("Run model success.");
    } else if (!fret.valid()) {
        // if fret is not valid, run result must have been got and fd must have been closed,
        // so there is no need to wait
        MSPROF_LOGI("Cannot get any data after running success, stop waiting.");
        flag = true;
    }
    return true;
}

bool GetModelOpInfo(const void *data, const uint32_t len, std::set<RunnerOpInfo> &modelOpInfo)
{
    uint32_t opNumber = 0;
    char opNameBuffer[OP_NAME_LENGTH] = {0};
    char opTypeBuffer[OP_TYPE_LENGTH] = {0};
    auto err = aclprofGetOpNum(data, len, &opNumber);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Get op number failed, err : %d", err);
        return false;
    }
    MSPROF_LOGD("Get op num : %u", opNumber);
    for (uint32_t i = 0; i < opNumber; i++) {
        err = aclprofGetOpName(data, len, i, opNameBuffer, OP_NAME_LENGTH);
        if (err != ACL_ERROR_NONE) {
            MSPROF_LOGE("Profiling data of op name parser exception, err %d", err);
            return false;
        }

        const string opName = opNameBuffer;
        auto ret = memset_s(opNameBuffer, sizeof(opNameBuffer), 0, sizeof(opNameBuffer));
        if (ret != EOK) {
            MSPROF_LOGE("Call memset_s failed, ret : %d", ret);
        }
        err = aclprofGetOpType(data, len, i, opTypeBuffer, OP_TYPE_LENGTH);
        if (err != ACL_ERROR_NONE) {
            MSPROF_LOGE("Profiling data of op type parser exception, err %d", err);
            return false;
        }
        const string opType = opTypeBuffer;
        ret = memset_s(opTypeBuffer, sizeof(opTypeBuffer), 0, sizeof(opTypeBuffer));
        if (ret != EOK) {
            MSPROF_LOGE("Call memset_s failed, ret : %d", ret);
        }
        const auto opStartTime = aclprofGetOpStart(data, len, i);
        const auto opEndTime = aclprofGetOpEnd(data, len, i);
        if (opStartTime == 0 || opEndTime == 0) {
            MSPROF_LOGE("Profiling data of op start or stop time parser exception");
            return false;
        }
        const auto modelId = aclprofGetModelId(data, len, i);
        const auto aicoreCostTime = ProfGetOpExecutionTime(data, len, i);
        const auto opCostTime = aclprofGetOpDuration(data, len, i);
        MSPROF_LOGD("ModelId %zu, name %s, type %s, aicore cost time %llu, op cost time %llu, op start %llu, op end %llu",
            modelId, opName.c_str(), opType.c_str(), aicoreCostTime, opCostTime, opStartTime, opEndTime);
        const RunnerOpInfo opInfo = {0, 0, opName, opCostTime, aicoreCostTime, to_string(modelId), opType, opStartTime,
            opEndTime};

        modelOpInfo.insert(opInfo);
    }
    return true;
}

bool ReadProfilingData(const int32_t epFd, const int32_t fd, std::future<bool> &fret, std::set<RunnerOpInfo> &modelOpInfo)
{
    const int maxevents = 1;
    struct epoll_event epEvent[maxevents];
    int32_t ret;
    int64_t dataLen;
    uint64_t bufferSize = 0;
    if (aclprofGetOpDescSize(&bufferSize) != ACL_ERROR_NONE) {
        MSPROF_LOGE("Get op desc size failed, errno : %d.", errno);
        return false;
    }
    const uint64_t readLength = bufferSize;
    std::unique_ptr<char[]> readbuf = (std::unique_ptr<char[]>)new (std::nothrow) char[readLength]();
    if (readbuf == nullptr) {
        MSPROF_LOGE("New read buffer failed");
        return false;
    }
    do {
        dataLen = 0;
        do {
            ret = epoll_wait(epFd, epEvent, maxevents, SELECT_TIMEOUT);
        } while (ret < 0 && errno == EINTR);
        if (ret < 0) {
            return false;
            MSPROF_LOGE("Epoll wait failed, errno : %d.", errno);
        }
        if (ret == 0) {
            bool flag = false;
            bool checkResult = CheckRunModelResult(fret, flag);
            if (checkResult != true || flag) {
                return checkResult;
            }
            MSPROF_LOGD("Wating for running finished");
            continue;
        }
        // wait success
        if (epEvent[0].data.fd != fd) {
            // event is not what we are waiting for, keep waiting
            MSPROF_LOGW("Receive event with invliad fd");
            continue;
        }
        // read data
        auto err = memset_s(readbuf.get(), readLength, 0, readLength);
        if (err != EOK) {
            MSPROF_LOGE("Call memset_s failed, ret : %d", ret);
        }
        dataLen = read(fd, readbuf.get(), readLength);
        if (dataLen < 0) {
            MSPROF_LOGE("Read data failed.");
            return false;
        } else if (dataLen == 0) {
            break;
        }
        if (GetModelOpInfo(readbuf.get(), dataLen, modelOpInfo) != true) { // written by user
            MSPROF_LOGE("Get op info of model error.");
            return false;
        }
    } while (ret == 0 || (ret > 0 && dataLen > 0));
    return true;
}

bool ProfDataRead(int32_t fd, std::future<bool> &fret, std::set<RunnerOpInfo> &modelOpInfo)
{
    const int epSize = 1; // The epSize is just for epoll-create api, no practical meaning in others.
    int epFd = epoll_create(epSize);
    if (epFd < 0) {
        MSPROF_LOGE("Create epoll failed, errno : %d.", errno);
        return false;
    }
    struct epoll_event epEvent;
    epEvent.events = EPOLLIN;
    epEvent.data.fd = fd;
    auto epollRet = epoll_ctl(epFd, EPOLL_CTL_ADD, fd, &epEvent);
    if (epollRet < 0) {
        MSPROF_LOGE("Epoll add failed, errno : %d.", errno);
        close(epFd);
        return false;
    }
    bool ret = ReadProfilingData(epFd, fd, fret, modelOpInfo);

    epollRet = epoll_ctl(epFd, EPOLL_CTL_DEL, fd, &epEvent);
    if (epollRet < 0) {
        MSPROF_LOGE("Epoll del failed, errno : %d.", errno);
        return false;
    }
    close(epFd);
    return ret;

}

bool RunModel(int32_t fd)
{
    int8_t opTimeSwitch = 1;
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_NONE;
    aclprofSubscribeConfig *profSubscribeConfig = aclprofCreateSubscribeConfig(opTimeSwitch, aicoreMetrics, reinterpret_cast<void *>(&fd));
    if (profSubscribeConfig == nullptr) {
        MSPROF_LOGE("Create subscribe config failed.");
        return false;
    }
    uint32_t modelId = 0;
    // load model
    auto err = aclmdlLoadFromFile(nullptr, &modelId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
    }
    // subscribe model
    // Msprofiler::AclApi::ProfRegisterTransport(Msprofiler::AclApi::CreateParserTransport);
    aclprofModelSubscribe(modelId, profSubscribeConfig);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Subscribe model failed");
        return false;
    }
    // run model
    err = aclmdlExecute(modelId, nullptr, nullptr);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Execute model failed");
        return false;
    }

    // unsubscribe model
    err = aclprofModelUnSubscribe(modelId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("UnSubscribe model failed");
        return false;
    }
    err = aclprofDestroySubscribeConfig(profSubscribeConfig);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Destroy Subscribe config failed");
        return false;
    }
    err = aclmdlUnload(modelId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
        return false;
    }
    return true;
}

extern aclError aclnnGlu();
bool RunOp(int32_t fd)
{
    int8_t opTimeSwitch = 1;
    aclprofAicoreMetrics aicoreMetrics = ACL_AICORE_NONE;
    aclprofSubscribeConfig *profSubscribeConfig = aclprofCreateSubscribeConfig(opTimeSwitch, aicoreMetrics, reinterpret_cast<void *>(&fd));
    if (profSubscribeConfig == nullptr) {
        MSPROF_LOGE("Create subscribe config failed.");
        return false;
    }

    uint32_t devId = 0;
    // subscribe model
    auto err = ProfOpSubscribe(devId, profSubscribeConfig);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Subscribe stream failed");
        return false;
    }
    // run op
    err = aclnnGlu();
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Execute model failed");
        return false;
    }

    // unsubscribe op
    err = ProfOpUnSubscribe(devId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("UnSubscribe stream failed");
        return false;
    }
    err = aclprofDestroySubscribeConfig(profSubscribeConfig);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Destroy Subscribe config failed");
        return false;
    }
    return true;
}

bool RunInfer(std::set<RunnerOpInfo> &modelOpInfo, RunFunc func)
{
    aclInit(nullptr);
    aclrtSetDevice(0);

    int32_t fd[2] = {-1, -1};
    if (pipe2(fd, O_CLOEXEC) < 0) { // create profiling read pipe
        return false;
    }

    std::future<bool> fret = std::async(std::launch::async, func, std::ref(fd[1]));
    auto ret = ProfDataRead(fd[0], fret, modelOpInfo);
    close(fd[0]);
    close(fd[1]);

    aclFinalize();

    auto bitSwitch = DataReportMgr().GetBitSwitch();
    if (bitSwitch != 0) {
        MSPROF_LOGE("Switch is %llx, not 0 after finalize", bitSwitch);
        return false;
    }

    return ret;
}

aclError RunInferWithApi(std::string &aclProfPath, uint32_t devId, aclprofAicoreMetrics aicoreMetrics,
    const aclprofAicoreEvents *aicoreEvents, uint64_t dataTypeConfig)
{
    aclInit(nullptr);
    aclrtSetDevice(devId);
    auto ret = aclprofInit(aclProfPath.c_str(), aclProfPath.size());
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofInit failed");
        return ret;
    }
    uint32_t deviceIdList[1] = {devId};
    auto config = aclprofCreateConfig(deviceIdList, 1, aicoreMetrics, aicoreEvents, dataTypeConfig);
    if (config == nullptr) {
        MSPROF_LOGE("aclprofCreateConfig failed");
        return ACL_ERROR_INVALID_PARAM;
    }
    ret = aclprofStart(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStart failed");
        return ret;
    }
    uint32_t modelId = 0;
    ret = aclmdlExecute(modelId, nullptr, nullptr);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ret;
    }
    ret = aclprofStop(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofStop failed");
        return ret;
    }
    ret = aclprofDestroyConfig(config);
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofDestroyConfig failed");
        return ret;
    }
    ret = aclprofFinalize();
    if (ret != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclprofFinalize failed");
        return ret;
    }
    aclFinalize();
    return ACL_ERROR_NONE;
}
