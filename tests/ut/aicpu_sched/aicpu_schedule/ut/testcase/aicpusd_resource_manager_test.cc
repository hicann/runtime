/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#define private public

#include "aicpusd_resource_manager.h"

#undef private

#include "aicpusd_status.h"
#include <core/aicpusd_meminfo_process.h>

namespace AicpuSchedule {
    namespace {
        void FreeAllBuf()
        {
            for (size_t index = 0; index < 1024; index++) {
                BufManager::GetInstance().FreeBuf(index);
            }
        }

        void EndGraphWaitClearAll()
        {
            if (EventWaitManager::EndGraphWaitManager().count_ == 0 ||
                EventWaitManager::EndGraphWaitManager().CheckEvent(
                    true, true, EventWaitManager::EndGraphWaitManager().count_ - 1)) {
                return;
            }

            std::unique_lock<std::mutex> lock(EventWaitManager::EndGraphWaitManager().waitMutex_);
            for (size_t i = 0; i < EventWaitManager::EndGraphWaitManager().count_; i++) {
                EventWaitManager::EndGraphWaitManager().eventState_[i] = false;
                EventWaitManager::EndGraphWaitManager().waitStream_[i] = UINT32_MAX;
            }
        }

        void NotifyWaitManagerClearAll()
        {
            if (EventWaitManager::NotifyWaitManager().count_ == 0 ||
                EventWaitManager::NotifyWaitManager().CheckEvent(
                    true, true, EventWaitManager::NotifyWaitManager().count_ - 1)) {
                return;
            }

            std::unique_lock<std::mutex> lock(EventWaitManager::NotifyWaitManager().waitMutex_);
            for (size_t i = 0; i < EventWaitManager::NotifyWaitManager().count_; i++) {
                EventWaitManager::NotifyWaitManager().eventState_[i] = false;
                EventWaitManager::NotifyWaitManager().waitStream_[i] = UINT32_MAX;
            }
        }

        void QueueNotFullWaitClearAll()
        {
            if (EventWaitManager::QueueNotFullWaitManager().count_ == 0 ||
                EventWaitManager::QueueNotFullWaitManager().CheckEvent(
                    true, true, EventWaitManager::QueueNotFullWaitManager().count_ - 1)) {
                return;
            }

            std::unique_lock<std::mutex> lock(EventWaitManager::QueueNotFullWaitManager().waitMutex_);
            for (size_t i = 0; i < EventWaitManager::QueueNotFullWaitManager().count_; i++) {
                EventWaitManager::QueueNotFullWaitManager().eventState_[i] = false;
                EventWaitManager::QueueNotFullWaitManager().waitStream_[i] = UINT32_MAX;
            }
        }

        void QueueNotEmptyWaitClearAll()
        {
            if (EventWaitManager::QueueNotEmptyWaitManager().count_ == 0 ||
                EventWaitManager::QueueNotEmptyWaitManager().CheckEvent(
                    true, true, EventWaitManager::QueueNotEmptyWaitManager().count_ - 1)) {
                return;
            }

            std::unique_lock<std::mutex> lock(EventWaitManager::QueueNotEmptyWaitManager().waitMutex_);
            for (size_t i = 0; i < EventWaitManager::QueueNotEmptyWaitManager().count_; i++) {
                EventWaitManager::QueueNotEmptyWaitManager().eventState_[i] = false;
                EventWaitManager::QueueNotEmptyWaitManager().waitStream_[i] = UINT32_MAX;
            }
        }
    }

    class BufManagerUTEST : public testing::Test {
    protected:
        static void SetUpTestCase()
        {
            std::cout << "BufManagerUTEST SetUpTestCase" << std::endl;
        }

        static void TearDownTestCase()
        {
            std::cout << "BufManagerUTEST TearDownTestCase" << std::endl;
        }

        virtual void SetUp()
        {
            std::cout << "BufManagerUTEST SetUP" << std::endl;
        }

        virtual void TearDown()
        {
            FreeAllBuf();
            GlobalMockObject::verify();
            std::cout << "BufManagerUTEST TearDown" << std::endl;
        }
    };

    class EventWaitManagerUTEST : public testing::Test {
    protected:
        static void SetUpTestCase()
        {
            std::cout << "EventWaitManagerUTEST SetUpTestCase" << std::endl;
        }

        static void TearDownTestCase()
        {
            std::cout << "EventWaitManagerUTEST TearDownTestCase" << std::endl;
        }

        virtual void SetUp()
        {
            std::cout << "EventWaitManagerUTEST SetUP" << std::endl;
        }

        virtual void TearDown()
        {
            EndGraphWaitClearAll();
            NotifyWaitManagerClearAll();
            QueueNotFullWaitClearAll();
            QueueNotEmptyWaitClearAll();
            GlobalMockObject::verify();
            std::cout << "EventWaitManagerUTEST TearDown" << std::endl;
        }
    };

    namespace {
        int halMbufAllocFake(unsigned int size, unsigned int align, unsigned long flag, int grp_id, Mbuf **mbuf)
        {
            char *tmpBuf = new char[size];
            *mbuf = (Mbuf *) tmpBuf;
            return DRV_ERROR_NONE;
        }

        int halMbufFreeFake(Mbuf *mbuf)
        {
            char *tmpBuf = (char *) mbuf;
            delete[]tmpBuf;
            return DRV_ERROR_NONE;
        }

        int halMbufFreeErrorFake(Mbuf *mbuf)
        {
            char *tmpBuf = (char *) mbuf;
            delete[]tmpBuf;
            return DRV_ERROR_INNER_ERR;
        }
    }

    TEST_F(BufManagerUTEST, GuardBuf_param_check)
    {
        auto ret = BufManager::GetInstance().GuardBuf(nullptr, 0);
        EXPECT_EQ(ret, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
        auto ret1 = BufManager::GetInstance().UnGuardBuf(0, nullptr);
        EXPECT_EQ(ret1, AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID);
    }

    TEST_F(BufManagerUTEST, MallocAndGuardBuf_failed)
    {
        MOCKER(halMbufAllocEx).stubs().will(returnValue(305));
        Mbuf *buf = BufManager::GetInstance().MallocAndGuardBuf(10, 0);
        EXPECT_EQ(buf, nullptr);
    }

    TEST_F(BufManagerUTEST, GuardBuf_normal_test)
    {
        Mbuf *buf = nullptr;
        int ret = halMbufAllocFake(10, 64, 0, 0, &buf);
        EXPECT_EQ(ret, DRV_ERROR_NONE);
        EXPECT_NE(buf, nullptr);
        ret = BufManager::GetInstance().GuardBuf(buf, 0);
        EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
        // repeat guard with same module id
        ret = BufManager::GetInstance().GuardBuf(buf, 0);
        EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
        ret = BufManager::GetInstance().UnGuardBuf(0, buf);
        EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
        // repeat UnGuardBuf
        ret = BufManager::GetInstance().UnGuardBuf(1, buf);
        EXPECT_EQ(ret, AICPU_SCHEDULE_OK);
        ret = halMbufFreeFake(buf);
        EXPECT_EQ(ret, DRV_ERROR_NONE);
    }

    TEST_F(BufManagerUTEST, FreeBuf_bymodel)
    {
        MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
        MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFake));
        Mbuf *mbuf1 = BufManager::GetInstance().MallocAndGuardBuf(10, 0);
        EXPECT_NE(mbuf1, nullptr);
        Mbuf *mbuf2 = BufManager::GetInstance().MallocAndGuardBuf(10, 2);
        EXPECT_NE(mbuf2, nullptr);
        Mbuf *mbuf3 = BufManager::GetInstance().MallocAndGuardBuf(10, 2);
        EXPECT_NE(mbuf3, nullptr);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[0].size(), 1);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[2].size(), 2);
        BufManager::GetInstance().FreeBuf((uint32_t) 0);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[0].size(), 0);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[2].size(), 2);
        BufManager::GetInstance().FreeBuf(2);
        EXPECT_TRUE(BufManager::GetInstance().modelBufs_[0].empty());
        EXPECT_TRUE(BufManager::GetInstance().modelBufs_[0].empty());
    }

    TEST_F(BufManagerUTEST, FreeBuf_bymodel_error)
    {
        MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
        MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeErrorFake));
        Mbuf *mbuf1 = BufManager::GetInstance().MallocAndGuardBuf(10, 0);
        EXPECT_NE(mbuf1, nullptr);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[0].size(), 1);
        BufManager::GetInstance().FreeBuf((uint32_t) 0);
        EXPECT_TRUE(BufManager::GetInstance().modelBufs_[0].empty());
    }

    TEST_F(BufManagerUTEST, FreeBuf_all)
    {
        MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
        MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeFake));
        Mbuf *mbuf1 = BufManager::GetInstance().MallocAndGuardBuf(10, 0);
        EXPECT_NE(mbuf1, nullptr);
        Mbuf *mbuf2 = BufManager::GetInstance().MallocAndGuardBuf(10, 2);
        EXPECT_NE(mbuf2, nullptr);
        Mbuf *mbuf3 = BufManager::GetInstance().MallocAndGuardBuf(10, 2);
        EXPECT_NE(mbuf3, nullptr);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[0].size(), 1);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[2].size(), 2);
        FreeAllBuf();
        EXPECT_TRUE(BufManager::GetInstance().modelBufs_[0].empty());
        EXPECT_TRUE(BufManager::GetInstance().modelBufs_[2].empty());
    }

    TEST_F(BufManagerUTEST, FreeBuf_all_error)
    {
        uint32_t notifyId = 123;
        uint32_t waitStreamId = 12;
        bool needWait = false;
        EventWaitManager::NotifyWaitManager().WaitEvent(notifyId, waitStreamId, needWait);
        bool hasWait = false;
        uint32_t notifyStreamId = 0;
        EventWaitManager::NotifyWaitManager().Event(notifyId, hasWait, notifyStreamId);

        MOCKER(halMbufAllocEx).stubs().will(invoke(halMbufAllocFake));
        MOCKER(halMbufFree).stubs().will(invoke(halMbufFreeErrorFake));
        Mbuf *mbuf1 = BufManager::GetInstance().MallocAndGuardBuf(10, 0);
        EXPECT_NE(mbuf1, nullptr);
        EXPECT_EQ(BufManager::GetInstance().modelBufs_[0].size(), 1);
        FreeAllBuf();
        EXPECT_TRUE(BufManager::GetInstance().modelBufs_[0].empty());
    }

    TEST_F(EventWaitManagerUTEST, NotifyWaitManager_notity_first)
    {
        uint32_t notifyId = 123;

        bool hasWait = false;
        uint32_t notifyStreamId = 0;
        EventWaitManager::NotifyWaitManager().Event(notifyId, hasWait, notifyStreamId);
        EXPECT_FALSE(hasWait);

        uint32_t waitStreamId = 12;
        bool needWait = false;
        EventWaitManager::NotifyWaitManager().WaitEvent(notifyId, waitStreamId, needWait);
        EXPECT_FALSE(needWait);
    }

    TEST_F(EventWaitManagerUTEST, NotifyWaitManager_ClearBatch)
    {
        uint32_t notifyId = 123;

        bool hasWait = false;
        uint32_t notifyStreamId = 0;
        EventWaitManager::NotifyWaitManager().Event(notifyId, hasWait, notifyStreamId);
        EXPECT_FALSE(hasWait);

        EventWaitManager::NotifyWaitManager().ClearBatch({notifyId});

        uint32_t waitStreamId = 12;
        bool needWait = false;
        EventWaitManager::NotifyWaitManager().WaitEvent(notifyId, waitStreamId, needWait);
        EXPECT_TRUE(needWait);
    }

    TEST_F(EventWaitManagerUTEST, NotifyWaitManager_ResetEventState)
    {
        uint32_t notifyId = 123;

        bool hasWait = false;
        uint32_t notifyStreamId = 0;
        EventWaitManager::NotifyWaitManager().Event(notifyId, hasWait, notifyStreamId);
        EXPECT_FALSE(hasWait);

        EventWaitManager::NotifyWaitManager().ResetEventState(notifyId);

        uint32_t waitStreamId = 12;
        bool needWait = false;
        EventWaitManager::NotifyWaitManager().WaitEvent(notifyId, waitStreamId, needWait);
        EXPECT_TRUE(needWait);
    }

    TEST_F(BufManagerUTEST, InitBufManagerSuccess)
    {
        MOCKER(AicpuMemInfoProcess::GetMemZoneInfo).stubs().will(returnValue(0));
        BufManager::GetInstance().InitBufManager();
        EXPECT_EQ(BufManager::GetInstance().buffConfig_.cfg[0].cfg_id, 0);
    }

}