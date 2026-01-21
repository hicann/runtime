/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <gtest/gtest.h>
#include <memory>
#include "single_list.h"

using namespace testing;

class UtestSingleListTest : public testing::Test {
 protected:
  void SetUp() {
  }

  void TearDown() {
  }
};

typedef struct {
  uint32_t key;
  uint32_t value;
  CSingleListNode node;
}StubNode;

TEST_F(UtestSingleListTest, SingleListCaseInsertHead) {
  CSingleList list;
  StubNode a = {0, 1};
  StubNode b = {1, 0};
  InitCSingleList(&list);

  ASSERT_TRUE(IsSingleListEmpty(&list));
  InsertCSingleListHead(&list, &a.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &a.node);
  EXPECT_TRUE(a.node.next == NULL);

  RemoveCSingleListNode(&list, &a.node);
  ASSERT_TRUE(IsSingleListEmpty(&list));
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);

  InsertCSingleListHead(&list, &a.node);
  InsertCSingleListHead(&list, &b.node);
  EXPECT_EQ(list.head, &b.node);
  EXPECT_EQ(list.tail, &a.node);
  EXPECT_EQ(b.node.next, &a.node);
  EXPECT_TRUE(a.node.next == NULL);

  RemoveCSingleListNode(&list, &a.node);
  EXPECT_EQ(list.head, &b.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  InsertCSingleListHead(&list, &a.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_EQ(a.node.next, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  RemoveCSingleListNode(&list, &a.node);
  EXPECT_EQ(list.head, &b.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  RemoveCSingleListNode(&list, &b.node);
  ASSERT_TRUE(IsSingleListEmpty(&list));
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);

  EXPECT_EQ(a.key, 0);
  EXPECT_EQ(a.value, 1);
  EXPECT_EQ(b.key, 1);
  EXPECT_EQ(b.value, 0);
}

TEST_F(UtestSingleListTest, SingleListCaseInsertTail) {
  CSingleList list;
  StubNode a, b, c;
  InitCSingleList(&list);

  ASSERT_TRUE(IsSingleListEmpty(&list));
  InsertCSingleListTail(&list, &a.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &a.node);
  EXPECT_TRUE(a.node.next == NULL);

  RemoveCSingleListNode(&list, &a.node);
  ASSERT_TRUE(IsSingleListEmpty(&list));
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);

  InsertCSingleListTail(&list, &a.node);
  InsertCSingleListTail(&list, &b.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_EQ(a.node.next, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  InsertCSingleListTail(&list, &c.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &c.node);
  EXPECT_EQ(a.node.next, &b.node);
  EXPECT_EQ(b.node.next, &c.node);
  EXPECT_TRUE(c.node.next == NULL);

  RemoveCSingleListNode(&list, &b.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &c.node);
  EXPECT_EQ(a.node.next, &c.node);
  EXPECT_TRUE(c.node.next == NULL);

  RemoveCSingleListTail(&list);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &a.node);
  EXPECT_TRUE(a.node.next == NULL);

  RemoveCSingleListTail(&list);
  ASSERT_TRUE(IsSingleListEmpty(&list));
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);
}

TEST_F(UtestSingleListTest, SingleListCaseInsertNode) {
  CSingleList list;
  StubNode a, b, c;
  InitCSingleList(&list);

  ASSERT_TRUE(IsSingleListEmpty(&list));
  InsertCSingleListHead(&list, &a.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &a.node);
  EXPECT_TRUE(a.node.next == NULL);

  InsertCSingleList(&list, &a.node, &b.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_EQ(a.node.next, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  InsertCSingleList(&list, &a.node, &c.node);
  EXPECT_EQ(list.head, &a.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_EQ(a.node.next, &c.node);
  EXPECT_EQ(c.node.next, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  RemoveCSingleListHead(&list);
  EXPECT_EQ(list.head, &c.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  RemoveCSingleListHead(&list);
  EXPECT_EQ(list.head, &b.node);
  EXPECT_EQ(list.tail, &b.node);
  EXPECT_TRUE(b.node.next == NULL);

  RemoveCSingleListHead(&list);
  ASSERT_TRUE(IsSingleListEmpty(&list));
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);
}

TEST_F(UtestSingleListTest, SingleListCaseForEach) {
  CSingleList list;
  StubNode a, b, c;
  InitCSingleList(&list);

  CSingleListNode *curNode;
  CSingleListNode *nextNode;
  int count = 0;
  CSingleListForEach(&list, curNode, nextNode) {
    count++;
  }

  InsertCSingleListHead(&list, &a.node);
  CSingleListForEach(&list, curNode, nextNode) {
    count++;
    RemoveCSingleListNode(&list, curNode);
  }
  EXPECT_EQ(count, 1);
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);

  InsertCSingleListHead(&list, &a.node);
  InsertCSingleListHead(&list, &b.node);
  count = 0;
  CSingleListForEach(&list, curNode, nextNode) {
    count++;
    RemoveCSingleListNode(&list, curNode);
  }
  EXPECT_EQ(count, 2);
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);

  InsertCSingleListHead(&list, &a.node);
  InsertCSingleListHead(&list, &b.node);
  InsertCSingleListHead(&list, &c.node);
  count = 0;
  CSingleListForEach(&list, curNode, nextNode) {
    count++;
    RemoveCSingleListNode(&list, curNode);
  }
  EXPECT_EQ(count, 3);
  EXPECT_TRUE(list.head == NULL);
  EXPECT_TRUE(list.tail == NULL);
}

TEST_F(UtestSingleListTest, SingleListCaseGetMain) {
  StubNode a;
  EXPECT_EQ(GET_MAIN_BY_MEMBER(&a.node, StubNode, node), &a);
  EXPECT_EQ(GET_MAIN_BY_MEMBER(&a.key, StubNode, key), &a);
}