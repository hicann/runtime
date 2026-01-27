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
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "queue/ring_buffer.h"
#include "queue/report_buffer.h"
#include "queue/block_buffer.h"
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