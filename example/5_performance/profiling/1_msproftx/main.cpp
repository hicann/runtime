/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <vector>
#include <unistd.h>
#include <string>
#include "utils.h"
#include "acl/acl.h"
#include "acl/acl_prof.h"

namespace {
void *CreateStampWithMessage(const std::string &message)
{
    void *stamp = aclprofCreateStamp();
    if (stamp == nullptr) {
        ERROR_LOG("aclprofCreateStamp failed for message %s", message.c_str());
        return nullptr;
    }

    aclError ret = aclprofSetStampTraceMessage(stamp, message.c_str(), static_cast<uint32_t>(message.length()));
    if (ret != ACL_SUCCESS) {
        ERROR_LOG("aclprofSetStampTraceMessage(%s) failed with error code %d",
            message.c_str(), static_cast<int32_t>(ret));
        aclprofDestroyStamp(stamp);
        return nullptr;
    }
    return stamp;
}

bool CheckPtr(const void *ptr, const char *name)
{
    if (ptr == nullptr) {
        ERROR_LOG("%s is nullptr", name);
        return false;
    }
    return true;
}

struct StampSet {
    void *loadMark = nullptr;
    void *outerRangePush = nullptr;
    void *innerRangePush = nullptr;
    void *preprocessRange = nullptr;
    void *execMark = nullptr;
};

int32_t CreateStampSet(StampSet *stampSet)
{
    stampSet->loadMark = CreateStampWithMessage("model_load_mark");
    stampSet->outerRangePush = CreateStampWithMessage("forward_pass_push");
    stampSet->innerRangePush = CreateStampWithMessage("operator_dispatch_push");
    stampSet->preprocessRange = CreateStampWithMessage("preprocess_range");
    stampSet->execMark = CreateStampWithMessage("model_exec_mark");

    if (!CheckPtr(stampSet->loadMark, "load stamp")) {
        return -1;
    }
    if (!CheckPtr(stampSet->outerRangePush, "outer push stamp")) {
        return -1;
    }
    if (!CheckPtr(stampSet->innerRangePush, "inner push stamp")) {
        return -1;
    }
    if (!CheckPtr(stampSet->preprocessRange, "range stamp")) {
        return -1;
    }
    if (!CheckPtr(stampSet->execMark, "exec mark stamp")) {
        return -1;
    }
    return 0;
}

void DestroyStampSet(const StampSet &stampSet)
{
    aclprofDestroyStamp(stampSet.loadMark);
    aclprofDestroyStamp(stampSet.outerRangePush);
    aclprofDestroyStamp(stampSet.innerRangePush);
    aclprofDestroyStamp(stampSet.preprocessRange);
    aclprofDestroyStamp(stampSet.execMark);
}

int32_t RunTraceFlow(aclrtStream stream)
{
    aclprofStepInfo *stepInfo = aclprofCreateStepInfo();
    if (!CheckPtr(stepInfo, "aclprofCreateStepInfo")) {
        return -1;
    }
    CHECK_ERROR(aclprofGetStepTimestamp(stepInfo, ACL_STEP_START, stream));

    StampSet stamps;
    if (CreateStampSet(&stamps) != 0) {
        aclprofDestroyStepInfo(stepInfo);
        return -1;
    }

    CHECK_ERROR(aclprofMark(stamps.loadMark));
    CHECK_ERROR(aclprofPush(stamps.outerRangePush));

    uint32_t preprocessRangeId = 0;
    CHECK_ERROR(aclprofRangeStart(stamps.preprocessRange, &preprocessRangeId));
    INFO_LOG("Preprocess range start");
    (void)sleep(static_cast<uint8_t>(1));
    CHECK_ERROR(aclprofRangeStop(preprocessRangeId));
    INFO_LOG("Preprocess range stop");

    CHECK_ERROR(aclprofPush(stamps.innerRangePush));
    INFO_LOG("Nested operator dispatch range start");
    (void)sleep(static_cast<uint8_t>(1));
    CHECK_ERROR(aclprofPop());
    INFO_LOG("Nested operator dispatch range stop");

    INFO_LOG("Model execute start");
    (void)sleep(static_cast<uint8_t>(3));
    INFO_LOG("Model execute end");
    CHECK_ERROR(aclprofMark(stamps.execMark));
    CHECK_ERROR(aclprofPop());

    CHECK_ERROR(aclprofGetStepTimestamp(stepInfo, ACL_STEP_END, stream));
    aclprofDestroyStepInfo(stepInfo);
    DestroyStampSet(stamps);
    return 0;
}

int32_t RunMsproftxSample()
{
    INFO_LOG("-------- Start --------");
    uint32_t deviceIdList[1] = {0};
    aclrtStream stream = nullptr;

    CHECK_ERROR(aclInit(nullptr));
    CHECK_ERROR(aclrtSetDevice(deviceIdList[0]));
    CHECK_ERROR(aclrtCreateStream(&stream));

    const std::string aclProfPath = "./output";
    CHECK_ERROR(aclprofInit(aclProfPath.c_str(), aclProfPath.length()));

    aclprofConfig *config = aclprofCreateConfig(
        deviceIdList,
        1,
        ACL_AICORE_ARITHMETIC_UTILIZATION,
        nullptr,
        ACL_PROF_ACL_API | ACL_PROF_TASK_TIME | ACL_PROF_MSPROFTX);
    if (!CheckPtr(config, "aclprofCreateConfig")) {
        return -1;
    }

    const std::string memFreq = "15";
    CHECK_ERROR(aclprofSetConfig(ACL_PROF_SYS_HARDWARE_MEM_FREQ, memFreq.c_str(), memFreq.length()));
    CHECK_ERROR(aclprofStart(config));

    if (RunTraceFlow(stream) != 0) {
        return -1;
    }

    CHECK_ERROR(aclprofStop(config));
    CHECK_ERROR(aclprofDestroyConfig(config));
    CHECK_ERROR(aclprofFinalize());
    CHECK_ERROR(aclrtDestroyStream(stream));
    CHECK_ERROR(aclrtResetDeviceForce(deviceIdList[0]));
    CHECK_ERROR(aclFinalize());
    INFO_LOG("-------- End --------");
    return 0;
}
} // namespace

int main(int argc, char *argv[])
{
    (void)argc;
    (void)argv;
    return RunMsproftxSample();
}
