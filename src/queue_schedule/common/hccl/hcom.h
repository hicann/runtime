/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef HCOM_H
#define HCOM_H

#include <hccl/base.h>
#include <hccl/hccl_types.h>
#include <functional>
#include <vector>

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

typedef struct HcomOpParamDef {
    const char *group = nullptr;    // 通信域groupName
    const char *opType = nullptr;   // 算子类型
    HcclDataType datatype = HcclDataType::HCCL_DATA_TYPE_RESERVED;  // 数据类型

    HcclReduceOp reduceOp = HcclReduceOp::HCCL_REDUCE_RESERVED; // 规约类型
    u8 deterministic;                                           // 是否为确定性计算

    const char *socVersion = nullptr;  // soc字符串，用于查询devType
    const char *rankTable = nullptr;    // rankTable解析结果
    const u32 *groupList = nullptr;     // groupList解析结果
    u32 groupListSize = 0;              // groupList的大小
    u64 count;  // 数据量

    union {
        struct {
            HcclDataType sendType = HcclDataType::HCCL_DATA_TYPE_RESERVED;
            HcclDataType recvType = HcclDataType::HCCL_DATA_TYPE_RESERVED;
            u64 rankSize = 0;
            void *sendCounts = nullptr;
            void *recvCounts = nullptr;
            void *sdispls = nullptr;
            void *rdispls = nullptr;
            void *sendCountMatrix = nullptr;
        } All2AllDataDes;
    };
    HcomOpParamDef()
        : group(nullptr), opType(nullptr), datatype(HcclDataType::HCCL_DATA_TYPE_RESERVED),
        reduceOp(HcclReduceOp::HCCL_REDUCE_RESERVED), deterministic(0), socVersion(nullptr), rankTable(nullptr), 
        groupList(nullptr), groupListSize(0), count(0), All2AllDataDes{}
    {
        All2AllDataDes.sendType = HcclDataType::HCCL_DATA_TYPE_RESERVED;
        All2AllDataDes.recvType = HcclDataType::HCCL_DATA_TYPE_RESERVED;
        All2AllDataDes.rankSize = 0;
        All2AllDataDes.sendCounts = nullptr;
        All2AllDataDes.recvCounts = nullptr;
        All2AllDataDes.sdispls = nullptr;
        All2AllDataDes.rdispls = nullptr;
        All2AllDataDes.sendCountMatrix = nullptr;
    }
} HcomOpParam;

typedef struct HcomResResponseDef {
    const u64 streamNum = 0;
    u64 taskNum = 0;
    const u64 opMemSize = 0;
} HcomResResponse;
/**
 * @brief Get the rank number in the group.
 *
 * @param group A string identifying the group name.
 * @param rankSize A pointer identifying the rank number.
 * @return HcclResult
 */
HcclResult HcomGetRankSize(const char *group, u32 *rankSize);

/**
 * @brief Get the rank number of this rank's server within the group.
 *
 * @param group A string identifying the group name.
 * @param localRankSize A pointer identifying the rank number.
 * @return HcclResult
 */
HcclResult HcomGetLocalRankSize(const char *group, u32 *localRankSize);

/**
 * @brief Get the rank id of this rank.
 *
 * @param group A string identifying the group name.
 * @param rankId A pointer identifying the rank id.
 * @return HcclResult
 */
HcclResult HcomGetRankId(const char *group, u32 *rankId);

/**
 * @brief Get the local rank id of this rank's server within the group.
 *
 * @param group A string identifying the group name.
 * @param localRankId A pointer identifying the local rank id.
 * @return HcclResult
 */
HcclResult HcomGetLocalRankId(const char *group, u32 *localRankId);

/**
 * @brief Get the world rank id according to the group rank id.
 *
 * @param group A string identifying the group name.
 * @param groupRank An integer(u32) identifying the group rank id.
 * @param worldRank A pointer identifying the world rank id.
 * @return HcclResult
 */
HcclResult HcomGetWorldRankFromGroupRank(const char *group, u32 groupRank, u32 *worldRank);

/**
 * @brief Get the group rank id according to the world rank id.
 *
 * @param worldRank An integer(u32) identifying the world rank id.
 * @param group A string identifying the group name.
 * @param groupRank A pointer identifying the group rank id.
 * @return HcclResult
 */
HcclResult HcomGetGroupRankFromWorldRank(u32 worldRank, const char *group, u32 *groupRank);

/**
 * @brief Create group.
 *
 * @param group A string identifying the group name.
 * @param rankNum An integer(u32) identifying the number of ranks in the group.
 * @param rankIds A list identifying the ranks in the group.
 * @return HcclResult
 */
HcclResult HcomCreateGroup(const char *group, u32 rankNum, u32 *rankIds);

/**
 * @brief Destroy group
 *
 * @param group A string identifying the group name.
 * @return HcclResult
 */
HcclResult HcomDestroyGroup(const char *group);

/**
 * @brief Set the gradient split strategy with in the group, according to gradient index.
 *
 * @param group A string identifying the group name.
 * @param segmentNum An integer(u32) identifying the segments number of gradients.
 * @param IdxList A list identifying the index of end gradient in each segment.
 * @return HcclResult
 */
extern HcclResult HcomSetGradFusionByIndex(const char *group, u32 segmentNum, const u32 *IdxList);

/**
 * @brief Set the gradient split strategy with in the group, according to gradient data size.
 *
 * @param group A string identifying the group name.
 * @param segmentNum An integer(u32) identifying the segments number of gradients.
 * @param sizeList A list identifying the percent of each segment.
 * @return HcclResult
 */
extern HcclResult HcomSetGradFusionBySize(const char *group, u32 segmentNum, const float *sizeList);

/**
 * @brief optimizer offload CPU-side hcom init.
 *
 * @param rankTable A string identifying the rank table.
 * @param rankId An integer(u32) identifying the number of rank id.
 * @return HcclResult
 */
extern HcclResult HcomInitByRankTable(const char *rankTable, uint32_t rankId);

/**
 * @brief optimizer offload CPU-side hcom destroy.
 *
 * @return HcclResult
 */
extern HcclResult HcomDestroy(void);

/**
 * @brief optimizer offload CPU-side establish a link.
 *
 * @param op A pointer identifying the op desc.
 * @param request A pointer identifying the link setup handle.
 * @return HcclResult
 */
extern HcclResult HcomPrepareStart(const HcomOpDesc* op, HcomRequest* request);

/**
 * @brief optimizer offload CPU-side query link status.
 *
 * @param request A pointer identifying link setup handle.
 * @param status A pointer identifying the link status.
 * @return HcclResult
 */
extern HcclResult HcomPrepareQuery(HcomRequest request, HcomStatus* status);

/**
 * @brief optimizer offload CPU-side cancel a link.
 *
 * @param request A pointer identifying link setup handle.
 * @param status A pointer identifying the link status.
 * @return HcclResult
 */
extern HcclResult HcomPrepareCancel(HcomRequest request, HcomStatus* status);

extern HcclResult HcclCpuCommInitClusterInfoMemConfig(const char* clusterInfoMem, uint32_t rank,
    HcclCommConfig* config);

extern HcclResult HcomGetCommHandleByGroup(const char *group, HcclComm *commHandle);
#ifdef __cplusplus
}
#endif // __cplusplus
#endif // HCOM_H
