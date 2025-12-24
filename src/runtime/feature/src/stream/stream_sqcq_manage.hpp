/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_STREAM_SQCQ_MANAGE_HPP
#define CCE_RUNTIME_STREAM_SQCQ_MANAGE_HPP

#include <vector>
#include <mutex>
#include <map>
#include <unordered_map>
#include "base.hpp"
#include "driver/ascend_hal.h"

constexpr uint32_t SQID_NOT_NEED_RELEASE = 0U;
constexpr uint32_t SQID_NEED_RELEASE = 1U;

namespace cce {
namespace runtime {
class Device;
class Stream;

typedef struct {
    uint32_t logicCqId;
    uint32_t remoteFlag;
    bool isFastCq;
    bool isDefaultCq;
} rtLogicCqInfo_t;

typedef struct {
    uint32_t streamId;
    uint32_t priority;
    uint32_t overflowEn : 1;
    uint32_t satMode : 1;
    uint32_t tsSqType : 1;
    uint32_t swsqFlag : 1;
    uint32_t rsv : 28;
    uint32_t threadDisableFlag;
    uint32_t shareSqId;
} rtStreamAllocInfo_t;

union rtStreamFlag {
    struct {
        uint32_t sqLock : 1;
        uint32_t waitLock : 1;      // rt set
        uint32_t dqsInterChip : 1;  // dqs inter chip schedule stream
        uint32_t res0    : 29;
    } bits;
    uint32_t u32;
};

enum class InfoExValidFlag : uint64_t {
    INFO_EX_BODY_FLAG_STREAM = 0x1U,    // bit0
    INFO_EX_BODY_FLAG_OST = 0x2U,       // bit1
    INFO_EX_BODY_FLAG_INVALID = 0x4U    // bit2
};

#pragma pack(push)
#pragma pack (4)
struct rtInfoExBody_t {
    uint64_t validFlag;                    // InfoExValidFlag
    rtStreamFlag streamFlag;
    uint32_t kisSimtStkBaseAddrLow;        // set for simt operator
    uint32_t kisSimtStkBaseAddrHigh : 16;  // set for simt operator
    uint32_t res1 : 16;
    uint32_t kisSimtWarpStkSize;           // set for simt operator
    uint32_t kisSimtDvgWarpStkSize;        // set for simt operator
    uint32_t poolId;                       // set for vf other resource
    uint32_t poolIdMax;                    // set for vf aic aiv resource
    uint32_t stackPhyBaseAddrLow;          // set for aic aiv
    uint32_t stackPhyBaseAddrHigh;         // set for aic aiv
} ;

struct rtStreamInfoExMsg_t {
    struct trs_ext_info_header head;
    rtInfoExBody_t body;
};
#pragma pack(pop)

class StreamSqCqManage : public NoCopy {
public:
    explicit StreamSqCqManage(Device * const dev);
    ~StreamSqCqManage() = default;

    rtError_t AllocStreamSqCq(const Stream * const newStm, const uint32_t priority, uint32_t drvFlag, uint32_t &sqId,
                              uint32_t &cqId);
    rtError_t AllocStarsV2StreamSqCq(const Stream * const newStm, const uint32_t priority, 
        uint32_t drvFlag, uint32_t &sqId, uint32_t &cqId, uint64_t &sqAddr);
    void FillStreamInfoEx(const Stream * const stm, rtStreamInfoExMsg_t &infoEX) const;
    rtError_t UpdateStreamSqCq(Stream *newStm);
    rtError_t ReAllocSqCqId(const Stream * const newStm);
    rtError_t DeAllocStreamSqCq(const uint32_t streamId, const uint32_t normalCqId, uint32_t drvFlag);
    std::mutex *GetSqMutex(const uint32_t sqId);
    rtError_t GetSqId(const uint32_t streamId, uint32_t &sqId);
    rtError_t GetStreamIdBySqId(const uint32_t sqId, uint32_t &streamId);
    void GetDefaultCqId(uint32_t * const cqId);

    void GetAllStreamId(std::vector<uint32_t> &streams);
    void GetAllStream(std::vector<Stream *> &streams);
    rtError_t AllocLogicCq(const uint32_t streamId, const bool isNeedFast, uint32_t &logicCqId,
        bool &isFastCq, const bool isDefaultCq = false, const uint32_t drvFlag = 0U);
    rtError_t GetLogicCqId(const uint32_t streamId, uint32_t * const logicCqId, bool * const isFastCq);
    rtError_t GetLogicCqIdWithoutLock(const uint32_t streamId, uint32_t * const logicCqId, bool * const isFastCq);
    rtError_t FreeLogicCq(const uint32_t streamId);
    rtError_t FreeLogicCqByThread(const uint32_t streamId);

    // add by stars remove thread
    void SetStreamIdToStream(const uint32_t streamId, Stream * const stm);
    void DelStreamIdToStream(const uint32_t streamId);
    rtError_t GetStreamById(const uint32_t streamId, Stream **stm);
    rtError_t GetStreamSharedPtrById(const uint32_t streamId, std::shared_ptr<Stream> &sharedStm);

private:
    rtError_t Add(const uint32_t streamId, uint32_t drvFlag, uint32_t &sqId, uint32_t &cqId,
                  uint32_t * const info, const uint32_t len, uint32_t * const msg, const uint32_t msgLen);
    rtError_t Alloc(const uint32_t streamId, const uint32_t drvFlag, uint32_t &sqId, uint32_t &cqId,
                    uint32_t * const info, const uint32_t len, uint32_t * const msg, const uint32_t msgLen);
    rtError_t UnbindandFreeLogicCq(const uint32_t streamId);
private:
    std::mutex streamMapLock_;
    std::map<uint32_t, uint32_t> streamIdToSqIdMap_;
    std::map<uint32_t, uint32_t> sqIdToStreamIdMap_;     /* only for starsv2 */
    std::map<uint32_t, uint32_t> sqIdRefMap_;
    std::map<uint32_t, std::mutex> sqIdMutex_;
    std::mutex logicCqLock_;
    /* key1 is streamId, second key2 is threadId and value is logicCqId and isFastCq */
    std::map<uint32_t, std::map<uint64_t, rtLogicCqInfo_t>> logicCqIdMap_;
    Device *device_;
    uint32_t normalCq_{UINT32_MAX};
    std::mutex streamIdToStreamMapLock_;
    std::unordered_map<uint32_t, Stream *> streams_;      // key is streamId, value is Stream
};

}  // namespace runtime
}  // namespace cce

#endif  // CCE_RUNTIME_STREAM_SQCQ_MANAGE_HPP