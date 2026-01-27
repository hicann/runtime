/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dirent.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "ts_api.h"
#include "aicpusd_common.h"
#define private public
#include "aicpusd_model_err_process.h"
#include "aicpusd_model_execute.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

class AICPUModelErrProcTEST : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AICPUModelErrProcTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AICPUModelErrProcTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AICPUModelErrProcTEST SetUP" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AICPUModelErrProcTEST TearDown" << std::endl;
    }
};

TEST_F(AICPUModelErrProcTEST, ProcessLogBuffCfgMsg_SetAddrSuccess) {
    uint8_t bufTmp[4096] = {0};
    AicpuConfigMsg cfgInfo = {0};
    cfgInfo.msgType = 2; /* set buf addr to aicpu */
    cfgInfo.tsId = 0;
    cfgInfo.bufLen = 4096;
    cfgInfo.bufAddr = (uint64_t)(uintptr_t)(&(bufTmp[0]));

    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().buffBaseAddr_[cfgInfo.tsId], cfgInfo.bufAddr);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().buffLen_[cfgInfo.tsId], cfgInfo.bufLen);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[cfgInfo.tsId], true);
}

TEST_F(AICPUModelErrProcTEST, ProcessLogBuffCfgMsg_SetAddrFail) {
    uint8_t bufTmp[4096] = {0};
    AicpuConfigMsg cfgInfo = {0};
    cfgInfo.msgType = 2; /* set buf addr to aicpu */
    cfgInfo.tsId = 2;
    cfgInfo.bufLen = 4096;
    cfgInfo.bufAddr = (uint64_t)(uintptr_t)(&(bufTmp[0]));

    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[cfgInfo.tsId], false);
}

TEST_F(AICPUModelErrProcTEST, ProcessLogBuffCfgMsg_ResetAddrSuccess) {
    uint8_t bufTmp[4096] = {0};
    AicpuConfigMsg cfgInfo = {0};
    cfgInfo.msgType = 2; /* set buf addr to aicpu */
    cfgInfo.tsId = 0;
    cfgInfo.bufLen = 4096;
    cfgInfo.bufAddr = (uint64_t)(uintptr_t)(&(bufTmp[0]));
    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().buffBaseAddr_[cfgInfo.tsId], cfgInfo.bufAddr);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().buffLen_[cfgInfo.tsId], cfgInfo.bufLen);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[cfgInfo.tsId], true);

    cfgInfo.msgType = 1; /* reset buf */
    cfgInfo.offset = 0;
    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);

    cfgInfo.msgType = 0; /* free buf */
    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[cfgInfo.tsId], false);
}

TEST_F(AICPUModelErrProcTEST, ProcessLogBuffCfgMsg_ResetAddrFail) {
    uint8_t bufTmp[4096] = {0};
    AicpuConfigMsg cfgInfo = {0};
    cfgInfo.msgType = 2; /* set buf addr to aicpu */
    cfgInfo.bufLen = 4096;
    cfgInfo.tsId = 0;
    cfgInfo.bufAddr = (uint64_t)(uintptr_t)(&(bufTmp[0]));
    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().buffBaseAddr_[cfgInfo.tsId], cfgInfo.bufAddr);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().buffLen_[cfgInfo.tsId], cfgInfo.bufLen);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[cfgInfo.tsId], true);

    cfgInfo.msgType = 0; /* reset buf */
    cfgInfo.offset = 1;
    AicpuModelErrProc::GetInstance().ProcessLogBuffCfgMsg(cfgInfo);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[cfgInfo.tsId], false);
}

TEST_F(AICPUModelErrProcTEST, SetUnitLogEmpyOffsetTooLarge) {

    AicpuModelErrProc::GetInstance().SetUnitLogEmpy(1, 4097);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[1], false);
}

TEST_F(AICPUModelErrProcTEST, SetUnitLogEmpyBuffInvalid) {
    const uint32_t tsId = 1U;
    AicpuModelErrProc::GetInstance().isBuffValid_[tsId] = false;
    AicpuModelErrProc::GetInstance().SetUnitLogEmpy(tsId, 0);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[tsId], false);
}

TEST_F(AICPUModelErrProcTEST, GetEmptLogOffsetBuffInvalid) {
    AicpuModelErrProc proc;
    const uint32_t tsId = 1U;
    proc.isBuffValid_[tsId] = false;
    const uint32_t ret = proc.GetEmptLogOffset(tsId);
    EXPECT_EQ(ret, UINT32_MAX);
}

TEST_F(AICPUModelErrProcTEST, CheckLogIsEmptOffsetTooLarge) {
    const uint32_t tsId = 1U;
    const bool ret = AicpuModelErrProc::GetInstance().CheckLogIsEmpt(tsId, 4097);
    EXPECT_EQ(ret, false);
}

TEST_F(AICPUModelErrProcTEST, AicoreAddErrLogOffsetInvalid) {
    const uint32_t tsId = 1U;
    const uint32_t buffLen = 4096*2;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 1, buffLen);
    AicpuModelErrProc::GetInstance().buffBaseAddr_[tsId] = PtrToValue(buff.get());
    AicpuModelErrProc::GetInstance().isBuffValid_[tsId] = true;

    const aicpu::AicoreErrMsgInfo errLog = {};
    uint32_t offset = 0U;
    const uint32_t ret = AicpuModelErrProc::GetInstance().AddErrLog(errLog, tsId, offset);
    AicpuModelErrProc::GetInstance().buffBaseAddr_[tsId] = 0UL;
    AicpuModelErrProc::GetInstance().isBuffValid_[tsId] = false;
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUModelErrProcTEST, AicpuAddErrLogSuccess) {
    const uint32_t tsId = 1U;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    AicpuModelErrProc::GetInstance().buffBaseAddr_[tsId] = PtrToValue(buff.get());
    AicpuModelErrProc::GetInstance().isBuffValid_[tsId] = true;

    const aicpu::AicpuErrMsgInfo errLog = {};
    uint32_t offset = 0U;
    const uint32_t ret = AicpuModelErrProc::GetInstance().AddErrLog(errLog, tsId, offset);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AICPUModelErrProcTEST, AicpuAddErrLogOffsetInvalid) {
    MOCKER_CPP(&AicpuModelErrProc::GetEmptLogOffset).stubs().will(returnValue(UINT32_MAX));
    const uint32_t tsId = 1U;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    AicpuModelErrProc::GetInstance().buffBaseAddr_[tsId] = PtrToValue(buff.get());
    AicpuModelErrProc::GetInstance().isBuffValid_[tsId] = true;

    const aicpu::AicpuErrMsgInfo errLog = {};
    uint32_t offset = 0U;
    const uint32_t ret = AicpuModelErrProc::GetInstance().AddErrLog(errLog, tsId, offset);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AICPUModelErrProcTEST, RecordAicpuOpErrLogSuccess) {
    AicpuModel model;
    model.modelTsId_ = 0;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));

    RunContext ctx = {.modelId=0};
    AicpuTaskInfo taskInfo = {};
    const char *kernelName = "testKernel";
    taskInfo.kernelName = PtrToValue(kernelName);
    const uint32_t resultCode = 1U;

    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);
    EXPECT_EQ(modelErrProc.buffBaseAddr_[0], PtrToValue(buff.get()));
    EXPECT_EQ(modelErrProc.buffLen_[0], buffLen);
    EXPECT_EQ(modelErrProc.isBuffValid_[0], true);
    modelErrProc.RecordAicpuOpErrLog(ctx, taskInfo, resultCode);
}

TEST_F(AICPUModelErrProcTEST, RecordAicpuOpErrLogFail) {
    AicpuModel model;
    model.modelTsId_ = 0;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));

    RunContext ctx = {.modelId=0};
    AicpuTaskInfo taskInfo = {};
    const char *kernelName = "testKernel";
    taskInfo.kernelName = PtrToValue(kernelName);
    const uint32_t resultCode = 1U;

    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);
    EXPECT_EQ(modelErrProc.buffBaseAddr_[0], PtrToValue(buff.get()));
    EXPECT_EQ(modelErrProc.buffLen_[0], buffLen);
    EXPECT_EQ(modelErrProc.isBuffValid_[0], true);
    modelErrProc.RecordAicpuOpErrLog(ctx, taskInfo, resultCode);
}

TEST_F(AICPUModelErrProcTEST, RecordAicpuOpErrLogNoModelFail) {
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel*)nullptr));
    RunContext ctx = {.modelId=0};
    AicpuTaskInfo taskInfo = {};
    const char *kernelName = "testKernel";
    taskInfo.kernelName = PtrToValue(kernelName);
    const uint32_t resultCode = 1U;
    AicpuModelErrProc::GetInstance().RecordAicpuOpErrLog(ctx, taskInfo, resultCode);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[0], false);
}

TEST_F(AICPUModelErrProcTEST, RecordAicpuOpErrLogTsIdMaxFail) {
    AicpuModel model;
    model.modelTsId_ = 50;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));

    RunContext ctx = {.modelId=0};
    AicpuTaskInfo taskInfo = {};
    const char *kernelName = "testKernel";
    taskInfo.kernelName = PtrToValue(kernelName);
    const uint32_t resultCode = 1U;
    AicpuModelErrProc::GetInstance().RecordAicpuOpErrLog(ctx, taskInfo, resultCode);
    EXPECT_EQ(AicpuModelErrProc::GetInstance().isBuffValid_[0], false);
}

TEST_F(AICPUModelErrProcTEST, RecordAicoreOpErrLogSuccess) {
    AicpuModel model;
    model.modelTsId_ = 0;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));

    TsToAicpuTaskReport taskInfo = {};
    taskInfo.result_code = 1;
    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);
    EXPECT_EQ(modelErrProc.buffBaseAddr_[0], PtrToValue(buff.get()));
    EXPECT_EQ(modelErrProc.buffLen_[0], buffLen);
    EXPECT_EQ(modelErrProc.isBuffValid_[0], true);
    AicpuSqeAdapter adapter(0U);
    AicpuSqeAdapter::AicpuTaskReportInfo info{};
    info.result_code = taskInfo.result_code;
    modelErrProc.RecordAicoreOpErrLog(info, adapter);
}

TEST_F(AICPUModelErrProcTEST, RecordAicoreOpErrLogFail) {
    AicpuModel model;
    model.modelTsId_ = 0;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));

    TsToAicpuTaskReport taskInfo = {};
    taskInfo.result_code = 1;
    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);
    EXPECT_EQ(modelErrProc.buffBaseAddr_[0], PtrToValue(buff.get()));
    EXPECT_EQ(modelErrProc.buffLen_[0], buffLen);
    EXPECT_EQ(modelErrProc.isBuffValid_[0], true);
    AicpuSqeAdapter adapter(0U);
    AicpuSqeAdapter::AicpuTaskReportInfo info{};
    info.result_code = taskInfo.result_code;
    modelErrProc.RecordAicoreOpErrLog(info, adapter);
}

TEST_F(AICPUModelErrProcTEST, RecordAicoreOpErrLogMemCpyFail) {
    AicpuModel model;
    model.modelTsId_ = 0;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue(&model));
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));
    MOCKER(memcpy_s).stubs().will(returnValue(-1));

    TsToAicpuTaskReport taskInfo = {};
    taskInfo.result_code = 1;
    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);
    EXPECT_EQ(modelErrProc.buffBaseAddr_[0], PtrToValue(buff.get()));
    EXPECT_EQ(modelErrProc.buffLen_[0], buffLen);
    EXPECT_EQ(modelErrProc.isBuffValid_[0], true);
    AicpuSqeAdapter adapter(0U);
    AicpuSqeAdapter::AicpuTaskReportInfo info{};
    info.result_code = taskInfo.result_code;
    modelErrProc.RecordAicoreOpErrLog(info, adapter);
}

TEST_F(AICPUModelErrProcTEST, RecordAicoreOpErrLogNoModelFail) {
    AicpuModel model;
    model.modelTsId_ = 0;
    MOCKER_CPP(&AicpuModelManager::GetModel).stubs().will(returnValue((AicpuModel *)nullptr));

    TsToAicpuTaskReport taskInfo = {};
    taskInfo.result_code = 1;
    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);
    EXPECT_EQ(modelErrProc.buffBaseAddr_[0], PtrToValue(buff.get()));
    EXPECT_EQ(modelErrProc.buffLen_[0], buffLen);
    EXPECT_EQ(modelErrProc.isBuffValid_[0], true);
    AicpuSqeAdapter adapter(0U);
    AicpuSqeAdapter::AicpuTaskReportInfo info{};
    info.result_code = taskInfo.result_code;
    modelErrProc.RecordAicoreOpErrLog(info, adapter);
}

TEST_F(AICPUModelErrProcTEST, AicpuAddErrLogMemCpyFail) {
    AicpuModelErrProc modelErrProc;
    const uint32_t buffLen = 1024;
    std::unique_ptr<char[]> buff(new (std::nothrow) char[buffLen]());
    memset(buff.get(), 0, buffLen);
    modelErrProc.SetLogBuffAddr(0, PtrToValue(buff.get()), buffLen);

    MOCKER(memcpy_s).stubs().will(returnValue(-1));
    aicpu::AicpuErrMsgInfo errLog = {};
    uint32_t offset = 0;
    const uint32_t ret = modelErrProc.AddErrLog(errLog, 0U, offset);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_SAFE_FUNCTION_ERR);
}

TEST_F(AICPUModelErrProcTEST, ReportErrLogFail) {
    ErrLogRptInfo info = {};
    MOCKER(tsDevSendMsgAsync).stubs().will(returnValue(-1));
    const auto ret = AicpuModelErrProc::GetInstance().ReportErrLog(info);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}
