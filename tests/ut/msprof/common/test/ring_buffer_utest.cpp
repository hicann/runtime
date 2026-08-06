/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string>
#include <memory>
#include <thread>
#include <vector>
#include <atomic>
#include <cstring>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "queue/ring_buffer.h"
#include "queue/report_buffer.h"
#include "queue/block_buffer.h"
#include "queue/variable_block_buffer.h"
#include "prof_api.h"
#include "prof_common.h"
#include "utils/utils.h"

using namespace analysis::dvvp::common::queue;

class COMMON_QUEUE_RING_BUFFER_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
private:
    std::string _log_file;
};

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));
    EXPECT_NE(nullptr, bq);
    bq.reset();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer_Init) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));
    EXPECT_NE(nullptr, bq);
    std::string name;
    bq->Init(2, name);
    bq.reset();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer_UnInit) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));
    EXPECT_NE(nullptr, bq);
    std::string name;
    bq->Init(2, name);
    bq->UnInit();
    bq.reset();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer_SetQuit) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));
    EXPECT_NE(nullptr, bq);
    std::string name;
    bq->Init(2, name);
    bq->SetQuit();
    bq->UnInit();
    bq.reset();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer_TryPush) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));

    //not inited
    EXPECT_EQ(false, bq->TryPush(1));

    std::string name;
    bq->Init(2, name);

    //exceeded max cycles
    bq->maxCycles_ = 0;
    EXPECT_EQ(false, bq->TryPush(1));

    //not exceed max cycles
    bq->maxCycles_ = 1024;
    EXPECT_EQ(true, bq->TryPush(1));

    //queue is full
    EXPECT_EQ(false, bq->TryPush(1));

    //queue quits
    bq->SetQuit();
    EXPECT_EQ(false, bq->TryPush(1));

    bq.reset();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer_TryPop) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));
    int data = -1;
    //not inited
    EXPECT_EQ(false, bq->TryPop(data));

    std::string name;
    bq->Init(2, name);
    //queue is empty
    EXPECT_EQ(false, bq->TryPop(data));
    bq->TryPush(1);
    //not ready
    bq->dataAvails_[0] = static_cast<int>(DataStatus::DATA_STATUS_NOT_READY);
    EXPECT_EQ(false, bq->TryPop(data));

    bq->dataAvails_[0] = static_cast<int>(DataStatus::DATA_STATUS_READY);
    EXPECT_EQ(true, bq->TryPop(data));
    EXPECT_EQ(1, data);

    bq.reset();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, RingBuffer_GetUsedSize) {
    std::shared_ptr<RingBuffer<int> > bq(new RingBuffer<int>(-1));

    std::string name;
    bq->Init(4, name);
    EXPECT_EQ(0, bq->GetUsedSize());

    bq->TryPush(1);
    EXPECT_EQ(1, bq->GetUsedSize());

    bq->TryPush(2);
    EXPECT_EQ(2, bq->GetUsedSize());

    bq->TryPush(3);
    EXPECT_EQ(3, bq->GetUsedSize());

    EXPECT_EQ(false, bq->TryPush(4));
    EXPECT_EQ(3, bq->GetUsedSize());

    EXPECT_EQ(0, bq->readIndex_.load());
    EXPECT_EQ(3, bq->writeIndex_.load());

    int data = -1;
    EXPECT_EQ(true, bq->TryPop(data));
    EXPECT_EQ(1, data);
    EXPECT_EQ(2, bq->GetUsedSize());

    EXPECT_EQ(1, bq->readIndex_.load());
    EXPECT_EQ(3, bq->writeIndex_.load());

    EXPECT_EQ(true, bq->TryPop(data));
    EXPECT_EQ(2, data);
    EXPECT_EQ(1, bq->GetUsedSize());

    EXPECT_EQ(2, bq->readIndex_.load());
    EXPECT_EQ(3, bq->writeIndex_.load());

    EXPECT_EQ(true, bq->TryPop(data));
    EXPECT_EQ(3, data);
    EXPECT_EQ(0, bq->GetUsedSize());

    EXPECT_EQ(3, bq->readIndex_.load());
    EXPECT_EQ(3, bq->writeIndex_.load());

    bq->TryPush(4);
    EXPECT_EQ(1, bq->GetUsedSize());

    EXPECT_EQ(3, bq->readIndex_.load());
    EXPECT_EQ(4, bq->writeIndex_.load());

    bq->TryPush(5);
    EXPECT_EQ(2, bq->GetUsedSize());

    EXPECT_EQ(3, bq->readIndex_.load());
    EXPECT_EQ(5, bq->writeIndex_.load());

    EXPECT_EQ(true, bq->TryPop(data));
    EXPECT_EQ(4, data);
    EXPECT_EQ(1, bq->GetUsedSize());

    EXPECT_EQ(4, bq->readIndex_.load());
    EXPECT_EQ(5, bq->writeIndex_.load());

    EXPECT_EQ(true, bq->TryPop(data));
    EXPECT_EQ(5, data);
    EXPECT_EQ(0, bq->GetUsedSize());

    EXPECT_EQ(5, bq->readIndex_.load());
    EXPECT_EQ(5, bq->writeIndex_.load());

    EXPECT_EQ(false, bq->TryPop(data));

    bq->readIndex_ = ((size_t)0xFFFFFFFFFFFFFFFF) - 2;
    bq->writeIndex_ = 2;
    EXPECT_EQ(5, bq->GetUsedSize());
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, ReportBuffer_GetUsedSize) {
    std::shared_ptr<ReportBuffer<int> > bq(new ReportBuffer<int>(-1));

    std::string name = "test";
    bq->Init(4, name);
    EXPECT_EQ(4, bq->capacity_);

    bq->TryPush(1, 1);
    EXPECT_EQ(1, bq->GetUsedSize());
    bq->TryPush(1, 2);
    EXPECT_EQ(2, bq->GetUsedSize());
    bq->TryPush(1, 3);
    EXPECT_EQ(3, bq->GetUsedSize());
    bq->TryPush(1, 4);
    EXPECT_EQ(0, bq->GetUsedSize());

    EXPECT_EQ(0, bq->readIndex_.load());
    EXPECT_EQ(4, bq->writeIndex_.load());

    bq->TryPush(1, 5);
    EXPECT_EQ(1, bq->GetUsedSize());

    int data = -1;
    uint32_t age = 0;
    EXPECT_EQ(true, bq->TryPop(age, data));
    EXPECT_EQ(5, data);
    EXPECT_EQ(0, bq->GetUsedSize());

    EXPECT_EQ(false, bq->TryPop(age, data));
    bq->UnInit();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, ReportBuffer_MultiPushPopTest) {
    std::shared_ptr<ReportBuffer<MsprofCompactInfo>> bq(new ReportBuffer<MsprofCompactInfo>(MsprofCompactInfo{}));
    std::string name = "multiTest";
    bq->Init(COM_RING_BUFF_CAPACITY, name);

    std::vector<std::thread> th;
    th.push_back(std::thread([this, bq]() -> void {
        for (auto i = 0; i < 1000000; i++) {
            uint32_t age = 0;
            MsprofCompactInfo dataGet;
            bool ret = bq->TryPop(age, dataGet);
            if (ret) {
                EXPECT_EQ(10000, dataGet.level);
                EXPECT_EQ(802, dataGet.type);
                EXPECT_EQ(151515151, dataGet.timeStamp);
                EXPECT_EQ(1, age);
            } else {
                EXPECT_TRUE(age == 0);
            }
            analysis::dvvp::common::utils::Utils::UsleepInterupt(10);
        }
    }));

    MsprofCompactInfo data;
    MsprofNodeBasicInfo *nodeInfo = reinterpret_cast<MsprofNodeBasicInfo *>(&data.data);
    nodeInfo->opName = 123456789;
    nodeInfo->opType = 12345678910;
    data.level = 10000;
    data.type = 802;
    data.timeStamp = 151515151;
    for (auto i = 0; i < 10; i++) {
        th.push_back(std::thread([this, bq, data]() -> void {
            for (auto i = 0; i < 10000; i++) {
                bq->TryPush(1, data);
            }
        }));
    }

    for_each(th.begin(), th.end(), std::mem_fn(&std::thread::join));
    bq->UnInit();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, BlockBuffer_BasePushPopTest) {
    std::shared_ptr<BlockBuffer<MsprofAdditionalInfo>> bq(new BlockBuffer<MsprofAdditionalInfo>());
    std::string name = "BaseBlockBufferTest";
    EXPECT_EQ(false, bq->Init(name, 0));
    EXPECT_EQ(false, bq->Init(name, 4));
    EXPECT_EQ(true, bq->Init(name, 4096));
    // push aicpu data
    MsprofAdditionalInfo data;
    data.level = 6000; // aicpu
    data.type = 2;
    data.timeStamp = 151515151;
    bq->BatchPush(&data, sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(1, bq->GetUsedSize());
    // push hccl data
    data.level = 5500; // hccl
    data.type = 10;
    data.timeStamp = 131313131;
    bq->BatchPush(&data, sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(2, bq->GetUsedSize());
    // init prof_drv buffer
    void *drvBufPtr = malloc(1024); // 1024byte
    (void)memset_s(drvBufPtr, 1024, 0, 1024);
    // pop 1024 data, offset 0byte, buffer only 512byte data
    size_t outSize = 1024;
    EXPECT_EQ(nullptr, bq->BatchPop(outSize, false)); // pop 0 additional data
    // pop 512byte data, offset 512byte
    outSize = 512;
    void *outPtr = bq->BatchPop(outSize, false);
    EXPECT_NE(nullptr, outPtr); // pop 2 additional data
    (void)memcpy_s(drvBufPtr + 512, outSize, outPtr, outSize);
    bq->BatchPopBufferIndexShift(outPtr, outSize);
    // test prof_drv buffer data: [0, 0, pop data, pop data]
    MsprofAdditionalInfo dataGet;
    (void)memcpy_s(&dataGet, 256, drvBufPtr, 256);
    EXPECT_EQ(0, dataGet.level);
    EXPECT_EQ(0, dataGet.type);
    EXPECT_EQ(0, dataGet.timeStamp);
    (void)memcpy_s(&dataGet, 256, drvBufPtr + 256, 256);
    EXPECT_EQ(0, dataGet.level);
    EXPECT_EQ(0, dataGet.type);
    EXPECT_EQ(0, dataGet.timeStamp);
    (void)memcpy_s(&dataGet, 256, drvBufPtr + 512, 256);
    EXPECT_EQ(6000, dataGet.level);
    EXPECT_EQ(2, dataGet.type);
    EXPECT_EQ(151515151, dataGet.timeStamp);
    (void)memcpy_s(&dataGet, 256, drvBufPtr + 768, 256);
    EXPECT_EQ(5500, dataGet.level);
    EXPECT_EQ(10, dataGet.type);
    EXPECT_EQ(131313131, dataGet.timeStamp);
    free(drvBufPtr);
    bq->UnInit();
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, BlockBuffer_TimeTest) {
    MsprofAdditionalInfo data;
    data.level = 5500; // hccl
    data.type = 10;
    data.timeStamp = 131313131;
    MsprofHcclInfo *hcclInfo = reinterpret_cast<MsprofHcclInfo *>(&data.data);
    hcclInfo->dataType = 1;
    hcclInfo->opType = 1;

    void *hcclBufPtr = malloc(131072);
    (void)memset_s(hcclBufPtr, 131072, 0, 131072);
    MsprofAdditionalInfo *addInfo = reinterpret_cast<MsprofAdditionalInfo *>(hcclBufPtr);
    for (auto i = 0; i < 512; i++) {
        *(addInfo + i) = data;
    }

    std::shared_ptr<BlockBuffer<MsprofAdditionalInfo>> bq(new BlockBuffer<MsprofAdditionalInfo>());
    std::string name = "TimeBlockBufferTest";
    bq->Init(name, BLOCK_BUFF_CAPACITY);
    uint64_t startRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    bq->BatchPush(addInfo, 512 * sizeof(MsprofAdditionalInfo));
    uint64_t endRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    MSPROF_LOGI("Block buffer try push in time: %llu ns.", endRawTime - startRawTime);
    EXPECT_EQ(512, bq->GetUsedSize());
    bq->UnInit();

    std::shared_ptr<ReportBuffer<MsprofAdditionalInfo>> rq(new ReportBuffer<MsprofAdditionalInfo>(MsprofAdditionalInfo{}));
    std::string name2 = "TimeReportBufferTest";
    rq->Init(ADD_RING_BUFF_CAPACITY, name2);
    startRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    for (auto i = 0; i < 512; i++) {
        rq->Push(1, *(addInfo + i));
    }
    endRawTime = analysis::dvvp::common::utils::Utils::GetClockMonotonicRaw();
    MSPROF_LOGI("Report buffer try push in time: %llu ns.", endRawTime - startRawTime);
    EXPECT_EQ(512, rq->GetUsedSize());
    rq->UnInit();
    free(hcclBufPtr);
}

TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, BlockBuffer_LargePushPopTest) {
    MsprofAdditionalInfo data;
    data.level = 5500; // hccl
    data.type = 10;
    data.timeStamp = 131313131;
    MsprofHcclInfo *hcclInfo = reinterpret_cast<MsprofHcclInfo *>(&data.data);
    hcclInfo->dataType = 1;
    hcclInfo->opType = 1;

    void *hcclBufPtr = malloc(262144);
    (void)memset_s(hcclBufPtr, 262144, 0, 262144);
    MsprofAdditionalInfo *addInfo = reinterpret_cast<MsprofAdditionalInfo *>(hcclBufPtr);
    for (auto i = 0; i < 1024; i++) {
        *(addInfo + i) = data;
    }

    std::shared_ptr<BlockBuffer<MsprofAdditionalInfo>> bq(new BlockBuffer<MsprofAdditionalInfo>());
    std::string name = "LargeBlockBufferTest";
    bq->Init(name, 4096);
    // push pop 2048
    bq->BatchPush(addInfo, 1024 * sizeof(MsprofAdditionalInfo));
    bq->BatchPush(addInfo, 1024 * sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(2048, bq->GetUsedSize());
    size_t outSize = 1024 * sizeof(MsprofAdditionalInfo);
    void *outPtr = bq->BatchPop(outSize, false);
    EXPECT_TRUE(1024 * sizeof(MsprofAdditionalInfo) == outSize);
    bq->BatchPopBufferIndexShift(outPtr, outSize);
    outPtr = bq->BatchPop(outSize, false);
    EXPECT_TRUE(1024 * sizeof(MsprofAdditionalInfo) == outSize);
    bq->BatchPopBufferIndexShift(outPtr, outSize);
    // push pop 1536
    bq->Init(name, 4096);
    bq->BatchPush(addInfo, 1024 * sizeof(MsprofAdditionalInfo));
    bq->BatchPush(addInfo, 512 * sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(1536, bq->GetUsedSize());
    outSize = 1536 * sizeof(MsprofAdditionalInfo);
    outPtr = bq->BatchPop(outSize, false);
    EXPECT_TRUE(1536 * sizeof(MsprofAdditionalInfo) == outSize);
    bq->BatchPopBufferIndexShift(outPtr, outSize);
    // front and end test
    bq->BatchPush(addInfo, 1024 * sizeof(MsprofAdditionalInfo));
    EXPECT_EQ(1024, bq->GetUsedSize());
    outSize = 1024 * sizeof(MsprofAdditionalInfo);
    outPtr = bq->BatchPop(outSize, false);
    EXPECT_EQ(512 * sizeof(MsprofAdditionalInfo), outSize);
    bq->BatchPopBufferIndexShift(outPtr, outSize);
    outPtr = bq->BatchPop(outSize, true);
    EXPECT_EQ(512 * sizeof(MsprofAdditionalInfo), outSize);
    bq->BatchPopBufferIndexShift(outPtr, outSize);
    bq->UnInit();
    free(hcclBufPtr);
}

// ---------------------------------------------------------------------------
// VariableBlockBuffer tests
// ---------------------------------------------------------------------------

// Init / UnInit and not-initialized guards: capacity below the minimum is rejected, a valid
// capacity succeeds, repeat init is a no-op, and push/pop on an uninitialized buffer are safe.
TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, VariableBlockBuffer_InitAndUnInit) {
    // push/pop before init are rejected without crashing
    std::shared_ptr<VariableBlockBuffer> uninit(new VariableBlockBuffer());
    const char data[16] = {0};
    EXPECT_EQ(MSPROF_ERROR_UNINITIALIZE, uninit->BatchPush(data, sizeof(data)));
    size_t popSize = 1;
    EXPECT_EQ(nullptr, uninit->BatchPop(popSize));

    std::shared_ptr<VariableBlockBuffer> bq(new VariableBlockBuffer());
    EXPECT_NE(nullptr, bq);
    // capacity smaller than MIN_VARIABLE_BLOCK_BUFF_CAPACITY (2048) is rejected
    EXPECT_EQ(false, bq->Init("VbbTooSmall", 1024));
    // valid capacity succeeds
    EXPECT_EQ(true, bq->Init("VbbOk", 4096));
    // repeat init returns true without re-allocating
    EXPECT_EQ(true, bq->Init("VbbOk", 4096));
    bq->UnInit();
}

// Push/pop behaviour: single round-trip, multi-segment contiguous pop in order, data cleared after
// shift, plus defensive early-returns (pop with size 0, index-shift with null ptr / zero size).
TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, VariableBlockBuffer_PushPopTest) {
    std::shared_ptr<VariableBlockBuffer> bq(new VariableBlockBuffer());
    EXPECT_EQ(true, bq->Init("VbbPushPop", 4096));

    // defensive early-returns on an empty buffer
    size_t zero = 0;
    EXPECT_EQ(nullptr, bq->BatchPop(zero));
    char dummy[8] = {0};
    bq->BatchPopBufferIndexShift(nullptr, 16);
    bq->BatchPopBufferIndexShift(dummy, 0);

    // single push/pop round-trip: popped data equals pushed data, region cleared after shift
    const char msg[] = "variable-block-payload";
    const size_t len = sizeof(msg);
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->BatchPush(msg, len));
    EXPECT_EQ(len, bq->GetUsedSize());
    size_t popSize = 1;
    void *outPtr = bq->BatchPop(popSize);
    EXPECT_NE(nullptr, outPtr);
    EXPECT_EQ(len, popSize);
    EXPECT_EQ(0, memcmp(outPtr, msg, len));
    bq->BatchPopBufferIndexShift(outPtr, popSize);
    EXPECT_EQ(0U, bq->GetUsedSize());

    // multiple variable-length segments are popped as one contiguous span, in push order
    const char a[] = {1, 2, 3};
    const char b[] = {4, 5, 6, 7, 8};
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->BatchPush(a, sizeof(a)));
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->BatchPush(b, sizeof(b)));
    EXPECT_EQ(sizeof(a) + sizeof(b), bq->GetUsedSize());
    size_t popSize2 = 1;
    void *outPtr2 = bq->BatchPop(popSize2);
    EXPECT_NE(nullptr, outPtr2);
    EXPECT_EQ(sizeof(a) + sizeof(b), popSize2);
    const char expect[] = {1, 2, 3, 4, 5, 6, 7, 8};
    EXPECT_EQ(0, memcmp(outPtr2, expect, sizeof(expect)));
    bq->BatchPopBufferIndexShift(outPtr2, popSize2);
    EXPECT_EQ(0U, bq->GetUsedSize());
    bq->UnInit();
}

// Ring boundary behaviour: a single pop never crosses the ring end (the wrapped tail is returned
// on the next pop), and when the buffer is full and never drained BatchPush bails out at maxCycles_
// returning MSPROF_ERROR_NONE instead of hanging.
TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, VariableBlockBuffer_WrapAndOverflow) {
    std::shared_ptr<VariableBlockBuffer> bq(new VariableBlockBuffer());
    const size_t cap = 4096;
    EXPECT_EQ(true, bq->Init("VbbWrap", cap));

    // advance write/read cursors close to the ring end so the next push wraps
    std::vector<char> chunk(1024, 0);
    for (int i = 0; i < 3; ++i) {
        EXPECT_EQ(MSPROF_ERROR_NONE, bq->BatchPush(chunk.data(), chunk.size()));
        size_t popSize = 1;
        void *p = bq->BatchPop(popSize);
        EXPECT_NE(nullptr, p);
        bq->BatchPopBufferIndexShift(p, popSize);
    }
    // now write cursor is at 3072; push 1536 bytes -> wraps the 4096 ring
    std::vector<char> big(1536);
    for (size_t i = 0; i < big.size(); ++i) {
        big[i] = static_cast<char>(i & 0xFF);
    }
    EXPECT_EQ(MSPROF_ERROR_NONE, bq->BatchPush(big.data(), big.size()));
    EXPECT_EQ(big.size(), bq->GetUsedSize());

    // first pop returns only the contiguous tail (cap - 3072 = 1024 bytes)
    size_t popSize = 1;
    void *outPtr = bq->BatchPop(popSize);
    EXPECT_NE(nullptr, outPtr);
    EXPECT_EQ(cap - 3072, popSize);
    EXPECT_EQ(0, memcmp(outPtr, big.data(), popSize));
    bq->BatchPopBufferIndexShift(outPtr, popSize);

    // second pop returns the wrapped remainder
    size_t remain = big.size() - (cap - 3072);
    size_t popSize2 = 1;
    void *outPtr2 = bq->BatchPop(popSize2);
    EXPECT_NE(nullptr, outPtr2);
    EXPECT_EQ(remain, popSize2);
    EXPECT_EQ(0, memcmp(outPtr2, big.data() + (cap - 3072), remain));
    bq->BatchPopBufferIndexShift(outPtr2, popSize2);
    EXPECT_EQ(0U, bq->GetUsedSize());
    bq->UnInit();

    // cycle overflow: small ring (maxCycles_ = 2), fill it and never drain -> second push that
    // cannot fit exhausts maxCycles_ and returns NONE (record dropped) rather than spinning forever
    std::shared_ptr<VariableBlockBuffer> full(new VariableBlockBuffer(2));
    EXPECT_EQ(true, full->Init("VbbCycle", 2048));
    std::vector<char> filler(2000, 7);
    EXPECT_EQ(MSPROF_ERROR_NONE, full->BatchPush(filler.data(), filler.size()));
    EXPECT_EQ(MSPROF_ERROR_NONE, full->BatchPush(filler.data(), filler.size()));
    full->UnInit();
}

// Concurrency: multiple producers + one consumer. Verifies the ordered-commit fix guarantees that
// BatchPop never observes a region whose memcpy has not finished (no torn/partial records).
TEST_F(COMMON_QUEUE_RING_BUFFER_TEST, VariableBlockBuffer_ConcurrentProducers) {
    // each record: [producerId][seq][payload bytes all equal to (id ^ seq) & 0xFF], fixed size
    struct Rec {
        uint32_t id;
        uint32_t seq;
        char pad[56];
    };
    const size_t recSize = sizeof(Rec);

    std::shared_ptr<VariableBlockBuffer> bq(new VariableBlockBuffer());
    EXPECT_EQ(true, bq->Init("VbbConcurrent", 65536));

    std::atomic<bool> stop(false);
    std::atomic<long> corrupt(0);
    std::atomic<long> popped(0);

    std::thread consumer([&]() {
        while (!stop.load() || bq->GetUsedSize() != 0) {
            size_t popSize = 1;
            void *p = bq->BatchPop(popSize);
            if (p == nullptr) {
                continue;
            }
            char *base = static_cast<char *>(p);
            for (size_t off = 0; off + recSize <= popSize; off += recSize) {
                Rec *r = reinterpret_cast<Rec *>(base + off);
                char expect = static_cast<char>((r->id ^ r->seq) & 0xFF);
                for (size_t k = 0; k < sizeof(r->pad); ++k) {
                    if (r->pad[k] != expect) {
                        corrupt.fetch_add(1);
                        break;
                    }
                }
                popped.fetch_add(1);
            }
            size_t whole = (popSize / recSize) * recSize;
            bq->BatchPopBufferIndexShift(p, whole > 0 ? whole : popSize);
        }
    });

    const uint32_t perProducer = 10000;
    auto producer = [&](uint32_t id) {
        Rec r;
        r.id = id;
        for (uint32_t s = 0; s < perProducer; ++s) {
            r.seq = s;
            char v = static_cast<char>((id ^ s) & 0xFF);
            (void)memset_s(r.pad, sizeof(r.pad), v, sizeof(r.pad));
            (void)bq->BatchPush(reinterpret_cast<const char *>(&r), recSize);
        }
    };

    std::vector<std::thread> producers;
    for (uint32_t i = 0; i < 4; ++i) {
        producers.emplace_back(producer, i + 1);
    }
    for (auto &t : producers) {
        t.join();
    }
    stop.store(true);
    consumer.join();

    // ordered-commit + release/acquire must guarantee zero torn records
    EXPECT_EQ(0, corrupt.load());
    bq->UnInit();
}