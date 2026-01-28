/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <atomic>
#include "acl_dump.h"
#include "adump_pub.h"
#include "adump_api.h"
#include "dump_manager.h"
#include "dump_printf.h"

namespace Adx {
uint64_t g_chunk[RING_CHUNK_SIZE + MAX_TENSOR_NUM] = {0};
bool g_setAssert = false;
static std::mutex g_setAssertMtx;
namespace {
uint32_t g_atomicIndex = 0x2000;
std::atomic<uint64_t> g_writeIdx{0};
}  // namespace

void *AdumpGetSizeInfoAddr(uint32_t space, uint32_t &atomicIndex)
{
    if (!g_setAssert) {
        const std::lock_guard<std::mutex> lock(g_setAssertMtx);
        if (!g_setAssert) {
            (void)rtSetTaskFailCallback(AdxAssertCallBack);
            g_setAssert = true;
        }
    }
    if (space > MAX_TENSOR_NUM) {
        return nullptr;
    }

    atomicIndex = g_atomicIndex++;
    auto nextWriteCursor = g_writeIdx.fetch_add(space);
    return g_chunk + (nextWriteCursor % RING_CHUNK_SIZE);
}

int32_t AdumpRegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc)
{
    return DumpManager::Instance().RegisterCallback(moduleId, enableFunc, disableFunc);
}

int32_t AdumpSaveToFile(const char *data, size_t dataLen, const char *filename, SaveType type)
{
    return DumpManager::Instance().SaveFile(data, dataLen, filename, type);
}
}  // namespace Adx

/**
 * @ingroup AscendCL
 * @brief Enable the dump function of the corresponding dump type.
 *
 * @param dumpType [IN]  type of dump
 * @param path     [IN]  dump path
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError aclopStartDumpArgs(uint32_t dumpType, const char *path)
{
    if ((dumpType & ACL_OP_DUMP_OP_AICORE_ARGS) == ACL_OP_DUMP_OP_AICORE_ARGS) {
        std::string dumpPath(path);
        if (Adx::DumpManager::Instance().StartDumpArgs(dumpPath) != 0) {
            return ACL_ERROR_FAILURE;
        }
    }
    return ACL_SUCCESS;
}

/**
 * @ingroup AscendCL
 * @brief Disable the dump function of the corresponding dump type.
 *
 * @param dumpType [IN]  type of dump
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
aclError aclopStopDumpArgs(uint32_t dumpType)
{
    if ((dumpType & ACL_OP_DUMP_OP_AICORE_ARGS) == ACL_OP_DUMP_OP_AICORE_ARGS) {
        if (Adx::DumpManager::Instance().StopDumpArgs() != 0) {
            return ACL_ERROR_FAILURE;
        }
    }
    return ACL_SUCCESS;
}

/**
 * @ingroup AscendCL
 * @brief Get Exception Dump path.
 *
 * @retval path for success
 * @retval NULL for failed
 */
const char* acldumpGetPath(acldumpType dumpType)
{
    switch (dumpType) {
        case acldumpType::AIC_ERR_BRIEF_DUMP:
        case acldumpType::AIC_ERR_NORM_DUMP:
        case acldumpType::AIC_ERR_DETAIL_DUMP:
            return Adx::DumpManager::Instance().GetExceptionDumpPath();
        case acldumpType::DATA_DUMP:
        case acldumpType::OVERFLOW_DUMP:
            return Adx::DumpManager::Instance().GetDataDumpPath();
        default:
            return nullptr;
    }
}