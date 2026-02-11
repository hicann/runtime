/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "event.hpp"
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "osal.hpp"
#include "reference.hpp"
#ifndef WIN32
#include <pthread.h>
#endif

using namespace testing;
using namespace cce::runtime;

class OsalTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout<<"osal test start"<<std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout<<"osal test start end"<<std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

class MyRunnable: public ThreadRunnable
{
public:
    MyRunnable()
    {
        runFlag_ = 0;
    }
    void Run(const void *param)
    {
        runFlag_ = 1;
    }

    uint32_t  runFlag_;
};

TEST_F(OsalTest, notifier_triger_after_wait)
{
    Notifier * notifier = OsalFactory::CreateNotifier();
    rtError_t error;

    error = notifier->Triger();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notifier->Wait();
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = notifier->Reset();
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete notifier;
}


TEST_F(OsalTest, ref_object_test)
{
    bool updateFlag;
    uint64_t refVal;
    void *val;
    RefObject<void *> obj;

    refVal = obj.GetRef();
    EXPECT_EQ(refVal, 0);

    updateFlag = obj.IncRef();
    EXPECT_EQ(updateFlag, false);

    refVal = obj.GetRef();
    EXPECT_EQ(refVal, 0x8000000000000000ULL + 1);

    //obj.DecRef(); //deadlock test by manual
    //val = obj.GetVal(); //deadlock test by manual

    obj.SetVal(&updateFlag);

    refVal = obj.GetRef();
    EXPECT_EQ(refVal, 1);

    val = obj.GetVal(false);
    EXPECT_EQ(val, &updateFlag);

    updateFlag = obj.DecRef();
    EXPECT_EQ(updateFlag, false);

    refVal = obj.GetRef();
    EXPECT_EQ(refVal, 0x8000000000000000ULL);

    obj.ResetVal();

    refVal = obj.GetRef();
    EXPECT_EQ(refVal, 0);

    val = obj.GetVal(false);
    EXPECT_EQ(val, (void *)NULL);
}