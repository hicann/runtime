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

#include <vector>
#include <string>
#include "ide_common_util_stest.h"
#include "ide_platform_util.h"
#include "impl_utils.h"
#include "ide_task_register.h"
extern "C"{
#include "dsmi_common_interface.h"
}

using std::vector;
using std::string;
using namespace Adx;
using namespace Analysis::Dvvp::Adx;

extern FILE *log_fd;
extern struct IdeComponentsFuncs g_ideComponentsFuncs;
extern vector<mmSockHandle> g_vec_sock;
extern int g_getpkg_len_stub_flag;
extern int g_sprintf_s_flag;
extern int IdeInitSock();
extern int SetSystemTimeByStr(const std::string date);
extern bool IdeInsertSock(const std::string &ip, mmSockHandle sock);
extern string get_current_system_time(void);
extern int IdeSendFrontData(struct IdeData &pdata, int handler, struct IdeSockHandle handle,
                            uint32_t perSendSize, long int& len);
extern int IdeSendLastData(struct IdeData &pdata, int handler, struct IdeSockHandle handle,
                           uint32_t perSendSize, uint32_t remain);

class IDE_DAEMON_COMMON_UTIL_STEST: public testing::Test {
protected:
    virtual void SetUp() {
        g_getpkg_len_stub_flag = 0;
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
};

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeGetCompontName)
{
    EXPECT_STREQ("default", IdeGetCompontName(NR_IDE_COMPONENTS));
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeXmalloc)
{
    void *ptr = IdeXmalloc(0);
    EXPECT_TRUE(ptr == NULL);
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeXmalloc_failed)
{
    void *malloc_addr = (void *)0x0;

    MOCKER(malloc)
        .stubs()
        .will(returnValue(malloc_addr));

    EXPECT_EQ(malloc_addr, IdeXmalloc(-1));
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeXmalloc_memset_s_failed)
{
    MOCKER(memset_s)
        .stubs()
        .will(returnValue(-1));

    EXPECT_EQ(NULL, IdeXmalloc(1));
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeXfree)
{
    void *ptr = (void *)0x0;
    IdeXfree(ptr);
    EXPECT_EQ(ptr, nullptr);

    MOCKER(free)
        .stubs();

    ptr = (void *)0x12345678;
    IdeXfree(ptr);
    EXPECT_NE(ptr, nullptr);
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeReqFree)
{
    struct tlv_req req;

    MOCKER(IdeXfree)
        .stubs();

    IdeReqFree(NULL);
    IdeReqFree(&req);
    EXPECT_NE(&req, nullptr);
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, DaemonInit_init_failed)
{
    mmSockHandle sock;

    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(0));

    MOCKER(setsid)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeDaemonSubInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));

    EXPECT_EQ(IDE_DAEMON_ERROR, DaemonInit());
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, DaemonInit_chdir_failed)
{
    mmSockHandle sock;

    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(0));
    
    MOCKER(setsid)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeDaemonSubInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(mmChdir)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    MOCKER(IdeComponentsInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    
    EXPECT_EQ(IDE_DAEMON_ERROR, DaemonInit());
    EXPECT_EQ(IDE_DAEMON_ERROR, DaemonInit());
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, DaemonInit_success)
{
    mmSockHandle sock;
    int port = 22118;

    MOCKER(IdeFork)
        .stubs()
        .will(returnValue(0));

    MOCKER(setsid)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeDaemonSubInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));

    MOCKER(chdir)
        .stubs()
        .will(returnValue(0));

    MOCKER(umask)
        .stubs()
        .will(returnValue(0));

    MOCKER(IdeComponentsInit)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));
    
    EXPECT_EQ(IDE_DAEMON_OK, DaemonInit());
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeRegisterModule)
{
    struct IdeSingleComponentFuncs ide_funcs;

    ide_funcs.init = hdc_init_mock;
    ide_funcs.destroy = hdc_destroy_mock;
    ide_funcs.sockProcess = NULL;
    ide_funcs.hdcProcess = NULL; 
    IdeRegisterModule(IDE_COMPONENT_HDC, ide_funcs);

    ide_funcs.init = debug_init_mock;
    ide_funcs.destroy = debug_destroy_mock;
    ide_funcs.sockProcess = NULL;
    ide_funcs.hdcProcess = NULL; 
    IdeRegisterModule(IDE_COMPONENT_DEBUG, ide_funcs);

    ide_funcs.init = bbox_init_mock;
    ide_funcs.destroy = bbox_destroy_mock;
    ide_funcs.sockProcess = NULL;
    ide_funcs.hdcProcess = NULL;     
    IdeRegisterModule(IDE_COMPONENT_BBOX, ide_funcs);

    ide_funcs.init = log_init_mock;
    ide_funcs.destroy = log_destroy_mock;
    ide_funcs.sockProcess = NULL;
    ide_funcs.hdcProcess = NULL;  
    IdeRegisterModule(IDE_COMPONENT_LOG, ide_funcs);

    ide_funcs.init = profile_init_mock;
    ide_funcs.destroy = profile_destroy_mock;
    ide_funcs.sockProcess = NULL;
    ide_funcs.hdcProcess = NULL;   
    IdeRegisterModule(IDE_COMPONENT_PROFILING, ide_funcs);

    EXPECT_EQ((void *)g_ideComponentsFuncs.init[IDE_COMPONENT_HDC], (void *)hdc_init_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.init[IDE_COMPONENT_DEBUG], (void *)debug_init_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.init[IDE_COMPONENT_BBOX], (void *)bbox_init_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.init[IDE_COMPONENT_LOG], (void *)log_init_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.init[IDE_COMPONENT_PROFILING], (void *)profile_init_mock);

    EXPECT_EQ((void *)g_ideComponentsFuncs.destroy[IDE_COMPONENT_HDC], (void *)hdc_destroy_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.destroy[IDE_COMPONENT_DEBUG], (void *)debug_destroy_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.destroy[IDE_COMPONENT_BBOX], (void *)bbox_destroy_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.destroy[IDE_COMPONENT_LOG], (void *)log_destroy_mock);
    EXPECT_EQ((void *)g_ideComponentsFuncs.destroy[IDE_COMPONENT_PROFILING], (void *)profile_destroy_mock);
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeComponentsInit)
{
    MOCKER(hdc_init_mock)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK))
        .then(returnValue(IDE_DAEMON_ERROR));

    MOCKER(profile_init_mock)
        .stubs()
        .will(returnValue(IDE_DAEMON_OK));   

    EXPECT_EQ(IDE_DAEMON_OK, IdeComponentsInit());
    EXPECT_EQ(IDE_DAEMON_ERROR, IdeComponentsInit());

    MOCKER(profile_destroy_mock)
        .stubs()
        .will(returnValue(IDE_DAEMON_ERROR));
    IdeComponentsDestroy();
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeGetComponentType)
{
    IdeComponentType type = NR_IDE_COMPONENTS;
    struct tlv_req req;

    req.type = IDE_EXEC_COMMAND_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_EXEC_HOSTCMD_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_SEND_FILE_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_DEBUG_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_LOG_LEVEL_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_PROFILING_REQ;
    EXPECT_EQ(IDE_COMPONENT_PROFILING, IdeGetComponentType(&req));

    req.type = IDE_FILE_SYNC_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_EXEC_API_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_DUMP_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_DETECT_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_FILE_GET_REQ;
    EXPECT_EQ(type, IdeGetComponentType(&req));

    req.type = IDE_INVALID_REQ;
    EXPECT_EQ(IDE_COMPONENT_HOOK_REG, IdeGetComponentType(&req));
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeGetCompontNameByReq)
{
    EXPECT_STREQ("profiling", IdeGetCompontNameByReq(IDE_PROFILING_REQ));
    EXPECT_STREQ("default", IdeGetCompontNameByReq(NR_IDE_CMD_CLASS));
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeXrmalloc)
{
    void *ptr = IdeXmalloc(5);
    void *ret_ptr = NULL;

    //size == 0
    ret_ptr = IdeXrmalloc(NULL, 0, 0);
    IdeXfree(ret_ptr);

    //size == 1
    ret_ptr = IdeXrmalloc(NULL, 0, 1);
    IdeXfree(ret_ptr);

    //remalloc
    ret_ptr = IdeXrmalloc(ptr, 5, 10);
    IdeXfree(ret_ptr);

    //memcpy_s failed
    MOCKER(memcpy_s)
        .stubs()
        .will(returnValue(-1));
    ret_ptr = IdeXrmalloc(ptr, 5, 10);
    EXPECT_TRUE(ret_ptr == NULL);
    IdeXfree(ptr);
}

TEST_F(IDE_DAEMON_COMMON_UTIL_STEST, IdeRegisterSig)
{
    MOCKER(memset_s)
        .stubs()
        .will(returnValue(-1))
        .then(returnValue(0));

    //memset_s failed
    EXPECT_EQ(IdeDaemonSubInit(), IDE_DAEMON_OK);

    //succ
    EXPECT_EQ(IdeDaemonSubInit(), IDE_DAEMON_OK);
}
