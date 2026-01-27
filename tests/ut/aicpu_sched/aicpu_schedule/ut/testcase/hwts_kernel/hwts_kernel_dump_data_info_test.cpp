/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <vector>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define private public
#include "aicpusd_model.h"
#include "aicpusd_resource_manager.h"
#include "aicpu_task_struct.h"
#include "dump_task.h"
#include "hwts_kernel_dfx.h"
#undef private
#include "aicpusd_context.h"
#include "aicpusd_model_execute.h"
#include "hwts_kernel_stub.h"

using namespace AicpuSchedule;

class DumpDataInfoKernelTest : public EventProcessKernelTest {
protected:
    DumpDataInfoTsKernel kernel_;
};

TEST_F(DumpDataInfoKernelTest, SingleOpOrUnknownShapeOpDumpTest) {
    const int32_t dataType = 7; //int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");

    uint64_t stepId = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    aicpu::dump::Task *task = opMappingInfo.add_task();

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("handsome");
    op->set_op_type("Handsome");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(p));
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
    inShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &(inData[0]);
    input->set_address(reinterpret_cast<uint64_t>(q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    uint64_t protoSize = opMappingInfoStr.size();

    aicpu::HwtsTsKernel kernelInfo = {};
    kernelInfo.kernelType = aicpu::KERNEL_TYPE_AICPU;
    kernelInfo.kernelBase.cceKernel.kernelSo = 0;
    const char *kernelName = "DumpDataInfo";
    kernelInfo.kernelBase.cceKernel.kernelName = uint64_t(kernelName);
    const uint32_t singleOpDumpParamNum = 2;
    const uint32_t paramLen =  sizeof(aicpu::AicpuParamHead) + singleOpDumpParamNum*sizeof(uint64_t);
    std::unique_ptr<char[]> buff(new (std::nothrow) char[paramLen]);
    if (buff == nullptr) {
        return;
    }
    aicpu::AicpuParamHead *paramHead = (aicpu::AicpuParamHead*)(buff.get());
    paramHead->length = paramLen;
    paramHead->ioAddrNum = 2;
    uint64_t *param = (uint64_t*)((char*)(buff.get()) + sizeof(aicpu::AicpuParamHead));
    param[0] = uint64_t(opMappingInfoStr.data());
    param[1] = uint64_t(&protoSize);
    kernelInfo.kernelBase.cceKernel.paramBase = uint64_t(buff.get());
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_OK);
}

TEST_F(DumpDataInfoKernelTest, SingleOpOrUnknownShapeOpDumpTest11) {
    const int32_t dataType = 7; //int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");

    uint64_t stepId = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    aicpu::dump::Task *task = opMappingInfo.add_task();

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("handsome");
    op->set_op_type("Handsome");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(p));
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
    inShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &(inData[0]);
    input->set_address(reinterpret_cast<uint64_t>(q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    uint64_t protoSize = opMappingInfoStr.size();

    aicpu::HwtsTsKernel kernelInfo = {};
    kernelInfo.kernelType = aicpu::KERNEL_TYPE_AICPU;
    kernelInfo.kernelBase.cceKernel.kernelSo = 0;
    const char *kernelName = "DumpDataInfo";
    kernelInfo.kernelBase.cceKernel.kernelName = uint64_t(kernelName);
    const uint32_t singleOpDumpParamNum = 2;
    const uint32_t paramLen =  sizeof(aicpu::AicpuParamHead) + singleOpDumpParamNum*sizeof(uint64_t);
    std::unique_ptr<char[]> buff(new (std::nothrow) char[paramLen]);
    if (buff == nullptr) {
        return;
    }
    aicpu::AicpuParamHead *paramHead = (aicpu::AicpuParamHead*)(buff.get());
    paramHead->length = paramLen;
    paramHead->ioAddrNum = 2;
    uint64_t *param = (uint64_t*)((char*)(buff.get()) + sizeof(aicpu::AicpuParamHead));
    param[0] = reinterpret_cast<uint64_t>(opMappingInfoStr.data());
    param[1] = reinterpret_cast<uint64_t>(&protoSize);
    kernelInfo.kernelBase.cceKernel.paramBase = uint64_t(buff.get());
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_OK);
}

TEST_F(DumpDataInfoKernelTest, SingleOpOrUnknownShapeOpDumpTest_DoDump_failed) {
    const int32_t dataType = 7; //int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");

    uint64_t stepId = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    aicpu::dump::Task *task = opMappingInfo.add_task();

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("handsome");
    op->set_op_type("Handsome");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(p));
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
    inShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &(inData[0]);
    input->set_address(reinterpret_cast<uint64_t>(q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    uint64_t protoSize = opMappingInfoStr.size();

    aicpu::HwtsTsKernel kernelInfo = {};
    kernelInfo.kernelType = aicpu::KERNEL_TYPE_AICPU;
    kernelInfo.kernelBase.cceKernel.kernelSo = 0;
    const char *kernelName = "DumpDataInfo";
    kernelInfo.kernelBase.cceKernel.kernelName = uint64_t(kernelName);
    const uint32_t singleOpDumpParamNum = 2;
    const uint32_t paramLen =  sizeof(aicpu::AicpuParamHead) + singleOpDumpParamNum*sizeof(uint64_t);
    std::unique_ptr<char[]> buff(new (std::nothrow) char[paramLen]);
    if (buff == nullptr) {
        return;
    }
    aicpu::AicpuParamHead *paramHead = (aicpu::AicpuParamHead*)(buff.get());
    paramHead->length = paramLen;
    paramHead->ioAddrNum = 2;
    uint64_t *param = (uint64_t*)((char*)(buff.get()) + sizeof(aicpu::AicpuParamHead));
    param[0] = reinterpret_cast<uint64_t>(opMappingInfoStr.data());
    param[1] = reinterpret_cast<uint64_t>(&protoSize);
    kernelInfo.kernelBase.cceKernel.paramBase = uint64_t(buff.get());
    MOCKER_CPP(&OpDumpTaskManager::CreateOpDumpTask).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    GlobalMockObject::verify();
    MOCKER_CPP(&OpDumpTask::PreProcessOpMappingInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    MOCKER_CPP(&OpDumpTaskManager::CreateOpDumpTask).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}

TEST_F(DumpDataInfoKernelTest, SingleOpOrUnknownShapeOpDumpTest_DoDumpST_failed)
{
    const int32_t dataType = 7; //int32
    aicpu::dump::OpMappingInfo opMappingInfo;

    opMappingInfo.set_dump_path("dump_path");

    uint64_t stepId = 1;
    opMappingInfo.set_step_id_addr(reinterpret_cast<uint64_t>(&stepId));
    aicpu::dump::Task *task = opMappingInfo.add_task();

    aicpu::dump::Op *op = task->mutable_op();
    op->set_op_name("handsome");
    op->set_op_type("Handsome");

    aicpu::dump::Output *output = task->add_output();
    output->set_data_type(dataType);
    output->set_format(1);
    aicpu::dump::Shape *shape = output->mutable_shape();
    shape->add_dim(2);
    shape->add_dim(2);
    int32_t data[4] = {1, 2, 3, 4};
    int32_t *p = &data[0];
    output->set_address(reinterpret_cast<uint64_t>(p));
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
    inShape->add_dim(2);
    int32_t inData[4] = {10, 20, 30, 40};
    int32_t *q = &(inData[0]);
    input->set_address(reinterpret_cast<uint64_t>(q));
    input->set_size(sizeof(inData));

    std::string opMappingInfoStr;
    opMappingInfo.SerializeToString(&opMappingInfoStr);
    uint64_t protoSize = opMappingInfoStr.size();

    aicpu::HwtsTsKernel kernelInfo = {};
    kernelInfo.kernelType = aicpu::KERNEL_TYPE_AICPU;
    kernelInfo.kernelBase.cceKernel.kernelSo = 0;
    const char *kernelName = "DumpDataInfo";
    kernelInfo.kernelBase.cceKernel.kernelName = uint64_t(kernelName);
    const uint32_t singleOpDumpParamNum = 2;
    const uint32_t paramLen =  sizeof(aicpu::AicpuParamHead) + singleOpDumpParamNum*sizeof(uint64_t);
    std::unique_ptr<char[]> buff(new (std::nothrow) char[paramLen]);
    if (buff == nullptr) {
        return;
    }
    aicpu::AicpuParamHead *paramHead = (aicpu::AicpuParamHead*)(buff.get());
    paramHead->length = paramLen;
    paramHead->ioAddrNum = 2;
    uint64_t *param = (uint64_t*)((char*)(buff.get()) + sizeof(aicpu::AicpuParamHead));
    param[0] = reinterpret_cast<uint64_t>(opMappingInfoStr.data());
    param[1] = reinterpret_cast<uint64_t>(&protoSize);
    kernelInfo.kernelBase.cceKernel.paramBase = uint64_t(buff.get());
    MOCKER_CPP(&OpDumpTaskManager::CreateOpDumpTask).stubs().will(returnValue(AICPU_SCHEDULE_OK));
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    GlobalMockObject::verify();
    MOCKER_CPP(&OpDumpTask::PreProcessOpMappingInfo).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
    MOCKER_CPP(&OpDumpTaskManager::CreateOpDumpTask).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_DUMP_FAILED));
    EXPECT_EQ(kernel_.Compute(kernelInfo), AICPU_SCHEDULE_ERROR_DUMP_FAILED);
}