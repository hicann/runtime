/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <dlfcn.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "Eigen/Dense"
#define private public
#define protected public
#include "dump_task.h"
#undef protected
#undef private

using namespace AicpuSchedule;

class AicpuDumpTaskTest : public testing::Test {
protected:
    static void SetUpTestCase() {
        std::cout << "AicpuDumpTaskTest SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase() {
        std::cout << "AicpuDumpTaskTest TearDownTestCase" << std::endl;
    }

    virtual void SetUp()
    {
        std::cout << "AicpuDumpTaskTest SetUp" << std::endl;
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpuDumpTaskTest TearDown" << std::endl;
    }
};

namespace {
uint32_t AicpuKfcDumpSrvLaunch(void *args)
{
    KfcDumpTask *taskPara = reinterpret_cast<KfcDumpTask *>(args);
    const KfcDumpTask taskKey(taskPara->streamId_, taskPara->taskId_, taskPara->index_);
    KfcDumpInfo *dumpinfo = nullptr;
    AicpuGetOpTaskInfo(taskKey, &dumpinfo);
    std::string dumpdata = "Input/Output,Index,Data Size,Data Type,Format,Shape,Max Value,Min Value,Avg Value,Count,Nan Count,Negative Inf Count,Positive Inf Count\nOutput,0,640000,DT_FLOAT,NHWC,4x50x50x16,1.99999,1,1.50004,160000,0,0,0";
    AicpuDumpOpTaskData(taskKey, reinterpret_cast<void *>(const_cast<char *>(dumpdata.c_str())), dumpdata.length());
    return 0;
}

std::map<std::string, void*> kfcSymbols = {
        {"AicpuKfcDumpSrvLaunch", (void*)(&AicpuKfcDumpSrvLaunch)},
    };

void *dlsymFake(void *handle, const char *symbol)
{
    auto symbolIter = kfcSymbols.find(std::string(symbol));
    if (symbolIter != kfcSymbols.end()) {
        return symbolIter->second;
    }
    return nullptr;
}

void *dlsymFakeFail(void *handle, const char *symbol)
{
    return nullptr;
}

bool CheckAndGetKfcDumpStatsAPIFake()
{
    return true;
}
}

TEST_F(AicpuDumpTaskTest, ProcessDumpOpInfoTest1) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->dumpMode_ = DumpMode::STATS_DUMP_DATA;

    const uint32_t dataLen = 10U;
    std::shared_ptr<uint32_t[]> datas(new uint32_t[dataLen]);
    ::toolkit::dumpdata::OpInput *opInput = opDumpTask->baseDumpData_.add_input();
    if (opInput != nullptr) {
        opInput->set_data_type(::toolkit::dumpdata::OutputDataType::DT_UINT32);
        opInput->set_format(0);
        ::toolkit::dumpdata::Shape *shape = opInput->mutable_shape();
        shape->add_dim(dataLen);
        opInput->set_size(dataLen * sizeof(uint32_t));
        opInput->set_address(datas.get());
    }

    ::toolkit::dumpdata::OpOutput *opOutput = opDumpTask->baseDumpData_.add_output();
    if (opOutput != nullptr) {
        opOutput->set_data_type(::toolkit::dumpdata::OutputDataType::DT_UINT32);
        opOutput->set_format(0);
        ::toolkit::dumpdata::Shape *shape = opOutput->mutable_shape();
        shape->add_dim(dataLen);
        opOutput->set_size(dataLen * sizeof(uint32_t));
        opOutput->set_address(datas.get());
    }

    opDumpTask->dumpMode_ = DumpMode::STATS_DUMP_DATA;

    const std::string dumpFilePath = "./";
    const std::string dumpDebugFilePath = "./";
    MOCKER_CPP(&OpDumpTask::DoDumpStats).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    TaskInfoExt dumpTaskInfo = {};
    dumpTaskInfo.threadId_ = 0;
    const auto ret = opDumpTask->ProcessDumpOpInfo(dumpTaskInfo, dumpFilePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuDumpTaskTest, ProcessDumpOpInfoTest2) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->dumpMode_ = 3;

    const std::string dumpFilePath = "./";
    const std::string dumpDebugFilePath = "./";
    MOCKER_CPP(&OpDumpTask::DoDumpStats).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    TaskInfoExt dumpTaskInfo = {};
    dumpTaskInfo.threadId_ = 0;
    const auto ret = opDumpTask->ProcessDumpOpInfo(dumpTaskInfo, dumpFilePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(AicpuDumpTaskTest, GenerateDataDimInfoTest) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);

    ::toolkit::dumpdata::Shape shape;
    const auto res = opDumpTask->GenerateDataDimInfo(shape);
    EXPECT_STREQ(res.c_str(), "-");
}

TEST_F(AicpuDumpTaskTest, GetDataTypeStrTest) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    const auto ret = opDumpTask->GetDataTypeStr(UINT16_MAX);
    EXPECT_STREQ(ret.c_str(), "-");
}

TEST_F(AicpuDumpTaskTest, GetDataFormatStrTest) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    const auto ret = opDumpTask->GetDataFormatStr(UINT16_MAX);
    EXPECT_STREQ(ret.c_str(), "-");
}


TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestFloat) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<float[]> datas(new float[dataLen]);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0.0f;
    }
    const uint64_t dataSize = dataLen * sizeof(float);

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_FLOAT);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestFloat16) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = Eigen::half(0.0);
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_FLOAT16);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestUint8) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint8_t[]> datas(new uint8_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint8_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_UINT8);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestInt8) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<int8_t[]> datas(new int8_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int8_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_INT8);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestInt16) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<int16_t[]> datas(new int16_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int16_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_INT16);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestUint16) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint16_t[]> datas(new uint16_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint16_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_UINT16);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestInt32) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<int32_t[]> datas(new int32_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int32_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_INT32);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestInt64) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<int64_t[]> datas(new int64_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(int64_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_INT64);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestUint64) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint64_t[]> datas(new uint64_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint64_t);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_UINT64);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestBool) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<bool[]> datas(new bool[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(bool);
    (void)memset(datas.get(), 0, dataSize);

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_BOOL);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestDouble) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<double[]> datas(new double[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(double);
    for (uint32_t i = 0; i < dataLen; ++i) {
        datas[i] = 0.0;
    }
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    std::string ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, ::toolkit::dumpdata::OutputDataType::DT_DOUBLE);
    EXPECT_STREQ(ret.c_str(), "0,0,0,10,0,0,0");
}

TEST_F(AicpuDumpTaskTest, GenerateDataStatsInfoTestDefault) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<double[]> datas(new double[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(double);

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    const auto ret = opDumpTask->GenerateDataStatsInfo(datas.get(), dataSize, UINT32_MAX);
    EXPECT_STREQ(ret.c_str(), ",,,,,,");
}

TEST_F(AicpuDumpTaskTest, UtGenerateDataStatsInfoTestAddrIsNull) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<double[]> datas(new double[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(double);

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    const auto ret = opDumpTask->GenerateDataStatsInfo(0, dataSize, UINT32_MAX);
    EXPECT_STREQ(ret.c_str(), ",,,,,,");
}


TEST_F(AicpuDumpTaskTest, DoDumpStatsTest) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    const std::string dumpFilePath = "./";
    const std::string content = "stub";
    const auto ret = opDumpTask->DoDumpStats(dumpFilePath, content);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuDumpTaskTest, EigenDataStatsTestNormal) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);

    const float stubDatas[dataLen] = {
        4.535, 1.097, 2.799, 0.01564, 0.00494,
        0.3586, 0.1295, 1.379, 0.4812, 4.164
    };

    std::ostringstream oss;
    for (uint32_t i = 0U; i < dataLen; ++i) {
        datas[i] = Eigen::half(stubDatas[i]);
        oss << datas[i] << " " << stubDatas[i] << std::endl;
    }

    EigenDataStats stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
    std::cout << stats.GetDataStatsStr() << std::endl;
    bool flag = true;
    if (std::abs(static_cast<float>(stats.avgValue_) - 1.496388) > 0.0003)
    {
        std::cout << "[ERROR]Convergence criterion not reached for avg\n";
        flag = false;
        FAIL();
    }

    if (std::abs(static_cast<float>(stats.maxValue_) - 4.535) > 0.0002)
    {
        std::cout << "[ERROR]Convergence criterion not reached for max\n";
        flag = false;
        FAIL();
    }

    if (std::abs(static_cast<float>(stats.minValue_) - 0.00494) > 0.0002)
    {
        std::cout << "[ERROR]Convergence criterion not reached for min\n";
        flag = false;
        FAIL();
    }
    EXPECT_EQ(flag, true);
}

TEST_F(AicpuDumpTaskTest, EigenDataStatsTestNormalSingle) {
    const uint32_t dataLen = 50U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    std::shared_ptr<float[]> floatDatas(new float[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);

    // Gen test data by random
    std::ostringstream oss;
    const int32_t low = 0;
    const int32_t high = 10;
    for (uint32_t i = 0; i < dataLen; ++i) {
        float r = low + static_cast<float>(rand()) * static_cast<float>(high - low) / RAND_MAX;
        floatDatas[i] = r;
        datas[i] = static_cast<Eigen::half>(r);
        oss << "Iter[" << i << "] " << r << "  "
            << datas[i] << std::endl;
    }

    // Gen standard mean value
    float avg = 0.0;
    for (uint32_t i = 0; i < dataLen; ++i) {
        avg += (floatDatas[i] - avg) / static_cast<float>(i + 1);
    }

    // cal float16
    EigenDataStats stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
    const auto statsStr = stats.GetDataStatsStr();
    oss << "Avg_f=" << avg << "  Avg_f16=" << stats.avgValue_ << std::endl;

    // Assert is fail
    std::cout << oss.str() << statsStr << std::endl;
    bool flag = true;
    if (std::abs(stats.avgValue_ - static_cast<double>(avg)) > 0.001) {
        std::cout << "[ERROR]Convergence criterion not reached for avg\n"
                  << "Avg_f=" << avg << " Avg_f16=" << stats.avgValue_ << std::endl;
        flag = false;
        FAIL();
    }
    EXPECT_EQ(flag, true);
}

TEST_F(AicpuDumpTaskTest, EigenDataStatsTestNormalMulti) {
    const uint32_t test_num = 100U;
    const uint32_t dataLen = 50U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    std::shared_ptr<float[]> floatDatas(new float[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);

    std::ostringstream oss;
    bool flag = true;
    for (uint32_t j = 0U; j < test_num; ++j) {
        // Gen test data by random
        const int32_t low = 0;
        const int32_t high = 10;
        for (uint32_t i = 0; i < dataLen; ++i) {
            float r = low + static_cast<float>(rand()) * static_cast<float>(high - low) / RAND_MAX;
            floatDatas[i] = r;
            datas[i] = static_cast<Eigen::half>(r);
        }

        // Gen standard mean value
        float avg = 0.0;
        for (uint32_t i = 0; i < dataLen; ++i) {
            avg += (floatDatas[i] - avg) / static_cast<float>(i + 1);
        }

        // cal float16
        EigenDataStats stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
        const auto statsStr = stats.GetDataStatsStr();
        oss << "Iter=" << j << " Avg_f=" << avg << "  Avg_f16=" << stats.avgValue_ << std::endl;

        // Assert is fail
        std::cout << oss.str() << statsStr << std::endl;
        if (std::abs(stats.avgValue_ - static_cast<double>(avg)) > 0.001) {
            std::cout << "[ERROR]Convergence criterion not reached for avg in multi test\n"
                      << "Iter=" << j << " Avg_f=" << avg << " Avg_f16=" << stats.avgValue_ << std::endl;
            flag = false;
            FAIL();
        }
    }
    EXPECT_EQ(flag, true);
}

TEST_F(AicpuDumpTaskTest, EigenDataStatsTestNan) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);
    datas[0] = static_cast<Eigen::half>(NAN);

    EigenDataStats stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
    EXPECT_STREQ("nan,nan,nan,10,1,0,0", stats.GetDataStatsStr().c_str());
}

TEST_F(AicpuDumpTaskTest, EigenDataStatsTestInf) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<Eigen::half[]> datas(new Eigen::half[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(Eigen::half);
    datas[0] = static_cast<Eigen::half>(INFINITY);

    EigenDataStats stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
    EXPECT_STREQ("inf,0,inf,10,0,0,1", stats.GetDataStatsStr().c_str());
}

TEST_F(AicpuDumpTaskTest, Uint8DataStatsTest) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint8_t[]> datas(new uint8_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint8_t);
    for (uint32_t i = 0U; i < dataLen; i++) {
        datas[i] = i + 1U;
    }

    Uint8DataStats stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
    EXPECT_STREQ("10,1,5.5,10,0,0,0", stats.GetDataStatsStr().c_str());
}

TEST_F(AicpuDumpTaskTest, Uint32DataStatsTest) {
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint32_t[]> datas(new uint32_t[dataLen]);
    const uint64_t dataSize = dataLen * sizeof(uint32_t);
    for (uint32_t i = 0U; i < dataLen; i++) {
        datas[i] = i + 1U;
    }

    NormalDataStats<uint32_t> stats(PtrToValue(static_cast<void *>(datas.get())), dataSize);
    EXPECT_STREQ("10,1,5.5,10,0,0,0", stats.GetDataStatsStr().c_str());
}

TEST_F(AicpuDumpTaskTest, LoadOpMappingInfoSuccess01) {
    // load success at normal situation
    const uint32_t modelId = 0U;
    const uint64_t stepId = 0UL;
    const uint64_t iterationsPerLoop = 1UL;
    const uint64_t loopCond = 1UL;
    const uint64_t streamId = 1;
    const uint64_t taskId = 1;

    aicpu::dump::OpMappingInfo opMappingInfo;
    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model0");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    OpDumpTaskManager taskManager;
    const int32_t ret = taskManager.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuDumpTaskTest, LoadOpMappingInfoSuccess02) {
    // load succecc when streamId and taskId is invalid value
    const uint32_t modelId = 0U;
    const uint64_t stepId = 0UL;
    const uint64_t iterationsPerLoop = 1UL;
    const uint64_t loopCond = 1UL;
    const uint64_t streamId = INVALID_VAL + 1;
    const uint64_t taskId = INVALID_VAL + 1;

    aicpu::dump::OpMappingInfo opMappingInfo;
    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model0");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
    opMappingInfo.set_flag(0x01);
    aicpu::dump::Task *task = opMappingInfo.add_task();
    task->set_task_id(taskId);
    task->set_stream_id(streamId);

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);

    OpDumpTaskManager taskManager;
    const int32_t ret = taskManager.LoadOpMappingInfo(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuDumpTaskTest, isSupportKfcDumpUTCust) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    opDumpTask->dumpMode_ = DumpMode::STATS_DUMP_DATA;
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, true);
    bool ret = opDumpTask->IsSupportKfcDump();
    EXPECT_EQ(ret, true);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, isSupportKfcDumpUTFfts) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::FFTSPLUS;
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    bool ret = opDumpTask->IsSupportKfcDump();
    EXPECT_EQ(ret, false);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, isSupportKfcDumpUTNoKfcApi) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFakeFail));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    bool ret = opDumpTask->IsSupportKfcDump();
    EXPECT_EQ(ret, false);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, GetDumpOpTaskDataforKfcUTSuccess) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    opDumpTask->dumpMode_ = DumpMode::STATS_DUMP_DATA;
    const KfcDumpTask dumpInfo(0, 0, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    KfcDumpInfo *kfcDumpInfo = nullptr;
    const int32_t ret = taskManager.GetDumpOpTaskDataforKfc(dumpInfo, &kfcDumpInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, GetDumpOpTaskDataforKfcUTFail) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    const KfcDumpTask dumpInfo(0, 0, 0);
    const KfcDumpTask taskKey(1, 0, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    KfcDumpInfo *kfcDumpInfo = nullptr;
    const int32_t ret = taskManager.GetDumpOpTaskDataforKfc(taskKey, &kfcDumpInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, DumpOpTaskDataforKfcUTSuccess) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    opDumpTask->dumpMode_ = DumpMode::STATS_DUMP_DATA;
    const KfcDumpTask dumpInfo(0, 0, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    const std::string content = "stub";
    uint32_t length = 20;
    const int32_t ret = taskManager.DumpOpTaskDataforKfc(dumpInfo, (void *)content.c_str(), length);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, DumpOpTaskDataforKfcUTFail) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    const KfcDumpTask dumpInfo(0, 0, 0);
    const KfcDumpTask taskKey(1, 0, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    const std::string content = "stub";
    uint32_t length = 20;
    const int32_t ret = taskManager.DumpOpTaskDataforKfc(taskKey, (void *)content.c_str(), length);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, GetKfcDumpInfoUTSuccess) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    opDumpTask->dumpMode_ = DumpMode::STATS_DUMP_DATA;
    opDumpTask->opName_ = "TestKfcDump_01";
    opDumpTask->opType_ = "TestKfcDump";
    opDumpTask->opWorkspaceAddr_.push_back(44442222);
    opDumpTask->opWorkspaceSize_.push_back(25);
    opDumpTask->inputsDataType_.push_back(1);
    opDumpTask->inputsFormat_.push_back(1);
    opDumpTask->inputsShape_.push_back({2,2,3});
    opDumpTask->inputsOriginShape_.push_back({2,4,5});
    opDumpTask->inputsAddrType_.push_back(aicpu::dump::NOTILING_ADDR);
    opDumpTask->inputsBaseAddr_.push_back(0x33332222);
    opDumpTask->inputsSize_.push_back(4);
    const uint32_t dataLen = 10U;
    std::shared_ptr<uint32_t[]> datas(new uint32_t[dataLen]);
    ::toolkit::dumpdata::OpInput *opInput = opDumpTask->baseDumpData_.add_input();
    if (opInput != nullptr) {
        opInput->set_address(datas.get());
    }
    ::toolkit::dumpdata::OpOutput *opOutput = opDumpTask->baseDumpData_.add_output();
    if (opInput != nullptr) {
        opOutput->set_address(datas.get());
    }
    opDumpTask->outputsDataType_.push_back(2);
    opDumpTask->outputsFormat_.push_back(3);
    opDumpTask->outputsShape_.push_back({2,2,3});
    opDumpTask->outputsOriginShape_.push_back({2,4,5});
    opDumpTask->outputsAddrType_.push_back(aicpu::dump::NOTILING_ADDR);
    opDumpTask->outputsBaseAddr_.push_back(0x11112222);
    opDumpTask->outputSize_.push_back(8);

    const KfcDumpTask dumpInfo(0, 0, 1);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    KfcDumpInfo *kfcDumpInfo = nullptr;
    const int32_t ret = taskManager.GetDumpOpTaskDataforKfc(dumpInfo, &kfcDumpInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuDumpTaskTest, ProcessDumpStatisticForKfcDumpUTSuccess) {
    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 2);
    const std::string dumpFilePath = "./test/";
    MOCKER_CPP(&OpDumpTask::IsSupportKfcDump).stubs().will(returnValue(true));
    MOCKER_CPP(&OpDumpTask::CheckAndGetKfcDumpStatsAPI).stubs().will(invoke(CheckAndGetKfcDumpStatsAPIFake));
    opDumpTask->kfcDumpFunc_ = &AicpuKfcDumpSrvLaunch;
    TaskInfoExt dumpTaskInfo = {};
    dumpTaskInfo.streamId_ = 0;
    dumpTaskInfo.taskId_ = 2;
    dumpTaskInfo.indexId_ = 0;
    KfcDumpTask dumpInfo(0, 2, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    auto ret = opDumpTask->ProcessDumpStatistic(dumpTaskInfo, dumpFilePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    MOCKER_CPP(&IdeDumpStart)
        .stubs()
        .will(returnValue((void *)nullptr));
    ret = opDumpTask->ProcessDumpStatistic(dumpTaskInfo, dumpFilePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    ret = opDumpTask->ProcessDumpStatistic(dumpTaskInfo, dumpFilePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuDumpTaskTest, DumpOpInfoForUnknowShapeForKfcDumpUtSuccess) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));
    // load success at normal situation
    const uint32_t modelId = 0U;
    const uint64_t stepId = 0UL;
    const uint64_t iterationsPerLoop = 1UL;
    const uint64_t loopCond = 1UL;
    const uint64_t streamId = 1;
    const uint64_t taskId = 1;
    const int32_t dataType = 7; // int32
    aicpu::dump::OpMappingInfo opMappingInfo;
    opMappingInfo.set_dump_path("dump_path");
    opMappingInfo.set_model_name("model0");
    opMappingInfo.set_model_id(modelId);
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    opMappingInfo.set_iterations_per_loop_addr(reinterpret_cast<uint64_t>(&iterationsPerLoop));
    opMappingInfo.set_loop_cond_addr(reinterpret_cast<uint64_t>(&loopCond));
    opMappingInfo.set_flag(0x01);
    opMappingInfo.set_dump_data(0x01);
    {
        aicpu::dump::Task *task = opMappingInfo.add_task();
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        task->set_tasktype(aicpu::dump::Task::AICPU);
        aicpu::dump::Op *op = task->mutable_op();
        op->set_op_name("op_n a.m\\ /e");
        op->set_op_type("op_t y.p\\e/ rr");

        aicpu::dump::Output *output = task->add_output();
        output->set_data_type(dataType);
        output->set_format(1);
        aicpu::dump::Shape *shape = output->mutable_shape();
        shape->add_dim(2);
        shape->add_dim(3);
        aicpu::dump::Shape *originShape = output->mutable_origin_shape();
        originShape->add_dim(2);
        originShape->add_dim(3);
        int32_t data[6] = {1, 2, 3, 4, 5, 6};
        int32_t *p = &data[0];
        output->set_address(reinterpret_cast<uint64_t>(&p));
        output->set_original_name("original_name");
        output->set_original_output_index(11);
        output->set_original_output_data_type(dataType);
        output->set_original_output_format(1);
        output->set_size(sizeof(data));

        aicpu::dump::Input *input = task->add_input();
        input->set_data_type(dataType);
        input->set_format(1);
        aicpu::dump::Shape *inShape = input->mutable_shape();
        inShape->add_dim(2);
        inShape->add_dim(3);
        aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
        inputOriginShape->add_dim(2);
        inputOriginShape->add_dim(3);
        int32_t inData[6] = {10, 20, 30, 40, 50, 60};
        input->set_address(reinterpret_cast<uint64_t>(&p));
        input->set_size(sizeof(inData));
    }
    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    int32_t ret = 0;
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    ret = taskManager.DumpOpInfoForUnknowShape(opMappingInfoStr.c_str(), opMappingInfoStr.length());
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    {
        aicpu::dump::Task *task = opMappingInfo.add_task();
        task->set_task_id(taskId);
        task->set_stream_id(streamId);
        task->set_tasktype(aicpu::dump::Task::AICPU);
        aicpu::dump::Op *op = task->mutable_op();
        op->set_op_name("op_n a.m\\ /e");
        op->set_op_type("op_t y.p\\e/ rr");

        aicpu::dump::Output *output = task->add_output();
        output->set_data_type(dataType);
        output->set_format(1);
        aicpu::dump::Shape *shape = output->mutable_shape();
        shape->add_dim(2);
        shape->add_dim(3);
        aicpu::dump::Shape *originShape = output->mutable_origin_shape();
        originShape->add_dim(2);
        originShape->add_dim(3);
        int32_t data[6] = {1, 2, 3, 4, 5, 6};
        int32_t *p = &data[0];
        output->set_address(reinterpret_cast<uint64_t>(&p));
        output->set_original_name("original_name");
        output->set_original_output_index(11);
        output->set_original_output_data_type(dataType);
        output->set_original_output_format(1);
        output->set_size(sizeof(data));

        aicpu::dump::Input *input = task->add_input();
        input->set_data_type(dataType);
        input->set_format(1);
        aicpu::dump::Shape *inShape = input->mutable_shape();
        inShape->add_dim(2);
        inShape->add_dim(3);
        aicpu::dump::Shape *inputOriginShape = input->mutable_origin_shape();
        inputOriginShape->add_dim(2);
        inputOriginShape->add_dim(3);
        int32_t inData[6] = {10, 20, 30, 40, 50, 60};
        input->set_address(reinterpret_cast<uint64_t>(&p));
        input->set_size(sizeof(inData));
    }
    std::string opMappingInfoStr1;
    opMappingInfo.SerializeToString(&opMappingInfoStr1);
    ret = taskManager.DumpOpInfoForUnknowShape(opMappingInfoStr1.c_str(), opMappingInfoStr1.length());
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    ret = taskManager.DumpOpInfoForUnknowShape(0, 0);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

    std::string opMappingInfoStr2 = "123";
    ret = taskManager.DumpOpInfoForUnknowShape(opMappingInfoStr2.c_str(), opMappingInfoStr2.length());
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);

}
TEST_F(AicpuDumpTaskTest, GetDumpOpTaskDataforKfcUTFail1) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    const KfcDumpTask dumpInfo(0, 0, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    KfcDumpInfo *kfcDumpInfo = nullptr;
    MOCKER_CPP(&OpDumpTaskManager::CreateKfcDumpInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    const int32_t ret = taskManager.GetDumpOpTaskDataforKfc(dumpInfo, &kfcDumpInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    taskManager.custDumpTaskMap_.clear();
}
TEST_F(AicpuDumpTaskTest, GetDumpOpTaskDataforKfcUTFail2) {
    MOCKER(dlsym).stubs().will(invoke(dlsymFake));

    std::shared_ptr<OpDumpTask> opDumpTask = std::make_shared<OpDumpTask>(0, 0);
    opDumpTask->taskType_ = aicpu::dump::Task::AICPU;
    const KfcDumpTask dumpInfo(0, 0, 0);
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.SetCustDumpTaskFlag(0, 0, false);
    taskManager.MakeDumpOpInfoforKfc(dumpInfo, opDumpTask);
    KfcDumpInfo *kfcDumpInfo = nullptr;
    MOCKER_CPP(&OpDumpTaskManager::CreateKfcDumpInfo).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    const int32_t ret = taskManager.GetDumpOpTaskDataforKfc(dumpInfo, &kfcDumpInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    taskManager.custDumpTaskMap_.clear();
}

TEST_F(AicpuDumpTaskTest, GetDumpOpTaskDataforKfcUTFail3) {
    KfcDumpInfo **dumpInfo = nullptr;
    KfcDumpTask taskinfo;
    std::shared_ptr<OpDumpTask> dumpTask = nullptr;
    OpDumpTaskManager &taskManager = OpDumpTaskManager::GetInstance();
    taskManager.kfcDumpTaskMap_.insert(std::make_pair(taskinfo, dumpTask));
    int32_t ret = 0;
    ret = taskManager.GetDumpOpTaskDataforKfc(taskinfo, dumpInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    void *dumpData = nullptr;
    uint32_t length = 0;
    ret = taskManager.DumpOpTaskDataforKfc(taskinfo, dumpData, length);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}
