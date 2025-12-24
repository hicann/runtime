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
#include "mockcpp/mockcpp.hpp"

#include "log_process_util.h"

using namespace Adx;

namespace Adx {
int32_t CreateProcess(const char *fileName, const mmArgvEnv *env, mmProcess *id);
}

class IDE_PROCESS_UTIL_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_PROCESS_UTIL_TEST, AdxCreateProcess)
{
    IdeString cmd = "cp /home/a.txt /root";
    MOCKER(CreateProcess)
        .stubs()
        .will(returnValue(EN_INVALID_PARAM))
        .then(returnValue(EN_OK));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxCreateProcess(cmd));

    MOCKER(mmWaitPid)
        .stubs()
        .will(returnValue(EN_ERROR))
        .then(returnValue(EN_ERR));

    EXPECT_EQ(IDE_DAEMON_ERROR, AdxCreateProcess(cmd));
    EXPECT_EQ(IDE_DAEMON_OK, AdxCreateProcess(cmd));
}

TEST_F(IDE_PROCESS_UTIL_TEST, CreateProcessError)
{
    const char *fileName = "/bin/sh";
    const char *argv[] = {"sh", "-c", "ls", "-l", nullptr};
    const char *envp[] = {"PATH=/usr/bin:/usr/sbin:/var"};
    mmArgvEnv argvEnv = {0};
    argvEnv.argv = const_cast<IdeStrBufAddrT>(argv);
    argvEnv.argvCount = sizeof(argv) / sizeof(argv[0]);
    argvEnv.envp = const_cast<IdeStrBufAddrT>(envp);
    argvEnv.envpCount = sizeof(envp) / sizeof(envp[0]);
    pid_t pid = 0;
    EXPECT_EQ(EN_INVALID_PARAM, CreateProcess(nullptr, nullptr, nullptr));

    MOCKER(fork).stubs().will(returnValue(EN_ERROR)).then(returnValue(0)).then(returnValue(123));
    EXPECT_EQ(EN_ERROR, CreateProcess(fileName, &argvEnv, &pid));
    MOCKER(execvpe).stubs().will(returnValue(-1));
    MOCKER(_exit).stubs();

    EXPECT_EQ(EN_OK, CreateProcess(fileName, &argvEnv, &pid));
    EXPECT_EQ(EN_OK, CreateProcess(fileName, &argvEnv, &pid));
}