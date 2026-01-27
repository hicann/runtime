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
#include <fstream>
#include "dump_config_converter.h"
#include "log/adx_log.h"
#include "mmpa_api.h"
#include "adump_api.h"
#include "acl_op.h"
#include "dump_setting.h"
#include "adump_stub.h"
#include "acl/acl_base.h"
#include "sys_utils.h"
#include "dump_manager.h"
#include "common/file.h"
#include "common/path.h"

using namespace Adx;

#define JSON_BASE ADUMP_BASE_DIR "ut/adump_base/stub/data/json/"
class AdumpApiStest: public testing::Test {
protected:
    virtual void SetUp() {}
    virtual void TearDown()
    {
        UnRegisterRtFunction();
        GlobalMockObject::verify();
    }
};

TEST_F(AdumpApiStest, TestAdumpSetDumpCommon)
{
    int32_t ret = AdumpSetDump(JSON_BASE "common/bad_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/empty_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/empty.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "common/invalid_ip_path_gt255.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/json_bad_obj.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/invalid_ip_path_no_ip.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/invalid_ip_path_invalid_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/invalid_ip_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/invalid_json.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/json_too_deep.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/json_too_many_array.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/only_dump_key.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/only_ip_path.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "common/only_path.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "common/path_too_long.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "common/watcher_input.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "common/watcher_output.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    MOCKER(&mmRealPath)
        .stubs()
        .will(returnValue(-1));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&mmAccess2)
        .stubs()
        .will(returnValue(-1));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&mmStatGet)
        .stubs()
        .will(returnValue(-1));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    char trustedPath[MMPA_MAX_PATH] = {};
    mmStat_t pathStat = {};
    pathStat.st_mode = 0000000;
    MOCKER(&mmStatGet)
        .stubs()
        .with(any(), outBoundP(&pathStat, sizeof(mmStat_t)))
        .will(returnValue(0));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    pathStat.st_mode = 0100000;
    pathStat.st_size = 10 * 1024 * 1024 + 1;
    MOCKER(&mmStatGet)
        .stubs()
        .with(any(), outBoundP(&pathStat, sizeof(mmStat_t)))
        .will(returnValue(0));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(false));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(true))
        .then(returnValue(false));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    GlobalMockObject::reset();
    MOCKER(&std::basic_ifstream<char>::is_open, bool (std::basic_ifstream<char>::*)())
        .stubs()
        .will(returnValue(true))
        .then(returnValue(true))
        .then(returnValue(false));
    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);
}

TEST_F(AdumpApiStest, TestAdumpSedDumpException)
{
    int32_t ret = AdumpSetDump(JSON_BASE "exception/aic_err_brief_dump.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "exception/lite_exception.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "exception/aic_err_norm_dump.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "exception/aic_err_detail_dump.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "exception/invalid_dump_scene.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "exception/dump_scene_conflict_dump_debug.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "exception/dump_scene_conflict_dump_op_switch.json");
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(AdumpApiStest, TestAdumpSetDumpOverflow)
{
    int32_t ret = AdumpSetDump(JSON_BASE "overflow/dump_debug_off.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "overflow/dump_debug_on.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "overflow/invalid_dump_debug.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "overflow/overflow_conflict_op_switch.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "overflow/overflow_ip_path.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "overflow/overflow_no_path.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "overflow/overflow_path_empty.json");
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(AdumpApiStest, TestAdumpSetDumpDataDump)
{
    int32_t ret = AdumpSetDump(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor_conflict_stats.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_level_kernel.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_level_op.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_mode_input.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_mode_output.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_op_switch_off.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_stats_empty_list.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_stats_no_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_stats_not_empty.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/invalid_dump_data.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "datadump/invalid_dump_level.json");
    EXPECT_EQ(ret, ADUMP_FAILED);

    ret = AdumpSetDump(JSON_BASE "datadump/invalid_dump_mode.json");
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(AdumpApiStest, TestAdumpUnSetDump) {
    int32_t ret = AdumpSetDump(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_SUCCESS);

    ret = AdumpSetDump(JSON_BASE "datadump/dump_data_stats.json");
    EXPECT_EQ(ret, ADUMP_SUCCESS);
    MOCKER(&DumpSetting::Init).stubs().will(returnValue(ADUMP_FAILED));
    ret = AdumpUnSetDump();
    EXPECT_EQ(ret, ADUMP_FAILED);
}

TEST_F(AdumpApiStest, Test_AdumpGetDumpSwitch)
{
    EXPECT_EQ(AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json"), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 3U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 0U);
    EXPECT_EQ(AdumpUnSetDump(), ADUMP_SUCCESS);

    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 0U);

    EXPECT_EQ(AdumpSetDump(JSON_BASE "exception/aic_err_brief_dump.json"), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 1U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);

    EXPECT_EQ(AdumpSetDump(JSON_BASE "datadump/dump_data_tensor.json"), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 1U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 3U);

    EXPECT_EQ(AdumpUnSetDump(), ADUMP_SUCCESS);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::ARGS_EXCEPTION), 0U);
    EXPECT_EQ(AdumpGetDumpSwitch(DumpType::OPERATOR), 0U);
}

static int32_t AdumpCallbackTest(uint64_t dumpSwitch, char *dumpConfig, int32_t size)
{
    if ((dumpSwitch & OP_INFO_RECORD) == 0) {
        std::string testData("test op info record");
        AdumpSaveToFile(testData.c_str(), testData.size(), "12323/test_op_info.json", SaveType::OVERWRITE);
        AdumpSaveToFile(testData.c_str(), testData.size(), "12323/test_op_info.json", SaveType::APPEND);
    }
    return 0;
}

TEST_F(AdumpApiStest, Test_OP_Dump_Save)
{
    EXPECT_EQ(0, AdumpRegisterCallback(IDEDD, AdumpCallbackTest, AdumpCallbackTest));
    std::string path("./STest_EmptyJsonSuccess");
    EXPECT_EQ(ACL_SUCCESS, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    std::string jsonPath = path + "/12323/test_op_info.json";
    std::ifstream jsonFile(jsonPath);
    EXPECT_EQ(true, jsonFile.is_open());
    std::string data;
    std::getline(jsonFile, data);
    EXPECT_STREQ("test op info recordtest op info record", data.c_str());
    system("rm -r ./STest_EmptyJsonSuccess");
}

TEST_F(AdumpApiStest, Test_OP_Dump_Save_Error)
{
    EXPECT_EQ(0, AdumpRegisterCallback(IDEDD, AdumpCallbackTest, AdumpCallbackTest));
    std::string path("./STest_EmptyJsonSuccess");
    EXPECT_EQ(ACL_SUCCESS, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    MOCKER(&File::IsFileOpen).stubs().will(returnValue(ADUMP_FAILED));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    MOCKER(&Path::RealPath).stubs().will(returnValue(false));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    MOCKER(&Path::CreateDirectory).stubs().will(returnValue(false));
    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    std::string jsonPath = path + "/12323/test_op_info.json";
    std::ifstream jsonFile(jsonPath);
    EXPECT_EQ(true, jsonFile.is_open());
    std::string data;
    std::getline(jsonFile, data);
    EXPECT_STREQ("", data.c_str());
    system("rm -r ./STest_EmptyJsonSuccess");
}

TEST_F(AdumpApiStest, Test_OP_Dump_Api_Error)
{
    EXPECT_EQ(0, AdumpRegisterCallback(IDEDD, AdumpCallbackTest, AdumpCallbackTest));

    EXPECT_EQ(ACL_SUCCESS, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));
    MOCKER_CPP(&DumpManager::StopDumpArgs).stubs().will(returnValue(-1));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStopDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS));

    std::string path("./STest_EmptyJsonSuccess");
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, ""));
    MOCKER_CPP(&Path::CreateDirectory).stubs().will(returnValue(false)).then(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    MOCKER_CPP(&Path::IsDirectory).stubs().will(returnValue(false)).then(returnValue(true));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    EXPECT_EQ(ACL_SUCCESS, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    EXPECT_EQ(ACL_ERROR_FAILURE, aclopStartDumpArgs(ACL_OP_DUMP_OP_AICORE_ARGS, path.c_str()));
    system("rm -r ./STest_EmptyJsonSuccess");
}