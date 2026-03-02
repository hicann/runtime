/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <gtest/gtest.h>
#include <iostream>
#include <thread>
#include "mockcpp/mockcpp.hpp"
#define protected public
#define private public

#include "kernel_dfx_dumper.h"
#include "rt_inner_dfx.h"
#include "lib_path.h"
#include "file_utils.h"
#include "mmpa_api.h"

using namespace Adx;

class KernelDfxDumperUtest: public testing::Test {
protected:
    virtual void SetUp() {
        KernelDfxDumper::Instance().UnInit();
    }
    virtual void TearDown()
    {
        KernelDfxDumper::Instance().UnInit();
        GlobalMockObject::verify();
    }
};

TEST_F(KernelDfxDumperUtest, Test_DfxDumper_EnableWithEnv)
{
    (void)system("rm -rf ./Test_DfxDumper_EnableWithEnv");
    (void)system("mkdir ./Test_DfxDumper_EnableWithEnv");
    (void)system("mkdir ./Test_DfxDumper_EnableWithEnv/NoPermission");
    (void)system("chmod 400 ./Test_DfxDumper_EnableWithEnv/NoPermission");

    // 无环境变量，不使能KernelDataDump
    KernelDfxDumper::Instance().EnableDfxDumper();
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(), false);

    // 环境变量ASCEND_DUMP_PATH无效路径/ASCEND_WORK_PATH无效路径，不使能KernelDataDump
    (void)setenv("ASCEND_DUMP_PATH", "./Test_DfxDumper_EnableWithEnv/NoPermission/ascendDumpPath", 1);
    (void)setenv("ASCEND_WORK_PATH", "./Test_DfxDumper_EnableWithEnv/NoPermission/ascendWorkPath", 1);
    KernelDfxDumper::Instance().EnableDfxDumper();
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(), false);

    // 环境变量ASCEND_DUMP_PATH有效路径/ASCEND_WORK_PATH有效路径，使能KernelDataDump(ASCEND_DUMP_PATH)
    (void)setenv("ASCEND_DUMP_PATH", "./Test_DfxDumper_EnableWithEnv/ascendDumpPath", 1);
    (void)setenv("ASCEND_WORK_PATH", "./Test_DfxDumper_EnableWithEnv/ascendWorkPath", 1);
    KernelDfxDumper::Instance().EnableDfxDumper();
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF), false);
    EXPECT_EQ(KernelDfxDumper::Instance().dumpPath_.find("ascendDumpPath") != std::string::npos, true);

    KernelDfxDumper::Instance().UnInit();
    // 环境变量ASCEND_DUMP_PATH无效路径/ASCEND_WORK_PATH有效路径，使能KernelDataDump(ASCEND_WORK_PATH)
    (void)setenv("ASCEND_DUMP_PATH", "./Test_DfxDumper_EnableWithEnv/NoPermission/ascendDumpPath", 1);
    (void)setenv("ASCEND_WORK_PATH", "./Test_DfxDumper_EnableWithEnv/ascendWorkPath", 1);
    KernelDfxDumper::Instance().EnableDfxDumper();
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF), false);
    EXPECT_EQ(KernelDfxDumper::Instance().dumpPath_.find("ascendWorkPath") != std::string::npos, true);

    // 已通过环境变量ASCEND_WORK_PATH使能KernelDataDump，再通过环境变量ASCEND_DUMP_PATH使能，不覆盖路径
    (void)setenv("ASCEND_DUMP_PATH", "./Test_DfxDumper_EnableWithEnv/ascendDumpPath", 1);
    (void)setenv("ASCEND_WORK_PATH", "./Test_DfxDumper_EnableWithEnv/ascendWorkPath", 1);
    KernelDfxDumper::Instance().EnableDfxDumper();
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF), false);
    EXPECT_EQ(KernelDfxDumper::Instance().dumpPath_.find("ascendWorkPath") != std::string::npos, true);

    // 覆盖异常分支
    MOCKER_CPP(&KernelDfxDumper::InitTask).stubs().will(returnValue(-1));
    KernelDfxDumper::Instance().EnableDfxDumper();

    (void)system("rm -rf ./Test_DfxDumper_EnableWithEnv");
    (void)unsetenv("ASCEND_DUMP_PATH");
    (void)unsetenv("ASCEND_WORK_PATH");
}

TEST_F(KernelDfxDumperUtest, Test_DfxDumper_EnableWithConfig)
{
    (void)system("rm -rf ./Test_DfxDumper_EnableWithConfig");
    (void)system("mkdir ./Test_DfxDumper_EnableWithConfig");
    (void)system("mkdir ./Test_DfxDumper_EnableWithConfig/NoPermission");
    (void)system("chmod 400 ./Test_DfxDumper_EnableWithConfig/NoPermission");

    // 空配置，不使能KernelDataDump
    DumpDfxConfig dumpDfxConfig;
    int32_t ret = KernelDfxDumper::Instance().EnableDfxDumper(dumpDfxConfig);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(), false);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // 配置无效路径，不使能KernelDataDump
    dumpDfxConfig.dfxTypes.push_back("all");
    dumpDfxConfig.dumpPath = "./Test_DfxDumper_EnableWithConfig/NoPermission/ascendDumpPath";
    ret = KernelDfxDumper::Instance().EnableDfxDumper(dumpDfxConfig);
    // 不清理注册标记
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT), true);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // 配置有效路径，使能KernelDataDump
    dumpDfxConfig.dfxTypes.push_back("printf");
    dumpDfxConfig.dfxTypes.push_back("tensor");
    dumpDfxConfig.dfxTypes.push_back("assert");
    dumpDfxConfig.dfxTypes.push_back("timestamp");
    dumpDfxConfig.dumpPath = "./Test_DfxDumper_EnableWithConfig/ascendDumpPath";
    ret = KernelDfxDumper::Instance().EnableDfxDumper(dumpDfxConfig);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_TENSOR), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_ASSERT), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_TIME_STAMP), true);
    EXPECT_EQ(KernelDfxDumper::Instance().IsEnabled(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_BLOCK_INFO), true);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    (void)system("rm -rf ./Test_DfxDumper_EnableWithConfig");
}

TEST_F(KernelDfxDumperUtest, Test_DfxDumper_InitUnitTask)
{
    (void)system("rm -rf ./Test_DfxDumper_InitUnitTask");
    (void)system("mkdir ./Test_DfxDumper_InitUnitTask");

    // 未注册，不启动落盘任务
    int32_t ret = KernelDfxDumper::Instance().InitTask();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(KernelDfxDumper::Instance().taskInit_, false);
    // 未注册，关闭落盘任务
    ret = KernelDfxDumper::Instance().UnInitTask();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(KernelDfxDumper::Instance().taskInit_, false);

    // 注册并启动落盘任务
    DumpDfxConfig dumpDfxConfig;
    dumpDfxConfig.dfxTypes.push_back("all");
    dumpDfxConfig.dumpPath = "./Test_DfxDumper_InitUnitTask/ascendDumpPath";
    ret = KernelDfxDumper::Instance().EnableDfxDumper(dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // 重复启动落盘任务不报错
    ret = KernelDfxDumper::Instance().InitTask();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(KernelDfxDumper::Instance().taskInit_, true);

    // 关闭落盘任务
    ret = KernelDfxDumper::Instance().UnInitTask();
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(KernelDfxDumper::Instance().taskInit_, false);

    (void)system("rm -rf ./Test_DfxDumper_InitUnitTask");
}

TEST_F(KernelDfxDumperUtest, Test_DfxDumper_DumpDfxCallback_Failed)
{
    (void)system("rm -rf ./Test_DfxDumper_DumpDfxCallback_Failed");
    (void)system("mkdir ./Test_DfxDumper_DumpDfxCallback_Failed");

    // 注册并启动落盘任务
    DumpDfxConfig dumpDfxConfig;
    dumpDfxConfig.dfxTypes.push_back("all");
    dumpDfxConfig.dumpPath = "./Test_DfxDumper_DumpDfxCallback_Failed/ascendDumpPath";
    int32_t ret = KernelDfxDumper::Instance().EnableDfxDumper(dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // 未注册的类型
    DumpKernelDfxInfoCallback(rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_PRINTF, 0, 0, nullptr, 0);
    const uint8_t buffer[] = "printf|assert";
    size_t length = sizeof(buffer);
    // 无效输入数据
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_INVALID, 0, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_FAILED);
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 3, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_FAILED);
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, nullptr, length);
    EXPECT_EQ(ret, ADUMP_FAILED);
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, buffer, 0);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // 无法加入落盘任务
    MOCKER_CPP(&Adx::BoundQueueMemory<DumpDfxInfo>::Push).stubs().will(returnValue(false));
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // 队列已满
    MOCKER_CPP(&Adx::BoundQueueMemory<DumpDfxInfo>::IsFull).stubs().will(returnValue(true));
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_FAILED);

    // 拷贝数据失败
    MOCKER(memcpy_s).stubs().will(returnValue(EN_ERROR));
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_FAILED);



    (void)system("rm -rf ./Test_DfxDumper_DumpDfxCallback_Invalid");
}

INT32 mmGetDiskFreeSpaceStub(const char* path, mmDiskSize *diskSize)
{
    diskSize->availSize = 10;
    diskSize->freeSize = 2097152;
    return EN_OK;
}

TEST_F(KernelDfxDumperUtest, Test_DfxDumper_DumpDfxCallback_RecordDisk)
{
    (void)system("rm -rf ./Test_DfxDumper_DumpDfxCallback_RecordDisk");
    (void)system("mkdir ./Test_DfxDumper_DumpDfxCallback_RecordDisk");

    // 落盘任务无效输入数据
    DumpDfxInfo dfxInfo{"", nullptr, 0UL};
    KernelDfxDumper::Instance().RecordDfxInfoToDisk(dfxInfo);

    // 注册并启动落盘任务
    DumpDfxConfig dumpDfxConfig;
    dumpDfxConfig.dfxTypes.push_back("all");
    dumpDfxConfig.dumpPath = "./Test_DfxDumper_DumpDfxCallback_RecordDisk/ascendDumpPath";
    int32_t ret = KernelDfxDumper::Instance().EnableDfxDumper(dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    // 加入落盘任务成功
    const uint8_t buffer[] = "printf|assert";
    size_t length = sizeof(buffer);

    Path filePath = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_0.bin");
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    // mmGetDiskFreeSpace桩函数：磁盘空间不足，不能落盘
    while(!KernelDfxDumper::Instance().dumpDfxInfoQueue_.IsEmpty()) {
        usleep(100000U);
    }
    EXPECT_EQ(filePath.Exist(), false);

    // 正常落盘数据
    MOCKER(mmGetDiskFreeSpace).stubs().will(invoke(mmGetDiskFreeSpaceStub));
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 0, buffer, length);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    while(!KernelDfxDumper::Instance().dumpDfxInfoQueue_.IsEmpty()) {
        usleep(100000U);
    }
    EXPECT_EQ(filePath.Exist(), true);

    // 写文件失败
    MOCKER(Adx::FileUtils::WriteFile).stubs().will(returnValue(1));
    Path filePath2 = Path(KernelDfxDumper::Instance().dumpPath_).Concat("asc_kernel_data_aic_1.bin");
    ret = KernelDfxDumper::Instance().DumpKernelDfxInfo(
        rtKernelDfxInfoType::RT_KERNEL_DFX_INFO_DEFAULT, 0, 1, buffer, length);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    while(!KernelDfxDumper::Instance().dumpDfxInfoQueue_.IsEmpty()) {
        usleep(100000U);
    }
    EXPECT_EQ(filePath2.Exist(), false);

    (void)system("rm -rf ./Test_DfxDumper_DumpDfxCallback_RecordDisk");
}