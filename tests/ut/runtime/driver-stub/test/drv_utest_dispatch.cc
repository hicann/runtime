/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "driver/ascend_hal.h"
#include "driver_queue.h"
#include <gtest/gtest.h>
#include "mockcpp/mockcpp.hpp"
#include <pthread.h>
#include <unistd.h>
#include "tsch/tsch_interrupt.h"
#include "tsch/host_interface.h"

using namespace testing;

extern "C" drvReportQueue_t* drvGetReportQueues(int32_t deviceId);
extern "C" drvError_t drvMoveTsReport(int32_t deviceId);
extern "C" drvError_t drvSubmitCommand(ts_task_cmd_queue_t *task, drvQosQueue_t *qos, drvQosMgmt_t *qosMgmt);
extern "C" void drvSemPost(drvSem_t * sem);

class DrvDispatchTest : public testing::Test {
 protected:
  static void SetUpTestCase() {
    std::cout << "DrvApiTest SetUP" << std::endl;
  }
  static void TearDownTestCase() {
    std::cout << "DrvApiTest SetUP" << std::endl;
  }
  // Some expensive resource shared by all tests.
  virtual void SetUp()
  {
    std::cout << "a test SetUP" << std::endl;
  }
  virtual void TearDown()
  {
    GlobalMockObject::verify();
    std::cout << "a test SetUP" << std::endl;
  }
};

int32_t device=0;
int32_t reportCount = 1;
#if 0
drvReportGetInfo drvGetInfo;

void *thread1(void *s)
{
	drvReportGet(device, &drvGetInfo);
	pthread_exit(NULL);
}
void *thread2(void *s)
{
	drvReportIrqTriger(DRV_INTERRUPT_REPORT_READY);
	pthread_exit(NULL);
}
#endif
extern "C" drvError_t drvQueueInit();

TEST_F(DrvDispatchTest, dispatch_occupyAPI_test)
{
    drvError_t error;
    uint32_t devId=0;
    struct halSqMemGetInput in;
    struct halSqMemGetOutput out;
    in.type = DRV_NORMAL_TYPE;
	in.tsId = 0;
	in.sqId = 0;
	in.cmdCount = 1;
    error = drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
	
    error = halSqMemGet( devId, &in, &out);
	EXPECT_EQ(error, DRV_ERROR_NONE);
	
    error = halSqMemGet( devId, NULL, &out);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);

    error = halSqMemGet( devId, &in, NULL);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
	
    error = halSqMemGet( -1, &in, &out);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	
    in.type = DRV_CALLBACK_TYPE;
    error = halSqMemGet( devId, &in, &out);
	EXPECT_EQ(error, DRV_ERROR_NONE);
//    error = drvCommandOccupy(deviceId, &drvInfo);
 //   EXPECT_EQ(error, DRV_ERROR_NONE);

   // error = drvCommandOccupy(deviceId, NULL);
  //  EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);

   // error = drvCommandOccupy(-1, &drvInfo);
   // EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvDispatchTest, dispatch_occupy_size_test)
{
    drvError_t error;
    int32_t deviceId = 0;
    int32_t maxQosSize = DRV_QOS_QUEUE_SIZE;
    
    struct halSqMemGetInput in;
    struct halSqMemGetOutput out = {0};
    in.type = DRV_NORMAL_TYPE;
	in.tsId = 0;
	in.sqId = 0;
	in.cmdCount = 1;
    error = drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);

    for (int32_t i = 0; i<maxQosSize-1; i++)//head=tail+1 -> queue full
    {
        error = halSqMemGet( deviceId, &in, &out);
	    EXPECT_EQ(error, DRV_ERROR_NONE);
    }
    error = halSqMemGet( deviceId, &in, &out);
    EXPECT_NE(error, DRV_ERROR_NONE);
}

TEST_F(DrvDispatchTest, dispatch_send_test)
{
    drvError_t error;
    int32_t deviceId = 0;
    uint8_t taskCommand[64];

    struct halSqMemGetInput in;
    struct halSqMemGetOutput out;
    in.type = DRV_NORMAL_TYPE;
	in.tsId = 0;
	in.sqId = 0;
	in.cmdCount = 1;
    error = drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
	
    error = halSqMemGet( deviceId, &in, &out);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    halSqMsgInfo Sendinfo;
    Sendinfo.type = DRV_NORMAL_TYPE;
    Sendinfo.tsId = 0;
    Sendinfo.sqId = 0;
    Sendinfo.cmdCount = 0;
	Sendinfo.reportCount = 0;
	
    error = halSqMsgSend(deviceId, &Sendinfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvDispatchTest, dispatch_send_test2)
{
    MOCKER(drvQosHanddleToId).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));

    drvError_t error;
    int32_t deviceId = 0;
    uint8_t taskCommand[64];

    struct halSqMemGetInput in;
    struct halSqMemGetOutput out = {0};
    in.type = DRV_NORMAL_TYPE;
	in.tsId = 0;
	in.sqId = 0;
	in.cmdCount = 1;
    error = drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
	
    error = halSqMemGet( deviceId, &in, &out);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    halSqMsgInfo Sendinfo;

    Sendinfo.type = DRV_NORMAL_TYPE;
    Sendinfo.tsId = 0;
    Sendinfo.sqId = 0;
    Sendinfo.cmdCount = 1;
	Sendinfo.reportCount = 1;
    error = halSqMsgSend(deviceId, &Sendinfo);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = halSqMsgSend(1, &Sendinfo);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvDispatchTest, dispatch_send_test3)
{	
    drvError_t error;
    int32_t deviceId = 0;

    struct halSqMemGetInput in;
    struct halSqMemGetOutput out = {0};
    in.type = DRV_NORMAL_TYPE;
	in.tsId = 0;
	in.sqId = 0;
	in.cmdCount = 1;
    error = drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);

    halSqMsgInfo Sendinfo;
    Sendinfo.type = DRV_NORMAL_TYPE;
    Sendinfo.tsId = 0;
    Sendinfo.sqId = 0;
    Sendinfo.cmdCount = 1;
	Sendinfo.reportCount = 1;
	
    error = halSqMemGet( deviceId, &in, &out);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = halSqMsgSend(deviceId, &Sendinfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}
TEST_F(DrvDispatchTest, dispatch_send_test4)
{	
    drvError_t error;
    int32_t deviceId = 0;

    struct halSqMemGetInput in;
    struct halSqMemGetOutput out = {0};
    in.type = DRV_CALLBACK_TYPE;
	in.tsId = 0;
	in.sqId = 0;
	in.cmdCount = 1;
    error = drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);

    halSqMsgInfo Sendinfo;
    Sendinfo.type = DRV_CALLBACK_TYPE;
    Sendinfo.tsId = 0;
    Sendinfo.sqId = 0;
    Sendinfo.cmdCount = 1;
	Sendinfo.reportCount = 1;
	
    error = halSqMemGet( deviceId, &in, &out);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = halSqMsgSend(deviceId, &Sendinfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	
    in.type = DRV_INVALID_TYPE;
	Sendinfo.type = DRV_INVALID_TYPE;
    error = halSqMemGet( deviceId, &in, &out);
	//EXPECT_EQ(error, DRV_ERROR_NONE);
    error = halSqMsgSend(deviceId, &Sendinfo);
    //EXPECT_EQ(error, DRV_ERROR_NONE);
}
TEST_F(DrvDispatchTest, dispatch_queueAPI_test)
{
    int32_t deviceId=0;
    int8_t qos=0;
    drvQosQueue_t* qosQueue=NULL;
    drvQosMgmt_t* qosMgmt=NULL;
    drvReportQueue_t* report=NULL;
    int32_t ret=0;
    ret=0;
    report=drvGetReportQueues(8);
    if(report==NULL)
        ret=1;
    EXPECT_EQ(report==NULL, true);
}

TEST_F(DrvDispatchTest, dispatch_qosHandle2Id_API_test)
{
    drvError_t error;
    error=drvQosHanddleToId(2, NULL, NULL, NULL);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

#if 0
TEST_F(DrvDispatchTest, dispatch_report_test)
{
    drvError_t error;

    pthread_t thread[2];
    int32_t createThreadRet;

    struct halReportReleaseInfo repReleaseInfo;
	uint32_t deviceId = 0;
    error=drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);

    memset(&thread,0,sizeof(thread));
    createThreadRet=pthread_create(&thread[0],NULL,thread1,NULL);
    sleep(1);
    createThreadRet=pthread_create(&thread[1],NULL,thread2,NULL);

    pthread_join(thread[0],NULL);
    pthread_join(thread[1],NULL);

    repReleaseInfo.type = DRV_NORMAL_TYPE;
    repReleaseInfo.tsId = 0;
    repReleaseInfo.cqId = 0;
    repReleaseInfo.count = 1;

    error = halReportRelease(deviceId, &repReleaseInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}
#endif

TEST_F(DrvDispatchTest, dispatch_irq_wait_report)
{
    drvError_t error;
    int32_t deviceId=0;
    struct halReportInfoInput irqWaitInputInfo;
	struct halReportInfoOutput irqWaitOutputInfo;
	
    irqWaitInputInfo.type = DRV_NORMAL_TYPE;
    irqWaitInputInfo.grpId = 0;
    irqWaitInputInfo.tsId = 0;
    irqWaitInputInfo.timeout = 0;

    error = halCqReportIrqWait(deviceId, &irqWaitInputInfo, &irqWaitOutputInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	
    irqWaitInputInfo.type = DRV_CALLBACK_TYPE;
    error = halCqReportIrqWait(deviceId, &irqWaitInputInfo, &irqWaitOutputInfo);
	
    irqWaitInputInfo.type = DRV_INVALID_TYPE;
    error = halCqReportIrqWait(deviceId, &irqWaitInputInfo, &irqWaitOutputInfo);
}

TEST_F(DrvDispatchTest, dispatch_irq_test)
{
    drvError_t error;
    drvInterruptNum_t irq=DRV_INTERRUPT_RESERVED;
    MOCKER(drvMoveTsReport).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
    error=drvQueueInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
    drvReportIrqTriger(irq);
    drvReportIrqTriger(DRV_INTERRUPT_REPORT_READY);
}

TEST_F(DrvDispatchTest, dispatch_irq_test2)
{
	drvError_t error;
	MOCKER(drvMoveTsReport).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
	error=drvQueueInit();
	EXPECT_EQ(error, DRV_ERROR_NONE);
	drvReportIrqTriger(DRV_INTERRUPT_REPORT_READY);
}

TEST_F(DrvDispatchTest, dispatch_irp_qos_test)
{
	drvError_t error;
	int32_t device=0;
	int32_t qos=0;
	drvCommand_t cmd;
	uint8_t taskCommand[64];

	error=drvQueueInit();
	EXPECT_EQ(error, DRV_ERROR_NONE);

	MOCKER(drvSetTaskCommand).stubs().will(returnValue(DRV_ERROR_NONE));
	drvReportIrqTriger(DRV_INTERRUPT_QOS_READY);
}

TEST_F(DrvDispatchTest, dispatch_qos_test)
{
	drvError_t error;
	drvQosQueue_t queue;
	drvQosMgmt_t qMgmt;
	queue.headIndex = 0;
	queue.tailIndex=0;
	qMgmt.IsSubmit[queue.headIndex]=1;

	MOCKER(drvSubmitCommand).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
	error=drvSetTaskCommand(-1, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, -1, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
	queue.tailIndex=1;
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
}

TEST_F(DrvDispatchTest, dispatch_taskCommand_test)
{
	drvError_t error;
	drvQosQueue_t queue;
	drvQosMgmt_t qMgmt;
	queue.headIndex = 0;
	queue.tailIndex=0;
	qMgmt.IsSubmit[queue.headIndex]=1;

	MOCKER(drvSubmitCommand).stubs().will(returnValue(DRV_ERROR_INNER_ERR));
	error=drvSetTaskCommand(-1, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, -1, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
	queue.tailIndex=1;
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
}

TEST_F(DrvDispatchTest, dispatch_report_test3)
{
	drvError_t error;
	error=drvMoveTsReport(-1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvDispatchTest, dispatch_submitAPI_test)
{
	drvError_t error;
	ts_task_cmd_queue_t task;
	drvQosQueue_t qos;
	drvQosMgmt_t qosMgmt;

	task.read_idx=1;
	task.write_idx=0;
	qos.headIndex=0;
	qos.tailIndex=0;
	qosMgmt.Credit=0;

	error=drvSubmitCommand(&task,&qos,&qosMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
}

TEST_F(DrvDispatchTest, dispatch_drvReportRelease_test)
{
    drvError_t error;
    int32_t devId = 1;
    struct halReportReleaseInfo info;
    info.tsId = 0;
    info.count = 1;
    info.type = DRV_CALLBACK_TYPE;

    error = halReportRelease(devId, &info);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	
    info.type = DRV_NORMAL_TYPE;
    error = halReportRelease(devId, &info);
    info.type = DRV_INVALID_TYPE;
    error = halReportRelease(devId, &info);
}

/*UT for drvSetTaskCommand "qMgmt->IsSubmit[queue->headIndex] == 0"*/
TEST_F(DrvDispatchTest, dispatch_taskCommand_test_1)
{
	drvError_t error;
	drvQosQueue_t queue;
	drvQosMgmt_t qMgmt;
	queue.headIndex = 0;
	queue.tailIndex=0;
	qMgmt.IsSubmit[queue.headIndex]=0;

	MOCKER(drvSubmitCommand).stubs().will(returnValue(DRV_ERROR_INNER_ERR));

	error=drvSetTaskCommand(-1, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, -1, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
	queue.tailIndex=1;
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_NOT_EXIST);
}

/* UT for drvSetTaskCommand "if(DRV_PLAT_ESL == tmp_enPlatorfm)" */
TEST_F(DrvDispatchTest, dispatch_taskCommand_test_2)
{
	drvError_t error;
	drvQosQueue_t queue;
	drvQosMgmt_t qMgmt;
	queue.headIndex = 0;
	queue.tailIndex=0;
	qMgmt.IsSubmit[queue.headIndex]=1;

	MOCKER(drvSubmitCommand).stubs().will(returnValue(DRV_ERROR_INNER_ERR));

	error=drvSetTaskCommand(-1, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, -1, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
	queue.tailIndex=1;
	error=drvSetTaskCommand(0, 0, &queue, &qMgmt);
	EXPECT_EQ(error, DRV_ERROR_INNER_ERR);
}


/* UT for drvMoveTsReport "return DRV_ERROR_INVALID_HANDLE;" */
TEST_F(DrvDispatchTest, dispatch_report_test_1)
{
	drvError_t error;
	int32_t deviceId = 0;
	drvReportQueue_t g_drvReportQueue[MAX_DEV_NUM];

	MOCKER(drvGetReportQueues).stubs().will(returnValue((drvReportQueue_t*)NULL));

	error=drvMoveTsReport(deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

/* UT for drvMoveTsReport */
TEST_F(DrvDispatchTest, dispatch_report_test_2)
{
	drvError_t error;
	int32_t deviceId = 0;
	drvReportQueue_t g_drvReportQueue[MAX_DEV_NUM];
	g_drvReportQueue[0].headIndex = 2;
	g_drvReportQueue[0].tailIndex = 1;

	MOCKER(drvGetReportQueues).stubs().will(returnValue(&g_drvReportQueue[0]));

	error=drvMoveTsReport(deviceId);
	EXPECT_NE(error, DRV_ERROR_NONE);
}

/* UT for drvMoveTsReport "if(DRV_PLAT_ESL == tmp_enPlatorfm)" */
TEST_F(DrvDispatchTest, dispatch_report_test_3)
{
	drvError_t error;
	int32_t deviceId = 0;
	drvReportQueue_t g_drvReportQueue[MAX_DEV_NUM];

	g_drvReportQueue[0].headIndex = 1;
	g_drvReportQueue[0].tailIndex = 1;

	MOCKER(drvGetReportQueues).stubs().will(returnValue(&g_drvReportQueue[0]));
	//MOCKER(drvGetRserverdMem).stubs().with(outBoundP((void **)&g_drvHostCtrl, sizeof(g_drvHostCtrl))).will(returnValue(DRV_ERROR_NONE));

	error=drvQueueInit();
	error = drvMoveTsReport(deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

/*UT for dispatcher.c drvReportGet() "if(DRV_PLAT_ESL == tmp_enPlatorfm)" Line:204*/
TEST_F(DrvDispatchTest, DRV_REPORT_GET)
{
    drvError_t error;
    int32_t deviceId=0;

    struct halReportGetInput repGetInputInfo;
    struct halReportGetOutput repGetOutputInfo;
	repGetInputInfo.type = DRV_NORMAL_TYPE;
    repGetInputInfo.tsId = 0;
	repGetInputInfo.cqId = 0;
	
    drvSemPost(&g_drvSem[deviceId]);

    error=halCqReportGet(deviceId, &repGetInputInfo, &repGetOutputInfo);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error=halCqReportGet(deviceId+1, &repGetInputInfo, &repGetOutputInfo);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	
   	repGetInputInfo.type = DRV_CALLBACK_TYPE;
	error=halCqReportGet(deviceId, &repGetInputInfo, &repGetOutputInfo);
	
   	repGetInputInfo.type = DRV_INVALID_TYPE;
	error=halCqReportGet(deviceId, &repGetInputInfo, &repGetOutputInfo);
}

