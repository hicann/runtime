/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "slogd_group_log.h"
extern "C"
{
extern int AddNewGroup(GroupInfo *groupInfo, char *groupLogPath, unsigned int pathLen);
};
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#define LLT_SLOG_DIR "llt/abl/slog"
class LogGroupUtest : public testing::Test
{
};
TEST_F(LogGroupUtest, AddNewGroupTest)
{
    GlobalMockObject::reset();
    GroupInfo group;
    const char *name1 = "Others";
    const char *name2 = "NN";
    (void)memset_s(&group, sizeof(GroupInfo), 0, sizeof(GroupInfo));
    group.groupId = 0;
    group.bufSize = 0;
    (void)memcpy_s(group.groupName, 127, name1, strlen(name1));

    char *path = LLT_SLOG_DIR "/ut/slog/res";
    EXPECT_EQ(NULL, GetGroupListHead());
    EXPECT_EQ(SYS_ERROR, AddNewGroup(&group, path, strlen(path)));

    group.bufSize = 256 * 1024;
    EXPECT_EQ(SYS_OK, AddNewGroup(&group, path, strlen(path)));
    group.groupId = 1;
    (void)memcpy_s(group.groupName, 127, name2, strlen(name2));
    EXPECT_EQ(SYS_OK, AddNewGroup(&group, path, strlen(path)));
    GroupInfo *info = GetGroupListHead();

    SlogdGroupLogExit();
    EXPECT_EQ(NULL, GetGroupListHead());
}
