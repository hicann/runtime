/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ANALYSIS_DVVP_COMMON_UTILS_UTILS_H
#define ANALYSIS_DVVP_COMMON_UTILS_UTILS_H

#include <cerrno>
#include <cstdio>
#include <fstream>
#include <memory>
#include <mutex>
#if (defined(linux) || defined(__linux__))
#include <netinet/in.h>
#include <netinet/ip.h>
#include <netinet/tcp.h>
#include <sys/socket.h>
#include <pwd.h>
#endif
#include <sstream>
#include <string>
#include <vector>
#include <cinttypes>
#include "errno/error_code.h"
#include "osal.h"
#include "msprof_dlog.h"
#include "msprof_error_manager.h"

template <typename T>
using SHARED_PTR_ALIA = std::shared_ptr<T>;

namespace analysis {
namespace dvvp {

struct ProfileFileChunk {
    bool isLastChunk;
    int32_t chunkModule;              // form FileChunkType
    size_t chunkSize;                 // chunk size
    size_t offset;                    // flush chunk to file by offset
    std::string chunk;                // chunk data
    std::string fileName;             // fulsh chunk to disks by "fileName.tag"
    std::string extraInfo;            // report data fill suffix enum "jobId.devId"
    std::string id;                   // Identify where chunk from "devId.devPid"
};

namespace common {
namespace utils {

#define MSVP_MAKE_SHARED0(instance, Type, action)                          \
    do {                                                                   \
        try {                                                              \
            instance = std::make_shared<Type>();                           \
        } catch (std::exception &ex) {                                     \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());     \
            action;                                                        \
        }                                                                  \
    } while (0)

#define MSVP_MAKE_SHARED1(instance, Type, args0, action)                          \
    do {                                                                          \
        try {                                                                     \
            instance = std::make_shared<Type>(args0);                             \
        } catch (std::exception &ex) {                                            \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());            \
            action;                                                               \
        }                                                                         \
    } while (0)

#define MSVP_MAKE_SHARED2(instance, Type, arg0, arg1, action)                          \
    do {                                                                               \
        try {                                                                          \
            instance = std::make_shared<Type>(arg0, arg1);                             \
        } catch (std::exception &ex) {                                                 \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                 \
            action;                                                                    \
        }                                                                              \
    } while (0)

#define MSVP_MAKE_SHARED3(instance, Type, arg0, arg1, arg2, action)                         \
    do {                                                                                    \
        try {                                                                               \
            instance = std::make_shared<Type>(arg0, arg1, arg2);                            \
        } catch (std::exception &ex) {                                                      \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                      \
            action;                                                                         \
        }                                                                                   \
    } while (0)

#define MSVP_MAKE_SHARED4(instance, Type, args0, args1, args2, args3, action)                  \
    do {                                                                                       \
        try {                                                                                  \
            instance = std::make_shared<Type>(args0, args1, args2, args3);                     \
        } catch (std::exception &ex) {                                                         \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                         \
            action;                                                                            \
        }                                                                                      \
    } while (0)

#define MSVP_MAKE_SHARED6(instance, Type,                                                       \
    arg1, arg2, arg3, arg4, arg5, arg6, action)                                                 \
    do {                                                                                        \
        try {                                                                                   \
            instance = std::make_shared<Type>(arg1, arg2, arg3, arg4, arg5, arg6);              \
        } catch (std::exception &ex) {                                                          \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                          \
            action;                                                                             \
        }                                                                                       \
    } while (0)

#define MSVP_MAKE_SHARED7(instance, Type,                                                       \
    arg0, arg1, arg2, arg3, arg4, arg5, arg6, action)                                           \
    do {                                                                                        \
        try {                                                                                   \
            instance = std::make_shared<Type>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);        \
        } catch (std::exception &ex) {                                                          \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                          \
            action;                                                                             \
        }                                                                                       \
    } while (0)

#define MSVP_MAKE_SHARED9(instance, Type,                                                                \
        arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, action)                                    \
        do {                                                                                             \
            try {                                                                                        \
                instance = std::make_shared<Type>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8); \
            } catch (std::exception &ex) {                                                               \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                                   \
                action;                                                                                  \
            }                                                                                            \
        } while (0)

#define MSVP_MAKE_SHARED_ARRAY(instance, Type, len, action)                                 \
    do {                                                                                    \
        try {                                                                               \
            instance = SHARED_PTR_ALIA<Type>(new Type[len], std::default_delete<Type[]>()); \
        } catch (std::exception &ex) {                                                      \
            MSPROF_LOGE("make shared failed, message: %s", ex.what());                      \
            action;                                                                         \
        }                                                                                   \
    } while (0)

#define MSVP_TRY_BLOCK(block, action)   \
    try {                               \
        block;                          \
    } catch (...) {                     \
        action;                         \
    }                                   \

#define MSVP_MAKE_SHARED0_NODO(instance, Type, action)                 \
    try {                                                              \
        instance = std::make_shared<Type>();                           \
    } catch (std::exception &ex) {                                     \
        MSPROF_LOGE("make shared failed, message: %s", ex.what());     \
        action;                                                        \
    }                                                                  \

#define MSVP_MAKE_SHARED1_NODO(instance, Type, args0, action)                 \
    try {                                                                     \
        instance = std::make_shared<Type>(args0);                             \
    } catch (std::exception &ex) {                                            \
        MSPROF_LOGE("make shared failed, message: %s", ex.what());            \
        action;                                                               \
    }                                                                         \

#define MSVP_MAKE_SHARED2_NODO(instance, Type, arg0, arg1, action)                 \
    try {                                                                          \
        instance = std::make_shared<Type>(arg0, arg1);                             \
    } catch (std::exception &ex) {                                                 \
        MSPROF_LOGE("make shared failed, message: %s", ex.what());                 \
        action;                                                                    \
    }                                                                              \

#define MSVP_MAKE_SHARED3_NODO(instance, Type, arg0, arg1, arg2, action)                \
    try {                                                                               \
        instance = std::make_shared<Type>(arg0, arg1, arg2);                            \
    } catch (std::exception &ex) {                                                      \
        MSPROF_LOGE("make shared failed, message: %s", ex.what());                      \
        action;                                                                         \
    }                                                                                   \

#define MSVP_MAKE_SHARED4_NODO(instance, Type, args0, args1, args2, args3, action)         \
    try {                                                                                  \
        instance = std::make_shared<Type>(args0, args1, args2, args3);                     \
    } catch (std::exception &ex) {                                                         \
        MSPROF_LOGE("make shared failed, message: %s", ex.what());                         \
        action;                                                                            \
    }                                                                                      \

#define FUNRET_CHECK_RET_VAL(EXPR) do {                      \
    if (EXPR) {                                              \
        MSPROF_LOGE("Function ret check failed");            \
    }                                                        \
} while (0)

#define FUNRET_CHECK_RET_VALUE(EXPR, action) do {            \
    if (EXPR) {                                              \
        MSPROF_LOGE("Function ret check failed");            \
        action;                                              \
    }                                                        \
} while (0)

#define FUNRET_CHECK_FAIL_PRINT(EXPR) do {                   \
    if (EXPR) {                                              \
        MSPROF_LOGE("Function ret check failed");            \
    }                                                        \
} while (0)

#define FUNRET_CHECK_NULL_PTR(PTR, action) do {     \
    if ((PTR) == nullptr) {                         \
        MSPROF_LOGE("Pointer is null");             \
        action;                                     \
    }                                               \
} while (0)

#define FUNRET_CHECK_EXPR_ACTION(EXPR, ACTION, msg, ...)    \
    if (EXPR) {                                             \
        MSPROF_LOGE(msg, ##__VA_ARGS__);                    \
        ACTION;                                             \
    }                                                       \

#define FUNRET_CHECK_EXPR_ACTION_LOGW(EXPR, ACTION, msg, ...)    \
    if (EXPR) {                                                  \
        MSPROF_LOGW(msg, ##__VA_ARGS__);                         \
        ACTION;                                                  \
    }                                                            \

#define FUNRET_CHECK_EXPR_LOGW(EXPR, msg, ...)    \
    if (EXPR) {                                           \
        MSPROF_LOGW(msg, ##__VA_ARGS__);                  \
    }                                                     \

#define FUNRET_CHECK_EXPR_PRINT(EXPR, msg, ...)             \
    if (EXPR) {                                             \
        MSPROF_LOGE(msg, ##__VA_ARGS__);                    \
    }                                                       \

#define INOTIFY_LISTEN_EVENTS        (IN_DELETE | IN_CLOSE_WRITE | IN_DELETE_SELF | IN_MOVE_SELF)

#define  US_TO_SECOND_TIMES(x)    (1000000 / (x))

#define UNUSED(x) (void)(x)

using VOID_PTR = void *;
using IDE_SESSION = void *;
using VOID_PTR_PTR = void **;
using CONST_VOID_PTR = const void *;
using UNSIGNED_CHAR_PTR = unsigned char *;
using CONST_UNSIGNED_CHAR_PTR = const unsigned char *;
using CHAR_PTR = char *;
using CHAR_PTR_PTR = char **;
using CONST_CHAR_PTR = const char *;
using CONST_CHAR_PTR_PTR = const char **;
using CHAR_PTR_CONST = char *const;
using CHAR_PTR_CONST_PTR = CHAR_PTR_CONST *;
using CONST_UINT8_PTR = const uint8_t *;
using CONST_UINT32_T_PTR = const uint32_t *;
using UINT32_T_PTR = uint32_t *;
using SIZE_T_PTR = size_t *;


constexpr int32_t INVALID_EXIT_CODE = -1;
constexpr int32_t VALID_EXIT_CODE = 0;
constexpr int32_t MSVP_MAX_DEV_NUM = 64; // 64 : dev max number
constexpr int32_t DEFAULT_HOST_ID = MSVP_MAX_DEV_NUM;
constexpr int32_t UNLOCK_NUM = 2;
constexpr int32_t FILE_WRITE_SIZE = 1;
constexpr uint32_t MAX_ERR_STRING_LEN = 256;
constexpr uint32_t MAX_CMD_PRINT_MESSAGE_LEN = 1024;

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define MSVP_STRDUP _strdup
const char * const MSVP_SLASH = "\\";
#else
#define MSVP_STRDUP strdup
const char * const MSVP_SLASH = "/";
#endif

struct ExecCmdParams {
    std::string cmd;
    bool async;    // if async = false, return exit code, if async = true, return child pid
    std::string stdoutRedirectFile;
    ExecCmdParams(const std::string &cmdStr, bool asyncB, const std::string &stdoutRedirectFileStr)
        : cmd(cmdStr), async(asyncB), stdoutRedirectFile(stdoutRedirectFileStr)
    {
    }
};

struct ExecCmdArgv {
    CHAR_PTR_CONST *argv;
    int32_t argvCount;
    CHAR_PTR_CONST *envp;
    int32_t envCount;
    ExecCmdArgv(CHAR_PTR_CONST_PTR argvT, const int32_t argvCountT, CHAR_PTR_CONST_PTR envpT, const int32_t envCountT)
        : argv(argvT), argvCount(argvCountT), envp(envpT), envCount(envCountT)
    {
    }
};

enum class VolumeSize {
    AVAIL_SIZE = 0,
    FREE_SIZE,
    TOTAL_SIZE
};

class Utils {
public:
    static int64_t GetFileSize(const std::string &path);
    static int32_t GetVolumeSize(const std::string &path, unsigned long long &size, VolumeSize sizeType);
    static bool IsDir(const std::string &path);
    static bool IsAllDigit(const std::string &digitStr);
    static bool IsFileExist(const std::string &path);
    static bool IsDirAccessible(const std::string &path);
    static std::string DirName(const std::string &path);
    static std::string BaseName(const std::string &path);
    static int32_t SplitPath(const std::string &path, std::string &dir, std::string &base);
    static int32_t RelativePath(const std::string &path, const std::string &dir, std::string &relativePath);
    static void GetFiles(const std::string &dir, bool isRecur, std::vector<std::string> &files, uint32_t depth);
    static void GetChildFilenames(const std::string &dir, std::vector<std::string> &files);
    static int32_t CreateDir(const std::string &path);
    static void RemoveDir(const std::string &dir, bool rmTopDir = true);
    static std::string CanonicalizePath(const std::string &path);
    static int32_t ExecCmd(const ExecCmdParams &execCmdParams,
        const std::vector<std::string> &argv,
        const std::vector<std::string> &envp,
        int32_t &exitCodeP,
        OsalProcess &childProcess);
    static int32_t ExecCmdC(const ExecCmdArgv &execCmdArgv, const ExecCmdParams &execCmdParams, int32_t &exitCodeP);
    static int32_t ExecCmdCAsync(const ExecCmdArgv &execCmdArgv, const ExecCmdParams &execCmdParams,
                             OsalProcess &childProcess);
    static int32_t ChangeWorkDir(const std::string &fileName);
    static void SetArgEnv(CHAR_PTR_CONST argv[],
                          const int32_t argvCount,
                          CHAR_PTR_CONST envp[],
                          const int32_t envCount,
                          OsalArgvEnv &argvEnv);
    static int32_t DoCreateCmdProcess(const std::string &stdoutRedirectFile,
                                  const std::string &fileName,
                                  const OsalArgvEnv &argvEnv,
                                  OsalProcess &tid);
    static int32_t WaitProcess(OsalProcess process, bool &isExited, int32_t &exitCode, bool hang = true);
    static bool ProcessIsRuning(OsalProcess process);
    static std::string JoinPath(const std::vector<std::string> &paths);
    static std::string LeftTrim(const std::string &str, const std::string &trims);
    static std::vector<std::string> Split(const std::string &input_str,
                                          bool filter_out_enabled = false,
                                          const std::string &filter_out = "",
                                          const std::string &pattern = " ");
    static std::string ToUpper(const std::string &value);
    static std::string ToLower(const std::string &value);
    static std::string Trim(const std::string &value);
    static int32_t UsleepInterupt(unsigned long usec);
    static unsigned long long GetClockRealtime();
    static unsigned long long GetClockMonotonicRaw();
    static unsigned long long GetCPUCycleCounter();
    static void GetChildDirs(const std::string &dir, bool isRecur, std::vector<std::string> &childDirs, uint32_t depth);
    static std::string TimestampToTime(const std::string &timestamp, int32_t unit = 1);
    static std::string HandleEnvString(CONST_CHAR_PTR envPtr);
    static std::string IdeGetHomedir();
    static std::string IdeReplaceWaveWithHomedir(const std::string &path);
    static void EnsureEndsInSlash(std::string& path);
    static VOID_PTR ProfMalloc(size_t size);
    static void ProfFree(VOID_PTR &ptr);
    static bool CheckStringIsNonNegativeIntNum(const std::string &numberStr);
    static bool CheckStringIsUnsignedIntNum(const std::string &numberStr);
    static bool CheckStringNumRange(const std::string &numberStr, const std::string &target);
    static std::string GetCoresStr(const std::vector<int32_t> &cores, const std::string &separator = ",");
    static std::string GetEventsStr(const std::vector<std::string> &events, const std::string &separator = ",");
    static void PrintSysErrorMsg();
    static std::string GetSelfPath();
    static std::string CreatePidStr(const std::string &pid);
    static std::string CreateProfDir(uint64_t index, const std::string &title = "PROF_");
    static std::string CreateHelperDir(uint64_t index, const std::string &helperPid);
    static std::string CreateProfDirSuffix(uint64_t index, std::string suffix, const std::string &title);
    static std::string CreateResultPath(const std::string &devId);
    static std::string ProfCreateId(uint64_t addr);
    static uint32_t GenerateSignature(CONST_UINT8_PTR data, uint64_t len);
    static std::string ConvertIntToStr(const int32_t interval);
    static int32_t GetPid();
    static void RemoveEndCharacter(std::string &input, const char end = '\n');
    static std::string GetCwdString(void);
    static std::string RelativePathToAbsolutePath(const std::string &path);
    static bool IsSoftLink(const std::string &path);
    template<typename T>
    static std::string Int2HexStr(T number)
    {
        std::stringstream ioss;
        std::string ret;
        ioss << std::hex << number;
        ioss >> ret;
        return ret;
    }
    static bool IsAppName(const std::string paramsName);
    static bool IsDynProfMode();
    static CHAR_PTR GetErrno();
    static std::string GetInfoPrefix(const std::string &fileName);
    static std::string GetInfoSuffix(const std::string &fileName);
    static std::string PackDotInfo(const std::string &leftPattern, const std::string &rightPattern);
    static uint64_t GreenwichToMonotonic(uint64_t inputTime);
    static bool StrToUint64(uint64_t &out, const std::string &numStr);
    static bool StrToUint32(uint32_t &out, const std::string &numStr);
    static bool StrToInt32(int32_t &out, const std::string &numStr);
    static bool StrToDouble(double &out, const std::string &numStr);
    static bool CheckInputArgsLength(int32_t argc, CONST_CHAR_PTR argv[]);
    static bool CheckBinValid(const std::string &binPath);
    static int32_t DumpFile(const std::string &output, CONST_CHAR_PTR data, std::size_t length);
    static std::string GetHostTime();
    static void GenTimeLineJsonFile(std::string path, const std::string &strData);
    template<typename TO, typename TI>
    static TO *ReinterpretCast(TI *ptr)
    {
        return reinterpret_cast<TO *>(ptr);
    }
    static bool CheckDuplicateStrings(const std::string &oriStr, const std::string &subStr);
};

template<class T>
class UtilsStringBuilder {
public:
    std::string Join(const std::vector<T> &elems, const std::string &sep) const;
};

template<class T>
std::string UtilsStringBuilder<T>::Join(const std::vector<T> &elems, const std::string &sep) const
{
    std::stringstream result;

    for (size_t ii = 0; ii < elems.size(); ++ii) {
        if (ii == 0) {
            result << elems[ii];
        } else {
            result << sep;
            result << elems[ii];
        }
    }

    return result.str();
}

int32_t WriteFile(const std::string &absolutePath, const std::string &recordFile, const std::string &profName);

#define MSPROF_GET_ENV(IDNAME, envStr)        \
    do {                                      \
        CONST_CHAR_PTR env = nullptr;         \
        MM_SYS_GET_ENV(IDNAME, env);          \
        envStr = Utils::HandleEnvString(env); \
    } while (0)

}  // namespace utils
}  // namespace common
}  // namespace dvvp
}  // namespace analysis

#endif
