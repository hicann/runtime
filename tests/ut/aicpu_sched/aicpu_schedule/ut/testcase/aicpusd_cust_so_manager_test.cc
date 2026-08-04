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
#include <fstream>
#include <securec.h>
#include <stdlib.h>
#include <sys/file.h>
#include <sys/stat.h>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "aicpusd_status.h"
#include "aicpu_engine.h"
#define private public
#include "aicpusd_util.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_cust_so_manager.h"
#undef private

using namespace AicpuSchedule;
using namespace aicpu;

namespace {
std::string MakeTempDir()
{
    char tmpDir[] = "/tmp/aicpu_cust_so_test_XXXXXX";
    char* const dir = mkdtemp(tmpDir);
    return (dir == nullptr) ? "" : std::string(dir);
}

void RemoveTempDir(const std::string& dir)
{
    if (dir.empty()) {
        return;
    }
    const std::string command = "rm -rf " + dir;
    (void)system(command.c_str());
}
} // namespace

class AicpuCustSoManagerTEST : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        dlog_setlevel(0, 1, 1);
        std::cout << "AicpuCustSoManagerTEST SetUpTestCase" << std::endl;
    }

    static void TearDownTestCase()
    {
        dlog_setlevel(0, 3, 0);
        std::cout << "AicpuCustSoManagerTEST TearDownTestCase" << std::endl;
    }

    virtual void SetUp() { std::cout << "AicpuCustSoManagerTEST SetUP" << std::endl; }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        std::cout << "AicpuCustSoManagerTEST TearDown" << std::endl;
    }
};

TEST_F(AicpuCustSoManagerTEST, CheckSoFullPathValid_Failed0)
{
    std::string soFullPath = "/abc/";
    char* a = nullptr;
    MOCKER(realpath).stubs().will(returnValue(a));
    auto ret = AicpuCustSoManager::GetInstance().CheckSoFullPathValid(soFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckSoFullPathValid_Failed1)
{
    std::string soFullPath = "/abc/";
    char* a = nullptr;
    MOCKER(memset_s).stubs().will(returnValue(-1));
    auto ret = AicpuCustSoManager::GetInstance().CheckSoFullPathValid(soFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckDirEmpty_Success)
{
    dirent ent;
    ent.d_name[0] = '.';
    ent.d_name[1] = '/';
    ent.d_type = DT_DIR;
    dirent* a = nullptr;
    MOCKER(readdir).stubs().will(returnValue(&ent)).then(returnValue(a));
    DIR* dirHandle = reinterpret_cast<DIR*>(static_cast<uintptr_t>(0x001));
    MOCKER(readdir).stubs().will(returnValue(dirHandle));
    auto ret = AicpuCustSoManager::GetInstance().CheckDirEmpty("./");
    EXPECT_EQ(ret, true);
}

TEST_F(AicpuCustSoManagerTEST, DeleteCustSoDir_Success)
{
    AicpuCustSoManager::GetInstance().custSoDirName_ = "/var/aicpu_testA";
    MOCKER(access).stubs().will(returnValue(0));
    int32_t ret = AicpuCustSoManager::GetInstance().DeleteCustSoDir();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndCreateSoFilePathFailed)
{
    AicpuCustSoManager soManager;
    const LoadOpFromBufArgs args = {};
    std::string soName = "libcust_aicpu.so";
    const int32_t ret = soManager.CheckAndCreateSoFile(&args, soName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndCreateSoFileArgsNullptr)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/var/";
    std::string soName = "libcust_aicpu.so";
    const int32_t ret = soManager.CheckAndCreateSoFile(nullptr, soName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndCreateSoFileSoBufNullptr)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/var/";
    LoadOpFromBufArgs args = {};
    args.kernelSoBuf = 0UL;
    std::string soName = "libcust_aicpu.so";
    const int32_t ret = soManager.CheckAndCreateSoFile(&args, soName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndCreateSoFileSoNameNullptr)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/var/";
    LoadOpFromBufArgs args = {};
    char kernelSoBuf = 'a';
    args.kernelSoBufLen = 1UL;
    args.kernelSoBuf = reinterpret_cast<uint64_t>(&kernelSoBuf);
    args.kernelSoName = 0UL;
    std::string soName = "libcust_aicpu.so";
    const int32_t ret = soManager.CheckAndCreateSoFile(&args, soName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndDeleteSoFileSoPathFailed)
{
    AicpuCustSoManager soManager;
    LoadOpFromBufArgs args = {};
    args.kernelSoBuf = 0UL;
    const int32_t ret = soManager.CheckAndDeleteSoFile(&args);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndDeleteSoFileArgsNullptr)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/var/";
    const int32_t ret = soManager.CheckAndDeleteSoFile(nullptr);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndDeleteSoFileSoNameNullptr)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/var/";
    LoadOpFromBufArgs args = {};
    args.kernelSoBuf = 0UL;
    args.kernelSoName = 0U;
    args.kernelSoNameLen = 1U;
    const int32_t ret = soManager.CheckAndDeleteSoFile(&args);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndDeleteSoFileSoPathInvalid)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/var/";
    LoadOpFromBufArgs args = {};
    std::string soName = "aa";
    args.kernelSoNameLen = soName.size();
    args.kernelSoName = PtrToValue(soName.data());
    args.kernelSoBuf = 0UL;
    MOCKER_CPP(&AicpuCustSoManager::CheckCustSoPath).stubs().will(returnValue(true));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(1));
    const int32_t ret = soManager.CheckAndDeleteSoFile(&args);
    EXPECT_EQ(ret, 1);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndDeleteCustSoDirPathFailed)
{
    AicpuCustSoManager soManager;
    const int32_t ret = soManager.CheckAndDeleteCustSoDir();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileSoNameInvalid)
{
    AicpuCustSoManager soManager;
    const char buf;
    const size_t bufLen = 1;
    const std::string soName = "?????";
    FileInfo fileInfo = {.data = &buf, .size = bufLen, .name = soName};
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
}

TEST_F(AicpuCustSoManagerTEST, GetPathForCustAicpuSoVfId)
{
    AicpuCustSoManager soManager;
    soManager.runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;
    std::string dirName = "tmp";
    MOCKER_CPP(&AicpuDrvManager::GetUniqueVfId).stubs().will(returnValue(5));
    const int32_t ret = soManager.GetDirForCustAicpuSo(dirName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckSoFullPathValidPathTooLong)
{
    AicpuCustSoManager soManager;
    const std::string dirName(PATH_MAX + 1, 'A');
    const int32_t ret = soManager.CheckSoFullPathValid(dirName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckSoFullPathValidPathInvalid)
{
    AicpuCustSoManager soManager;
    const std::string dirName(10, 'A');
    const int32_t ret = soManager.CheckSoFullPathValid(dirName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckSoFullPathValidSuccess)
{
    AicpuCustSoManager soManager;
    std::string dirName("/");
    MOCKER(realpath).stubs().will(returnValue(const_cast<char*>(dirName.data())));
    const int32_t ret = soManager.CheckSoFullPathValid(dirName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, DeleteCustSoDirPathInvalid)
{
    AicpuCustSoManager soManager;
    const int32_t ret = soManager.DeleteCustSoDir();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, DeleteCustSoDirPathSuccess)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/aicpu_test";
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuUtil::ExecuteCmd).stubs().will(returnValue(0));
    const int32_t ret = soManager.DeleteCustSoDir();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, RemoveSoFileAccessFail)
{
    AicpuCustSoManager soManager;
    const std::string dirName = "/aicpu_test";
    const std::string soFullPath = "/aicpu_test";

    MOCKER(access).stubs().will(returnValue(-1));
    const int32_t ret = soManager.RemoveSoFile(dirName, soFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, RemoveSoFileChmodFail)
{
    AicpuCustSoManager soManager;
    const std::string dirName = "/aicpu_test";
    const std::string soFullPath = "/aicpu_test";

    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(-1));
    const int32_t ret = soManager.RemoveSoFile(dirName, soFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, RemoveSoFileRemoveFail)
{
    AicpuCustSoManager soManager;
    const std::string dirName = "/aicpu_test";
    const std::string soFullPath = "/aicpu_test";

    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(0));
    MOCKER(remove).stubs().will(returnValue(-1));
    const int32_t ret = soManager.RemoveSoFile(dirName, soFullPath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, DeleteSoFileRemoveFileFail)
{
    AicpuCustSoManager soManager;
    soManager.runMode_ = aicpu::AicpuRunMode::THREAD_MODE;

    MOCKER_CPP(&AicpuCustSoManager::RemoveSoFile)
        .stubs()
        .will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_ERROR_INNER_ERROR)));
    const int32_t ret = soManager.DeleteSoFile("/home/home/home", "soFullPath");
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, DeleteSoFileCloseFail)
{
    AicpuCustSoManager soManager;
    soManager.runMode_ = aicpu::AicpuRunMode::THREAD_MODE;

    MOCKER_CPP(&AicpuCustSoManager::RemoveSoFile).stubs().will(returnValue(static_cast<int32_t>(AICPU_SCHEDULE_OK)));
    MOCKER(aeCloseSo).stubs().will(returnValue(AE_STATUS_BAD_PARAM));
    const int32_t ret = soManager.DeleteSoFile("/home/home/home", "soFullPath");
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, CheckDirEmptyDirNullptr)
{
    AicpuCustSoManager soManager;
    const bool ret = soManager.CheckDirEmpty("/aicputesttesttest");
    EXPECT_EQ(ret, false);
}

TEST_F(AicpuCustSoManagerTEST, CheckOrMakeDirectoryMkdirFail)
{
    AicpuCustSoManager soManager;
    MOCKER(mkdir).stubs().will(returnValue(-1));
    const int32_t ret = soManager.CheckOrMakeDirectory("/aicpu_test/aicpu_test");
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckOrMakeDirectoryChmodFail)
{
    AicpuCustSoManager soManager;
    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(-1));
    const int32_t ret = soManager.CheckOrMakeDirectory("/aicpu_test/aicpu_test");
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, GetPathForCustAicpuSoThreadDirEmpty)
{
    AicpuCustSoManager soManager;
    soManager.runMode_ = aicpu::AicpuRunMode::THREAD_MODE;

    setenv(ENV_NAME_CUST_SO_PATH.c_str(), "", 1);
    std::string dirName = "";
    const int32_t ret = soManager.GetDirForCustAicpuSo(dirName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    unsetenv(ENV_NAME_CUST_SO_PATH.c_str());
}

TEST_F(AicpuCustSoManagerTEST, GetPathForCustAicpuSoThreadGetEnvFail)
{
    AicpuCustSoManager soManager;
    soManager.runMode_ = aicpu::AicpuRunMode::THREAD_MODE;

    MOCKER_CPP(&AicpuUtil::GetEnvVal).stubs().will(returnValue(false));
    std::string dirName = "";
    const int32_t ret = soManager.GetDirForCustAicpuSo(dirName);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, WriteBufToSoFileMkdirFail)
{
    AicpuCustSoManager soManager;
    FileInfo fileInfo = {.data = nullptr, .size = 0, .name = "libtest.so"};
    std::string filePath = "/tmp/libtest.so";
    const int32_t ret = soManager.WriteBufToSoFile(fileInfo, filePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, WriteBufToSoFileCheckPathFail)
{
    AicpuCustSoManager soManager;

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(0));
    FileInfo fileInfo = {.data = nullptr, .size = 0, .name = "libtest.so"};
    std::string filePath = "/tmp/libtest.so";
    const int32_t ret = soManager.WriteBufToSoFile(fileInfo, filePath);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, WriteBufToSoFileFlushFail)
{
    AicpuCustSoManager soManager;
    char buf[] = "abc";
    const std::string soPath = "/tmp/aicpu_flush_fail.so";
    FileInfo fileInfo = {.data = buf, .size = sizeof(buf) - 1U, .name = soPath};

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(access).stubs().will(returnValue(-1));
    MOCKER_CPP(&std::ofstream::good).stubs().will(returnValue(true)).then(returnValue(false));

    const int32_t ret = soManager.WriteBufToSoFile(fileInfo, "/tmp");
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
    (void)remove(soPath.c_str());
}

TEST_F(AicpuCustSoManagerTEST, WriteBufToSoFileSuccess)
{
    AicpuCustSoManager soManager;
    char tmpDirTemplate[] = "/tmp/aicpu_cust_so_ut_XXXXXX";
    char* tmpDir = mkdtemp(tmpDirTemplate);
    ASSERT_NE(tmpDir, nullptr);

    const char buf[] = "abc";
    const std::string soPath = std::string(tmpDir) + "/libtest.so";
    FileInfo fileInfo = {.data = const_cast<char*>(buf), .size = sizeof(buf) - 1U, .name = soPath};

    const int32_t ret = soManager.WriteBufToSoFile(fileInfo, std::string(tmpDir));
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(access(soPath.c_str(), F_OK), 0);

    (void)remove(soPath.c_str());
    (void)remove(tmpDir);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileWriteFail)
{
    AicpuCustSoManager soManager;
    FileInfo fileInfo = {.data = nullptr, .size = 0, .name = "libtest.so"};
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CheckAndDeleteCustSoDirRemoveFail)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/aicpu1testtesttest";

    MOCKER_CPP(&AicpuCustSoManager::CheckCustSoPath).stubs().will(returnValue(true));
    MOCKER_CPP(&AicpuCustSoManager::CheckDirEmpty).stubs().will(returnValue(true));
    MOCKER(remove).stubs().will(returnValue(-1));
    const int32_t ret = soManager.CheckAndDeleteCustSoDir();
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileInPcieMode)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/home/CustAiCpuUser/cust_aicpu_0_0_238463/";
    soManager.runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;

    const char buf = 'a';
    const size_t bufLen = 1;
    FileInfo fileInfo = {.data = &buf, .size = bufLen, .name = "libtest.so"};

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileInPcieModeFindSameFile)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/home/CustAiCpuUser/cust_aicpu_0_0_238463/";
    soManager.runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;

    const char buf = 'a';
    const size_t bufLen = 1;
    FileInfo fileInfo = {.data = &buf, .size = bufLen, .name = "libtest.so"};

    const uint64_t hashVal = HashCalculator::GetQuickHash(&buf, bufLen);
    FileHashInfo hashInfo = {.filePath = "libtest.so", .fileSize = bufLen, .hashValue = hashVal};
    soManager.hashCalculator_.cache_.emplace_back(hashInfo);

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(access).stubs().will(returnValue(0)).then(returnValue(1));
    MOCKER(symlink).stubs().will(returnValue(0));
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileInPcieModeFindSameFileSoNotExist)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/home/CustAiCpuUser/cust_aicpu_0_0_238463/";
    soManager.runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;

    const char buf = 'a';
    const size_t bufLen = 1;
    FileInfo fileInfo = {.data = &buf, .size = bufLen, .name = "libtest.so"};

    const uint64_t hashVal = HashCalculator::GetQuickHash(&buf, bufLen);
    FileHashInfo hashInfo = {.filePath = "libtest.so", .fileSize = bufLen, .hashValue = hashVal};
    soManager.hashCalculator_.cache_.emplace_back(hashInfo);

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(access).stubs().will(returnValue(1));
    MOCKER(symlink).stubs().will(returnValue(0));
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileInPcieModeFindSameFileLinkExist)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/home/CustAiCpuUser/cust_aicpu_0_0_238463/";
    soManager.runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;

    const char buf = 'a';
    const size_t bufLen = 1;
    FileInfo fileInfo = {.data = &buf, .size = bufLen, .name = "libtest.so"};

    const uint64_t hashVal = HashCalculator::GetQuickHash(&buf, bufLen);
    FileHashInfo hashInfo = {.filePath = "libtest.so", .fileSize = bufLen, .hashValue = hashVal};
    soManager.hashCalculator_.cache_.emplace_back(hashInfo);

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(0));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(access).stubs().will(returnValue(0));
    MOCKER(symlink).stubs().will(returnValue(0));
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
}

TEST_F(AicpuCustSoManagerTEST, CreateSoFileInPcieModeFindSameFileCheckDirFailed)
{
    AicpuCustSoManager soManager;
    soManager.custSoDirName_ = "/home/CustAiCpuUser/cust_aicpu_0_0_238463/";
    soManager.runMode_ = aicpu::AicpuRunMode::PROCESS_PCIE_MODE;

    const char buf = 'a';
    const size_t bufLen = 1;
    FileInfo fileInfo = {.data = &buf, .size = bufLen, .name = "libtest.so"};

    const uint64_t hashVal = HashCalculator::GetQuickHash(&buf, bufLen);
    FileHashInfo hashInfo = {.filePath = "libtest.so", .fileSize = bufLen, .hashValue = hashVal};
    soManager.hashCalculator_.cache_.emplace_back(hashInfo);

    MOCKER_CPP(&AicpuCustSoManager::CheckOrMakeDirectory).stubs().will(returnValue(AICPU_SCHEDULE_ERROR_INNER_ERROR));
    MOCKER_CPP(&AicpuCustSoManager::CheckSoFullPathValid).stubs().will(returnValue(0));
    MOCKER(access).stubs().will(returnValue(0)).then(returnValue(1));
    MOCKER(symlink).stubs().will(returnValue(0));
    const int32_t ret = soManager.CreateSoFile(fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, TestQuickHash)
{
    std::string data = "aaaaaaaaaaaaaaaaa";
    uint64_t hash = HashCalculator::GetQuickHash(data.c_str(), data.size());
    EXPECT_EQ(hash, 12846934374798548220);
}

TEST_F(AicpuCustSoManagerTEST, GenerateFileHashInfoFail)
{
    HashCalculator calculator;

    const std::string filePath = "libtest.so";
    FileHashInfo fileInfo = {};
    MOCKER(stat).stubs().will(returnValue(0));
    const int32_t ret = calculator.GenerateFileHashInfo(filePath, fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, GenerateFileHashInfoOpFileFail)
{
    HashCalculator calculator;

    const std::string filePath = "libtest.so";
    FileHashInfo fileInfo = {};
    MOCKER(stat).stubs().will(returnValue(0));
    MOCKER_CPP(&HashCalculator::IsRegularFile).stubs().will(returnValue(true));
    const int32_t ret = calculator.GenerateFileHashInfo(filePath, fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_INNER_ERROR);
}

TEST_F(AicpuCustSoManagerTEST, IsFileInCacheSuccess)
{
    HashCalculator calculator;
    FileHashInfo fileInfo = {.filePath = "test"};
    calculator.cache_.emplace_back(fileInfo);
    EXPECT_TRUE(calculator.IsFileInCache("test"));
    EXPECT_FALSE(calculator.IsFileInCache("test1"));
}

TEST_F(AicpuCustSoManagerTEST, FileLockerSuccessTest)
{
    CustSoFileLock fileLock;
    fileLock.locker_ = 1;

    MOCKER(flock).stubs().will(returnValue(0));
    MOCKER(close).stubs().will(returnValue(0));
    fileLock.LockFileLocker();
    fileLock.UnlockFileLocker();
}

TEST_F(AicpuCustSoManagerTEST, FileLockerFailTest)
{
    CustSoFileLock fileLock;
    fileLock.locker_ = 1;

    MOCKER(flock).stubs().will(returnValue(-1));
    MOCKER(close).stubs().will(returnValue(-1));
    fileLock.LockFileLocker();
    fileLock.UnlockFileLocker();
}

TEST_F(AicpuCustSoManagerTEST, GenerateFileHashInfoSuccess)
{
    const std::string tempDir = MakeTempDir();
    ASSERT_FALSE(tempDir.empty());
    const std::string filePath = tempDir + "/libtest.so";
    {
        std::ofstream file(filePath, std::ios::binary);
        file << "hash-data";
    }

    HashCalculator calculator;
    FileHashInfo fileInfo = {};
    const int32_t ret = calculator.GenerateFileHashInfo(filePath, fileInfo);
    EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
    EXPECT_EQ(fileInfo.filePath, filePath);
    EXPECT_EQ(fileInfo.fileSize, strlen("hash-data"));

    RemoveTempDir(tempDir);
}

TEST_F(AicpuCustSoManagerTEST, UpdateCacheWithRealFile)
{
    const std::string tempDir = MakeTempDir();
    ASSERT_FALSE(tempDir.empty());
    const std::string rootPath = tempDir + "/";
    const std::string libDir = rootPath + "lib";
    ASSERT_EQ(mkdir(libDir.c_str(), 0750), 0);
    const std::string filePath = libDir + "/libcache.so";
    {
        std::ofstream file(filePath, std::ios::binary);
        file << "cache-data";
    }

    HashCalculator calculator;
    calculator.soRootPath_ = rootPath;

    std::vector<std::string> fileNames;
    EXPECT_EQ(calculator.GetFileNameInDir(fileNames), AICPU_SCHEDULE_OK);
    ASSERT_FALSE(fileNames.empty());

    calculator.UpdateCache();
    EXPECT_TRUE(calculator.IsFileInCache(filePath));

    const size_t cacheSize = calculator.cache_.size();
    calculator.UpdateCache();
    EXPECT_EQ(calculator.cache_.size(), cacheSize);

    RemoveTempDir(tempDir);
}
