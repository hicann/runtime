/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acl/acl.h"

#include <string>
#include <cassert>
#include <iostream>
#include <fstream>
#include <cstdarg>

#include "dlog_pub.h"
#include "plog.h"
#include "acl_rt_impl_base.h"

#include <thread>
#include <gtest/gtest.h>
#include <gmock/gmock.h>

#include "mmpa/mmpa_api.h"
#include "runtime/dev.h"
#include "runtime/stream.h"
#include "runtime/context.h"
#include "runtime/event.h"
#include "runtime/mem.h"
#include "runtime/kernel.h"
#include "runtime/base.h"
#include "runtime/config.h"
#include "utils/file_utils.h"
#include "acl_stub.h"
#include "utils/hash_utils.h"

#include "base/err_mgr.h"

#define protected public
#define private public
#include "common/json_parser.h"
#include "common/log_inner.h"
#include "toolchain/dump.h"
#include "toolchain/profiling.h"
#include "toolchain/profiling_manager.h"
#include "set_device_vxx.h"
#include "aclrt_impl/init_callback_manager.h"
#undef private
#undef protected

using namespace testing;
using namespace std;
using namespace acl;

extern "C" int AdxDataDumpServerInit();
extern "C" int AdxDataDumpServerUnInit();
extern aclError MemcpyKindTranslate(aclrtMemcpyKind kind, rtMemcpyKind_t &rtKind);
namespace acl {
    extern "C" void aclAppLogWithArgs(aclLogLevel logLevel, const char *func, const char *file, uint32_t line, const char *fmt, va_list args);
    extern void aclGetMsgCallback(const char_t *msg, uint32_t len);
    extern void GetAllPackageVersion();
    extern aclError HandleDefaultDeviceAndStackSize(const char_t *const configPath);
    extern aclError GetAlignedAndPaddingSize(const size_t size, const bool isPadding, size_t &alignedSize);
    extern int32_t UpdateOpSystemRunCfg(void *cfgAddr, uint32_t cfgLen);
    extern bool GetAclInitFlag();
    extern void resetAclJsonHash();
    extern uint64_t &GetAclInitRefCount();
    extern aclError HandleEventModeConfig(const char_t *const configPath);
}

namespace {
    void TestAclAppLogWithArgs(aclLogLevel level, const char* func, const char* file,
                           uint32_t line, const char* fmt, ...) {
        va_list args;
        va_start(args, fmt);
        aclAppLogWithArgs(level, func, file, line, fmt, args);
        va_end(args);
    }
}

const std::string utTestBasePath = ACL_BASE_DIR "/build_ut/tests/ut";
extern bool GetDriverPath(const std::string &ascendInstallPath, std::string &driverPath);
extern aclError GetCANNVersionInternal(const aclCANNPackageName name, aclCANNPackageVersion &version,
    const std::string &installPath);
extern bool GetPkgPath(const std::string &ascendInstallPath, std::string &pkgPath,
    const std::string &pkgPathKey);
extern aclError GetVersionStringInternal(const std::string &fullPath, const char_t *pkgName,
    std::string &versionOut, bool isSilent = false);

static void writeToFile(const std::string &fileName, const std::string &text)
{
    system(("mkdir -p $(dirname " + fileName + ")").c_str());
    std::ofstream out(fileName);
    out << text;
    out.close();
}

static aclError InitCallback_Fail(const char *configStr, size_t len, void *userData) {
    (void)configStr;
    (void)len;
    (void)userData;
    return ACL_ERROR_RT_PARAM_INVALID;
}

static aclError FinalizeCallback_Fail(void *userData) {
    (void)userData;
    return ACL_ERROR_RT_PARAM_INVALID;
}

static aclError FinalizeCallback_Success(void *userData) {
    (void)userData;
    return ACL_SUCCESS;
}

class UTEST_ACL_Common : public testing::Test
{
    public:
        UTEST_ACL_Common(){}
    protected:
        virtual void SetUp()
        {
            MockFunctionTest::aclStubInstance().ResetToDefaultMock();
            ON_CALL(MockFunctionTest::aclStubInstance(), GetPlatformResWithLock(_, _))
                .WillByDefault(Return(true));
        }
        virtual void TearDown()
        {
            Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
        }
        static void TearDownTestCase()
        {
            (void)aclFinalize();
        }
    protected:

};

rtError_t rtGetRunMode_invoke(rtRunMode *mode)
{
    *mode = RT_RUN_MODE_OFFLINE;
    return RT_ERROR_NONE;
}

static void ExceptionInfoCallback(aclrtExceptionInfo *exceptionInfo)
{
    (void) exceptionInfo;
    uint32_t task_id = aclrtGetTaskIdFromExceptionInfo(nullptr);
    uint32_t stream_id = aclrtGetStreamIdFromExceptionInfo(nullptr);
    uint32_t thread_id = aclrtGetThreadIdFromExceptionInfo(nullptr);
    (void)task_id;
    (void)stream_id;
    (void)thread_id;
}

TEST_F(UTEST_ACL_Common, aclrtGetSocName)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetSocVersion(_, _))
        .WillOnce(Return(1))
        .WillRepeatedly(Return(0));
    const char *socName = aclrtGetSocName();
    EXPECT_EQ(socName, nullptr);
}

TEST_F(UTEST_ACL_Common, HandleErrorManagerConfigTest)
{
    auto ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testErrorManager1.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testErrorManager2.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testErrorManager3.json");
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    resetAclJsonHash();
}

TEST_F(UTEST_ACL_Common, SetDefaultDeviceTest)
{
    auto &cbMgrInstance = InitCallbackManager::GetInstance();
    auto bakInitCbMap = cbMgrInstance.initCallbackMap_;
    cbMgrInstance.initCallbackMap_.clear();
    auto ret = aclInitCallbackRegister(ACL_REG_TYPE_OTHER, InitCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDefaultDeviceId(_))
        .WillRepeatedly(Return(ACL_ERROR_FAILURE));

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_01.json");
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_02.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_03.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_04.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_05.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_06_invalid.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_02.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDefaultDeviceId(_))
        .WillRepeatedly(Return(ACL_SUCCESS));
    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_02.json");
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    cbMgrInstance.initCallbackMap_ = bakInitCbMap;
}

TEST_F(UTEST_ACL_Common, SetEventModeTest)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDefaultDeviceId(_))
        .WillRepeatedly(Return(ACL_SUCCESS));
    aclError ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testEventMode/testEventMode_01.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testEventMode/testEventMode_02.json");
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testEventMode/testEventMode_03.json"); // 格式错误
    EXPECT_EQ(ret, ACL_ERROR_PARSE_FILE);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testEventMode/testEventMode_04.json");  // 不包含acl_graph
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testEventMode/testEventMode_05.json");  // 不包含event_mode
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testEventMode/testEventMode_06.json");  // event_mode参数非法
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    resetAclJsonHash();

    ret = HandleEventModeConfig("testEventMode_not_exist.json");
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);
}

TEST_F(UTEST_ACL_Common, SetStackSize)
{
    // stack size 32k
    aclError ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testStackSize/testStackSize_normal_32768.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testStackSize/testStackSize_normal_no_field.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testStackSize/testStackSize_abnormal_abc.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testStackSize/testStackSize_abnormal_-1.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    // not exist file
    ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testStackSize/xxxxxxxxxxxxx.json");
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSetLimit(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(0));
    ret = HandleDefaultDeviceAndStackSize(ACL_BASE_DIR "/tests/ut/acl/json/testStackSize/testStackSize_normal_32768.json");
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Common, ErrorManagerTest)
{
    auto ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testErrorManager3.json");
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/xxxx.json");
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtRegKernelLaunchFillFunc(_, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT))
        .WillRepeatedly(Return(0));
    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    const char* configPath1 = ACL_BASE_DIR "/tests/ut/acl/json/empty.json";
    ret = aclInit(configPath1);
    EXPECT_EQ(ret, ACL_SUCCESS);
    resetAclJsonHash();

    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), Init())
        .WillOnce(Return(1))
        .WillRepeatedly(Return(0));

    const char* configPath2 = ACL_BASE_DIR "/tests/ut/acl/json/testDump1.json";
    ret = aclInit(configPath2);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, duplicate_aclinit)
{
    // 引用计数改为1，跳过aclInit, 引用计数改为2
    const char* configPath = ACL_BASE_DIR "/tests/ut/acl/json/testDump1.json";
    auto ret = aclInit(configPath);
    EXPECT_EQ(ret, ACL_ERROR_REPEAT_INITIALIZE);
    EXPECT_EQ(GetAclInitFlag(), true);

    uint64_t refCount = 0;
    // 引用计数为2，跳过aclFinalizeInternal，引用计数改为1
    ret = aclFinalizeReference(&refCount);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(GetAclInitFlag(), true);
    EXPECT_EQ(refCount, 1);
    // 引用计数为1，执行aclFinalizeInternal，引用计数改为0
    ret = aclFinalizeReference(&refCount);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(GetAclInitFlag(), false);
    EXPECT_EQ(refCount, 0);
    // 引用计数为0，返回重复去初始化错误码
    ret = aclFinalizeReference(&refCount);
    EXPECT_EQ(ret, ACL_ERROR_REPEAT_FINALIZE);
    EXPECT_EQ(refCount, 0);
    // 引用计数为0，执行aclInit, 引用计数仍为1
    ret = aclInit(configPath);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(GetAclInitFlag(), true);
}

TEST_F(UTEST_ACL_Common, finalize1)
{
    auto ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, aclFinalizeReference_failed)
{
    auto ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    uint64_t refCount = 0;
    ret = aclFinalizeReference(&refCount);
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, finalize2)
{
    acl::AclDump::GetInstance().adxInitFromAclInitFlag_ = true;
    auto ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdxDataDumpServerInit())
        .WillRepeatedly(Return(0));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), AdxDataDumpServerUnInit())
        .WillOnce(Return(ACL_ERROR_INTERNAL_ERROR));
    ret = aclFinalize();
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_MODEL, FinalizeCallback_Success);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, dvpp_finalize_failed)
{
    auto ret = aclFinalizeCallbackRegister(ACL_REG_TYPE_ACL_DVPP, FinalizeCallback_Fail, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_NONE);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = aclFinalizeCallbackUnRegister(ACL_REG_TYPE_ACL_DVPP, FinalizeCallback_Fail);
    EXPECT_EQ(ret, ACL_ERROR_NONE);
}

TEST_F(UTEST_ACL_Common, finalize_failed_with_rts_fail)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtUnRegKernelLaunchFillFunc(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(0));
    aclError ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Common, aclInitFlag_true)
{
    bool ret = GetAclInitFlag();
    EXPECT_EQ(ret, true);
}

TEST_F(UTEST_ACL_Common, finalize3)
{
    aclError ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);

    // 先重置一下全局配置文件hash值
    resetAclJsonHash();
    ret = aclInit(ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_02.json");
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtUnRegKernelLaunchFillFunc(_))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT))
        .WillRepeatedly(Return(0));
    
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDefaultDeviceId(_))
        .WillOnce(Return(ACL_ERROR_RT_FAILURE));

    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_ERROR_RT_FAILURE);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDefaultDeviceId(_))
        .WillOnce(Return(ACL_SUCCESS));
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, cal_hash_wrong_config_file)
{
    std::string hashResult;
    std::string configString;
    auto ret = acl::GetStrFromConfigPath("non_existent_file.txt", configString);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);
}

TEST_F(UTEST_ACL_Common, init_with_different_config)
{
    auto ret = aclInit("");
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    resetAclJsonHash();

    ret = aclInit("");
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclInit(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclFinalize();
    EXPECT_EQ(ret, ACL_SUCCESS);
}


TEST_F(UTEST_ACL_Common, getVersion)
{
    int majorVersion = 0;
    int minorVersion = 0;
    int patchVersion = 0;
    aclError ret = aclrtGetVersion(&majorVersion, &minorVersion, &patchVersion);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_failed_no_env)
{
    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, "", 1, mmRet);
    (void)mmRet;

    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_failed_no_env02)
{
    int32_t mmRet = 0;
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
    (void)mmRet;
    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_failed_no_file01)
{
    std::string envPath = utTestBasePath + "/getCANNVersion_cann/Ascend/latest";
    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, envPath.c_str(), 1, mmRet);
    (void)mmRet;

    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_failed_no_file02)
{
    std::string envPath = utTestBasePath + "/getCANNVersion_cann/Ascend/latest";
    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, envPath.c_str(), 1, mmRet);
    (void)mmRet;

    writeToFile(envPath + "share/info/runtime/version.new.info",
        "Version=7.6.T9.0.B057\n"
        "version_dir=CANN-7.6\n"
        "timestamp=00000000_000000000\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + envPath).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_failed_invalid_file01)
{
    std::string envPath = utTestBasePath + "/getCANNVersion_cann/Ascend/latest";
    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, envPath.c_str(), 1, mmRet);
    (void)mmRet;

    writeToFile(envPath + "/share/info/runtime/version.info",
        "timestamp=00000000_000000000\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + envPath).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_failed_invalid_file03)
{
    std::string envPath = utTestBasePath + "/getCANNVersion_cann/Ascend/latest";
    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, envPath.c_str(), 1, mmRet);
    (void)mmRet;

    writeToFile(envPath + "/share/info/runtime/version.info",
        "Version=7\n"
        "timestamp=00000000_000000000\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_CANN;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + envPath).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, getCANNVersion_cann_invalid_name)
{
    aclCANNPackageName name = (aclCANNPackageName)100;
    aclCANNPackageVersion version;
    aclError ret = aclsysGetCANNVersion(name, &version);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalOps_success)
{
    std::string opsPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    writeToFile(opsPath + "/ops_legacy/version.info",
        "Version=7.6.T9.0.B057\n"
        "timestamp=00000000_000000000\n"
    );

    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + opsPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_OPP;
    aclCANNPackageVersion version;
    aclError ret = GetCANNVersionInternal(name, version, opsPath);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(std::string(version.version), "7.6.T9.0.B057");
    EXPECT_EQ(std::string(version.majorVersion), "7");
    EXPECT_EQ(std::string(version.minorVersion), "6");
    EXPECT_EQ(std::string(version.releaseVersion), "T9");
    EXPECT_EQ(std::string(version.patchVersion), "0");

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_success01)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    writeToFile(driverPath + "/driver/version.info",
        "Version=7.6.T9.0.B057\n"
        "timestamp=00000000_000000000\n"
    );

    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + driverPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_DRIVER;
    aclCANNPackageVersion version;
    std::string driverInstallPath;
    EXPECT_TRUE(GetDriverPath(ascendInstallPath, driverInstallPath));
    aclError ret = GetCANNVersionInternal(name, version, driverInstallPath);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(std::string(version.version), "7.6.T9.0.B057");
    EXPECT_EQ(std::string(version.majorVersion), "7");
    EXPECT_EQ(std::string(version.minorVersion), "6");
    EXPECT_EQ(std::string(version.releaseVersion), "T9");
    EXPECT_EQ(std::string(version.patchVersion), "0");

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_success02)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    writeToFile(driverPath + "/driver/version.info",
        "Version=8.5.0-beta.1\n"
        "timestamp=00000000_000000000\n"
    );

    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + driverPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_DRIVER;
    aclCANNPackageVersion version;
    std::string driverInstallPath;
    EXPECT_TRUE(GetDriverPath(ascendInstallPath, driverInstallPath));
    aclError ret = GetCANNVersionInternal(name, version, driverInstallPath);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(std::string(version.version), "8.5.0.beta1");
    EXPECT_EQ(std::string(version.majorVersion), "8");
    EXPECT_EQ(std::string(version.minorVersion), "5");
    EXPECT_EQ(std::string(version.releaseVersion), "0");
    EXPECT_EQ(std::string(version.patchVersion), "beta1");

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_failed01)
{
    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    std::string driverPath;
    EXPECT_FALSE(GetDriverPath(ascendInstallPath, driverPath));
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_failed02)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + driverPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_DRIVER;
    aclCANNPackageVersion version;
    std::string driverInstallPath;
    EXPECT_TRUE(GetDriverPath(ascendInstallPath, driverInstallPath));
    aclError ret = GetCANNVersionInternal(name, version, driverInstallPath);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_failed03)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        driverPath + "\n"
    );

    std::string driverInstallPath;
    EXPECT_FALSE(GetDriverPath(ascendInstallPath, driverInstallPath));
    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_failed04)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    writeToFile(driverPath + "/driver/version.info",
        "VersionXXX=7.6.T9.0.B057\n"
        "timestamp=00000000_000000000\n"
    );

    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + driverPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_DRIVER;
    aclCANNPackageVersion version;
    std::string driverInstallPath;
    EXPECT_TRUE(GetDriverPath(ascendInstallPath, driverInstallPath));
    aclError ret = GetCANNVersionInternal(name, version, driverInstallPath);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_failed05)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    writeToFile(driverPath + "/driver/version.info",
        "timestamp=00000000_000000000\n"
    );

    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + driverPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_DRIVER;
    aclCANNPackageVersion version;
    std::string driverInstallPath;
    EXPECT_TRUE(GetDriverPath(ascendInstallPath, driverInstallPath));
    aclError ret = GetCANNVersionInternal(name, version, driverInstallPath);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, GetCANNVersionInternalDriver_failed06)
{
    std::string driverPath = utTestBasePath + "/getCANNVersion_cann/usr/local/Ascend";
    writeToFile(driverPath + "/driver/version.info",
        "Version=7\n"
        "timestamp=00000000_000000000\n"
    );

    std::string ascendInstallPath = utTestBasePath + "/getCANNVersion_cann/etc/ascend_install.info";
    writeToFile(ascendInstallPath,
        "Driver_Install_Path_Param=" + driverPath + "\n"
    );

    aclCANNPackageName name = ACL_PKG_NAME_DRIVER;
    aclCANNPackageVersion version;
    std::string driverInstallPath;
    EXPECT_TRUE(GetDriverPath(ascendInstallPath, driverInstallPath));
    aclError ret = GetCANNVersionInternal(name, version, driverInstallPath);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + utTestBasePath + "/getCANNVersion_cann").c_str());
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_CANN_Success)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/compiler/version.info";
    
    writeToFile(infoPath, "Version=8.5.0.alpha001 \n");

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "compiler";
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};
    
    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(std::string(verStr), "8.5.0.alpha001");

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_Retry_AlternativeName_Success)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    
    std::string infoPath = mockAscendHome + "/share/info/ops_math/version.info";
    writeToFile(infoPath, "Version=1.0.0");

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);

    char pkgName[] = "ops-math"; 
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};

    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(std::string(verStr), "1.0.0");

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_Retry_AlternativeName_Success_01)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    
    std::string infoPath = mockAscendHome + "/share/info/ops-base/version.info";
    writeToFile(infoPath, "Version=1.0.0");

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);

    char pkgName[] = "ops_base"; 
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};

    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(std::string(verStr), "1.0.0");

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_Driver_Success)
{
    std::string mockDriverInstallDir = utTestBasePath + "/getCANNVersion/usr/local/Ascend";
    std::string driverInfoPath = mockDriverInstallDir + "/driver/version.info";
    writeToFile(driverInfoPath, "Version=23.0.rc1");

    std::string installConfPath = utTestBasePath + "/getCANNVersion/etc/ascend_install.info";
    writeToFile(installConfPath, "Driver_Install_Path_Param= " + mockDriverInstallDir + "\n");

    char pkgName[] = "driver";
    std::string verInfo;
    std::string driverInstallPath;

    EXPECT_TRUE(GetPkgPath(installConfPath, driverInstallPath, "Driver_Install_Path_Param="));
    
    aclError ret = GetVersionStringInternal(driverInfoPath, pkgName, verInfo, false);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(verInfo, "23.0.rc1");

    system(("rm -rf " + utTestBasePath + "/getCANNVersion").c_str());
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_ComplexSemVer_Success)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/runtime/version.info";
    
    writeToFile(infoPath, "Version=8.5.0.beta.1");

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);

    char pkgName[] = "runtime"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_SUCCESS);

    int32_t expectedNum = 80500000 - 200 + 1;
    EXPECT_EQ(verNum, expectedNum);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_NoEnv_Fail)
{
    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, "", 1, mmRet);
    (void)mmRet;

    char pkgName[] = "compiler";
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};

    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_NoEnv_Fail_02)
{
    int32_t mmRet = 0;
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
    (void)mmRet;

    char pkgName[] = "compiler";
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};

    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_NoFile_Fail)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "runtime"; 
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};

    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionStr_InvalidFormat_Fail)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/runtime/version.info";
    
    writeToFile(infoPath, "runtime=8.5"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "runtime"; 
    char verStr[ACL_PKG_VERSION_MAX_SIZE] = {0};

    aclError ret = aclsysGetVersionStr(pkgName, verStr);

    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_InvalidFormat_Fail)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/runtime/version.info";
    
    writeToFile(infoPath, "Version=8.5"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);

    char pkgName[] = "runtime"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_InvalidFormat_Fail_02)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/runtime/version.info";
    
    writeToFile(infoPath, "Version=8.5.0-gamma"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);

    char pkgName[] = "runtime"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_InvalidFormat_Fail_03)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/ops/version.info";
    
    writeToFile(infoPath, "Version=8"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "ops"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_InvalidFormat_Fail_04)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/compile/version.info";
    
    writeToFile(infoPath, "Version=A"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "compile"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_InvalidFormat_Fail_05)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/runtime/version.info";
    
    writeToFile(infoPath, "Version=8.5.0..alpha"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "runtime"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclsysGetVersionNum_InvalidFormat_Fail_06)
{
    std::string mockAscendHome = utTestBasePath + "/Ascend";
    std::string infoPath = mockAscendHome + "/share/info/compile/version.info";
    
    writeToFile(infoPath, "Version=8.5.0-rc.1a"); 

    int32_t mmRet = 0;
    MM_SYS_SET_ENV(MM_ENV_ASCEND_HOME_PATH, mockAscendHome.c_str(), 1, mmRet);
    (void)mmRet;

    char pkgName[] = "compile"; 
    int32_t verNum = 0;

    aclError ret = aclsysGetVersionNum(pkgName, &verNum);

    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);

    system(("rm -rf " + mockAscendHome).c_str());
    MM_SYS_UNSET_ENV(MM_ENV_ASCEND_HOME_PATH, mmRet);
}

TEST_F(UTEST_ACL_Common, aclInitFlag_false)
{
    bool ret = GetAclInitFlag();
    EXPECT_EQ(ret, false);
}

TEST(AclInitTest, MultiThreadConcurrentAclInit) {
    const int numThreads = 10;
    std::vector<std::thread> threads;
    std::atomic<int> successCount(0);
    std::atomic<int> repeatInitCount(0);
    aclError ret;

    for (int i = 0; i < numThreads; ++i) {
        threads.emplace_back([&]() {
          ret = aclInit("");
          if (ret == ACL_SUCCESS) {
              successCount++;
          } else if (ret == ACL_ERROR_REPEAT_INITIALIZE) {
              repeatInitCount++;
          }
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }
    EXPECT_EQ(successCount, 1);  // 只有一个线程能够成功初始化
    EXPECT_EQ(repeatInitCount, numThreads - 1);  // 其他线程返回 ACL_ERROR_REPEAT_INITIALIZE
    EXPECT_EQ(GetAclInitRefCount(), numThreads);  // 引用计数增加1
//    ret = aclFinalize();
//    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST(AclInitTest, MultiThreadConcurrentAclFinalizeReference) {
    const int numThreads = 10;
    std::vector<std::thread> threads;
    std::atomic<int> successCount(0);
    aclError ret;

    for (int i = 0; i < numThreads; ++i) {
        threads.emplace_back([&]() {
          uint64_t refCount = 0;
          ret = aclFinalizeReference(&refCount);
          if (ret == ACL_SUCCESS) {
              successCount++;
          }
        });
    }

    for (auto& thread : threads) {
        thread.join();
    }

    EXPECT_EQ(successCount, numThreads);
    EXPECT_EQ(GetAclInitRefCount(), 0);
    EXPECT_EQ(GetAclInitFlag(), false);
}

TEST_F(UTEST_ACL_Common, device)
{
    int32_t deviceId = 0;
    aclError ret = aclrtSetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDevice(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));

    ret = aclrtSetDevice(deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtResetDevice(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceReset(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetDevice(deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtResetDeviceForce(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceResetForce(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetDeviceForce(deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclInit(nullptr);
    ret = aclrtSetDeviceWithoutTsdVXX(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetDeviceWithoutTsd(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtSetDeviceWithoutTsdVXX(deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtResetDeviceWithoutTsdVXX(deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceResetWithoutTsd(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtResetDeviceWithoutTsdVXX(deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtGetDevice(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtGetDevice(&deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetDevice(&deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret =  aclrtSynchronizeDevice();
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceSynchronize())
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret =  aclrtSynchronizeDevice();
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    aclrtRunMode runMode;
    ret = aclrtGetRunMode(&runMode);
    EXPECT_NE(ret, ACL_SUCCESS);

    aclrtTsId tsId = ACL_TS_ID_RESERVED;
    ret = aclrtSetTsDevice(tsId);
    EXPECT_NE(ret, ACL_SUCCESS);

    tsId = ACL_TS_ID_AICORE;
    ret = aclrtSetTsDevice(tsId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetTSDevice(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSetTsDevice(tsId);
    EXPECT_NE(ret, ACL_SUCCESS);

    uint32_t count = 0;
    ret = aclrtGetDeviceCount(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtGetDeviceCount(&count);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceCount(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetDeviceCount(&count);
    EXPECT_NE(ret, ACL_SUCCESS);

}

TEST_F(UTEST_ACL_Common, context)
{
    aclrtContext context = (aclrtContext)0x01;
    int32_t deviceId = 0;
    // aclrtCreateContext
    aclError ret = aclrtCreateContext(&context, deviceId);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateContext(nullptr, deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxCreateEx(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateContext(&context, deviceId);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtDestroyContext
    context = (aclrtContext)0x01;
    ret = aclrtDestroyContext(context);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyContext(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxDestroyEx(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyContext(context);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtSetCurrentContext
    context = (aclrtContext)0x01;
    ret = aclrtSetCurrentContext(context);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSetCurrentContext(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxSetCurrent(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSetCurrentContext(context);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtGetCurrentContext
    context = (aclrtContext)0x01;
    ret = aclrtGetCurrentContext(&context);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtGetCurrentContext(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxGetCurrent(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtGetCurrentContext(&context);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, stream)
{
    // test aclrtCreateStream
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtCreateStream(&stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateStream(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamCreate(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateStream(&stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // test aclrtDestroyStream
    stream = (aclrtStream)0x01;
    ret = aclrtDestroyStream(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyStream(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamDestroy(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyStream(stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // test aclrtSynchronizeStream
    stream = (aclrtStream)0x01;
    ret = aclrtSynchronizeStream(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSynchronizeStream(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamSynchronize(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSynchronizeStream(stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // test aclrtStreamWaitEvent
    stream = (aclrtStream)0x01;
    aclrtEvent event = (aclrtEvent)0x01;
    ret = aclrtStreamWaitEvent(stream, event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtStreamWaitEvent(nullptr, event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamWaitEvent(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtStreamWaitEvent(stream, event);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, stream_force)
{
    // test aclrtCreateStream
    aclrtStream stream = (aclrtStream)0x01;
    aclError ret = aclrtCreateStream(&stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateStream(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamCreate(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateStream(&stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // test aclrtDestroyStreamForce
    stream = (aclrtStream)0x01;
    ret = aclrtDestroyStreamForce(stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyStreamForce(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtStreamDestroyForce(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyStreamForce(stream);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, event)
{
    aclrtEvent event = (aclrtEvent)0x01;
    // aclrtCreateEvent
    aclError ret = aclrtCreateEvent(&event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtCreateEvent(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventCreate(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateEvent(&event);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    // aclrtDestroyEvent
    event = (aclrtEvent)0x01;
    ret = aclrtDestroyEvent(event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtDestroyEvent(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventDestroy(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtDestroyEvent(event);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtRecordEvent(aclrtEvent event, aclrtStream stream)
    event = (aclrtEvent)0x01;
    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtRecordEvent(event, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtRecordEvent(nullptr, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventRecord(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtRecordEvent(event, stream);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    // aclrtResetEvent
    event = (aclrtEvent)0x01;
    stream = (aclrtStream)0x01;
    ret = aclrtResetEvent(event, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtResetEvent(nullptr, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventReset(_, _))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtResetEvent(event, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtQueryEvent
    event = (aclrtEvent)0x01;
    aclrtEventStatus status;
    ret = aclrtResetEvent(nullptr, &status);
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclrtResetEvent(event, nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventQuery(_))
        .WillOnce(Return((RT_ERROR_NONE)))
        .WillOnce(Return(ACL_ERROR_RT_EVENT_NOT_COMPLETE))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    ret = aclrtQueryEvent(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_STATUS_COMPLETE);

    ret = aclrtQueryEvent(event, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_EVENT_STATUS_NOT_READY);

    ret = aclrtQueryEvent(event, &status);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtSynchronizeEvent
    event = (aclrtEvent)0x01;
    ret = aclrtSynchronizeEvent(event);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtSynchronizeEvent(nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventSynchronize(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtSynchronizeEvent(event);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, eventWithFlag)
{
    uint32_t flag = 0x00000008u;
    aclError ret;
    aclrtEvent event = (aclrtEvent)0x01;

    ret = aclrtCreateEventWithFlag(nullptr, flag);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtCreateEventWithFlag(&event, flag);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventCreateWithFlag(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtCreateEventWithFlag(&event, flag);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, elapsedTime)
{
    // aclrtEventElapsedTime
    float time = 0.0f;
    aclError ret;
    aclrtEvent start = (aclrtEvent)0x01;
    aclrtEvent end = (aclrtEvent)0x01;

    ret = aclrtEventElapsedTime(nullptr, start, end);
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclrtEventElapsedTime(&time, nullptr, end);
    EXPECT_NE(ret, ACL_SUCCESS);
    ret = aclrtEventElapsedTime(&time, start, nullptr);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtEventElapsedTime(&time, start, end);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEventElapsedTime(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtEventElapsedTime(&time, start, end);
    EXPECT_NE(ret, ACL_SUCCESS);

}

TEST_F(UTEST_ACL_Common, setOpWaitTimeOut)
{
    uint32_t timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpWaitTimeOut(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    aclError ret = aclrtSetOpWaitTimeout(timeout);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpWaitTimeOut(_))
        .WillOnce(Return((RT_ERROR_NONE)));
    ret = aclrtSetOpWaitTimeout(timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, setOpExecuteimeOut)
{
    uint32_t timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpExecuteTimeOut(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    aclError ret = aclrtSetOpExecuteTimeOut(timeout);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpExecuteTimeOut(_))
        .WillOnce(Return((RT_ERROR_NONE)));
    ret = aclrtSetOpExecuteTimeOut(timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, setOpExecuteimeOutWithMs)
{
    uint32_t timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpExecuteTimeOutWithMs(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    aclError ret = aclrtSetOpExecuteTimeOutWithMs(timeout);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpExecuteTimeOutWithMs(_))
        .WillOnce(Return((RT_ERROR_NONE)));
    ret = aclrtSetOpExecuteTimeOutWithMs(timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, setOpExecuteTimeOutV2)
{
    uint64_t timeout = 3;
    uint64_t actualTimeout;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpExecuteTimeOutV2(_,_))
    .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    aclError ret = aclrtSetOpExecuteTimeOutV2(timeout, &actualTimeout);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    timeout = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetOpExecuteTimeOutV2(_,_))
    .WillOnce(Return((RT_ERROR_NONE)));
    ret = aclrtSetOpExecuteTimeOutV2(timeout, &actualTimeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, getOpTimeOutInterval)
{
    uint64_t interval;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetOpTimeOutInterval(_))
    .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    aclError ret = aclrtGetOpTimeOutInterval(&interval);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    interval = 3;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetOpTimeOutInterval(_))
    .WillOnce(Return((RT_ERROR_NONE)));
    ret = aclrtGetOpTimeOutInterval(&interval);
    EXPECT_EQ(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

void CallBackFunc(void *arg)
{
    (void) arg;
    int a = 1;
    a++;
}

TEST_F(UTEST_ACL_Common, callback)
{
    aclError ret;
    aclrtStream stream = (aclrtStream)0x01;
    ret = aclrtSubscribeReport(1, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSubscribeReport(_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtSubscribeReport(1, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtUnSubscribeReport(1, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtUnSubscribeReport(_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = aclrtUnSubscribeReport(1, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtLaunchCallback(CallBackFunc, nullptr, ACL_CALLBACK_BLOCK, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);
    ret = aclrtLaunchCallback(CallBackFunc, nullptr, static_cast<aclrtCallbackBlockType>(2), stream);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCallbackLaunch(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtLaunchCallback(CallBackFunc, nullptr, ACL_CALLBACK_BLOCK, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtProcessReport(0);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtProcessReport(1);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtProcessReport(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtProcessReport(-1);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtProcessReport(_))
        .WillOnce(Return((ACL_ERROR_RT_THREAD_SUBSCRIBE)));
    ret = aclrtProcessReport(-1);
    EXPECT_NE(ret, ACL_SUCCESS);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtProcessReport(_))
        .WillOnce(Return((ACL_ERROR_RT_REPORT_TIMEOUT)));
    ret = aclrtProcessReport(-1);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_malloc_device)
{
    void *devPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(devPtr, nullptr);

    ret = aclrtFree(devPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMalloc(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMalloc(nullptr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);

    size = static_cast<size_t>(-1);
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(0);
    ret = aclrtMalloc(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_malloc_aligned32_device)
{
    void *devPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(devPtr, nullptr);

    ret = aclrtFree(devPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMalloc(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));

    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMallocAlign32(nullptr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY_P2P);
    EXPECT_EQ(ret, ACL_SUCCESS);

    size = static_cast<size_t>(-1);
    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(0);
    ret = aclrtMallocAlign32(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_malloc_cache_device)
{
    void *devPtr = nullptr;
    size_t size = 1;

    aclError ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(devPtr, nullptr);

    // aclrtMemFlush
    ret = aclrtMemFlush(devPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtFlushCache(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemFlush(devPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(0);
    ret = aclrtMemFlush(devPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    // aclrtMemInvalidate
    size = static_cast<size_t>(1);
    ret = aclrtMemInvalidate(devPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtInvalidCache(_, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemInvalidate(devPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(0);
    ret = aclrtMemInvalidate(devPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtFree(devPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocCached(_, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    size = static_cast<size_t>(1);
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_HUGE_FIRST);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(-1);
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);

    size = static_cast<size_t>(0);
    ret = aclrtMallocCached(&devPtr, size, ACL_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_malloc_host)
{
    void *hostPtr = nullptr;
    size_t size = 0;

    aclError ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);
    size = 1;
    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_NE(hostPtr, nullptr);
    ret = aclrtFreeHost(hostPtr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMallocHost(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));

    ret = aclrtMallocHost(nullptr, size);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMallocHost(&hostPtr, size);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_memcpyAsync)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpyAsync(_, _, _, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));

    void *dst = (void *)0x01;
    void *src = (void *)0x02;
    aclrtStream stream = (aclrtStream)0x10;
    aclError ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(nullptr, 1, src, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, nullptr, 1, ACL_MEMCPY_HOST_TO_HOST, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_HOST, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEVICE_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_DEFAULT, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtMemcpyAsync(dst, 1, src, 1, (aclrtMemcpyKind)0x7FFFFFFF, stream);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_getMemInfo)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemGetInfoEx(_, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    size_t free = 0x01;
    size_t total = 0x02;
    aclError ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, &total);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtGetMemInfo(ACL_DDR_MEM_HUGE, &free, &total);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = aclrtGetMemInfo(ACL_HBM_MEM, &free, &total);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, memory_memsetAsync)
{

    void *devPtr = (void *)0x01;
    aclrtStream stream = (aclrtStream)0x10;
    aclError ret = aclrtMemsetAsync(nullptr, 1, 1, 1, stream);
    EXPECT_NE(ret, ACL_SUCCESS);

    ret = aclrtMemsetAsync(devPtr, 1, 1, 1, stream);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemsetAsync(_, _, _, _, _))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtMemsetAsync(devPtr, 1, 1, 1, stream);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, GetCurLogLevel1)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), dlog_getlevel(_,_))
        .WillOnce(Return((DLOG_ERROR)));
    uint32_t log_level = AclLog::GetCurLogLevel();
    EXPECT_EQ(log_level, ACL_ERROR);
}

TEST_F(UTEST_ACL_Common, GetCurLogLevel2)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), dlog_getlevel(_,_))
        .WillOnce(Return((DLOG_WARN)));
    uint32_t log_level = AclLog::GetCurLogLevel();
    EXPECT_EQ(log_level, ACL_WARNING);
}

TEST_F(UTEST_ACL_Common, GetCurLogLevel3)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), dlog_getlevel(_,_))
        .WillOnce(Return((DLOG_INFO)));
    uint32_t log_level = AclLog::GetCurLogLevel();
    EXPECT_EQ(log_level, ACL_INFO);
}

TEST_F(UTEST_ACL_Common, GetCurLogLevel4)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), dlog_getlevel(_,_))
        .WillOnce(Return((DLOG_DEBUG)));
    uint32_t log_level = AclLog::GetCurLogLevel();
    EXPECT_EQ(log_level, ACL_DEBUG);
}

TEST_F(UTEST_ACL_Common, GetCurLogLevel5)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), dlog_getlevel(_,_))
        .WillOnce(Return((DLOG_NULL)));
    uint32_t log_level = AclLog::GetCurLogLevel();
    EXPECT_EQ(log_level, ACL_INFO);
}

extern int g_logLevel;
TEST_F(UTEST_ACL_Common, ACLSaveLog)
{
    const char *strLog = "hello, acl";
    AclLog::ACLSaveLog(ACL_DEBUG, strLog);
    EXPECT_EQ(g_logLevel, ACL_DEBUG);
    AclLog::ACLSaveLog(ACL_INFO, strLog);
    EXPECT_EQ(g_logLevel, ACL_INFO);
    AclLog::ACLSaveLog(ACL_WARNING, strLog);
    EXPECT_EQ(g_logLevel, ACL_WARNING);
    AclLog::ACLSaveLog(ACL_ERROR, strLog);
    EXPECT_EQ(g_logLevel, ACL_ERROR);
}

TEST_F(UTEST_ACL_Common, ACLProfiling)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), MsprofRegTypeInfo(_,_,_))
    .WillRepeatedly(Return(2));
    EXPECT_NE(acl::AclProfilingManager::GetInstance().Init(), ACL_SUCCESS);
    EXPECT_EQ(acl::AclProfilingManager::GetInstance().UnInit(), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ACLExceptionCallback)
{
    EXPECT_EQ(aclrtSetExceptionInfoCallback(ExceptionInfoCallback), ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtRegTaskFailCallbackByModule(_, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtSetExceptionInfoCallback(ExceptionInfoCallback), ACL_SUCCESS);
    uint32_t task_id = aclrtGetTaskIdFromExceptionInfo(nullptr);
    uint32_t stream_id = aclrtGetStreamIdFromExceptionInfo(nullptr);
    uint32_t thread_id = aclrtGetThreadIdFromExceptionInfo(nullptr);
    uint32_t device_id = aclrtGetDeviceIdFromExceptionInfo(nullptr);
    uint32_t retCode = aclrtGetErrorCodeFromExceptionInfo(nullptr);
    EXPECT_EQ(task_id, 0xFFFFFFFFU);
    EXPECT_EQ(stream_id, 0xFFFFFFFFU);
    EXPECT_EQ(thread_id, 0xFFFFFFFFU);
    EXPECT_EQ(device_id, 0xFFFFFFFFU);
    EXPECT_EQ(retCode, 0xFFFFFFFFU);
    aclrtExceptionInfo info{};
    device_id = aclrtGetDeviceIdFromExceptionInfo(&info);
    retCode = aclrtGetErrorCodeFromExceptionInfo(&info);
    EXPECT_EQ(retCode, 0);
}

TEST_F(UTEST_ACL_Common, ACLSetGroup)
{
    uint32_t count = 0;
    EXPECT_EQ(aclrtGetGroupCount(&count), ACL_SUCCESS);
    aclrtGroupInfo * groupInfo = aclrtCreateGroupInfo();
    EXPECT_EQ(aclrtGetAllGroupInfo(groupInfo), ACL_SUCCESS);

    uint32_t aicoreNum = 0;
    size_t param_ret_size = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_AICORE_INT,
        (void *)(&aicoreNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_EQ(aicoreNum, 2);
    EXPECT_EQ(param_ret_size, 4);

    uint32_t aicpuNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_AIC_INT,
        (void *)(&aicpuNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_EQ(aicpuNum, 3);

    uint32_t aivectorNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_AIV_INT,
        (void *)(&aivectorNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_EQ(aivectorNum, 4);

    uint32_t sdmaNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_SDMANUM_INT,
        (void *)(&sdmaNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_EQ(sdmaNum, 5);

    uint32_t activeStreamNum = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_ASQNUM_INT,
        (void *)(&activeStreamNum), 4, &param_ret_size), ACL_SUCCESS);
    EXPECT_EQ(activeStreamNum, 6);

    uint32_t groupId = 0;
    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, ACL_GROUP_GROUPID_INT,
        (void *)(&groupId), 4, &param_ret_size), ACL_SUCCESS);

    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 2, ACL_GROUP_ASQNUM_INT,
        (void *)(&activeStreamNum), 4, &param_ret_size), ACL_ERROR_INVALID_PARAM);

    EXPECT_EQ(aclrtGetGroupInfoDetail(groupInfo, 1, static_cast<aclrtGroupAttr>(6),
        (void *)(&activeStreamNum), 4, &param_ret_size), ACL_ERROR_INVALID_PARAM);

    EXPECT_EQ(aclrtSetGroup(1), ACL_SUCCESS);
    EXPECT_EQ(aclrtDestroyGroupInfo(groupInfo), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ACLDeviceCanAccessPeer)
{
    int32_t canAccessPeer = 0;
    EXPECT_EQ(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 0), ACL_ERROR_INVALID_PARAM);

    EXPECT_EQ(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceCanAccessPeer(_, _, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevicePhyIdByIndex(_, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtDeviceCanAccessPeer(&canAccessPeer, 0, 1), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ACLEnablePeerAccess)
{
    int32_t peerDeviceId = 1;
    uint32_t tmpFlags = 1;
    EXPECT_EQ(aclrtDeviceEnablePeerAccess(peerDeviceId, tmpFlags), ACL_ERROR_FEATURE_UNSUPPORTED);

    uint32_t flags = 0;
    EXPECT_EQ(aclrtDeviceEnablePeerAccess(peerDeviceId, flags), ACL_SUCCESS);

    EXPECT_EQ(aclrtDeviceEnablePeerAccess(0, flags), ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtEnableP2P(_, _, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtDeviceEnablePeerAccess(peerDeviceId, flags), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevicePhyIdByIndex(_, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtDeviceEnablePeerAccess(peerDeviceId, flags), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillRepeatedly(Return((1)));
    EXPECT_NE(aclrtDeviceEnablePeerAccess(peerDeviceId, flags), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ACLDisablePeerAccess)
{
    int32_t peerDeviceId = 1;
    EXPECT_EQ(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_SUCCESS);

    EXPECT_EQ(aclrtDeviceDisablePeerAccess(0), ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDisableP2P(_, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevicePhyIdByIndex(_, _))
        .WillOnce(Return((1)));
    EXPECT_NE(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillRepeatedly(Return((1)));
    EXPECT_NE(aclrtDeviceDisablePeerAccess(peerDeviceId), ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, AclGetRecentErrMsgTest)
{
    // GetErrMgrErrorMessage stub will return "default" as default return value.
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevMsg(_, _))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    const char *str = "123";
    std::unique_ptr<const char[]> errMsg(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg.get()), str);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return((ByMove(std::move(errMsg)))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    std::unique_ptr<const char[]> errMsg2(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg2.get()), str);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevMsg(_, _))
        .WillOnce(Return(RT_ERROR_NONE));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return((ByMove(std::move(errMsg2)))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));

    const char* str1 = "";
    std::unique_ptr<const char[]> hostErrMsg(new char[std::strlen(str1) + 1]);
    std::strcpy(const_cast<char*>(hostErrMsg.get()), str1);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevMsg(_, _))
        .WillOnce(Return(RT_ERROR_NONE));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return(ByMove(std::move(hostErrMsg))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);

    const char_t *msg = nullptr;
    aclGetMsgCallback(msg, 0);
    msg = "abc";
    aclGetMsgCallback(msg, 3);
}

rtError_t rtGetFaultEvent_Invoke(const int32_t deviceId, rtDmsEventFilter *filter,
                                 rtDmsFaultEvent *dmsEvent, uint32_t len, uint32_t *eventCount)
{
    (void)deviceId;
    (void)filter;
    if (len >= 2U) {
        dmsEvent[0].eventId = 0x80E01801U;
        dmsEvent[0].eventName[0] = 'A';
        dmsEvent[0].eventName[1] = '\0';
        dmsEvent[1].eventId = 0x80E01802U;
        dmsEvent[1].eventName[0] = 'B';
        dmsEvent[1].eventName[1] = '\0';
        if (eventCount != nullptr) {
            *eventCount = 2U;
        }
    }
    return RT_ERROR_NONE;
}

TEST_F(UTEST_ACL_Common, AclGetRecentErrMsgTest_FaultEvent_Succ_With_Host_Device_Event)
{
    const char_t *msg = "device";
    aclGetMsgCallback(msg, sizeof("device") - 1);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetFaultEvent(_, _, _, _, _))
        .WillOnce(Invoke(rtGetFaultEvent_Invoke));
    const char* str = "123";
    std::unique_ptr<const char[]> errMsg(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg.get()), str);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return((ByMove(std::move(errMsg)))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, AclGetRecentErrMsgTest_FaultEvent_Succ_With_Device_Event)
{
    const char_t *msg = "device";
    aclGetMsgCallback(msg, sizeof("device") - 1);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetFaultEvent(_, _, _, _, _))
        .WillOnce(Invoke(rtGetFaultEvent_Invoke));
    const char* str = "";
    std::unique_ptr<const char[]> errMsg(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg.get()), str);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return((ByMove(std::move(errMsg)))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, AclGetRecentErrMsgTest_FaultEvent_Succ_With_Host_Event)
{
    const char_t *msg = "";
    aclGetMsgCallback(msg, 0);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetFaultEvent(_, _, _, _, _))
        .WillOnce(Invoke(rtGetFaultEvent_Invoke));
    const char* str = "host";
    std::unique_ptr<const char[]> errMsg(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg.get()), str);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return((ByMove(std::move(errMsg)))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, AclGetRecentErrMsgTest_FaultEvent_Succ_With_Event)
{
    const char_t *msg = "";
    aclGetMsgCallback(msg, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetFaultEvent(_, _, _, _, _))
        .WillOnce(Invoke(rtGetFaultEvent_Invoke));
    const char* str = "";
    std::unique_ptr<const char[]> errMsg(new char[std::strlen(str) + 1]);
    std::strcpy(const_cast<char*>(errMsg.get()), str);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), GetErrMgrErrorMessage())
        .WillOnce(Return((ByMove(std::move(errMsg)))));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}

TEST_F(UTEST_ACL_Common, AclGetRecentErrMsgTest_FaultEvent_Failed_With_GetDdevice_Failed)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillRepeatedly(Return((ACL_ERROR_RT_PARAM_INVALID)));
    EXPECT_NE(aclGetRecentErrMsg(), nullptr);
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
}


TEST_F(UTEST_ACL_Common, AclrtGetSocNameTest)
{
    const char *ret = aclrtGetSocName();
    EXPECT_NE(ret, nullptr);
}

TEST_F(UTEST_ACL_Common, AclrtCtxSetSysParamOpt)
{
    aclError ret = aclrtCtxSetSysParamOpt(static_cast<aclSysParamOpt>(99), 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtCtxSetSysParamOpt(ACL_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxSetSysParamOpt(_, _))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    ret = aclrtCtxSetSysParamOpt(ACL_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Common, AclrtCtxGetSysParamOptTest)
{
    aclError ret = aclrtCtxGetSysParamOpt(ACL_OPT_DETERMINISTIC, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    int64_t val = 0;
    ret = aclrtCtxGetSysParamOpt(static_cast<aclSysParamOpt>(99), &val);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtCtxGetSysParamOpt(ACL_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxGetSysParamOpt(_, _))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    ret = aclrtCtxGetSysParamOpt(ACL_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);

    // not set
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxGetSysParamOpt(_, _))
        .WillOnce(Return(ACL_ERROR_RT_SYSPARAMOPT_NOT_SET));
    ret = aclrtCtxGetSysParamOpt(ACL_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(ret, ACL_ERROR_RT_SYSPARAMOPT_NOT_SET);
}

TEST_F(UTEST_ACL_Common, AclrtSetSysParamOpt)
{
    aclError ret = aclrtSetSysParamOpt(static_cast<aclSysParamOpt>(99), 1);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtSetSysParamOpt(ACL_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtSetSysParamOpt(_, _))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    ret = aclrtSetSysParamOpt(ACL_OPT_DETERMINISTIC, 1);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Common, AclrtGetSysParamOptTest)
{
    aclError ret = aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    int64_t val = 0;
    ret = aclrtGetSysParamOpt(static_cast<aclSysParamOpt>(99), &val);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetSysParamOpt(_, _))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    ret = aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);

    // not set
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetSysParamOpt(_, _))
        .WillOnce(Return(ACL_ERROR_RT_SYSPARAMOPT_NOT_SET));
    ret = aclrtGetSysParamOpt(ACL_OPT_DETERMINISTIC, &val);
    EXPECT_EQ(ret, ACL_ERROR_RT_SYSPARAMOPT_NOT_SET);
}

TEST_F(UTEST_ACL_Common, AclrtGetOverflowStatus)
{
    aclError ret = aclrtGetOverflowStatus(nullptr, 0UL, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = aclrtGetOverflowStatus((void *)0x1, 1UL, nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDeviceSatStatus(_, _, _))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    ret = aclrtGetOverflowStatus((void *)0x1, 1UL, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Common, AclrtResetOverflowStatus)
{
    aclError ret = aclrtResetOverflowStatus(nullptr);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCleanDeviceSatStatus(_))
        .WillOnce(Return(ACL_ERROR_RT_INTERNAL_ERROR));
    ret = aclrtResetOverflowStatus(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Common, GetAlignedAndPaddingSize)
{
    size_t alignedSize = 0UL;
    aclError ret = acl::GetAlignedAndPaddingSize(UINT64_MAX - 63UL, true, alignedSize);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acl::GetAlignedAndPaddingSize(UINT64_MAX - 64UL, true, alignedSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(alignedSize, UINT64_MAX - 31UL);
    ret = acl::GetAlignedAndPaddingSize(1UL, true, alignedSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(alignedSize, 64UL);
    ret = acl::GetAlignedAndPaddingSize(32UL, true, alignedSize);
    EXPECT_EQ(alignedSize, 64UL);

    ret = acl::GetAlignedAndPaddingSize(UINT64_MAX - 63UL, false, alignedSize);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    ret = acl::GetAlignedAndPaddingSize(UINT64_MAX - 64UL, false, alignedSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(alignedSize, UINT64_MAX - 63UL);
    ret = acl::GetAlignedAndPaddingSize(1UL, false, alignedSize);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(alignedSize, 32UL);
    ret = acl::GetAlignedAndPaddingSize(32UL, false, alignedSize);
    EXPECT_EQ(alignedSize, 32UL);
}

static rtError_t rtDeviceStatusQueryInvok(const uint32_t devId, rtDeviceStatus *deviceStatus)
{
    (void) devId;
    *deviceStatus = static_cast<rtDeviceStatus>(0);
    return RT_ERROR_NONE;
}
TEST_F(UTEST_ACL_Common, aclrtQueryDeviceStatusTest)
{
    // test aclrtQueryDeviceStatus
    int32_t deviceId = 0;
    aclrtDeviceStatus status;

    // input param is invalid
    aclError ret = aclrtQueryDeviceStatus(deviceId, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    // get status success
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceStatusQuery(_,_))
        .WillOnce(Invoke(rtDeviceStatusQueryInvok));
    ret = aclrtQueryDeviceStatus(deviceId, &status);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(status, ACL_RT_DEVICE_STATUS_NORMAL);

    // get status fail
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtDeviceStatusQuery(_,_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)));
    ret = aclrtQueryDeviceStatus(deviceId, &status);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Common, update_op_sys_cfg_failed_with_invalid_param)
{
    uint64_t offset;
    int32_t ret = UpdateOpSystemRunCfg(nullptr, sizeof(offset));
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    ret = UpdateOpSystemRunCfg(&offset, sizeof(offset) - 1UL);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
}

TEST_F(UTEST_ACL_Common, update_op_sys_cfg_failed_with_rts_error)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetL2CacheOffset(_, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(0));
    uint64_t offset;
    int32_t ret = UpdateOpSystemRunCfg(&offset, sizeof(offset));
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetDevice(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(0));
    ret = UpdateOpSystemRunCfg(&offset, sizeof(offset));
    EXPECT_NE(ret, ACL_RT_SUCCESS);
}

TEST_F(UTEST_ACL_Common, update_op_sys_cfg_failed_with_feature_not_support)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetL2CacheOffset(_, _))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT))
        .WillRepeatedly(Return(0));
    uint64_t offset;
    int32_t ret = UpdateOpSystemRunCfg(&offset, sizeof(offset));
    EXPECT_EQ(ret, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_Common, update_op_sys_cfg_succ)
{
    uint64_t offset;
    auto ret = UpdateOpSystemRunCfg(&offset, sizeof(offset));
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ParseJsonFromFile_fileName_nullptr)
{
    nlohmann::json js;
    aclError ret = acl::JsonParser::ParseJsonFromFile(nullptr, js);
    EXPECT_EQ(ret, ACL_RT_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ParseJsonFromFile_failed_with_not_exist_file)
{
    nlohmann::json js;
    const char_t* fileName = "xxyyzz.json";
    aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_FILE);
}

TEST_F(UTEST_ACL_Common, ParseJsonFromFile_failed_with_empty)
{
    nlohmann::json js;
    const char_t* fileName = ACL_BASE_DIR "/tests/ut/acl/json/empty.json";
    aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
    EXPECT_EQ(ret, ACL_SUCCESS);
}

TEST_F(UTEST_ACL_Common, ParseJsonFromFile_failed_with_illegal_format)
{
    nlohmann::json js;
    const char_t* fileName = ACL_BASE_DIR "/tests/ut/acl/json/illegal_format.json";
    aclError ret = acl::JsonParser::ParseJsonFromFile(fileName, js);
    EXPECT_EQ(ret, ACL_ERROR_PARSE_FILE);
}

TEST_F(UTEST_ACL_Common, GetMaxNestedLayers_with_invalid_file)
{
    const char_t *fileName = "xxyyzz.json";
    size_t length = 1UL;
    size_t maxObjDepth = 1000000000UL;
    size_t maxArrayDepth = 1000000000UL;
    acl::JsonParser::GetMaxNestedLayers(fileName, length, maxObjDepth, maxArrayDepth);
    EXPECT_TRUE(maxObjDepth == 1000000000UL);
    EXPECT_TRUE(maxArrayDepth == 1000000000UL);
}

TEST_F(UTEST_ACL_Common, GetMaxNestedLayers_with_invliad_length)
{
    const char_t *fileName = ACL_BASE_DIR "/tests/ut/acl/json/illegal_format.json";
    size_t length = 0UL;
    size_t maxObjDepth = 1000000000UL;
    size_t maxArrayDepth = 1000000000UL;
    acl::JsonParser::GetMaxNestedLayers(fileName, length, maxObjDepth, maxArrayDepth);
    EXPECT_TRUE(maxObjDepth == 1000000000UL);
    EXPECT_TRUE(maxArrayDepth == 1000000000UL);
}

TEST_F(UTEST_ACL_Common, GetMaxNestedLayers_with_normal)
{
    const char_t *fileName = ACL_BASE_DIR "/tests/ut/acl/json/testDepth.json";
    size_t length = 1UL;
    size_t maxObjDepth = 1000000000UL;
    size_t maxArrayDepth = 1000000000UL;
    acl::JsonParser::GetMaxNestedLayers(fileName, length, maxObjDepth, maxArrayDepth);
    EXPECT_TRUE(maxObjDepth == 1000000000UL);
    EXPECT_TRUE(maxArrayDepth == 1000000000UL);
}

TEST_F(UTEST_ACL_Common, GetMaxNestedLayers_with_large_length)
{
    const char_t *fileName = ACL_BASE_DIR "/tests/ut/acl/json/illegal_format.json";
    size_t length = 100000UL;
    size_t maxObjDepth = 1000000000UL;
    size_t maxArrayDepth = 1000000000UL;
    acl::JsonParser::GetMaxNestedLayers(fileName, length, maxObjDepth, maxArrayDepth);
    EXPECT_TRUE(maxObjDepth == 1000000000UL);
    EXPECT_TRUE(maxArrayDepth == 1000000000UL);
}

TEST_F(UTEST_ACL_Common, GetJsonCtxByKey_failed)
{
    nlohmann::json js;
    const char_t* fileName = ACL_BASE_DIR "/tests/ut/acl/json/illegal_format.json";
    std::string strJsonCtx = "123";
    std::string subStrKey;
    bool found = false;
    aclError ret = acl::JsonParser::GetJsonCtxByKey(fileName, strJsonCtx, subStrKey, found);
    EXPECT_EQ(ret, ACL_ERROR_PARSE_FILE);
    EXPECT_FALSE(found);
}

TEST_F(UTEST_ACL_Common, GetAttrConfigFromFile_failed)
{
    nlohmann::json js;
    const char_t* fileName = ACL_BASE_DIR "/tests/ut/acl/json/illegal_format.json";
    std::map<aclCannAttr, CannInfo> cannInfoMap;
    aclError ret = acl::JsonParser::GetAttrConfigFromFile(fileName, cannInfoMap);
    EXPECT_EQ(ret, ACL_ERROR_PARSE_FILE);
}

TEST_F(UTEST_ACL_Common, GetDefaultDeviceIdFromFile_failed)
{
    const char_t *fileName = ACL_BASE_DIR "/tests/ut/acl/json/testDefaultDevice/testDefaultDevice_07_invalid.json";
    int32_t devId = 0;
    auto ret = acl::JsonParser::GetDefaultDeviceIdFromFile(fileName, devId);
    EXPECT_EQ(ret, ACL_ERROR_INTERNAL_ERROR);
}

TEST_F(UTEST_ACL_Common, aclAppLogWithArgs_succ)
{
    aclLogLevel level = ACL_ERROR;
    const char *func = "UserFunc";
    const char *file = "main.cpp";
    uint32_t line = 88U;
    TestAclAppLogWithArgs(level, func, file, line, "hello world!");
    EXPECT_TRUE(g_logLevel == ACL_ERROR);
}

TEST_F(UTEST_ACL_Common, aclAppLog_succ)
{
    aclLogLevel level = ACL_ERROR;
    const char *func = "UserFunc";
    const char *file = "main.cpp";
    uint32_t line = 88U;
    aclAppLog(level, func, file, line, "hello world!");
    EXPECT_TRUE(g_logLevel == ACL_ERROR);
}

TEST_F(UTEST_ACL_Common, aclAppLog_failed_1000bytes)
{
    aclLogLevel level = ACL_ERROR;
    const char *func = "UserFunc";
    const char *file = "main.cpp";
    uint32_t line = 88U;
    const char_t *fmt =
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789";
    aclAppLog(level, func, file, line, fmt);
    EXPECT_TRUE(g_logLevel == ACL_ERROR);
}

TEST_F(UTEST_ACL_Common, aclAppLog_failed_1100bytes)
{
    aclLogLevel level = ACL_ERROR;
    const char *func = "UserFunc";
    const char *file = "main.cpp";
    uint32_t line = 88U;
    const char_t *fmt =
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "012345678901345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
              "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789";
    aclAppLog(level, func, file, line, fmt);
    EXPECT_TRUE(g_logLevel == ACL_ERROR);
}

TEST_F(UTEST_ACL_Common, FormatStr_failed_1100bytes)
{
    const char_t *fmt =
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "012345678901345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
            "0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789";
    std::string value = acl::AclErrorLogManager::FormatStr(fmt);
    EXPECT_TRUE(value.empty());

    value = acl::AclErrorLogManager::FormatStr(nullptr);
    EXPECT_TRUE(value.empty());
}
