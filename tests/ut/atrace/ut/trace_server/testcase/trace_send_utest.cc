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
#include "atrace_types.h"
#include "trace_system_api.h"
#include "trace_session_mgr.h"
#include "adcore_api.h"
#include "trace_types.h"
#include "trace_send_mgr.h"
#include "trace_adx_api.h"
#include "trace_node.h"
#include "trace_msg.h"
#include "trace_server_mgr.h"
#include "adx_component_api_c.h"

#define MSG_STATUS_LONG_LINK    12
#define MSG_STATUS_SHORT_LINK   13

class TraceSendUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
        Clear();
        system("mkdir -p " LLT_TEST_DIR );
    }

    void Clear()
    {
        system("rm -rf " LLT_TEST_DIR "/*");
    }
    virtual void TearDown()
    {
        system("echo [DBG][TEST][`date +%Y-%m-%d-%H-%M-%S`] End test case");
        GlobalMockObject::verify();
        system("rm -rf " LLT_TEST_DIR );
    }

    static void SetUpTestCase()
    {
    }

    static void TearDownTestCase()
    {
    }
};

typedef struct {
    unsigned short headInfo;    // head magic data, judge to little
    unsigned char headVer;      // head version
    unsigned char order;        // packet order (reserved)
    unsigned short reqType;     // request type of proto
    unsigned short devId;       // request device Id
    unsigned int totalLen;      // whole message length, only all data[0] length
    unsigned int sliceLen;      // one slice length, only data[0] length
    unsigned int offset;        // offset
    unsigned short msgType;     // message type
    unsigned short status;      // message status data
    unsigned char data[0];      // message data
} TraceDataMsg;

// send mgr
TEST_F(TraceSendUtest, KtraceSendMgr)
{
    // session node init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // insert session node
    void *handle1 = malloc(10);
    int32_t pid1 = 10;
    int32_t devId1 = 0;
    int32_t timeout1 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid1, devId1));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle1, pid1, devId1, timeout1));
    SessionNode *sessionNode1 = TraceServerGetSessionNode(pid1, devId1);
    EXPECT_EQ(pid1, sessionNode1->pid);
    EXPECT_EQ(devId1, sessionNode1->devId);
    EXPECT_EQ(timeout1, sessionNode1->timeout);
    EXPECT_EQ(false, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());

    void *handle2 = malloc(10);
    int32_t pid2 = 0;
    int32_t devId2 = 0;
    int32_t timeout2 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid2, devId2));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle2, pid2, devId2, timeout2));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(handle1, pid1, devId1));
    SessionNode *sessionNode2 = TraceServerGetSessionNode(pid2, devId2);

    // push node
    int8_t flag = 2;
    char *data1 = (char *)malloc(1024);
    snprintf_s(data1, 1024, 1023, "test node1 mgr.");
    char *data2 = (char *)malloc(1024);
    snprintf_s(data2, 1024, 1023, "test node2 mgr.");
    uint32_t len = 1024;
    EXPECT_EQ(TRACE_SUCCESS, TraceTsPushNode(sessionNode1, flag, data1, len));
    EXPECT_EQ(TRACE_SUCCESS, TraceTsPushNode(sessionNode2, flag, data2, len));

    EXPECT_EQ(TRACE_SUCCESS, TraceServerCreateSendThread());
    TraceServerDestroySendThread();
    TraceServerSessionExit();
}

TEST_F(TraceSendUtest, KtraceSendMgrFailed)
{
    MOCKER(AdxSendMsg).stubs().will(returnValue(-1));
    MOCKER(mmSetCurrentThreadName).stubs().will(returnValue(TRACE_FAILURE));
    // session node init
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(true, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());
 
    // insert session node
    void *handle1 = malloc(10);
    int32_t pid1 = 10;
    int32_t devId1 = 0;
    int32_t timeout1 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid1, devId1));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle1, pid1, devId1, timeout1));
    SessionNode *sessionNode1 = TraceServerGetSessionNode(pid1, devId1);
    EXPECT_EQ(pid1, sessionNode1->pid);
    EXPECT_EQ(devId1, sessionNode1->devId);
    EXPECT_EQ(timeout1, sessionNode1->timeout);
    EXPECT_EQ(false, TraceIsSessionNodeListNull());
    EXPECT_EQ(true, TraceIsDeletedSessionNodeListNull());

    void *handle2 = malloc(10);
    int32_t pid2 = 0;
    int32_t devId2 = 0;
    int32_t timeout2 = 3000;
    EXPECT_EQ(NULL, TraceServerGetSessionNode(pid2, devId2));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerInsertSessionNode(handle2, pid2, devId2, timeout2));
    EXPECT_EQ(TRACE_SUCCESS, TraceServerDeleteSessionNode(handle1, pid1, devId1));
    SessionNode *sessionNode2 = TraceServerGetSessionNode(pid2, devId2);

    // push node
    int8_t flag = 2;
    char *data1 = (char *)malloc(1024);
    snprintf_s(data1, 1024, 1023, "test node1 mgr.");
    char *data2 = (char *)malloc(1024);
    snprintf_s(data2, 1024, 1023, "test node2 mgr.");
    uint32_t len = 1024;
    EXPECT_EQ(TRACE_SUCCESS, TraceTsPushNode(sessionNode1, flag, data1, len));
    EXPECT_EQ(TRACE_SUCCESS, TraceTsPushNode(sessionNode2, flag, data2, len));

    EXPECT_EQ(TRACE_SUCCESS, TraceServerCreateSendThread());
    sleep(1);
    TraceServerDestroySendThread();
    TraceServerSessionExit();
}

TEST_F(TraceSendUtest, KtraceSendMgrThreadFailed)
{
    MOCKER(mmCreateTaskWithThreadAttr).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceServerCreateSendThread());
}

TEST_F(TraceSendUtest, TraceServiceInit)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceServiceInit(-1));
}

TEST_F(TraceSendUtest, TraceServiceInitFailed)
{
    MOCKER(AdxServiceStartup).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_FAILURE, TraceServiceInit(-1));
    MOCKER(AdxRegisterService).stubs().will(returnValue(TRACE_FAILURE));
    EXPECT_EQ(TRACE_FAILURE, TraceServiceInit(-1));
}

TEST_F(TraceSendUtest, TraceDeviceProcessHello)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = TRACE_HELLO_MSG;
    helloMsg->magic = TRACE_HEAD_MAGIC;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceHelloMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceDeviceProcessEndNull)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    TraceEndMsg *endMsg = (TraceEndMsg *)msg->data;
    endMsg->msgType = TRACE_END_MSG;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceDeviceProcessStart)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle1 = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    msg->status = MSG_STATUS_LONG_LINK;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceProcess(handle1, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;

    // end
    AdxCommConHandle handle2 = (AdxCommConHandle)AdiagMalloc(10);
    msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    TraceEndMsg *endMsg = (TraceEndMsg *)msg->data;
    endMsg->msgType = TRACE_END_MSG;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceProcess(handle2, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
    TraceServerSessionExit();
}

TEST_F(TraceSendUtest, TraceDeviceProcessInvalid)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = 5;
    helloMsg->magic = TRACE_HEAD_MAGIC;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, 0));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceDeviceProcessNull)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)NULL, 0));
    MOCKER(AdxIsCommHandleValid).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)NULL, 0));
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceMallocFailed)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    AdxCommConHandle handle = (AdxCommConHandle)malloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)malloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    msg->status = MSG_STATUS_LONG_LINK;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceAdxRecvMsgFailed)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    MOCKER(AdxRecvMsg).stubs().will(returnValue(-1));
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    msg->status = MSG_STATUS_LONG_LINK;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());

}

TEST_F(TraceSendUtest, TraceAdxSendHelloMsgFailed)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    MOCKER(AdxSendMsg).stubs().will(returnValue(-1));
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = TRACE_HELLO_MSG;
    helloMsg->magic = TRACE_HEAD_MAGIC;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceHelloMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceAdxSendInvalidMsg)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = 10;
    helloMsg->magic = TRACE_HEAD_MAGIC;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceHelloMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceAdxSendInvalidMagic)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = TRACE_HELLO_MSG;
    helloMsg->magic = TRACE_HEAD_MAGIC + 1U;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceHelloMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceAdxSendInvalidHandle)
{
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = TRACE_HELLO_MSG;
    helloMsg->magic = TRACE_HEAD_MAGIC;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceHelloMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceAdxSendMallocFailed)
{
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)malloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)malloc(sizeof(TraceDataMsg) + sizeof(TraceHelloMsg));
    TraceHelloMsg *helloMsg = (TraceHelloMsg *)msg->data;
    helloMsg->msgType = TRACE_HELLO_MSG;
    helloMsg->magic = TRACE_HEAD_MAGIC;
    helloMsg->version = TRACE_HEAD_VERSION;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceHelloMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceAdxGetAttrByCommHandleFailed)
{
    EXPECT_EQ(TRACE_SUCCESS, TraceServerSessionInit());
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(-1)).then(returnValue(0)).then(returnValue(-1));
    AdxCommConHandle handle1 = (AdxCommConHandle)AdiagMalloc(10);
    AdxCommConHandle handle2 = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    msg->status = MSG_STATUS_LONG_LINK;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle1, (const void *)msg, sizeof(TraceEndMsg)));
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle2, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;

    AdxCommConHandle handle3 = (AdxCommConHandle)AdiagMalloc(10);
    msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    TraceEndMsg *endMsg = (TraceEndMsg *)msg->data;
    endMsg->msgType = TRACE_END_MSG;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle3, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
    TraceServerSessionExit();
}

TEST_F(TraceSendUtest, TraceEndMsgAdxGetAttrByCommHandleFailed)
{
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(0)).then(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    AdxCommConHandle handle = (AdxCommConHandle)AdiagMalloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)AdiagMalloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    TraceEndMsg *endMsg = (TraceEndMsg *)msg->data;
    endMsg->msgType = TRACE_END_MSG;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}

TEST_F(TraceSendUtest, TraceStartMsgAdxGetAttrByCommHandleFailed)
{
    MOCKER(AdxGetAttrByCommHandle).stubs().will(returnValue(0)).then(returnValue(-1));
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceInit());
    MOCKER(AdiagMalloc).stubs().will(returnValue((void *)NULL));
    AdxCommConHandle handle = (AdxCommConHandle)malloc(10);
    TraceDataMsg* msg = (TraceDataMsg *)malloc(sizeof(TraceDataMsg) + sizeof(TraceEndMsg));
    msg->status = MSG_STATUS_LONG_LINK;
    EXPECT_EQ(TRACE_FAILURE, TraceDeviceProcess(handle, (const void *)msg, sizeof(TraceEndMsg)));
    free(msg);
    msg = NULL;
    EXPECT_EQ(TRACE_SUCCESS, TraceDeviceExit());
}