/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "trace_recorder.h"
#include "trace_attr.h"
#include "adiag_utils.h"
#include <pwd.h>
#include "mmpa_api.h"
#include "trace_types.h"
#include "trace_system_api.h"
#include <atomic>
#include <cerrno>
#include <fcntl.h>
#include <string>
#include <sys/stat.h>
#include <vector>

#define TIMESTAMP_MAX_LENGTH 29U

static std::atomic<uint32_t> g_traceOpenCallIndex(0);
static std::atomic<bool> g_firstTraceOpenEntered(false);
static std::atomic<bool> g_allowFirstTraceOpen(false);
static std::atomic<bool> g_agingThreadDone(false);
static std::atomic<uint32_t> g_strcpyCallIndex(0);

typedef struct {
    TraceDirInfo dirInfo;
    TraceFileInfo fileInfo;
    char dirTime[TIMESTAMP_MAX_LENGTH];
    TraStatus ret;
    int32_t fd;
    int32_t err;
} TraceGetFdThreadArg;

typedef struct {
    bool success;
} TraceAgingThreadArg;

const char *GetSafeDirTime(uint32_t index)
{
    static const char *const dirTimes[] = {
        "19701111111111111111", "19701111111111111112", "19701111111111111113",
        "19701111111111111114", "19701111111111111115", "19701111111111111116",
        "19701111111111111117", "19701111111111111118", "19701111111111111119",
        "19701111111111111121", "19701111111111111122", "19701111111111111123",
        "19701111111111111124", "19701111111111111125", "19701111111111111126",
        "19701111111111111127", "19701111111111111128", "19701111111111111129",
        "19701111111111111131", "19701111111111111132", "19701111111111111133"
    };
    return dirTimes[index];
}

int32_t TraceOpenBlockFirstThenOpen(const char *filePath, int32_t flag, uint32_t mode)
{
    uint32_t callIndex = g_traceOpenCallIndex.fetch_add(1);
    if (callIndex == 0U) {
        g_firstTraceOpenEntered.store(true);
        while (!g_allowFirstTraceOpen.load()) {
            usleep(1000);
        }
    }

    int32_t fd = open(filePath, flag, mode);
    if (fd >= 0) {
        (void)fchmod(fd, mode);
    }
    return fd;
}

TraStatus TraceHandleEmptyEnvStringStub(const char *env, char *buf, uint32_t len)
{
    (void)env;
    if ((buf == nullptr) || (len == 0U)) {
        return TRACE_FAILURE;
    }
    buf[0] = '\0';
    return TRACE_SUCCESS;
}

TraStatus TraceHandleRelativeEnvStringStub(const char *env, char *buf, uint32_t len)
{
    (void)env;
    const char relativePath[] = "trace_recorder_copy_failed_path";
    if ((buf == nullptr) || (len <= strlen(relativePath))) {
        return TRACE_FAILURE;
    }
    errno_t ret = memcpy_s(buf, len, relativePath, strlen(relativePath) + 1U);
    return (ret == EOK) ? TRACE_SUCCESS : TRACE_FAILURE;
}

errno_t StrcpyFailOnceThenCopy(char *strDest, size_t destMax, const char *strSrc)
{
    if (g_strcpyCallIndex.fetch_add(1U) == 0U) {
        return EINVAL;
    }
    if ((strDest == nullptr) || (strSrc == nullptr) || (destMax == 0U) || (strlen(strSrc) >= destMax)) {
        return EINVAL;
    }
    errno_t ret = memcpy_s(strDest, destMax, strSrc, strlen(strSrc) + 1U);
    return (ret == EOK) ? EOK : EINVAL;
}

void *TraceRecorderGetFdThread(void *arg)
{
    TraceGetFdThreadArg *threadArg = static_cast<TraceGetFdThreadArg *>(arg);
    errno = 0;
    threadArg->ret = TraceRecorderGetFd(&threadArg->dirInfo, &threadArg->fileInfo, &threadArg->fd);
    threadArg->err = errno;
    if (threadArg->fd >= 0) {
        close(threadArg->fd);
    }
    return NULL;
}

void *TraceRecorderCreateAgingDirsThread(void *arg)
{
    TraceAgingThreadArg *threadArg = static_cast<TraceAgingThreadArg *>(arg);
    threadArg->success = true;
    for (uint32_t i = 0; i < 10U; i++) {
        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), GetSafeDirTime(i), true };
        TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "other", TRACE_FILE_TXT_SUFFIX };
        int32_t fd = -1;
        if (TraceRecorderGetFd(&dirInfo, &fileInfo, &fd) != TRACE_SUCCESS) {
            threadArg->success = false;
            break;
        }
        close(fd);
    }
    g_agingThreadDone.store(true);
    return NULL;
}

bool BuildRecorderDirPath(char *path, size_t len, const char *eventName, const char *dirTime)
{
    int32_t ret = snprintf_s(path, len, len - 1U, "%s/atrace/trace_%d_%d_%s/%s_event_%d_%s",
        LLT_TEST_DIR, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime(), eventName, getpid(), dirTime);
    return ret != -1;
}

bool BuildRecorderFilePath(char *path, size_t len, const char *eventName, const char *dirTime,
    const char *tracerName, const char *objName, const char *suffix)
{
    char dirPath[MAX_FULLPATH_LEN + 1U] = {0};
    if (!BuildRecorderDirPath(dirPath, MAX_FULLPATH_LEN + 1U, eventName, dirTime)) {
        return false;
    }
    int32_t ret = snprintf_s(path, len, len - 1U, "%s/%s_tracer_%s%s", dirPath, tracerName, objName, suffix);
    return ret != -1;
}

bool BuildRecorderFilePathWithRoot(char *path, size_t len, const char *rootPath, const char *eventName,
    const char *dirTime, const char *tracerName, const char *objName, const char *suffix)
{
    int32_t ret = snprintf_s(path, len, len - 1U, "%s/atrace/trace_%d_%d_%s/%s_event_%d_%s/%s_tracer_%s%s",
        rootPath, TraceAttrGetPgid(), TraceAttrGetPid(), TraceAttrGetTime(), eventName, getpid(), dirTime,
        tracerName, objName, suffix);
    return ret != -1;
}

std::string BuildNestedRelativePathForAbsLength(size_t targetAbsLen)
{
    char cwd[TRACE_MAX_PATH] = {0};
    if (getcwd(cwd, sizeof(cwd)) == nullptr) {
        return "";
    }
    const size_t cwdLen = strlen(cwd);
    std::string relativeDir = "trace_recorder_long_path_ut";
    if (targetAbsLen < cwdLen + 1U + relativeDir.size()) {
        return "";
    }
    const std::string segment = "/segment_for_trace_recorder";
    while (cwdLen + 1U + relativeDir.size() + segment.size() <= targetAbsLen) {
        relativeDir += segment;
    }
    const size_t currentAbsLen = cwdLen + 1U + relativeDir.size();
    if (currentAbsLen < targetAbsLen) {
        if (!relativeDir.empty()) {
            relativeDir += "/";
        }
        relativeDir += std::string(targetAbsLen - currentAbsLen - 1U, 'x');
    }
    return relativeDir;
}

TEST(TraceRecorderPathHelperTest, BuildNestedRelativePathRejectsDeepCwd)
{
    char cwd[TRACE_MAX_PATH] = {0};
    ASSERT_NE(nullptr, getcwd(cwd, sizeof(cwd)));
    const size_t tooShortForInitialDir = strlen(cwd) + strlen("/trace_recorder_long_path_ut") - 1U;
    EXPECT_TRUE(BuildNestedRelativePathForAbsLength(tooShortForInitialDir).empty());
}

TEST(TraceRecorderPathLimitTest, RecorderPathLimitsReserveFinalFileName)
{
    EXPECT_LT(static_cast<size_t>(MAX_FILEDIR_LEN), static_cast<size_t>(MAX_FILEPATH_LEN));
    EXPECT_LT(static_cast<size_t>(MAX_FILEPATH_LEN), static_cast<size_t>(MAX_FULLPATH_LEN));
    EXPECT_LE(static_cast<size_t>(MAX_FILEPATH_LEN) + static_cast<size_t>(TRACE_RECORDER_FILE_RESERVED_LEN),
        static_cast<size_t>(MAX_FULLPATH_LEN));
}

void RemoveTestPath(const std::string &path)
{
    if (path.empty()) {
        return;
    }
    std::string cmd = "rm -rf " + path;
    (void)system(cmd.c_str());
}

class ScopedEnvAndPathCleanup {
public:
    explicit ScopedEnvAndPathCleanup(const char *envName) : envName_(envName)
    {
    }

    ~ScopedEnvAndPathCleanup()
    {
        unsetenv(envName_);
        for (auto iter = cleanupPaths_.rbegin(); iter != cleanupPaths_.rend(); ++iter) {
            RemoveTestPath(*iter);
        }
    }

    void AddPath(const std::string &path)
    {
        cleanupPaths_.push_back(path);
        RemoveTestPath(path);
    }

private:
    const char *envName_;
    std::vector<std::string> cleanupPaths_;
};

class TraceRecorderUtest: public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }

    virtual void SetUp()
    {
        system("mkdir -p " LLT_TEST_DIR "/ascend");
        struct passwd *pwd = getpwuid(getuid());
        pwd->pw_dir = LLT_TEST_DIR;
        MOCKER(getpwuid).stubs().will(returnValue(pwd));
        EXPECT_EQ(TRACE_SUCCESS, TraceAttrInit());
        EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    }

    virtual void TearDown()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
        TraceRecorderExit();
        TraceAttrExit();
        GlobalMockObject::verify();
    }

    static void TearDownTestCase()
    {
        system("rm -rf " LLT_TEST_DIR );
    }
};

void TestRecorderWrite(uint32_t dirNum, uint32_t fileNum, uint32_t msgNum, const char *suffix)
{
    for (uint32_t i = 0; i < dirNum; i++) {
        char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
        TraStatus ret = TimestampToFileStr(GetRealTime() + i * 100, timeStr, TIMESTAMP_MAX_LENGTH);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, TraceGetPid(), timeStr };
        printf("dir[%u] time = [%s]\n", i, timeStr);
        for (uint32_t j = 0; j < fileNum; j++) {
            std::string objName = "HCCL_" + std::to_string(i) + "_" + std::to_string(j);
            TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName.c_str(), suffix };
            int32_t fd = -1;
            ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
            EXPECT_EQ(TRACE_SUCCESS, ret);
            for (uint32_t k = 0; k < msgNum; k++) {
                std::string msg = "msg_" + std::to_string(k) + "\n";
                ret = TraceRecorderWrite(fd, msg.c_str(), msg.size() + 1);
                EXPECT_EQ(TRACE_SUCCESS, ret);
            }
            close(fd);
        }
    }
}

void *RecordTrace(void *arg)
{
    (void)arg;
    sleep(1);
    TestRecorderWrite(10, 1, 2, TRACE_FILE_TXT_SUFFIX);
    return NULL;
}

TEST_F(TraceRecorderUtest, TestRecord_Concurrent)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    int32_t threadNum = 10;
    pthread_t theadId[threadNum] = { 0 };

    for (int i = 0; i < threadNum; i++) {
        int32_t ret = pthread_create(&theadId[i], NULL, RecordTrace, NULL);
        EXPECT_EQ(0, ret);
    }

    for (int i = 0; i < threadNum; i++) {
        pthread_join(theadId[i], NULL);
    }
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordEnvPath)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    TestRecorderWrite(1, 1, 2, TRACE_FILE_TXT_SUFFIX);

    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePath)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    const std::string relativeDir = "trace_recorder_relative_path_ut";
    envGuard.AddPath(relativeDir);
    setenv("ASCEND_WORK_PATH", ("./" + relativeDir).c_str(), 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(0U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "relative", TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
    ASSERT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderWrite(fd, "relative", 8U));
    if (fd >= 0) {
        close(fd);
    }

    char cwd[MAX_FILEDIR_LEN + 1U] = {0};
    ASSERT_NE(nullptr, getcwd(cwd, sizeof(cwd)));
    std::string expectedRoot = std::string(cwd) + "/" + relativeDir;
    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePathWithRoot(filePath, MAX_FULLPATH_LEN + 1U, expectedRoot.c_str(),
        TRACER_SCHEDULE_NAME, dirTime, TRACER_SCHEDULE_NAME, "relative", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePathWithParentDir)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    const std::string parentDir = "trace_recorder_relative_dotdot_parent";
    const std::string targetDir = "trace_recorder_relative_dotdot_target";
    envGuard.AddPath(parentDir);
    envGuard.AddPath(targetDir);
    setenv("ASCEND_WORK_PATH", (parentDir + "/../" + targetDir).c_str(), 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(1U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "dotdot", TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
    ASSERT_EQ(TRACE_SUCCESS, ret);
    if (fd >= 0) {
        close(fd);
    }

    char cwd[MAX_FILEDIR_LEN + 1U] = {0};
    ASSERT_NE(nullptr, getcwd(cwd, sizeof(cwd)));
    std::string expectedRoot = std::string(cwd) + "/" + targetDir;
    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePathWithRoot(filePath, MAX_FULLPATH_LEN + 1U, expectedRoot.c_str(),
        TRACER_SCHEDULE_NAME, dirTime, TRACER_SCHEDULE_NAME, "dotdot", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePathAround240BytesWritesToEnvPath)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    const size_t issuePathLen = 240U;
    const std::string relativeDir = BuildNestedRelativePathForAbsLength(issuePathLen);
    ASSERT_FALSE(relativeDir.empty());
    envGuard.AddPath(relativeDir);
    setenv("ASCEND_WORK_PATH", ("./" + relativeDir).c_str(), 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(2U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "longpath", TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
    ASSERT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderWrite(fd, "longpath", 8U));
    if (fd >= 0) {
        close(fd);
    }

    char cwd[TRACE_MAX_PATH] = {0};
    ASSERT_NE(nullptr, getcwd(cwd, sizeof(cwd)));
    std::string expectedRoot = std::string(cwd) + "/" + relativeDir;
    ASSERT_EQ(issuePathLen, expectedRoot.size());
    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePathWithRoot(filePath, MAX_FULLPATH_LEN + 1U, expectedRoot.c_str(),
        TRACER_SCHEDULE_NAME, dirTime, TRACER_SCHEDULE_NAME, "longpath", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));
}

TEST_F(TraceRecorderUtest, TestRecordEnvEmptyPathFallbackToHome)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    setenv("ASCEND_WORK_PATH", "", 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(3U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "empty", TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
    ASSERT_EQ(TRACE_SUCCESS, ret);
    if (fd >= 0) {
        close(fd);
    }

    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePathWithRoot(filePath, MAX_FULLPATH_LEN + 1U, LLT_TEST_DIR "/ascend",
        TRACER_SCHEDULE_NAME, dirTime, TRACER_SCHEDULE_NAME, "empty", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));
}

TEST_F(TraceRecorderUtest, TestRecordEnvNormalizeEmptyBufferFallbackToHome)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    MOCKER(TraceHandleEnvString).stubs().will(invoke(TraceHandleEmptyEnvStringStub));
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePathGetcwdFailedFallbackToHome)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    setenv("ASCEND_WORK_PATH", "trace_recorder_getcwd_failed_path", 1);
    MOCKER(getcwd).stubs().will(returnValue((char *)nullptr));
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePathCopyFailedFallbackToHome)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    g_strcpyCallIndex.store(0U);
    MOCKER(TraceHandleEnvString).stubs().will(invoke(TraceHandleRelativeEnvStringStub));
    MOCKER(strcpy_s).stubs().will(invoke(StrcpyFailOnceThenCopy));
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePathMaxLengthInitSucceeds)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    std::string relativeDir = BuildNestedRelativePathForAbsLength(static_cast<size_t>(MAX_FILEDIR_LEN));
    ASSERT_FALSE(relativeDir.empty());
    envGuard.AddPath(relativeDir);
    setenv("ASCEND_WORK_PATH", relativeDir.c_str(), 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    EXPECT_EQ(0, access(relativeDir.c_str(), F_OK));

    const char *dirTime = GetSafeDirTime(14U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "rootmax", TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
    ASSERT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderWrite(fd, "rootmax", 7U));
    if (fd >= 0) {
        close(fd);
    }

    const char *safeDirTime = GetSafeDirTime(15U);
    TraceDirInfo safeDirInfo = { TRACER_STACKCORE_NAME, getpid(), safeDirTime, false };
    TraceFileInfo safeFileInfo = { TRACER_STACKCORE_NAME, "safemax", TRACE_FILE_TXT_SUFFIX };
    int32_t safeFd = -1;
    ret = TraceRecorderSafeGetFd(&safeDirInfo, &safeFileInfo, &safeFd);
    ASSERT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderWrite(safeFd, "safemax", 7U));
    if (safeFd >= 0) {
        close(safeFd);
    }
}

TEST_F(TraceRecorderUtest, TestRecordEnvRelativePathTooLongFallbackToHome)
{
    TraceRecorderExit();
    ScopedEnvAndPathCleanup envGuard("ASCEND_WORK_PATH");
    std::string relativeDir = BuildNestedRelativePathForAbsLength(static_cast<size_t>(MAX_FILEDIR_LEN) + 1U);
    ASSERT_FALSE(relativeDir.empty());
    envGuard.AddPath(relativeDir);
    setenv("ASCEND_WORK_PATH", relativeDir.c_str(), 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    EXPECT_NE(0, access(relativeDir.c_str(), F_OK));
}

TEST_F(TraceRecorderUtest, TestRecordEnvInvalidPath)
{
    printf("path doesn't exist, then create it successfully.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    printf("path doesn't exist, then create it failed.\n");
    TraceRecorderExit();
    system("rm -rf " LLT_TEST_DIR "/env");
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("path doesn't have permission to write.\n");
    TraceRecorderExit();
    MOCKER(TraceAccess).stubs().will(returnValue(-1));
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    unsetenv("ASCEND_WORK_PATH");
}


TEST_F(TraceRecorderUtest, TestRecordEnv_MkdirRecurFailed)
{
    printf("path doesn't exist, then create it.\n");
    printf("strdup failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(strdup).stubs().will(returnValue((char *)0));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("snprintf_s failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("strncat_s failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(strncat_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();

    printf("mkdir failed.\n");
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR "/env/", 1);
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());
    GlobalMockObject::verify();
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordRealPathFailed)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    MOCKER(mmRealPath).stubs().will(returnValue(EN_ERROR));
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    TraceRecorderExit();
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TestRecordHomePath)
{
    TestRecorderWrite(1, 1, 2, TRACE_FILE_TXT_SUFFIX);
}

TEST_F(TraceRecorderUtest, TestGetDirMkdirFailed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    int testNum = 4;
    for (int i = 0 ; i < testNum; i++) {
        MOCKER(mkdir)
            .stubs()
            .will(repeat(0, i))
            .then(returnValue(-1));
        MOCKER(access).stubs().will(returnValue(-1));
        MOCKER(chown).stubs().will(returnValue(0));
        MOCKER(chmod).stubs().will(returnValue(0));
        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), timeStr };
        const TraceDirNode *dir = TraceRecorderGetDirPath(&dirInfo);
        EXPECT_EQ((const TraceDirNode *)0, dir);
        GlobalMockObject::verify();
    }
}

TEST_F(TraceRecorderUtest, TestSafeGetFdMkdirFailed)
{
    MOCKER(mkdir)
        .stubs()
        .will(returnValue(-1));
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, getpid(), dirTimeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", TRACE_FILE_TXT_SUFFIX };
    int32_t fd;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceRecorderUtest, TestSafeGetFd)
{
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, getpid(), dirTimeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", TRACE_FILE_TXT_SUFFIX };
    int32_t fd;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(TraceRecorderUtest, TestSafeGetFdLongObjNameWithinFullPathSucceeds)
{
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), dirTimeStr };
    std::string objName(TRACE_RECORDER_FILE_RESERVED_LEN + 1U, 'a');
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, objName.c_str(), TRACE_FILE_TXT_SUFFIX };
    char dirPath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderSafeGetDirPath(&dirInfo, dirPath, MAX_FULLPATH_LEN + 1U));
    ASSERT_LT(strlen(dirPath) + strlen("/") + strlen(fileInfo.tracerName) + strlen("_tracer_") + objName.size() +
        strlen(fileInfo.suffix), static_cast<size_t>(MAX_FULLPATH_LEN));

    int32_t fd = -1;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    if (fd >= 0) {
        close(fd);
    }
}

TEST_F(TraceRecorderUtest, TestSafeGetBinFd)
{
    char dirTimeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), dirTimeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = {  TRACER_STACKCORE_NAME, getpid(), dirTimeStr};
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", TRACE_FILE_TXT_SUFFIX };
    int32_t fd;
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_SUCCESS, ret);
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_Failed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), timeStr };
    TraceFileInfo info = { TRACER_SCHEDULE_NAME,  "ts_0", ".txt" };
    int32_t fd = -1;
    MOCKER(TraceRecorderGetDirPath).stubs().will(returnValue((const TraceDirNode *)0));
    ret = TraceRecorderGetFd(&dirInfo, &info, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_SameDirAgingKeepsWritable)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    setenv("ASCEND_TRACE_RECORD_NUM", "10", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);

    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), timeStr, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "ts_0", TRACE_FILE_TXT_SUFFIX };
    for (uint32_t i = 0; i < 11U; i++) {
        int32_t fd = -1;
        ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        close(fd);
    }

    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePath(filePath, MAX_FULLPATH_LEN + 1U, TRACER_SCHEDULE_NAME, timeStr,
        TRACER_SCHEDULE_NAME, "ts_0", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));

    unsetenv("ASCEND_TRACE_RECORD_NUM");
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_ConcurrentDirAgingKeepsFirstOpen)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    setenv("ASCEND_TRACE_RECORD_NUM", "10", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    g_traceOpenCallIndex.store(0);
    g_firstTraceOpenEntered.store(false);
    g_allowFirstTraceOpen.store(false);
    g_agingThreadDone.store(false);
    MOCKER(TraceOpen).stubs().will(invoke(TraceOpenBlockFirstThenOpen));

    TraceGetFdThreadArg firstArg = {};
    int32_t ret = snprintf_s(firstArg.dirTime, TIMESTAMP_MAX_LENGTH, TIMESTAMP_MAX_LENGTH - 1U,
        "%s", GetSafeDirTime(10U));
    EXPECT_NE(-1, ret);
    firstArg.dirInfo = { TRACER_SCHEDULE_NAME, getpid(), firstArg.dirTime, true };
    firstArg.fileInfo = { TRACER_SCHEDULE_NAME, "first", TRACE_FILE_TXT_SUFFIX };
    firstArg.fd = -1;
    firstArg.ret = TRACE_SUCCESS;
    firstArg.err = 0;

    pthread_t threadId = 0;
    EXPECT_EQ(0, pthread_create(&threadId, NULL, TraceRecorderGetFdThread, &firstArg));
    for (uint32_t i = 0; i < 5000U && !g_firstTraceOpenEntered.load(); i++) {
        usleep(1000);
    }
    ASSERT_TRUE(g_firstTraceOpenEntered.load());

    TraceAgingThreadArg agingArg = { true };
    pthread_t agingThreadId = 0;
    EXPECT_EQ(0, pthread_create(&agingThreadId, NULL, TraceRecorderCreateAgingDirsThread, &agingArg));
    usleep(100000);
    EXPECT_FALSE(g_agingThreadDone.load());

    g_allowFirstTraceOpen.store(true);
    EXPECT_EQ(0, pthread_join(threadId, NULL));
    EXPECT_EQ(0, pthread_join(agingThreadId, NULL));
    EXPECT_EQ(TRACE_SUCCESS, firstArg.ret);
    EXPECT_GE(firstArg.fd, 0);
    EXPECT_TRUE(agingArg.success);

    GlobalMockObject::verify();
    unsetenv("ASCEND_TRACE_RECORD_NUM");
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_WriteCreatesExpectedFile)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(4U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "normal", TRACE_FILE_TXT_SUFFIX };
    int32_t fd = -1;
    auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderWrite(fd, "abc", 3U));
    close(fd);

    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePath(filePath, MAX_FULLPATH_LEN + 1U, TRACER_SCHEDULE_NAME, dirTime,
        TRACER_SCHEDULE_NAME, "normal", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));

    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_SameDirWithinLimitKeepsWritable)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    setenv("ASCEND_TRACE_RECORD_NUM", "10", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(5U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "repeat", TRACE_FILE_TXT_SUFFIX };
    for (uint32_t i = 0; i < 2U; i++) {
        int32_t fd = -1;
        auto ret = TraceRecorderGetFd(&dirInfo, &fileInfo, &fd);
        EXPECT_EQ(TRACE_SUCCESS, ret);
        EXPECT_EQ(TRACE_SUCCESS, TraceRecorderWrite(fd, "x", 1U));
        close(fd);
    }

    char filePath[MAX_FULLPATH_LEN + 1U] = {0};
    ASSERT_TRUE(BuildRecorderFilePath(filePath, MAX_FULLPATH_LEN + 1U, TRACER_SCHEDULE_NAME, dirTime,
        TRACER_SCHEDULE_NAME, "repeat", TRACE_FILE_TXT_SUFFIX));
    EXPECT_EQ(0, access(filePath, F_OK));

    unsetenv("ASCEND_TRACE_RECORD_NUM");
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_UniqueDirAgingRemovesOldestOnly)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    setenv("ASCEND_TRACE_RECORD_NUM", "10", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    char dirPaths[11][MAX_FULLPATH_LEN + 1U] = {};
    for (uint32_t i = 0; i < 11U; i++) {
        const char *dirTime = GetSafeDirTime(i);
        ASSERT_TRUE(BuildRecorderDirPath(dirPaths[i], MAX_FULLPATH_LEN + 1U, TRACER_SCHEDULE_NAME, dirTime));

        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
        TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "unique", TRACE_FILE_TXT_SUFFIX };
        int32_t fd = -1;
        EXPECT_EQ(TRACE_SUCCESS, TraceRecorderGetFd(&dirInfo, &fileInfo, &fd));
        close(fd);
    }

    EXPECT_NE(0, access(dirPaths[0], F_OK));
    for (uint32_t i = 1; i < 11U; i++) {
        EXPECT_EQ(0, access(dirPaths[i], F_OK));
    }

    unsetenv("ASCEND_TRACE_RECORD_NUM");
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TraceRecorderGetFd_ReusedOldDirDoesNotRefreshAgingOrder)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    setenv("ASCEND_TRACE_RECORD_NUM", "10", 1);
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    char dirPaths[11][MAX_FULLPATH_LEN + 1U] = {};
    for (uint32_t i = 0; i < 10U; i++) {
        ASSERT_TRUE(BuildRecorderDirPath(dirPaths[i], MAX_FULLPATH_LEN + 1U, TRACER_SCHEDULE_NAME,
            GetSafeDirTime(i)));

        TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), GetSafeDirTime(i), true };
        TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "timestamp", TRACE_FILE_TXT_SUFFIX };
        int32_t fd = -1;
        EXPECT_EQ(TRACE_SUCCESS, TraceRecorderGetFd(&dirInfo, &fileInfo, &fd));
        close(fd);
    }

    TraceDirInfo reusedDirInfo = { TRACER_SCHEDULE_NAME, getpid(), GetSafeDirTime(0U), true };
    TraceFileInfo reusedFileInfo = { TRACER_SCHEDULE_NAME, "reuse", TRACE_FILE_TXT_SUFFIX };
    int32_t reusedFd = -1;
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderGetFd(&reusedDirInfo, &reusedFileInfo, &reusedFd));
    close(reusedFd);

    ASSERT_TRUE(BuildRecorderDirPath(dirPaths[10], MAX_FULLPATH_LEN + 1U, TRACER_SCHEDULE_NAME,
        GetSafeDirTime(10U)));

    TraceDirInfo newDirInfo = { TRACER_SCHEDULE_NAME, getpid(), GetSafeDirTime(10U), true };
    TraceFileInfo newFileInfo = { TRACER_SCHEDULE_NAME, "timestamp", TRACE_FILE_TXT_SUFFIX };
    int32_t newFd = -1;
    EXPECT_EQ(TRACE_SUCCESS, TraceRecorderGetFd(&newDirInfo, &newFileInfo, &newFd));
    close(newFd);

    EXPECT_NE(0, access(dirPaths[0], F_OK));
    for (uint32_t i = 1; i < 11U; i++) {
        EXPECT_EQ(0, access(dirPaths[i], F_OK));
    }

    unsetenv("ASCEND_TRACE_RECORD_NUM");
    unsetenv("ASCEND_WORK_PATH");
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_SecondDirectoryFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(6U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));

    testing::internal::CaptureStdout();
    const TraceDirNode *dir = TraceRecorderGetDirPath(&dirInfo);
    std::string output = testing::internal::GetCapturedStdout();

    EXPECT_EQ(nullptr, dir);
    EXPECT_NE(std::string::npos, output.find("create trace second directory failed"));
    EXPECT_NE(std::string::npos, output.find("stage=second_event_dir"));
    EXPECT_NE(std::string::npos, output.find("reason=mkdir"));
    EXPECT_NE(std::string::npos, output.find("rootPath="));
    EXPECT_NE(std::string::npos, output.find("dirPath="));
    EXPECT_NE(std::string::npos, output.find("dirPathLen="));
    EXPECT_NE(std::string::npos, output.find("limit="));
    GlobalMockObject::verify();
}

void ExpectGetDirPathFailureLog(const TraceDirInfo &dirInfo, const std::vector<std::string> &expected)
{
    testing::internal::CaptureStdout();
    const TraceDirNode *dir = TraceRecorderGetDirPath(&dirInfo);
    std::string output = testing::internal::GetCapturedStdout();

    EXPECT_EQ(nullptr, dir);
    for (const auto &text : expected) {
        EXPECT_NE(std::string::npos, output.find(text)) << output;
    }
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_RootDirectoryFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(7U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));

    ExpectGetDirPathFailureLog(dirInfo, {
        "create trace root directory failed", "stage=root_dir", "reason=mkdir", "rootPath=", "rootPathLen=", "limit="
    });
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_AtraceDirectorySnprintfFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(8U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));

    ExpectGetDirPathFailureLog(dirInfo, {
        "create trace atrace directory failed", "stage=atrace_dir", "reason=snprintf_s", "rootPath=", "limit="
    });
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_AtraceDirectoryMkdirFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(9U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS)).then(returnValue(TRACE_FAILURE));

    ExpectGetDirPathFailureLog(dirInfo, {
        "create trace atrace directory failed", "stage=atrace_dir", "reason=mkdir", "dirPath=", "dirPathLen=", "limit="
    });
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_FirstDirectorySnprintfFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(11U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(vsnprintf_s).stubs().will(returnValue(0)).then(returnValue(-1));

    ExpectGetDirPathFailureLog(dirInfo, {
        "create trace first directory failed", "stage=first_trace_dir", "reason=snprintf_s", "rootPath=", "limit="
    });
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_FirstDirectoryMkdirFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(12U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));

    ExpectGetDirPathFailureLog(dirInfo, {
        "create trace first directory failed", "stage=first_trace_dir", "reason=mkdir", "dirPath=", "dirPathLen=",
        "limit="
    });
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TraceRecorderGetDirPath_SecondDirectorySnprintfFailureLogsPathContext)
{
    TraceRecorderExit();
    setenv("ASCEND_WORK_PATH", LLT_TEST_DIR, 1);
    ASSERT_EQ(TRACE_SUCCESS, TraceRecorderInit());

    const char *dirTime = GetSafeDirTime(13U);
    TraceDirInfo dirInfo = { TRACER_SCHEDULE_NAME, getpid(), dirTime, true };
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    MOCKER(vsnprintf_s).stubs().will(returnValue(0)).then(returnValue(0)).then(returnValue(-1));

    ExpectGetDirPathFailureLog(dirInfo, {
        "create trace second directory failed", "stage=second_event_dir", "reason=snprintf_s", "rootPath=", "limit="
    });
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestTraceRecorderSafeGetFd_Failed)
{
    auto ret = TraceRecorderSafeGetFd(NULL, NULL, NULL);
    EXPECT_EQ(TRACE_INVALID_PARAM, ret);

    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), timeStr };
    TraceFileInfo fileInfo = { TRACER_SCHEDULE_NAME, "HCCL", ".txt" };
    int32_t fd = -1;
    TraStatus status = TRACE_FAILURE;

    MOCKER(TraceMkdir).stubs().will(returnValue(status));
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(status, ret);
    GlobalMockObject::verify();

    std::string tooLongObjName(MAX_FULLPATH_LEN, 'a');
    TraceFileInfo tooLongFileInfo = { TRACER_SCHEDULE_NAME, tooLongObjName.c_str(), ".txt" };
    ret = TraceRecorderSafeGetFd(&dirInfo, &tooLongFileInfo, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);

    MOCKER(TraceOpen).stubs().will(returnValue(-1));
    ret = TraceRecorderSafeGetFd(&dirInfo, &fileInfo, &fd);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestTraceRecorderSafeMkdirPath_Failed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), timeStr };

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs()
        .will(returnValue(0))
        .then(returnValue(-1));
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(vsnprintf_s).stubs()
        .will(returnValue(0))
        .then(returnValue(0))
        .then(returnValue(-1));
    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_SUCCESS));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs().will(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();

    MOCKER(TraceMkdir).stubs()
        .will(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_SUCCESS))
        .then(returnValue(TRACE_FAILURE));
    ret = TraceRecorderSafeMkdirPath(&dirInfo);
    EXPECT_EQ(TRACE_FAILURE, ret);
    GlobalMockObject::verify();
}

TEST_F(TraceRecorderUtest, TestTraceRecorderSafeGetDirPath_Failed)
{
    char timeStr[TIMESTAMP_MAX_LENGTH] = {0};
    auto ret = TimestampToFileStr(std::time(0), timeStr, TIMESTAMP_MAX_LENGTH);
    EXPECT_EQ(TRACE_SUCCESS, ret);
    TraceDirInfo dirInfo = { TRACER_STACKCORE_NAME, getpid(), timeStr };
    char path[1024] = {0};

    EXPECT_EQ(TRACE_INVALID_PARAM, TraceRecorderSafeGetDirPath(NULL, path, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceRecorderSafeGetDirPath(&dirInfo, NULL, 1024));
    EXPECT_EQ(TRACE_INVALID_PARAM, TraceRecorderSafeGetDirPath(&dirInfo, path, 0));

    MOCKER(vsnprintf_s).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceRecorderSafeGetDirPath(&dirInfo, path, 1024));
}
