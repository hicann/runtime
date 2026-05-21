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
#include <unistd.h>
#include "mockcpp/mockcpp.hpp"
#include <vector>
#include "dump_config_converter.h"
#include "log/adx_log.h"
#include "mmpa_api.h"
#include "fstream"
#include "utils.h"
#include "error_manager_stub.h"

using namespace Adx;

namespace {
void TestFailureHelper(const std::string &configData, const std::string &configPath,
                       const std::string &expectedErrorCode)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    
    ClearLastReportedErrorCode();
    DumpConfigConverter converter{configData.c_str(), configData.size(), configPath.c_str()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_FALSE(IsNeedDump);
    EXPECT_EQ(GetLastReportedErrorCode(), expectedErrorCode);
}

struct TestSuccessOptions {
    bool expectNeedDump = false;
    DumpType expectDumpType = DumpType::OPERATOR;
    DumpConfig *outDumpConfig = nullptr;
    DumpDfxConfig *outDumpDfxConfig = nullptr;
    
    TestSuccessOptions(bool needDump, DumpType type, DumpConfig *cfg = nullptr, DumpDfxConfig *dfx = nullptr)
        : expectNeedDump(needDump), expectDumpType(type), outDumpConfig(cfg), outDumpDfxConfig(dfx) {}
};

void TestSuccessHelperWithOpts(const std::string &configData, const std::string &configPath,
                               const TestSuccessOptions &opts)
{
    DumpConfig localDumpConfig;
    DumpDfxConfig localDumpDfxConfig;
    DumpConfig &dumpConfig = opts.outDumpConfig ? *opts.outDumpConfig : localDumpConfig;
    DumpDfxConfig &dumpDfxConfig = opts.outDumpDfxConfig ? *opts.outDumpDfxConfig : localDumpDfxConfig;
    
    DumpType dumpType;
    bool IsNeedDump = false;
    DumpConfigConverter converter{configData.c_str(), configData.size(), configPath.c_str()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(IsNeedDump, opts.expectNeedDump);
    if (opts.expectNeedDump) {
        EXPECT_EQ(dumpType, opts.expectDumpType);
    }
}

void TestSuccessHelper(const std::string &configData, 
                       const std::string &configPath,
                       bool expectNeedDump,
                       DumpType expectDumpType,
                       DumpConfig &dumpConfig,
                       DumpDfxConfig &dumpDfxConfig)
{
    DumpType dumpType;
    bool IsNeedDump = false;
    DumpConfigConverter converter{configData.c_str(), configData.size(), configPath.c_str()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_EQ(IsNeedDump, expectNeedDump);
    if (expectNeedDump) {
        EXPECT_EQ(dumpType, expectDumpType);
    }
}

void TestSuccessHelper(const std::string &configData, 
                       const std::string &configPath,
                       bool expectNeedDump,
                       DumpType expectDumpType,
                       DumpConfig &dumpConfig)
{
    DumpDfxConfig dumpDfxConfig;
    TestSuccessHelper(configData, configPath, expectNeedDump, expectDumpType, dumpConfig, dumpDfxConfig);
}

void TestSuccessHelper(const std::string &configData, 
                       const std::string &configPath,
                       bool expectNeedDump,
                       DumpType expectDumpType)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    TestSuccessHelper(configData, configPath, expectNeedDump, expectDumpType, dumpConfig, dumpDfxConfig);
}

void TestSuccessHelper(const std::string &configData, 
                       const std::string &configPath,
                       bool expectNeedDump,
                       DumpType expectDumpType,
                       DumpDfxConfig &dumpDfxConfig)
{
    DumpConfig dumpConfig;
    TestSuccessHelper(configData, configPath, expectNeedDump, expectDumpType, dumpConfig, dumpDfxConfig);
}
} // namespace

#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"

class DumpConfigConverterUtest : public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(DumpConfigConverterUtest, TestConvertCommon)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool IsNeedDump = false;

    DumpConfigConverter converter = DumpConfigConverter(nullptr, static_cast<size_t>(-1));
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    MOCKER(&mmRealPath).stubs().will(returnValue(-1));
    std::string configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&mmAccess2).stubs().will(returnValue(-1));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(false));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    GlobalMockObject::reset();
}

TEST_F(DumpConfigConverterUtest, TestConvertException)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configData = ReadFileToString(JSON_BASE "exception/aic_err_brief_dump.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);

    configData = ReadFileToString(JSON_BASE "exception/lite_exception.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);

    configData = ReadFileToString(JSON_BASE "exception/aic_err_norm_dump.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::EXCEPTION);

    configData = ReadFileToString(JSON_BASE "exception/aic_err_detail_dump.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::AIC_ERR_DETAIL_DUMP);

    configData = ReadFileToString(JSON_BASE "exception/invalid_dump_scene.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "exception/dump_scene_conflict_dump_debug.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "exception/dump_scene_conflict_dump_op_switch.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpConfigConverterUtest, TestConvertOverflow)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool IsNeedDump = false;

    std::string configData = ReadFileToString(JSON_BASE "overflow/dump_debug_on.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OP_OVERFLOW);

    configData = ReadFileToString(JSON_BASE "overflow/invalid_dump_debug.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_conflict_op_switch.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_ip_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OP_OVERFLOW);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_no_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_path_empty.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpConfigConverterUtest, TestConvertDataDump)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor_conflict_stats.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_level_kernel.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_level_op.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_mode_input.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_mode_output.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_stats_empty_list.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/dump_stats_no_stats.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_stats_not_empty.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/invalid_dump_data.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/invalid_dump_level.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/invalid_dump_mode.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpConfigConverterUtest, TestNpuCollectPathEnableExceptionDump)
{
    DumpConfig config;
    DumpType dumpType;
    bool ret = false;
    // 无环境变量
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, false);

    (void)system("rm -rf ./TestNpuCollectPathEnableExceptionDump");
    (void)system("mkdir ./TestNpuCollectPathEnableExceptionDump");

    // 环境变量NPU_COLLECT_PATH，无效路径，无法创建目录，不使能L1 exception dump
    (void)system("mkdir ./TestNpuCollectPathEnableExceptionDump/NoPermission");
    (void)system("chmod 400 ./TestNpuCollectPathEnableExceptionDump/NoPermission");
    (void)setenv("NPU_COLLECT_PATH", "./TestNpuCollectPathEnableExceptionDump/NoPermission/npuCollectPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    // 动态探测是否能在chmod 400目录下创建子目录（virtiofs环境下root可能无此权限）
    bool bRet = (system("mkdir ./TestNpuCollectPathEnableExceptionDump/NoPermission/_probe_ 2>/dev/null") == 0);
    if (bRet) { (void)system("rm -rf ./TestNpuCollectPathEnableExceptionDump/NoPermission/_probe_"); }
    EXPECT_EQ(ret, bRet);

    // 环境变量NPU_COLLECT_PATH，无效路径，无权限，不使能L1 exception dump
    (void)system("mkdir -p ./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission");
    (void)system("chmod 400 ./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission");
    (void)setenv("NPU_COLLECT_PATH", "./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    // CheckDumpPath uses access(R_OK|W_OK) on the existing dir — probe the same way
    bool bRet2 = (access("./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission", R_OK | W_OK) == 0);
    EXPECT_EQ(ret, bRet2);

    // 环境变量NPU_COLLECT_PATH，无效路径，非目录，不使能L1 exception dump
    (void)system("touch ./TestNpuCollectPathEnableExceptionDump/npuCollectPathIsFile");
    (void)setenv("NPU_COLLECT_PATH", "./TestNpuCollectPathEnableExceptionDump/npuCollectPathIsFile", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, false);

    // 环境变量NPU_COLLECT_PATH，有效路径，使能L1 exception dump
    (void)setenv("NPU_COLLECT_PATH", "./TestNpuCollectPathEnableExceptionDump/npuCollectPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./TestNpuCollectPathEnableExceptionDump/npuCollectPath");
    (void)system("rm -rf ./TestNpuCollectPathEnableExceptionDump");
    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("NPU_COLLECT_PATH");
    (void)unsetenv("ASCEND_DUMP_SCENE");
}

TEST_F(DumpConfigConverterUtest, TestAscendDumpSceneEnableExceptionDump)
{
    DumpConfig config;
    DumpType dumpType;
    (void)system("rm -rf ./TestAscendDumpSceneEnableExceptionDump");
    (void)system("mkdir ./TestAscendDumpSceneEnableExceptionDump");
    (void)system("mkdir ./TestAscendDumpSceneEnableExceptionDump/NoPermission");
    (void)system("chmod 400 ./TestAscendDumpSceneEnableExceptionDump/NoPermission");

    // 环境变量NPU_COLLECT_PATH，有效路径，使能L1 exception dump
    (void)setenv("NPU_COLLECT_PATH", "./TestAscendDumpSceneEnableExceptionDump/npuCollectPath", 1);
    // 环境变量ASCEND_DUMP_SCENE，无效值，使能L1 exception dump
    (void)setenv("ASCEND_DUMP_SCENE", "!aic_err_brief_dump", 1);
    bool ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./TestAscendDumpSceneEnableExceptionDump/npuCollectPath");

    // 环境变量ASCEND_DUMP_SCENE，有效值，覆盖NPU_COLLECT_PATH
    (void)setenv("ASCEND_DUMP_SCENE", "aic_err_brief_dump", 1);
    // 路径优先级3：未配置路径环境变量，dump_path：默认值路径(./)
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./");

    // 路径优先级2.1：生效ASCEND_WORK_PATH，无效路径，dump_path: 默认值路径(./)
    (void)setenv("ASCEND_WORK_PATH", "./TestAscendDumpSceneEnableExceptionDump/NoPermission/ascendWorkPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);
    // 动态探测是否能在chmod 400目录下创建子目录（virtiofs环境下root可能无此权限）
    bool canWriteNoPermission = (system("mkdir ./TestAscendDumpSceneEnableExceptionDump/NoPermission/_probe_ 2>/dev/null") == 0);
    if (canWriteNoPermission) { (void)system("rm -rf ./TestAscendDumpSceneEnableExceptionDump/NoPermission/_probe_"); }
    std::string dumpPath = canWriteNoPermission ? "./TestAscendDumpSceneEnableExceptionDump/NoPermission/ascendWorkPath" : "./";
    EXPECT_EQ(config.dumpPath, dumpPath);

    // 路径优先级2.2：生效ASCEND_WORK_PATH，有效路径
    (void)setenv("ASCEND_WORK_PATH", "./TestAscendDumpSceneEnableExceptionDump/ascendWorkPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./TestAscendDumpSceneEnableExceptionDump/ascendWorkPath");

    // 路径优先级1.1：生效ASCEND_DUMP_PATH，无效路径，使用ASCEND_WORK_PATH
    (void)setenv("ASCEND_DUMP_PATH", "./TestAscendDumpSceneEnableExceptionDump/NoPermission/ascendDumpPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);
    dumpPath = canWriteNoPermission ? "./TestAscendDumpSceneEnableExceptionDump/NoPermission/ascendDumpPath" :
                               "./TestAscendDumpSceneEnableExceptionDump/ascendWorkPath";
    EXPECT_EQ(config.dumpPath, dumpPath);
    // 路径优先级1.2：生效ASCEND_DUMP_PATH，有效路径
    (void)setenv("ASCEND_DUMP_PATH", "./TestAscendDumpSceneEnableExceptionDump/ascendDumpPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./TestAscendDumpSceneEnableExceptionDump/ascendDumpPath");
    (void)system("rm -rf ./TestAscendDumpSceneEnableExceptionDump");
    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("ASCEND_DUMP_PATH");
    (void)unsetenv("NPU_COLLECT_PATH");
    (void)unsetenv("ASCEND_DUMP_SCENE");
}

TEST_F(DumpConfigConverterUtest, TestJsonSyntaxErrors)
{
    std::string configPath = "/TestJsonSyntaxErrors.json";

    TestFailureHelper(R"({"dump": {"dump_op_switch": "on")", configPath, "EP0004");
    TestFailureHelper(R"({"dump": {"dump_list": [{"model_name": "model1"})", configPath, "EP0004");
    TestFailureHelper(R"(asdf{)", configPath, "EP0004");
}

TEST_F(DumpConfigConverterUtest, TestDumpFieldTypeErrors)
{
    std::string configPath = "/TestDumpFieldTypeErrors.json";

    TestFailureHelper(R"({"dump": true})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": []})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": 123})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": null})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": "invalid"})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestTopLevelFieldTypeErrors)
{
    std::string configPath = "/TestTopLevelFieldTypeErrors.json";

    TestFailureHelper(R"({"dump": {"dump_path": 12345}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_path": ["./"]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_path": true}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_path": null}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_mode": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_mode": ["output"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_op_switch": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_op_switch": ["on"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_level": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_level": ["op"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_scene": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_scene": ["lite_exception"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_data": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_data": ["tensor"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_debug": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_debug": ["on"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_kernel_data": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_kernel_data": ["all"]}})", configPath, "EP0001");

    TestFailureHelper(R"({"dump": {"dump_step": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_step": ["1-10"]}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestMinimalDumpConfig)
{
    std::string configPath = "/TestMinimalDumpConfig.json";

    TestSuccessHelper(R"({})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(R"({"other": "data"})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(R"({"dump": {"dump_path": "./"}})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(R"({"dump": {"dump_path": "192.168.0.1:/home/xh"}})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(R"({"dump": {}})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_debug": "off"}})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "off"}})", configPath, false, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestExceptionDumpSuccess)
{
    std::string configPath = "/TestExceptionDumpSuccess.json";

    TestSuccessHelper(R"({"dump": {"dump_scene": "lite_exception"}})", 
        configPath, true, DumpType::ARGS_EXCEPTION);
    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_scene": "lite_exception"}})", 
        configPath, true, DumpType::ARGS_EXCEPTION);
    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_scene": "aic_err_brief_dump"}})", 
        configPath, true, DumpType::ARGS_EXCEPTION);
    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_scene": "aic_err_norm_dump"}})", 
        configPath, true, DumpType::EXCEPTION);
    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_scene": "aic_err_detail_dump"}})", 
        configPath, true, DumpType::AIC_ERR_DETAIL_DUMP);
}

TEST_F(DumpConfigConverterUtest, TestExceptionDumpPathOverrideByEnv)
{
    std::string configPath = "/TestExceptionDumpPathOverrideByEnv.json";
    DumpConfig dumpConfig;

    (void)system("rm -rf ./TestExceptionDumpPath");
    (void)system("mkdir -p ./TestExceptionDumpPath/config_path");
    (void)system("mkdir -p ./TestExceptionDumpPath/work_path");
    (void)system("mkdir -p ./TestExceptionDumpPath/dump_path");

    (void)setenv("ASCEND_DUMP_PATH", "./TestExceptionDumpPath/dump_path", 1);
    std::string configData = 
        R"({"dump": {"dump_scene": "aic_err_brief_dump", "dump_path": "./TestExceptionDumpPath/config_path"}})";
    TestSuccessHelper(configData, configPath, true, DumpType::ARGS_EXCEPTION, dumpConfig);
    EXPECT_EQ(dumpConfig.dumpPath, "./TestExceptionDumpPath/dump_path");

    (void)unsetenv("ASCEND_DUMP_PATH");
    (void)setenv("ASCEND_WORK_PATH", "./TestExceptionDumpPath/work_path", 1);
    TestSuccessHelper(configData, configPath, true, DumpType::ARGS_EXCEPTION, dumpConfig);
    EXPECT_EQ(dumpConfig.dumpPath, "./TestExceptionDumpPath/work_path");

    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("ASCEND_DUMP_PATH");

    TestSuccessHelper(configData, configPath, true, DumpType::ARGS_EXCEPTION, dumpConfig);
    EXPECT_EQ(dumpConfig.dumpPath, "./TestExceptionDumpPath/config_path");
    (void)system("rm -rf ./TestExceptionDumpPath");
}

TEST_F(DumpConfigConverterUtest, TestWatcherSuccess)
{
    std::string configPath = "/TestWatcherSuccess.json";

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher", "dump_mode": "output"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher", "dump_mode": "output",
        "dump_list": [{"watcher_nodes": ["node1"]}]}})",
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher", "dump_mode": "output",
        "dump_list": [{"layer": ["A", "B"], "watcher_nodes": ["C", "D"]}]}})",
        configPath, true, DumpType::OPERATOR);

    DumpDfxConfig dumpDfxConfig;
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher", "dump_mode": "output"}})", 
        configPath, true, DumpType::OPERATOR, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "./");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
}

TEST_F(DumpConfigConverterUtest, TestWatcherDumpFieldsSuccess)
{
    std::string configPath = "/TestWatcherDumpFieldsSuccess.json";
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;

    TestSuccessHelperWithOpts(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher", "dump_mode": "output", 
        "dump_level": "op", "dump_data": "stats", "dump_kernel_data": "all,printf",
        "dump_stats": ["Max", "Min"], "dump_step": "1-10"}})",
        configPath, TestSuccessOptions{true, DumpType::OPERATOR, &dumpConfig, &dumpDfxConfig});

    EXPECT_EQ(dumpConfig.dumpSwitch, OPERATOR_OP_DUMP);
    EXPECT_EQ(dumpConfig.dumpData, "stats");
    EXPECT_EQ(dumpConfig.dumpStatsItem.size(), 2U);
    EXPECT_EQ(dumpConfig.dumpStatsItem[0], "Max");
    EXPECT_EQ(dumpConfig.dumpStatsItem[1], "Min");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 2U);
    EXPECT_EQ(dumpDfxConfig.dfxTypes[0], "all");
    EXPECT_EQ(dumpDfxConfig.dfxTypes[1], "printf");
}

TEST_F(DumpConfigConverterUtest, TestWatcherDumpPathNotOverrideByEnv)
{
    std::string configPath = "/TestWatcherDumpPathNotOverrideByEnv.json";
    DumpConfig dumpConfig;

    (void)system("rm -rf ./TestWatcherDumpPath");
    (void)system("mkdir -p ./TestWatcherDumpPath/config_path");
    (void)system("mkdir -p ./TestWatcherDumpPath/work_path");
    (void)system("mkdir -p ./TestWatcherDumpPath/dump_path");

    std::string configData = 
        R"({"dump": {"dump_scene": "watcher", "dump_path": "./TestWatcherDumpPath/config_path"}})";

    (void)setenv("ASCEND_DUMP_PATH", "./TestWatcherDumpPath/dump_path", 1);
    TestSuccessHelper(configData, configPath, true, DumpType::OPERATOR, dumpConfig);
    EXPECT_EQ(dumpConfig.dumpPath, "./TestWatcherDumpPath/config_path");

    (void)unsetenv("ASCEND_DUMP_PATH");
    (void)setenv("ASCEND_WORK_PATH", "./TestWatcherDumpPath/work_path", 1);
    TestSuccessHelper(configData, configPath, true, DumpType::OPERATOR, dumpConfig);
    EXPECT_EQ(dumpConfig.dumpPath, "./TestWatcherDumpPath/config_path");

    (void)unsetenv("ASCEND_WORK_PATH");
    TestSuccessHelper(configData, configPath, true, DumpType::OPERATOR, dumpConfig);
    EXPECT_EQ(dumpConfig.dumpPath, "./TestWatcherDumpPath/config_path");

    (void)system("rm -rf ./TestWatcherDumpPath");
}

TEST_F(DumpConfigConverterUtest, TestDebugSuccess)
{
    std::string configPath = "/TestDebugSuccess.json";

    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_debug": "on"}})", 
        configPath, true, DumpType::OP_OVERFLOW);
    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_debug": "off"}})", 
        configPath, false, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestOpSwitchSuccess)
{
    std::string configPath = "/TestOpSwitchSuccess.json";

    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_op_switch": "on"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_op_switch": "off"}})", 
        configPath, false, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestDumpListSuccess)
{
    std::string configPath = "/TestDumpListSuccess.json";

    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1", "layer": ["layer1"]}]}})",
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "optype_blacklist": [{"name": "type1"}]}]}})",
        configPath, true, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestKernelDataSuccess)
{
    std::string configPath = "/TestKernelDataSuccess.json";

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "all"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "printf"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "tensor"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "assert"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "timestamp"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "all,printf"}})",
        configPath, true, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestAllFieldsSuccess)
{
    std::string configPath = "/TestAllFieldsSuccess.json";

    TestSuccessHelper(R"({"dump": {"dump_path": "./"}})", configPath, false, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_mode": "output", "dump_level": "op", "dump_data": "tensor",
        "dump_list": [{"model_name": "model1"}]}})",
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "kernel",
        "dump_list": [{"model_name": "model1", "layer": ["layer1"]}]}})",
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_step": "1-10", "dump_list": [{"model_name": "model1"}]}})",
        configPath, true, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestDumpDataStatsSuccess)
{
    std::string configPath = "/TestDumpDataStatsSuccess.json";

    TestSuccessHelper(R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats"}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Max"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Min"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Avg"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Nan"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Negative Inf"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Positive Inf"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["L2norm"]}})", 
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_data": "stats", "dump_stats": ["Max", "Min", "Avg"]}})", 
        configPath, true, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestDumpStatsFieldTypeErrors)
{
    std::string configPath = "/TestDumpStatsFieldTypeErrors.json";

    TestFailureHelper(R"({"dump": {"dump_stats": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_stats": "tensor"}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_stats": true}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_stats": {"key": "value"}}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestDumpStatsArrayItemTypeErrors)
{
    std::string configPath = "/TestDumpStatsArrayItemTypeErrors.json";

    TestFailureHelper(R"({"dump": {"dump_stats": [123, 456]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_stats": [true, false]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_stats": [{"key": "value"}]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_stats": ["L2norm", 123]}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestDumpListFieldTypeErrors)
{
    std::string configPath = "/TestDumpListFieldTypeErrors.json";

    TestFailureHelper(R"({"dump": {"dump_list": 123}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": "model1"}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": true}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": {"key": "value"}}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestDumpListArrayItemTypeErrors)
{
    std::string configPath = "/TestDumpListArrayItemTypeErrors.json";

    TestFailureHelper(R"({"dump": {"dump_list": [123]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": ["string"]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": [true]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": [{"model_name": "model1"}, 123]}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestDumpListItemFieldTypeErrors)
{
    std::string configPath = "/TestDumpListItemFieldTypeErrors.json";

    TestFailureHelper(R"({"dump": {"dump_list": [{"model_name": 123}]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": [{"model_name": true}]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": [{"model_name": ["model"]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "layer": 123}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "layer": "layer1"}]}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_list": [{"model_name": "model1", "layer": [123]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "layer": [true]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "layer": [{"key": "value"}]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "watcher_nodes": 123}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "watcher_nodes": "node1"}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "watcher_nodes": [123]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "watcher_nodes": [true]}]}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestBlacklistFieldTypeErrors)
{
    std::string configPath = "/TestBlacklistFieldTypeErrors.json";

    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","optype_blacklist": 123}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","optype_blacklist": "type1"}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","optype_blacklist": [123]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","optype_blacklist": ["type1"]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","optype_blacklist": [{"name": 123}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name", "optype_blacklist": [{"name": "type", "pos": 123}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name", "optype_blacklist": [{"name": "type", "pos": "pos1"}]}]}})",
         configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name", "optype_blacklist": [{"name": "type", "pos": [123]}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name", "optype_blacklist": [{"name": "type", "pos": [true]}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name","opname_blacklist": 123}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name","opname_blacklist": [{"name": 123}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "name", "opname_blacklist": [{"name": "op1", "pos": [123]}]}]}})",
        configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestOpnameRangeFieldTypeErrors)
{
    std::string configPath = "/TestOpnameRangeFieldTypeErrors.json";

    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","opname_range": 123}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","opname_range": "range1"}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","opname_range": [123]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","opname_range": ["range1"]}]}})", configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1","opname_range": [{"begin": 123}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "opname_range": [{"begin": "op1", "end": 123}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "opname_range": [{"begin": "op1", "end": true}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_list": [{"model_name": "model1", "opname_range": [{"begin": "op1", "end": ["op2"]}]}]}})",
        configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestTopLevelFieldValueErrors)
{
    std::string configPath = "/TestTopLevelFieldValueErrors.json";

    TestFailureHelper(R"({"dump": {"dump_mode": ""}})", configPath, "EP0001");
    TestFailureHelper(R"({"dump": {"dump_mode": "invalid_mode"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_data": "invalid_data"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_kernel_data": "invalid_kernel_data"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_kernel_data": "all,invalid_kernel_data"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_op_switch": "invalid_switch"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_level": "invalid_level"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_debug": "invalid_debug"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_scene": "invalid_scene"}})", configPath, "EP0002");
}

TEST_F(DumpConfigConverterUtest, TestDumpStatsValueErrors)
{
    std::string configPath = "/TestDumpStatsValueErrors.json";

    TestFailureHelper(R"({"dump": {"dump_stats": ["invalid_stat"]}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_stats": ["Max", "invalid_stat"]}})", configPath, "EP0002");
}

TEST_F(DumpConfigConverterUtest, TestDumpKernelDataInvalidValue)
{
    std::string configPath = "/TestDumpKernelDataInvalidValue.json";

    TestFailureHelper(R"({"dump": {"dump_kernel_data": "invalid_type"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_kernel_data": "all,invalid_type"}})", configPath, "EP0002");
    TestFailureHelper(R"({"dump": {"dump_kernel_data": "tensor,printf,invalid"}})", configPath, "EP0002");
}

TEST_F(DumpConfigConverterUtest, TestDumpStepLengthExceedLimit)
{
    std::string configPath = "/TestDumpStepLengthExceedLimit.json";

    std::string longDumpStep = "1-2|3-4|5-6|7-8|9-10";
    for (int i = 11; i <= 200; ++i) {
        longDumpStep += "|" + std::to_string(i) + "-" + std::to_string(i + 1);
    }

    TestFailureHelper(
        R"({"dump": {"dump_path": "./",
        "dump_list": [{"model_name": "model1"}],
        "dump_step": ")" + longDumpStep + R"("}})", configPath, "EP0003");
}

TEST_F(DumpConfigConverterUtest, TestDumpDebugConflictWithDumpOpSwitch)
{
    std::string configPath = "/TestDumpDebugConflictWithDumpOpSwitch.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_debug": "on", "dump_op_switch": "on"}})", configPath, "EP0005");
}

TEST_F(DumpConfigConverterUtest, TestExceptionDumpSceneConflictWithForbiddenFields)
{
    std::string configPath = "/TestExceptionDumpSceneConflictWithForbiddenFields.json";

    TestFailureHelper(R"({"dump": {"dump_scene": "lite_exception", "dump_debug": "on"}})", configPath, "EP0005");
    TestFailureHelper(R"({"dump": {"dump_scene": "lite_exception", "dump_op_switch": "on"}})", configPath, "EP0005");
}

TEST_F(DumpConfigConverterUtest, TestExceptionDumpSceneNoConflictWithForbiddenFields)
{
    std::string configPath = "/TestExceptionDumpSceneNoConflictWithForbiddenFields.json";
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;

    TestSuccessHelperWithOpts(
        R"({"dump": {"dump_scene": "lite_exception", "dump_path": "./", "dump_mode": "output",
        "dump_level": "kernel", "dump_data": "tensor", "dump_kernel_data": "printf",
        "dump_stats": ["Max", "Min"], "dump_step": "1-10"}})",
        configPath, TestSuccessOptions{true, DumpType::ARGS_EXCEPTION, &dumpConfig, &dumpDfxConfig});

    EXPECT_EQ(dumpConfig.dumpMode, "output");
    EXPECT_EQ(dumpConfig.dumpSwitch, OPERATOR_KERNEL_DUMP);
    EXPECT_EQ(dumpConfig.dumpData, "tensor");
    EXPECT_EQ(dumpConfig.dumpStatsItem.size(), 2U);
    EXPECT_EQ(dumpConfig.dumpStatsItem[0], "Max");
    EXPECT_EQ(dumpConfig.dumpStatsItem[1], "Min");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
    EXPECT_EQ(dumpDfxConfig.dfxTypes[0], "printf");
}

TEST_F(DumpConfigConverterUtest, TestExceptionDumpSceneWithDumpDfxConfig)
{
    DumpDfxConfig dumpDfxConfig;
    std::string configPath = "/TestExceptionDumpSceneWithDumpDfxConfig.json";

    TestSuccessHelper(
        R"({"dump": {"dump_scene": "lite_exception", "dump_kernel_data": "all"}})",
        configPath, true, DumpType::ARGS_EXCEPTION, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
    dumpDfxConfig.dfxTypes.clear();

    TestSuccessHelper(
        R"({"dump": {"dump_scene": "lite_exception", "dump_path": "./", "dump_kernel_data": "printf"}})",
        configPath, true, DumpType::ARGS_EXCEPTION, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "./");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
}

TEST_F(DumpConfigConverterUtest, TestWatcherConflictWithForbiddenFields)
{
    std::string configPath = "/TestWatcherConflictWithForbiddenFields.json";

    TestFailureHelper(R"({"dump": {"dump_scene": "watcher", "dump_debug": "on"}})", configPath, "EP0005");
    TestFailureHelper(R"({"dump": {"dump_scene": "watcher", "dump_op_switch": "on"}})", configPath, "EP0005");
}

TEST_F(DumpConfigConverterUtest, TestWatcherSceneConstraints)
{
    std::string configPath = "/TestWatcherSceneConstraints.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher","dump_list": [{"watcher_nodes": []}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_scene": "watcher", 
        "dump_list": [{"model_name": "model1", "watcher_nodes": ["node1"]}]}})",
        configPath, "EP0005");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1", "watcher_nodes": ["node1"]}]}})",
        configPath, "EP0005");
}

TEST_F(DumpConfigConverterUtest, TestBlacklistWithDumpLevelConstraints)
{
    std::string configPath = "/TestBlacklistWithDumpLevelConstraints.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "kernel",
        "dump_list": [{"model_name": "model1", "optype_blacklist": [{"name": "type1"}]}]}})",
        configPath, "EP0005");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "kernel",
        "dump_list": [{"model_name": "model1", "opname_blacklist": [{"name": "op1"}]}]}})",
        configPath, "EP0005");
}

TEST_F(DumpConfigConverterUtest, TestBlacklistPosValuesSuccess)
{
    std::string configPath = "/TestBlacklistPosValuesSuccess.json";

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "optype_blacklist": [{"name": "type1", "pos": ["workspace0"]}]}]}})",
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "optype_blacklist": [{"name": "type1", "pos": ["input_0"]}]}]}})",
        configPath, true, DumpType::OPERATOR);
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "optype_blacklist": [{"name": "type1", "pos": ["output_0"]}]}]}})",
        configPath, true, DumpType::OPERATOR);
    // pos正常格式的数据(inputN or outputN)
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "opname_blacklist": [{"name": "op1", "pos": ["input0", "output0"]}]}]}})",
        configPath, true, DumpType::OPERATOR);
}

TEST_F(DumpConfigConverterUtest, TestOpnameRangeWithDumpLevelConstraints)
{
    std::string configPath = "/TestOpnameRangeWithDumpLevelConstraints.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "kernel",
        "dump_list": [{"opname_range": [{"begin": "op1", "end": "op2"}]}]}})",
        configPath, "EP0005");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"opname_range": [{"begin": "op1", "end": "op2"}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "", "opname_range": [{"begin": "op1", "end": "op2"}]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "opname_range": [{"begin": "", "end": "op2"}]}]}})",
        configPath, "EP0003");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "opname_range": [{"begin": "op1", "end": ""}]}]}})",
        configPath, "EP0003");
}

TEST_F(DumpConfigConverterUtest, TestDumpStatsConstraints)
{
    std::string configPath = "/TestDumpStatsConstraints.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_data": "tensor", "dump_stats": ["Max"]}})", configPath, "EP0005");
    TestFailureHelper(R"({"dump": {"dump_path": "./", "dump_stats": []}})", configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestDumpStepConstraints)
{
    std::string configPath = "/TestDumpStepConstraints.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_step": "1-2-3"}})",
        configPath, "EP0003");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_step": "abc-123"}})",
        configPath, "EP0003");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_step": "10-5"}})",
        configPath, "EP0003");

    std::string exceedLimitStep = "0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|"
        "30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|"
        "66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100";
    std::string exceedLimitJson = 
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_step": ")"
        + exceedLimitStep + R"("}})";
    TestFailureHelper(exceedLimitJson, configPath, "EP0003");
}

TEST_F(DumpConfigConverterUtest, TestModelNameAndLayerEmptyConstraints)
{
    std::string configPath = "/TestModelNameAndLayerEmptyConstraints.json";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "", "layer": ["layer1"]}]}})",
        configPath, "EP0001");
    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1", "layer": []}]}})",
        configPath, "EP0001");
}

TEST_F(DumpConfigConverterUtest, TestBlacklistSizeExceedLimit)
{
    std::string configPath = "/TestBlacklistSizeExceedLimit.json";

    std::string blacklistArray = "[";
    for (int i = 0; i < 101; ++i) {
        blacklistArray += "{\"name\":\"type" + std::to_string(i) + "\"}";
        if (i < 100) blacklistArray += ",";
    }
    blacklistArray += "]";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "optype_blacklist": )" + blacklistArray + R"(}]}})",
        configPath, "EP0003");

    blacklistArray = "[";
    for (int i = 0; i < 101; ++i) {
        blacklistArray += "{\"name\":\"op" + std::to_string(i) + "\"}";
        if (i < 100) blacklistArray += ",";
    }
    blacklistArray += "]";

    TestFailureHelper(
        R"({"dump": {"dump_path": "./", "dump_level": "op",
        "dump_list": [{"model_name": "model1", "opname_blacklist": )" + blacklistArray + R"(}]}})",
        configPath, "EP0003");
}

TEST_F(DumpConfigConverterUtest, TestParseDumpKernelData)
{
    DumpConfig dumpConfig;
    DumpDfxConfig dumpDfxConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configPath = "/TestParseDumpKernelData.json";

    ClearLastReportedErrorCode();
    std::string configData = 
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "all,printf"}})";
    DumpConfigConverter converter{configData.c_str(), configData.size(), configPath.c_str()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 2);

    ClearLastReportedErrorCode();
    configData = 
        R"({"dump": {"dump_path": "./", "dump_list": [{"model_name": "model1"}], "dump_kernel_data": "tensor"}})";
    converter = DumpConfigConverter{configData.c_str(), configData.size(), configPath.c_str()};
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump, dumpDfxConfig);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1);
}

TEST_F(DumpConfigConverterUtest, TestDumpPathValueError)
{
    std::string configPath = "/TestDumpPathValueError.json";

    TestFailureHelper(R"({"dump": {"dump_path": ""}})", configPath, "EP0001");

    std::string longPath(600, 'a');
    std::string longPathJson = R"({"dump": {"dump_path": ")" + longPath + R"("}})";
    TestFailureHelper(longPathJson, configPath, "EP0003");

    TestFailureHelper(R"({"dump": {"dump_path": "asdf###"}})", configPath, "EP0003");

    TestFailureHelper(R"({"dump": {"dump_path": "./nonexistent/path"}})", configPath, "EP0003");

    (void)system("rm -rf ./TestDumpPath");
    (void)system("mkdir -p ./TestDumpPath");

    (void)system("mkdir -p ./TestDumpPath/valid_dir");
    TestSuccessHelper(
        R"({"dump": {"dump_path": "./TestDumpPath/valid_dir", "dump_list": [{"model_name": "model1"}]}})", 
        configPath, true, DumpType::OPERATOR);

    (void)system("touch ./TestDumpPath/regular_file_with_permission");
    (void)system("chmod 644 ./TestDumpPath/regular_file_with_permission");
    TestFailureHelper(R"({"dump": {"dump_path": "./TestDumpPath/regular_file_with_permission"}})", 
        configPath, "EP0003");

    (void)system("touch ./TestDumpPath/file_no_permission");
    (void)system("chmod 000 ./TestDumpPath/file_no_permission");
    TestFailureHelper(R"({"dump": {"dump_path": "./TestDumpPath/file_no_permission"}})", 
        configPath, "EP0003");

    (void)system("mkdir -p ./TestDumpPath/dir_no_permission");
    (void)system("chmod 000 ./TestDumpPath/dir_no_permission");
    bool bRet = getuid() == 0 ? true : false;
    if (bRet) {
        TestSuccessHelper(
            R"({"dump": {"dump_path": "./TestDumpPath/dir_no_permission"}})", configPath, false, DumpType::OPERATOR);
    } else {
        TestFailureHelper(R"({"dump": {"dump_path": "./TestDumpPath/dir_no_permission"}})", configPath, "EP0003");
    }

    (void)system("chmod 755 ./TestDumpPath/dir_no_permission");
    (void)system("chmod 755 ./TestDumpPath/file_no_permission");
    (void)system("chmod 755 ./TestDumpPath/regular_file_with_permission");
    (void)system("rm -rf ./TestDumpPath");

    // 暂时没有ip address error的reason
    TestFailureHelper(R"({"dump": {"dump_path": "192.168.0.1:"}})", configPath, "EP0003");
    TestFailureHelper(R"({"dump": {"dump_path": "192.168.0.256:/home/xh"}})", configPath, "EP0003");
    TestFailureHelper(R"({"dump": {"dump_path": "192.168.0.aaa:/home/xh"}})", configPath, "EP0003");
    TestFailureHelper(R"({"dump": {"dump_path": ":/home/xh"}})", configPath, "EP0003");
    TestFailureHelper(R"({"dump": {"dump_path": "192.168.0.1:/home/    "}})", configPath, "EP0003");
}

TEST_F(DumpConfigConverterUtest, TestConvertDumpDfxConfig)
{
    std::string configPath = "/TestConvertDumpDfxCfx.json";
    DumpDfxConfig dumpDfxConfig;

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./"}})",
        configPath, false, DumpType::OPERATOR, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "./");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.empty(), true);

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_kernel_data": "printf"}})",
        configPath, false, DumpType::OPERATOR, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "./");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
    dumpDfxConfig.dfxTypes.clear();

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on"}})",
        configPath, true, DumpType::OPERATOR, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "./");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
    dumpDfxConfig.dfxTypes.clear();

    TestSuccessHelper(
        R"({"dump": {"dump_path": "./", "dump_op_switch": "on", "dump_kernel_data": "tensor"}})",
        configPath, true, DumpType::OPERATOR, dumpDfxConfig);
    EXPECT_EQ(dumpDfxConfig.dumpPath, "./");
    EXPECT_EQ(dumpDfxConfig.dfxTypes.size(), 1U);
}