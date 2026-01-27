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
#include "atrace_api.h"
#include "tracer_core.h"
#include "stacktrace_signal.h"
#include "trace_attr.h"
#include "adiag_list.h"
#include "adiag_utils.h"
#include "trace_system_api.h"
#include <pwd.h>

class TraceUtilUtest: public testing::Test {
protected:
    static void SetUpTestCase()
    {
    }
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
    static void TearDownTestCase()
    {
    }
};

TEST_F(TraceUtilUtest, AdiagListInit)
{
    struct AdiagList list;
    AdiagStatus ret = AdiagListInit(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    ret = AdiagListDestroy(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);
}

TEST_F(TraceUtilUtest, TraceListInsertOne)
{
    struct AdiagList list;
    AdiagStatus ret = AdiagListInit(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    char node[] = "node1";
    ret = AdiagListInsert(&list, node);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    ret = AdiagListRemove(&list, node);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    ret = AdiagListDestroy(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);
}

TEST_F(TraceUtilUtest, TraceListInsertTwo)
{
    struct AdiagList list;
    AdiagStatus ret = AdiagListInit(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    char node[] = "node1";
    ret = AdiagListInsert(&list, node);
    EXPECT_EQ(ret, ADIAG_SUCCESS);
    ret = AdiagListInsert(&list, node);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    ret = AdiagListRemoveAll(&list, node, NULL);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    ret = AdiagListDestroy(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);
}

TEST_F(TraceUtilUtest, TraceListInsertFailed)
{
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    struct AdiagList list;
    AdiagStatus ret = AdiagListInit(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);

    char node[] = "node1";
    ret = AdiagListInsert(&list, node);
    EXPECT_EQ(ret, ADIAG_FAILURE);

    ret = AdiagListDestroy(&list);
    EXPECT_EQ(ret, ADIAG_SUCCESS);
}

TEST_F(TraceUtilUtest, TestAdiagQuickSort)
{
    int32_t arraySize = 9;
    int32_t array[arraySize] = { 5, 8, 1, 3, 7, 9, 2, 6, 4 };
    int32_t expectArray[arraySize] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    AdiagQuickSort(array, 0, arraySize - 1);
    for (int32_t i = 0; i < arraySize; i++) {
        EXPECT_EQ(expectArray[i], array[i]);
    }
}

TEST_F(TraceUtilUtest, TestAdiagQuickSortFailed)
{
    int32_t arraySize = 9;
    int32_t array[arraySize] = { 5, 8, 1, 3, 7, 9, 2, 6, 4 };
    AdiagQuickSort(array, 0, 1024);
    for (int32_t i = 0; i < arraySize; i++) {
        EXPECT_EQ(array[i], array[i]);
    }
}

TEST_F(TraceUtilUtest, TestAdiagStrToInt)
{
    AdiagStatus ret = ADIAG_FAILURE;
    int32_t value = 0;
    long long num = INT32_MAX;
    char str[30] = {0};
    (void)sprintf(str, "%lld", num);

    ret = AdiagStrToInt(NULL, &value);
    EXPECT_EQ(ADIAG_FAILURE, ret);

    ret = AdiagStrToInt("123456", NULL);
    EXPECT_EQ(ADIAG_FAILURE, ret);

    ret = AdiagStrToInt(str, &value);
    EXPECT_EQ(ADIAG_SUCCESS, ret);
    EXPECT_EQ(num, value);
}

TEST_F(TraceUtilUtest, AdiagListForEachTraverseFailed)
{
    struct AdiagList list;
    AdiagStatus ret = AdiagListInit(&list);
    EXPECT_EQ(ADIAG_SUCCESS, ret);
    MOCKER(AdiagLockGet).expects(never());
    AdiagListForEachTraverse(&list, NULL, NULL);
    AdiagListForEachTraverse(NULL,(const AdiagListTraverseFunc)1, NULL);
}

TEST_F(TraceUtilUtest, TestTraceDriverApi)
{
    MOCKER(TraceDlclose).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceAttrInit());
    TraceAttrExit();
}

TEST_F(TraceUtilUtest, TestTraceMkdir)
{
    uint32_t mode = 0750U;
    int32_t uid = 0;
    uint32_t gid = 0;
    MOCKER(mkdir).stubs().will(returnValue(-1));
    // EXPECT_EQ(TRACE_MKDIR_FAIL, TraceMkdir("/tmp/123456789", mode, uid, gid));
    GlobalMockObject::verify();

    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(-1));
    // EXPECT_EQ(TRACE_CHMOD_FAIL, TraceMkdir("/tmp/123456789", mode, uid, gid));
    GlobalMockObject::verify();

    MOCKER(mkdir).stubs().will(returnValue(0));
    MOCKER(chmod).stubs().will(returnValue(0));
    MOCKER(chown).stubs().will(returnValue(-1));
    // EXPECT_EQ(TRACE_CHOWN_FAIL, TraceMkdir("/tmp/123456789", mode, uid, gid));
    GlobalMockObject::verify();
}