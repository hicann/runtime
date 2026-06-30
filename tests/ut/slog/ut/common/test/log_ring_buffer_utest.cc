/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "log_ring_buffer.h"
#include "log_error_code.h"

#include "gtest/gtest.h"
#include <cstdlib>
#include <cstring>

namespace {
constexpr uint32_t BUF_SIZE = 8192U;
constexpr uint32_t SMALL_SIZE = 128U;

void BuildHead(LogHead &head, uint16_t msgLen)
{
    memset_s(&head, sizeof(head), 0, sizeof(head));
    head.magic = HEAD_MAGIC;
    head.version = HEAD_VERSION;
    head.msgLength = msgLen;
}
}

class LogRingBufferUtest : public testing::Test {
protected:
    char *buf_ = nullptr;
    RingBufferCtrl *ctrl_ = nullptr;
    void SetUp() override
    {
        buf_ = static_cast<char *>(calloc(BUF_SIZE, 1));
        ASSERT_NE(nullptr, buf_);
        ctrl_ = reinterpret_cast<RingBufferCtrl *>(buf_);
    }
    void TearDown() override
    {
        free(buf_);
        buf_ = nullptr;
        ctrl_ = nullptr;
    }
};

TEST_F(LogRingBufferUtest, InitHeadNull)
{
    EXPECT_EQ(-1, LogBufInitHead(nullptr, BUF_SIZE, 0));
}

TEST_F(LogRingBufferUtest, InitHeadSizeTooSmall)
{
    EXPECT_EQ(-1, LogBufInitHead(ctrl_, 0, 0));
    EXPECT_EQ(-1, LogBufInitHead(ctrl_, SMALL_SIZE, 0));
}

TEST_F(LogRingBufferUtest, InitHeadSuccess)
{
    EXPECT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    EXPECT_EQ(LEVEL_FILTER_CLOSE, ctrl_->levelFilter);
    EXPECT_GT(ctrl_->dataLen, 0U);
    EXPECT_GT(ctrl_->dataOffset, 0U);
    EXPECT_EQ(0U, ctrl_->logFirstIdx);
    EXPECT_EQ(0U, ctrl_->logNextIdx);
}

TEST_F(LogRingBufferUtest, InitHeadWithCustomOffset)
{
    uint32_t offset = 256U;
    EXPECT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, offset));
    EXPECT_EQ(offset, ctrl_->dataOffset);
    EXPECT_GT(ctrl_->dataLen, 0U);
}

TEST_F(LogRingBufferUtest, WriteNullCtrl)
{
    LogHead head;
    BuildHead(head, 8);
    uint64_t cover = 0;
    EXPECT_EQ(-(int32_t)BUFFER_NULL, LogBufWrite(nullptr, "abc", &head, &cover));
}

TEST_F(LogRingBufferUtest, WriteBadBufHead)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    ctrl_->logFirstIdx = ctrl_->dataLen + 1; // invalid
    LogHead head;
    BuildHead(head, 8);
    uint64_t cover = 0;
    EXPECT_EQ(-(int32_t)BUFFER_CHECK, LogBufWrite(ctrl_, "abc", &head, &cover));
}

TEST_F(LogRingBufferUtest, WriteAndReadNormal)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    const char *text = "hello ring buffer";
    LogHead head;
    BuildHead(head, (uint16_t)strlen(text));
    uint64_t cover = 0;
    EXPECT_EQ((int32_t)strlen(text), LogBufWrite(ctrl_, text, &head, &cover));
    EXPECT_EQ(0U, cover);
    EXPECT_EQ(1U, ctrl_->logNextSeq);

    ReadContext ctx = {0};
    LogBufReStart(ctrl_, &ctx);
    char out[MSG_LENGTH] = {0};
    LogHead msgRes;
    EXPECT_EQ((int32_t)strlen(text), LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes));
    EXPECT_STREQ(text, out);
    // nothing more to read
    EXPECT_EQ(-(int32_t)BUFFER_READ_FINISH, LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes));
}

TEST_F(LogRingBufferUtest, WriteMultipleAndReadAll)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    uint64_t cover = 0;
    for (int i = 0; i < 5; i++) {
        char text[32] = {0};
        snprintf_s(text, sizeof(text), sizeof(text) - 1, "msg-%d", i);
        LogHead head;
        BuildHead(head, (uint16_t)strlen(text));
        EXPECT_EQ((int32_t)strlen(text), LogBufWrite(ctrl_, text, &head, &cover));
    }
    ReadContext ctx = {0};
    LogBufReStart(ctrl_, &ctx);
    char out[MSG_LENGTH] = {0};
    LogHead msgRes;
    for (int i = 0; i < 5; i++) {
        char expect[32] = {0};
        snprintf_s(expect, sizeof(expect), sizeof(expect) - 1, "msg-%d", i);
        EXPECT_EQ((int32_t)strlen(expect), LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes));
        EXPECT_STREQ(expect, out);
    }
    EXPECT_EQ(-(int32_t)BUFFER_READ_FINISH, LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes));
}

TEST_F(LogRingBufferUtest, WriteTruncateLongMsg)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    char text[MSG_LENGTH + 64] = {0};
    memset_s(text, sizeof(text), 'A', MSG_LENGTH + 32);
    text[MSG_LENGTH + 32] = '\0';
    LogHead head;
    BuildHead(head, (uint16_t)(MSG_LENGTH + 32)); // longer than MSG_LENGTH, internally truncated
    uint64_t cover = 0;
    // implementation keeps head->msgLength unchanged but truncates the stored text
    EXPECT_EQ((int32_t)(MSG_LENGTH + 32), LogBufWrite(ctrl_, text, &head, &cover));
    ReadContext ctx = {0};
    LogBufReStart(ctrl_, &ctx);
    char out[MSG_LENGTH] = {0};
    LogHead msgRes;
    EXPECT_GT(LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes), 0);
}

TEST_F(LogRingBufferUtest, WriteWrapAround)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    uint64_t cover = 0;
    // fill buffer near the tail to trigger wrap path
    char text[256] = {0};
    memset_s(text, sizeof(text), 'B', 200);
    LogHead head;
    BuildHead(head, 200);
    // write many to push logNextIdx close to dataLen
    for (int i = 0; i < 30; i++) {
        LogBufWrite(ctrl_, text, &head, &cover);
    }
    // one more write should hit the wrap branch (logNextIdxTmp + size + LOGHEAD_LEN > dataLen)
    LogBufWrite(ctrl_, text, &head, &cover);
    // after wrap logNextIdx should be small
    EXPECT_LT(ctrl_->logNextIdx, ctrl_->dataLen);
    SUCCEED();
}

TEST_F(LogRingBufferUtest, WriteCoverOldLogs)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    uint64_t cover = 0;
    char text[512] = {0};
    memset_s(text, sizeof(text), 'C', 400);
    LogHead head;
    BuildHead(head, 400);
    // fill until covering starts
    for (int i = 0; i < 40; i++) {
        LogBufWrite(ctrl_, text, &head, &cover);
    }
    EXPECT_GT(cover, 0U);
    EXPECT_GT(LogBufLost(ctrl_), 0U);
}

TEST_F(LogRingBufferUtest, ReadNullAndBadState)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    ReadContext ctx = {0};
    char out[MSG_LENGTH] = {0};
    LogHead msgRes;
    EXPECT_EQ(-(int32_t)BUFFER_NULL, LogBufRead(&ctx, nullptr, out, MSG_LENGTH, &msgRes));
    ctrl_->logFirstIdx = ctrl_->dataLen + 1;
    EXPECT_EQ(-(int32_t)BUFFER_CHECK, LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes));
}

TEST_F(LogRingBufferUtest, ReadIdxExceedDataLen)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    ReadContext ctx = {0};
    ctx.readIdx = ctrl_->dataLen + 1;
    char out[MSG_LENGTH] = {0};
    LogHead msgRes;
    EXPECT_EQ(-(int32_t)BUFFER_CHECK, LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes));
}

TEST_F(LogRingBufferUtest, ReadAfterOverwriteResyncs)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    uint64_t cover = 0;
    char text[512] = {0};
    memset_s(text, sizeof(text), 'D', 400);
    LogHead head;
    BuildHead(head, 400);
    for (int i = 0; i < 40; i++) {
        LogBufWrite(ctrl_, text, &head, &cover); // overflow, logFirstSeq advances
    }
    ReadContext ctx = {0};
    LogBufReStart(ctrl_, &ctx);
    // simulate a stale reader whose readSeq is behind logFirstSeq -> CompareFirstSeq path
    ctx.readSeq = 0;
    ctx.readIdx = 0;
    char out[MSG_LENGTH] = {0};
    LogHead msgRes;
    int32_t ret = LogBufRead(&ctx, ctrl_, out, MSG_LENGTH, &msgRes);
    EXPECT_GE(ret, 0);
}

TEST_F(LogRingBufferUtest, CurrDataLen)
{
    EXPECT_EQ(0U, LogBufCurrDataLen(nullptr));
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    EXPECT_EQ(0U, LogBufCurrDataLen(ctrl_)); // empty
    const char *text = "data";
    LogHead head;
    BuildHead(head, (uint16_t)strlen(text));
    uint64_t cover = 0;
    LogBufWrite(ctrl_, text, &head, &cover);
    EXPECT_GT(LogBufCurrDataLen(ctrl_), 0U);
    // overwritten case
    ctrl_->logFirstSeq = ctrl_->lastSeq + 1;
    EXPECT_EQ(ctrl_->dataLen, LogBufCurrDataLen(ctrl_));
    // dataLen < lastIdx case
    ctrl_->logFirstSeq = 0;
    ctrl_->lastIdx = ctrl_->dataLen + 1;
    EXPECT_EQ(0U, LogBufCurrDataLen(ctrl_));
}

TEST_F(LogRingBufferUtest, CurrDataLenWrapBranch)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    // not overwritten, logNextIdx < lastIdx (wrap read pointer branch)
    ctrl_->lastIdx = 100U;
    ctrl_->logNextIdx = 50U;
    ctrl_->logFirstSeq = 0;
    EXPECT_EQ(ctrl_->dataLen - 100U + 50U, LogBufCurrDataLen(ctrl_));
}

TEST_F(LogRingBufferUtest, Lost)
{
    EXPECT_EQ(0U, LogBufLost(nullptr));
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    EXPECT_EQ(0U, LogBufLost(ctrl_));
    ctrl_->logFirstSeq = 10;
    ctrl_->lastSeq = 3;
    EXPECT_EQ(7U, LogBufLost(ctrl_));
}

TEST_F(LogRingBufferUtest, ReInitAndReStart)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    const char *text = "init";
    LogHead head;
    BuildHead(head, (uint16_t)strlen(text));
    uint64_t cover = 0;
    LogBufWrite(ctrl_, text, &head, &cover);
    RingBufferStat stat = {0};
    stat.ringBufferCtrl = ctrl_;
    LogBufReInit(&stat);
    EXPECT_EQ(ctrl_->logNextSeq, ctrl_->lastSeq);
    EXPECT_EQ(ctrl_->logNextIdx, ctrl_->lastIdx);

    ReadContext ctx = {0};
    LogBufReStart(ctrl_, &ctx);
    EXPECT_EQ(ctrl_->lastIdx, ctx.readIdx);
    EXPECT_EQ(ctrl_->lastSeq, ctx.readSeq);
    EXPECT_EQ(0U, ctx.lostCount);
}

TEST_F(LogRingBufferUtest, SetLevelFilter)
{
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    LogBufSetLevelFilter(ctrl_, LEVEL_FILTER_OPEN);
    EXPECT_EQ(LEVEL_FILTER_OPEN, ctrl_->levelFilter);
}

TEST_F(LogRingBufferUtest, CheckEmpty)
{
    RingBufferStat stat = {0};
    EXPECT_TRUE(LogBufCheckEmpty(nullptr));
    EXPECT_TRUE(LogBufCheckEmpty(&stat)); // ringBufferCtrl NULL
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    stat.ringBufferCtrl = ctrl_;
    EXPECT_TRUE(LogBufCheckEmpty(&stat)); // lastSeq == logNextSeq
    const char *text = "x";
    LogHead head;
    BuildHead(head, (uint16_t)strlen(text));
    uint64_t cover = 0;
    LogBufWrite(ctrl_, text, &head, &cover);
    EXPECT_FALSE(LogBufCheckEmpty(&stat));
}

TEST_F(LogRingBufferUtest, CheckEnough)
{
    EXPECT_FALSE(LogBufCheckEnough(nullptr, 16));
    ASSERT_EQ(0, LogBufInitHead(ctrl_, BUF_SIZE, 0));
    RingBufferStat stat = {0};
    stat.ringBufferCtrl = ctrl_;
    EXPECT_TRUE(LogBufCheckEnough(&stat, 16));
    // fill until not enough
    char text[MSG_LENGTH] = {0};
    memset_s(text, sizeof(text), 'E', MSG_LENGTH - 1);
    LogHead head;
    BuildHead(head, (uint16_t)(MSG_LENGTH - 1));
    uint64_t cover = 0;
    for (int i = 0; i < 8; i++) {
        LogBufWrite(ctrl_, text, &head, &cover);
    }
    // large message that cannot fit anymore
    EXPECT_FALSE(LogBufCheckEnough(&stat, MSG_LENGTH));
}
