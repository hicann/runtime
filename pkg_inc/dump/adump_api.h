/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
/* * @defgroup dump dump接口 */
#ifndef ADUMP_API_H
#define ADUMP_API_H
#include <cstdint>
#include <string>
#include <map>
#include <vector>
#include "acl/acl_base.h"
#include "profiling/prof_common.h"
#include "adump_pub.h"

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define ADX_API __declspec(dllexport)
#else
#define ADX_API __attribute__((visibility("default")))
#endif
namespace Adx {

// AdumpGetSizeInfoAddr chunk size parameter
constexpr uint32_t RING_CHUNK_SIZE = 60000;
constexpr uint32_t MAX_TENSOR_NUM = 1000;

struct DumpConfig {
    std::string dumpPath;
    std::string dumpMode;   // input/output/workspace
    std::string dumpStatus; // on/off
    std::string dumpData;   // tensor/stats
    uint64_t dumpSwitch{ OPERATOR_OP_DUMP | OPERATOR_KERNEL_DUMP };
    std::vector<std::string> dumpStatsItem;
};

/**
 * @ingroup dump
 * @par 描述: dump 开关状态(flag)查询, 接口即将废弃, 不建议使用
 *
 * @attention 无
 * @param  dumpType [IN] dump 类型（operator, exception）
 * @retval #false dump 开关状态(flag) off
 * @retval #true dump 开关状态(flag) on
 * @see 无
 * @since
 */
ADX_API bool AdumpIsDumpEnable(DumpType dumpType);

/**
 * @ingroup dump
 * @par 描述: dump 开关状态(flag)查询, 接口即将废弃, 不建议使用
 *
 * @attention 无
 * @param  dumpType [IN] dump 类型（operator, exception）
 * @param  dumpType [OUT] dumpSwitch开关
 * @retval #false dump 开关状态(flag) off
 * @retval #true dump 开关状态(flag) on
 * @see 无
 * @since
 */
ADX_API bool AdumpIsDumpEnable(DumpType dumpType, uint64_t &dumpSwitch);

/**
 * @ingroup dump
 * @par 描述: dump 开关设置, 接口即将废弃, 不建议使用
 *
 * @attention 无
 * @param  dumpType [IN] dump 类型（operator, exception）
 * @param  flag [IN] dump开关状态, 0: off, !0 on
 * @retval #0 dump 开关设置成功
 * @retval #!0 dump 开关设置失败
 * @see 无
 * @since
 */
ADX_API int32_t AdumpSetDumpConfig(DumpType dumpType, const DumpConfig &dumpConfig);

/**
 * @ingroup dump
 * @par 描述: 获取异常算子需要Dump的信息空间, 接口即将废弃, 不建议使用
 *
 * @attention 无
 * @param  uint32_t space [IN] 待获取space大小
 * @param  uint64_t &atomicIndex [OUT] 返回获取space地址的index参数
 * @retval # nullptr 地址信息获取失败
 * @retval # !nullptr 地址信息获取成功
 * @see 无
 * @since
 */
extern "C" ADX_API void *AdumpGetSizeInfoAddr(uint32_t space, uint32_t &atomicIndex);

ADX_API void AdumpPrintWorkSpace(const void *workSpaceAddr, const size_t dumpWorkSpaceSize,
                                 aclrtStream stream, const char *opType);

ADX_API void AdumpPrintWorkSpace(const void *workSpaceAddr, const size_t dumpWorkSpaceSize,
                                 aclrtStream stream, const char *opType, bool enableSync);

ADX_API void AdumpPrintAndGetTimeStampInfo(const void *workSpaceAddr, const size_t dumpWorkSpaceSize,
    aclrtStream stream, const char *opType, std::vector<MsprofAicTimeStampInfo> &timeStampInfo);

struct AdumpPrintConfig{
   bool printEnable;
};
ADX_API void AdumpPrintSetConfig(const AdumpPrintConfig &config);
} // namespace Adx
#endif
