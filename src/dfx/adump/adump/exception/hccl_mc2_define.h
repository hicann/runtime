/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef HCCL_MC2_DEFINE_H
#define HCCL_MC2_DEFINE_H

#include <cstdint>
#include "acl_rt.h"

namespace Adx {
constexpr uint32_t RANK_NUM = 32;
constexpr uint32_t HCCL_MULTI_QP_THRESHOLD_DEFAULT = 512;
constexpr uint32_t LOCAL_NOTIFY_MAX_NUM = 64;
constexpr uint32_t LOCAL_STREAM_MAX_NUM = 40;
constexpr uint32_t AICPU_OP_NOTIFY_MAX_NUM = 2;
constexpr uint32_t AICPU_MAX_RANK_NUM = 128 * 1024;
constexpr uint32_t MAX_RANK_NUM_A3 = 768;
constexpr uint32_t MAX_MODULE_DEVICE_NUM = 32; // 单server双模组时支持最大的设备数量

struct HcclMC2WorkSpace {
    uint64_t workSpace;
    uint64_t workSpaceSize;
};

struct HcclOpConfig {
    uint8_t deterministic; // 确定性计算开关
    uint8_t retryEnable;  // 是否重执行
    uint8_t highPerfEnable; // deprecate
    uint8_t padding[5];  // 大小需要64By对齐，未来添加参数时减小padding
    uint8_t linkTimeOut[8]; // 发送超时时长
    uint64_t notifyWaitTime;  // 超时时长，同HCCL_EXEC_TIMEOUT
    uint32_t retryHoldTime;
    uint32_t retryIntervalTime;
    bool interHccsDisable = false;  // 使能rdma开关
    aclrtFloatOverflowMode floatOverflowMode = ACL_RT_OVERFLOW_MODE_UNDEF;
    uint32_t multiQpThreshold{HCCL_MULTI_QP_THRESHOLD_DEFAULT};  // 多QP每个QP分担数据量最小阈值
};

struct MemDetails {
    uint64_t size = 0;
    uint64_t addr = 0;
    uint32_t key = 0;
};

struct IbVerbsData {
    MemDetails remoteInput;
    MemDetails remoteOutput;
    MemDetails localInput;
    MemDetails localOutput;
    uint8_t res[24];
};

struct HcclCombinOpParam {
    HcclMC2WorkSpace mc2WorkSpace;
    uint32_t rankId;                            // id of this rank
    uint32_t rankNum;                           // num of ranks in this comm group
    uint64_t winSize;                           // size of each windows memory
    uint64_t windowsIn[RANK_NUM];               // windows address for input, windowsIn[rankId] corresponds
                                                // to the local card address,
                                                // and others are cross-card mapping addresses.
    uint64_t windowsOut[RANK_NUM];              // windows address for output, windowsOut[rankId] corresponds
                                                // to the local card address,
                                                // and others are cross-card mapping addresses.
    uint8_t res[8328];
    uint8_t multiFlag;
    uint64_t ibverbsData;
    uint64_t ibverbsDataSize;
    // 追加字段
    uint64_t sizeOfAiRMAInfo;   // sizeof(HcclAiRMAInfo)
    uint64_t aiRMAInfo;         // HcclAiRMAInfo* 单个结构体指针

    uint64_t capabilityPtr;     // address of the communication capability information structure on the Device
    uint64_t capabilitySize;    // size of the communication capability information structure
};

struct HcclStreamInfo {
    int32_t streamIds;
    uint32_t sqIds;
    uint32_t cqIds;   // 记录物理cqId
    uint32_t logicCqids; // 记录逻辑cqId
};

// 记录aicpu-custom共享的stream信息
struct HcclStreamParam {
    HcclStreamInfo streamInfo;
    uint64_t sqCqContextAddr = 0; // 记录sqeContext地址
    uint64_t sqCqContextSize = 0; // 记录sqeContext大小
};

struct HcclSignalInfo {
    uint64_t resId; // 在代表event时为eventid，notify时为notifyid
    uint64_t addr;
    uint32_t devId;
    uint32_t tsId;
    uint32_t rankId;
    uint32_t flag;
};

struct ListCommon {
    uint64_t nextHost;
    uint64_t preHost;
    uint64_t nextDevice;
    uint64_t preDevice;
};

// 预留占位内存
struct ReservedStruct {
    uint32_t streamNum;
    uint32_t signalNum;
    HcclSignalInfo localSignals[LOCAL_NOTIFY_MAX_NUM];
    HcclStreamInfo streamInfo[19];
    HcclStreamInfo mainStreamInfo;
    HcclSignalInfo aicpuOpNotify[AICPU_OP_NOTIFY_MAX_NUM];  // 集合通信AICPU展开资源
    ListCommon nextTagRes;                                  // HccltagLocalResV2
};

// 卡内主从流同步，下沉图，单算子，通信域内复用
struct LocalResInfoV2 {
    uint32_t streamNum;
    uint32_t signalNum;
    HcclSignalInfo localSignals[LOCAL_NOTIFY_MAX_NUM];
    HcclStreamParam streamParam[LOCAL_STREAM_MAX_NUM];
    HcclStreamParam mainStreamParam;
    HcclSignalInfo aicpuOpNotify[AICPU_OP_NOTIFY_MAX_NUM];  // 集合通信AICPU展开资源
    ListCommon nextTagRes;                                  // HccltagLocalResV2
};

struct AlgoTopoInfo {
    uint32_t userRank;      // 通信域 RankID
    uint32_t userRankSize;  // 通信域的 Rank数量
    int32_t deviceLogicId;
    bool isSingleMeshAggregation;
    uint32_t deviceNumPerAggregation;  // 每个module中的Device数量
    uint32_t superPodNum;           // 集群中总的超节点数
    uint32_t devicePhyId;
    uint32_t topoType;  // TopoType
    uint32_t deviceType;
    uint32_t serverNum;
    uint32_t meshAggregationRankSize;
    uint32_t multiModuleDiffDeviceNumMode;
    uint32_t multiSuperPodDiffServerNumMode;
    uint32_t realUserRank;
    bool isDiffDeviceModule;
    bool isDiffDeviceType;
    uint32_t gcdDeviceNumPerAggregation;
    uint32_t moduleNum;
    uint32_t isUsedRdmaRankPairNum;
    uint64_t isUsedRdmaRankPair;
    uint32_t pairLinkCounterNum;
    uint64_t pairLinkCounter;
    uint32_t nicNum;
    uint64_t nicList;            // niclist数组指针
    uint64_t complanRankLength;  // complanRank占用的字节数
    uint64_t complanRank;        // 指针
    uint64_t bridgeRankNum;      // bridgeRank占用的个数
    uint64_t bridgeRank;         // 指针
    uint64_t serverAndsuperPodRankLength;  // serverAndsuperPodRank占用的字节数
    uint64_t serverAndsuperPodRank;    // 指针
};

struct RemoteResPtr {
    uint64_t nextHostPtr;
    uint64_t nextDevicePtr;
};

// 层次化算法信息
struct HierarchicalAlgInfo {
    uint64_t commplaneSubGroupRankLength;  // complanSubGroupRank占用的字节数
    uint64_t commplaneSubGroupRank;  // 指针
    uint32_t hierarchicalAlgOptionNum;
    uint64_t hierarchicalAlgOptionVec;    // hierarchicalAlgOptionVec数组指针
};

struct HDCommunicateParams {
    uint64_t hostAddr { 0 };
    uint64_t deviceAddr { 0 };
    uint64_t readCacheAddr { 0 };
    uint32_t devMemSize{ 0 };
    uint32_t buffLen{ 0 };
    uint32_t flag{ 0 };
};

// 算子计数信息
struct OpCounterInfo {
    uint64_t headCountMem = 0;
    uint64_t tailCountMem = 0;
    uint64_t addOneMem = 0;
    uint32_t memSize = 0;
    bool isEnableCounter = false;
};

struct HcclOpResParam {
    // 本地资源
    HcclMC2WorkSpace mc2WorkSpace;
    uint32_t localUsrRankId;  // usrrankid
    uint32_t rankSize;        // 通信域内total rank个数
    uint64_t winSize;  // 每个win大小，静态图时，可能为0，如果通信域内也有动态图，则可能为非0
    uint64_t localWindowsIn;   // 全F为无效值
    uint64_t localWindowsOut;  // 全F为无效值
    char hcomId[128];
    uint64_t winExpSize;
    uint64_t localWindowsExp;
    // aicore识别remote window
    uint32_t rWinStart;   // 为HcclRankRelationRes起始位置
    uint32_t rWinOffset;  // 为HcclRemoteRes的大小
    uint64_t version;
    // 以下可以修改
    ReservedStruct reservedStrcut;
    AlgoTopoInfo topoInfo;

    // 外部配置参数
    HcclOpConfig config;
    uint64_t hostStateInfo;
    uint64_t aicpuStateInfo;
    uint64_t lockAddr;
    uint32_t rsv[16];
    uint32_t notifysize;                              // RDMA场景使用，910B/910_93为4B，其余芯片为8B
    uint32_t remoteResNum;                            // 有效的remoteResNum
    RemoteResPtr remoteRes[AICPU_MAX_RANK_NUM];  // 数组指针，指向HcclRankRelationResV2，下标为remoteUserRankId

    // communicate retry
    HDCommunicateParams kfcControlTransferH2DParams;
    HDCommunicateParams kfcStatusTransferD2HParams;

    uint64_t tinyMem;   // for all2all
    uint64_t tinyMemSize;

    // 零拷贝场景使用
    uint64_t zeroCopyHeadPtr;
    uint64_t zeroCopyTailPtr;
    uint64_t zeroCopyRingBuffer;
    uint64_t zeroCopyIpcPtrs[MAX_MODULE_DEVICE_NUM];               // 保存集合通信时每个对端的输入输出内存地址
    uint32_t zeroCopyDevicePhyId[MAX_MODULE_DEVICE_NUM];           // 保存每个rank对应的物理卡Id

    bool utraceStatusFlag;

    OpCounterInfo opCounterInfo;

    HierarchicalAlgInfo hierarchicalAlgInfo;
    LocalResInfoV2 localRes;
    uint64_t debugConfig = 0; // 环境变量HCCL_DEBUG_CONFIG, 考虑兼容性放在结构体末尾

    // aicpu和custom进程需要交互的部分信息
    uint64_t aicpuCustomParamAddr;
    uint64_t aicpuCustomParamSize;

    MemDetails userMemRes[MAX_RANK_NUM_A3];     // 下标为rank id
    uint32_t userMemType = 0;                             // 0:CCL Buffer; 1:user Mem
};
}
#endif