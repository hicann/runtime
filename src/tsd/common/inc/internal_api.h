/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TDT_COMMON_COMMON_INC_INTERNAL_API_H
#define TDT_COMMON_COMMON_INC_INTERNAL_API_H

#include <memory>
#include <chrono>
#include "tsd/status.h"
#include "inc/log.h"
#include "inc/tsd_util.h"

    #define TSD_CHECK_NO_RETURN(condition, log, ...)                                \
        do {                                                                        \
            const bool cond = (condition);                                          \
            if (!cond) {                                                            \
                TSD_ERROR(log, ##__VA_ARGS__);                                    \
            }                                                                       \
        } while (false)

    #define TSD_CHECK_NO_RETURN_RUNINFO_LOG(condition, log, ...)                      \
            do {                                                                    \
                const bool cond = (condition);                                      \
                if (!cond) {                                                        \
                    TSD_RUN_INFO(log, ##__VA_ARGS__);                                \
                }                                                                   \
            } while (false)

    #define TSD_CHECK_EQ_RETURN_RUNWARN_LOG(condition, errCode, log, ...)             \
            do {                                                                    \
                const bool cond = (condition);                                      \
                if (cond) {                                                         \
                    TSD_RUN_WARN(log, ##__VA_ARGS__);                                \
                    return (errCode);                                               \
                }                                                                   \
            } while (false)

// 注意: 该宏第一项Condition是期望为真，否则将进行后续的返回和日志记录
    #define TSD_CHECK(condition, retValue, log, ...)                                \
        do {                                                                        \
            const bool cond = (condition);                                          \
            if (!cond) {                                                            \
                TSD_ERROR(log, ##__VA_ARGS__);                                    \
                return (retValue);                                                  \
            }                                                                       \
        } while (false)

// 注意: 该宏第一项Condition是期望为真，否则将进行后续的返回和日志记录
    #define TSD_CHECK_RET_VOID(condition, log, ...)                                 \
        do {                                                                        \
            const bool cond = (condition);                                          \
            if (!cond) {                                                            \
                TSD_ERROR(log, ##__VA_ARGS__);                                    \
                return;                                                             \
            }                                                                       \
        } while (false)


    #define TSD_CHECK_NULLPTR_VOID(value)                                           \
        do {                                                                        \
            if ((value) == nullptr) {                                               \
                return;                                                             \
            }                                                                       \
        } while (false)

    #define TSD_CHECK_NULLPTR(value, errorCode, log, ...)                           \
        do {                                                                        \
            if ((value) == nullptr) {                                               \
                TSD_ERROR(log, ##__VA_ARGS__);                                    \
                return (errorCode);                                                 \
            }                                                                       \
        } while (false)


    #define TSD_BITMAP_GET(val, pos) (((val) >> (pos)) & 0x01U)

    #define TSD_BITMAP_SET(val, pos) ((val) |= (1ULL << (pos)))

    #define TSD_BITMAP_CLR(val, pos) ((val) &= (~(1ULL << (pos))))

namespace tsd {

    constexpr uint32_t TSD_SUPPORT_HS_AISERVER_FEATURE_BIT = 0U;

    constexpr uint32_t TSD_SUPPORT_BUILTIN_UDF_BIT = 1U;

    constexpr uint32_t TSD_SUPPORT_CLOSE_LIST_BIT = 2U;

    constexpr uint32_t TSD_SUPPORT_ADPROF_BIT = 3U;

    constexpr uint32_t TSD_SUPPORT_EXTEND_PKG = 4U;

    constexpr uint32_t TSD_SUPPORT_MUL_HCCP = 5U;

    constexpr uint32_t TSD_SUPPORT_DRIVER_EXTEND_BIT = 6U;

    constexpr uint32_t TSD_SUPPORT_ASCENDCPP_PKG = 7U;

    constexpr uint32_t TSD_SUPPORT_COMMON_SINK_PKG_CONFIG = 8U;

    constexpr uint32_t MAX_DEVNUM_PER_OS = 64U;  // 当前单OS上芯片最大数是64个

    // tsdclient
    constexpr uint32_t TSDCLIENT_SUPPORT_NEW_ERRORCODE= 1U;

    constexpr uint32_t MAX_DEVNUM_PER_HOST = 128U;  // 当前host侧看到的是两个OS拼接后的芯片数8个,对应不同进程

    constexpr int32_t TDT_RETURN_ERROR = -1;

    constexpr uint64_t S_TO_NS = 1000000UL;

    constexpr uint64_t MS_TO_NS = 1000UL;

    constexpr uint64_t S_TO_MS = 1000UL;

    const std::string NUMA_NODE_FILE_NAME_PREFIX = "/sys/devices/system/node/node";
    const std::string NUMA_NODE_FILE_NAME_SUFFIX = "/meminfo";
    const std::string NUMA_NODE_FILE_FREE_PREFIX = "Node ";
    const std::string NUMA_NODE_FILE_FREE_SUFFIX = " MemFree:";
    constexpr uint32_t NUMA_NODE_OOM_RESERVED_PF_DIE0 = 31U;
    constexpr uint32_t NUMA_NODE_OOM_RESERVED_PF_DIE1 = 63U;
    constexpr uint32_t NUMA_NODE_OOM_RESERVED_VF_DIE0 = 40U;
    constexpr uint32_t NUMA_NODE_OOM_RESERVED_VF_DIE1 = 72U;

    /**
    * @ingroup Trim
    * @brief 删除string首尾空白
    * @param [in] str : 字符串变量
    * @return 字符串
    */
    void Trim(std::string& str);

    uint64_t CalFileSize(const std::string &filePath);

    /**
    * @ingroup ValidateStr
    * @brief 判断是否符合正则匹配
    * @param [in] str : 文件名
    * @param [in] mode : 文件名匹配格式
    * @return 文件校验值
    */
    bool ValidateStr(const std::string &str, const std::string &mode);

    /**
     * @ingroup IsFpgaEnv
     * @brief 读环境变量判断当前是否是FPGA环境
     * @return : true: fpga环境， false: 非fpga环境
     */
    bool IsFpgaEnv();

    void SetAicpuHeterogeneousThreadMode(const bool flag);

    bool IsAicpuHeterogeneousThreadMode();

    inline uint64_t GetCurrentTime()
    {
        uint64_t ret = 0U;
        struct timeval tv;
        if (gettimeofday(&tv, nullptr) == 0) {
            ret = (static_cast<uint64_t>(tv.tv_sec) * S_TO_NS) + static_cast<uint64_t>(tv.tv_usec);
        }

        return ret;
    }

    /**
     * @ingroup
     * @brief read env value
     * @param [in] envName : env to get
     * @param [out] envValue : result
     * @return : void
     */
    void GetScheduleEnv(const char_t * const envName, std::string &envValue);

    /**
     * @ingroup
     * @brief If the envStr value is same as envValue passed in, return true
     * @param [in] ：envStr：env name
     * @param [in] ：envValue：expected env value
     * @return : true, if value equal to envValue
     */
    bool GetFlagFromEnv(const char_t * const envStr, const char_t * const envValue);

    /**
     * @ingroup
     * @brief Is adc env
     * @return : true, if is adc
     */
    bool IsAdcEnv();

    /**
     * @ingroup CheckRealPath
     * @brief check if path is realpath
     * @param inputPath input file path
     * @return : true: valid path， false: invalid path
     */
    bool CheckRealPath(const std::string &inputPath);

    /**
     * @ingroup CheckValidatePath
     * @brief check if path is valid
     * @param path path
     * @return : true: valid path， false: invalid path
     */
    bool CheckValidatePath(const std::string &path);

    /**
     * @ingroup TSD
     * @brief PackSystem: 封装system API
     * @param [in] : cmdLine-需要执行的命令行
     * @param [out] :  成功---0,  错误--其他错误码
     */
    int32_t PackSystem(const char_t * const cmdLine);

    int32_t TsdExecuteCmd(const std::string &cmd);

    bool GetConfigIniValueInt32(const std::string &fileName, const std::string &key, int32_t &val);

    /**
     * @ingroup TSD
     * @brief PackSystem: safety strerror
     * @param [out] : system error description
     */
    std::string SafeStrerror();

    char_t TsdCh2Hex(const char_t c);

    uint32_t CalcUniqueVfId(const uint32_t deviceId, const uint32_t vfId);

    bool TransStrToull(const std::string &para, uint64_t &value);
    bool TransStrToInt(const std::string &para, int32_t &value);

    void RemoveOneFile(const std::string &filePath);

    inline void WrappedExit(int32_t status)
    {
        _exit(status);
    }

    bool IsDirEmpty(const std::string &dirPath);
}
#endif  // TDT_COMMON_COMMON_INC_INTERNAL_API_H
