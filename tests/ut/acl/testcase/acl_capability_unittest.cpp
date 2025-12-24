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
#include <gmock/gmock.h>

#include <fstream>
#include "acl/acl.h"
#include "acl_stub.h"
#include "nlohmann/json.hpp"

using namespace testing;

namespace {
    class TestDirUtils {
    public:
        void BuildTestDir()
        {
            // temporary test directory
            (void)!system(("mkdir -p " + testDir).c_str());
            (void)!system(("mkdir -p " + configDir).c_str());
            const std::string configFile = ACL_BASE_DIR"/src/acl/config/swFeatureList.json";
            (void)!system(("cp " + configFile + " " + configDir).c_str());
            (void)!system(("mkdir -p " + runtimeDir).c_str());
            (void)!system(("touch " + infoFile).c_str());
            (void)!system(("mkdir -p " + fakeConfigDir).c_str());
            (void)!system(("touch " + fakeConfigFile).c_str());
        }
        void RemoveTestDir()
        {
            (void)!system(("rm -rf " + testDir).c_str());
        }
        void MakeRuntimeVersionInfo()
        {
            std::ofstream ofs(infoFile, std::ios::trunc);
            ofs << "Version=7.1.T7.0.B207\n";
            ofs << "version_dir=CANN-7.0\n";
            ofs << "runtime_acl_version=1.0";
            ofs.close();
        }
        void MakeEmptyVersionInfo()
        {
            std::ofstream ofs(infoFile, std::ios::trunc);
            ofs << "\n";
            ofs.close();
        }
        void MakeIncorrectVersionInfo()
        {
            std::ofstream ofs(infoFile, std::ios::trunc);
            ofs << "Version=CANN7.1.T7.0.B207\n";
            ofs.close();
        }

        void MakeFakeConfigFile()
        {
            std::ofstream ofs(fakeConfigFile, std::ios::trunc);
            // soc version is not a list, parse failed
            nlohmann::json js = R"({"INF_NAN": {"runtimeVersion" : "7.1","socVersionList" : "910B"}})"_json;
            ofs << js.dump();
            ofs.close();
        }

    private:
        const std::string testDir = ACL_BASE_DIR"/tests/tmp_run_data";
        const std::string runtimeDir = testDir + "/share/info/runtime";
        const std::string configDir = testDir + "/ascendcl_config";
        const std::string infoFile = runtimeDir + "/version.info";
        const std::string failDir = testDir + "/tmp_fail";
        const std::string fakeConfigDir = failDir + "/tmp_run_data/ascendcl_config";
        const std::string fakeConfigFile = fakeConfigDir + "/swFeatureList.json";
    };

    bool MockGetPlatformResWithLock(const string &label, const string &key, string &val)
    {
        (void)label;
        static std::map<std::string, std::string> valTable = {{"ai_core_cnt", "20"}, {"vector_core_cnt", "XXX"}};
        auto iter = valTable.find(key);
        if (iter != valTable.end()) {
            val = iter->second;
            return true;
        }
        // l2_size will fail
        return false;
    };

    class MockMmpa {
    public:
        static INT32 mmDladdr(VOID *addr, mmDlInfo *info)
        {
            (void)addr;
            info->dli_fname = ACL_BASE_DIR"/tests/tmp_run_data/ascendcl_config";
            return 0;
        }

        static INT32 mmDladdrFail(VOID *addr, mmDlInfo *info)
        {
            (void)addr;
            info->dli_fname = "fake_config_path";
            return 0;
        }

        static INT32 mmDladdrFail2(VOID *addr, mmDlInfo *info)
        {
            (void)addr;
            info->dli_fname = ACL_BASE_DIR"/tests/tmp_run_data/tmp_fail/tmp_run_data/ascendcl_config";
            return 0;
        }
    };

    class MockRuntime {
    public:
        static rtError_t rtGetSocVersion(char *version, const uint32_t maxLen)
        {
            const char *socVersion = "Ascend310P1";
            memcpy_s(version, maxLen, socVersion, strlen(socVersion) + 1);
            return RT_ERROR_NONE;
        }
    };
} // namespace

class UTEST_ACL_Capability : public Test {
protected:
    static void SetUpTestCase()
    {
        (void)aclInit(nullptr);
    }
    static void TearDownTestCase()
    {
        (void)aclFinalize();
    }
    void SetUp() override
    {
        ::testing::FLAGS_gmock_verbose = "error";
        dirUtils.BuildTestDir();
    }
    void TearDown() override
    {
        Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
        dirUtils.RemoveTestDir();
    }
    TestDirUtils dirUtils;
};

TEST_F(UTEST_ACL_Capability, aclGetDeviceCapability_Ok_GetAiCoreNum)
{
    aclDeviceInfo infoType = ACL_DEVICE_INFO_AI_CORE_NUM;
    int64_t value;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _, _))
        .WillRepeatedly(Invoke(MockGetPlatformResWithLock));

    aclError ret = aclGetDeviceCapability(0U, infoType, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(value, 20U);
}

TEST_F(UTEST_ACL_Capability, aclGetDeviceCapability_Fail_InvalidDeviceIdOrInfoType)
{
    aclDeviceInfo infoType = ACL_DEVICE_INFO_AI_CORE_NUM;
    int64_t value;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceCount(_))
        .WillOnce(Return(ACL_ERROR_RT_INVALID_DEVICEID))
        .WillOnce(Return(RT_ERROR_NONE));

    // case: invalid deviceId
    aclError ret = aclGetDeviceCapability(9U, infoType, &value);
    EXPECT_EQ(ret, ACL_ERROR_RT_INVALID_DEVICEID);

    // case: invalid infoType
    infoType = ACL_DEVICE_INFO_UNDEFINED;
    ret = aclGetDeviceCapability(0U, infoType, &value);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Capability, aclGetDeviceCapability_Fail_GetPlatformInfoError)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), InitializePlatformInfo())
        .WillOnce(Return(0xFFFFFFFF))
        .WillRepeatedly(Return(0));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetPlatformInfos(_, _, _))
        .WillOnce(Return(0xFFFFFFFF))
        .WillRepeatedly(Return(0));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _, _))
        .WillRepeatedly(Invoke(MockGetPlatformResWithLock));

    aclDeviceInfo infoType = ACL_DEVICE_INFO_AI_CORE_NUM;
    int64_t value;
    // case: PlatformInfoManger init failed
    aclError ret = aclGetDeviceCapability(0U, infoType, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: PlatformInfoManger get PlatformInfos failed
    ret = aclGetDeviceCapability(0U, infoType, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: PlatformInfoManger GetPlatformRes failed
    infoType = ACL_DEVICE_INFO_L2_SIZE;
    ret = aclGetDeviceCapability(0U, infoType, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: invalid info value, std::stoll() exception is catched
    infoType = ACL_DEVICE_INFO_VECTOR_CORE_NUM;
    ret = aclGetDeviceCapability(0U, infoType, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Capability, aclGetDeviceCapability_Fail_NullInput)
{
    aclDeviceInfo infoType = ACL_DEVICE_INFO_AI_CORE_NUM;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _, _))
        .WillRepeatedly(Invoke(MockGetPlatformResWithLock));

    aclError ret = aclGetDeviceCapability(0U, infoType, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttributeList_Fail_CannInfoUtilsInitError)
{
    const aclCannAttr *attrArray = nullptr;
    size_t num = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _))
        .WillOnce(Return(EN_ERR))
        .WillOnce(Invoke(MockMmpa::mmDladdrFail))
        .WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    // case: GetSoRealPath failed, dladdr cannot find so path
    aclError ret = aclGetCannAttributeList(&attrArray, &num);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: GetSoRealPath failed, call mmRealPath with empty path
    ret = aclGetCannAttributeList(&attrArray, &num);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttribute_Fail_InvalidConfigFile)
{
    dirUtils.MakeFakeConfigFile();
    aclCannAttr cannAttr = ACL_CANN_ATTR_INF_NAN;
    int32_t value;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _))
        .WillOnce(Invoke(MockMmpa::mmDladdrFail2))
        .WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    // case: invalid swFeatureList.json, parsing json catches exception
    aclError ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttribute_Fail_InvalidVersionInfo)
{
    aclCannAttr cannAttr = ACL_CANN_ATTR_INF_NAN;
    int32_t value = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _)).WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    // case: failed to parse runtime version info
    dirUtils.MakeEmptyVersionInfo();
    aclError ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: incorrect version info
    dirUtils.MakeIncorrectVersionInfo();
    ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: repeat initialization
    ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttribute_Fail_CannInfoUtilsInitError)
{
    aclCannAttr cannAttr = ACL_CANN_ATTR_INF_NAN;
    int32_t value;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _))
        .WillOnce(Return(EN_ERR))
        .WillOnce(Invoke(MockMmpa::mmDladdrFail))
        .WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    // case: GetSoRealPath failed, dladdr cannot find so path
    aclError ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    // case: GetSoRealPath failed, call mmRealPath with empty path
    ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

// test cases bewlow will successfully initialize CannInfoUtils
TEST_F(UTEST_ACL_Capability, aclGetCannAttribute_Fail_InvalidCannAttr)
{
    dirUtils.MakeRuntimeVersionInfo();
    aclCannAttr cannAttr = ACL_CANN_ATTR_UNDEFINED;
    int32_t value;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _)).WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    aclError ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttribute_Fail_NullInput)
{
    dirUtils.MakeRuntimeVersionInfo();
    aclCannAttr cannAttr = ACL_CANN_ATTR_INF_NAN;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _)).WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    aclError ret = aclGetCannAttribute(cannAttr, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttribute_Ok_GetInfNan)
{
    dirUtils.MakeRuntimeVersionInfo();
    aclCannAttr cannAttr = ACL_CANN_ATTR_INF_NAN;
    int32_t value;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _)).WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    aclError ret = aclGetCannAttribute(cannAttr, &value);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(value, 1);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttributeList_Ok_Ascend910B1)
{
    dirUtils.MakeRuntimeVersionInfo();
    const aclCannAttr *attrArray = nullptr;
    size_t num = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _)).WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    // case: Ascend910B1 support INF_NAN, BF16, JIT_COMPILE
    aclError ret = aclGetCannAttributeList(&attrArray, &num);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(num, 3);
}

TEST_F(UTEST_ACL_Capability, aclGetCannAttributeList_Fail_NullInput)
{
    dirUtils.MakeRuntimeVersionInfo();
    const aclCannAttr *attrArray = nullptr;
    size_t num = 0;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), mmDladdr(_, _)).WillRepeatedly(Invoke(MockMmpa::mmDladdr));

    // case: nullptr input cannAttr
    aclError ret = aclGetCannAttributeList(nullptr, &num);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    // case: nullptr input num
    ret = aclGetCannAttributeList(&attrArray, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}
