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
#include "mockcpp/mockcpp.hpp"
#include <vector>
#include "dump_config_converter.h"
#include "log/adx_log.h"
#include "mmpa_api.h"
#include "fstream"
#include "utils.h"

using namespace Adx;

#define JSON_BASE ADUMP_BASE_DIR "stub/data/json/"
class DumpConfigConverterUtest: public testing::Test {
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
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configData = ReadFileToString(JSON_BASE "common/bad_path.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/empty_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "common/empty.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "common/invalid_ip_path_gt255.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/json_bad_obj.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/invalid_ip_path_no_ip.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/invalid_ip_path_invalid_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/invalid_ip_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/invalid_json.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/json_too_deep.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/json_too_many_array.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/only_dump_key.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/only_ip_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "common/only_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "common/path_too_long.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "common/watcher_input.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "common/watcher_output.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);
    EXPECT_FALSE(IsNeedDump);

    converter = DumpConfigConverter(nullptr, static_cast<size_t>(-1));
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    MOCKER(&mmRealPath)
        .stubs()
        .will(returnValue(-1));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&mmAccess2)
        .stubs()
        .will(returnValue(-1));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(false));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);

}

TEST_F(DumpConfigConverterUtest, TestConvertException)
{
    DumpConfig dumpConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configData = ReadFileToString(JSON_BASE "exception/aic_err_brief_dump.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);

    configData = ReadFileToString(JSON_BASE "exception/lite_exception.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);

    configData = ReadFileToString(JSON_BASE "exception/aic_err_norm_dump.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::EXCEPTION);

    configData = ReadFileToString(JSON_BASE "exception/aic_err_detail_dump.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::AIC_ERR_DETAIL_DUMP);

    configData = ReadFileToString(JSON_BASE "exception/invalid_dump_scene.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "exception/dump_scene_conflict_dump_debug.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "exception/dump_scene_conflict_dump_op_switch.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpConfigConverterUtest, TestConvertOverflow)
{
    DumpConfig dumpConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configData = ReadFileToString(JSON_BASE "overflow/dump_debug_off.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "overflow/dump_debug_on.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OP_OVERFLOW);

    configData = ReadFileToString(JSON_BASE "overflow/invalid_dump_debug.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_conflict_op_switch.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_ip_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OP_OVERFLOW);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_no_path.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "overflow/overflow_path_empty.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(DumpConfigConverterUtest, TestConvertDataDump)
{
    DumpConfig dumpConfig;
    DumpType dumpType;
    bool IsNeedDump = false;
    std::string configData = ReadFileToString(JSON_BASE "datadump/dump_data_stats.json");
    DumpConfigConverter converter{configData.c_str(), configData.size()};
    int32_t ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor_conflict_stats.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/dump_data_tensor.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_level_kernel.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_level_op.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_mode_input.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_mode_output.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_op_switch_off.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_FALSE(IsNeedDump);

    configData = ReadFileToString(JSON_BASE "datadump/dump_stats_empty_list.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/dump_stats_no_stats.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/dump_stats_not_empty.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    EXPECT_TRUE(IsNeedDump);
    EXPECT_EQ(dumpType, DumpType::OPERATOR);

    configData = ReadFileToString(JSON_BASE "datadump/invalid_dump_data.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/invalid_dump_level.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
    EXPECT_EQ(ret, ADUMP_FAILED);

    configData = ReadFileToString(JSON_BASE "datadump/invalid_dump_mode.json");
    converter = DumpConfigConverter(configData.c_str(), configData.size());
    ret = converter.Convert(dumpType, dumpConfig, IsNeedDump);
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
    EXPECT_EQ(ret, false);

    // 环境变量NPU_COLLECT_PATH，无效路径，无权限，不使能L1 exception dump
    (void)system("mkdir -p ./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission");
    (void)system("chmod 400 ./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission");
    (void)setenv("NPU_COLLECT_PATH", "./TestNpuCollectPathEnableExceptionDump/npuCollectPathNoPermission", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, false);

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

    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("NPU_COLLECT_PATH");
    (void)unsetenv("ASCEND_DUMP_SCENE");
}


TEST_F(DumpConfigConverterUtest, TestAscendDumpSceneEnableExceptionDump)
{
    DumpConfig config;
    DumpType dumpType;
    bool ret = false;

    (void)system("rm -rf ./TestAscendDumpSceneEnableExceptionDump");
    (void)system("mkdir ./TestAscendDumpSceneEnableExceptionDump");
    (void)system("mkdir ./TestAscendDumpSceneEnableExceptionDump/NoPermission");
    (void)system("chmod 400 ./TestAscendDumpSceneEnableExceptionDump/NoPermission");

    // 环境变量NPU_COLLECT_PATH，有效路径，使能L1 exception dump
    (void)setenv("NPU_COLLECT_PATH", "./TestAscendDumpSceneEnableExceptionDump/npuCollectPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./TestAscendDumpSceneEnableExceptionDump/npuCollectPath");

    // 环境变量ASCEND_DUMP_SCENE，无效值，使能L1 exception dump
    (void)setenv("ASCEND_DUMP_SCENE", "!aic_err_brief_dump", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
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
    EXPECT_EQ(config.dumpPath, "./");

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
    EXPECT_EQ(config.dumpPath, "./TestAscendDumpSceneEnableExceptionDump/ascendWorkPath");

    // 路径优先级1.2：生效ASCEND_DUMP_PATH，有效路径
    (void)setenv("ASCEND_WORK_PATH", "./TestAscendDumpSceneEnableExceptionDump/ascendDumpPath", 1);
    ret = DumpConfigConverter::EnableExceptionDumpWithEnv(config, dumpType);
    EXPECT_EQ(ret, true);
    EXPECT_EQ(dumpType, DumpType::ARGS_EXCEPTION);
    EXPECT_EQ(config.dumpPath, "./TestAscendDumpSceneEnableExceptionDump/ascendDumpPath");
    (void)system("rm -rf ./TestAscendDumpSceneEnableExceptionDump");
    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("ASCEND_WORK_PATH");
    (void)unsetenv("NPU_COLLECT_PATH");
    (void)unsetenv("ASCEND_DUMP_SCENE");
}