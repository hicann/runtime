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
#include "utils.h"
#include "tprt_api.h"
#include "tprt_error_code.h"
#include "tprt_type.h"
#include "tprt.hpp"
#include "tprt_device.hpp"
#include "tprt_base.hpp"
#undef private

using namespace cce::tprt;

class TprtApiTest : public testing::Test {
protected:
    static void SetUpTestCase()
    {
        std::cout << "TprtApiTest SetUP" << std::endl;

        std::cout << "TprtApiTest start" << std::endl;
    }

    static void TearDownTestCase()
    {
        std::cout << "TprtApiTest end" << std::endl;
    }

    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

TEST_F(TprtApiTest, TprtDeviceOpen_cfg_error)
{
    TprtCfgInfo_t *cfg = nullptr;
    uint32_t devId = 0;
    uint32_t error = TprtDeviceOpen(devId, cfg);
    EXPECT_EQ(error, TPRT_INPUT_NULL);

    TprtCfgInfo_t cfg_error1 = {0U, 1024U, 100U, 1000U};
    error = TprtDeviceOpen(devId, &cfg_error1);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);

    TprtCfgInfo_t cfg_error2 = {1024U, 0U, 100U, 1000U};
    error = TprtDeviceOpen(devId, &cfg_error2);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
}

TEST_F(TprtApiTest, tprtSqCqCreate_Success)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_SUCCESS);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtSqCqCreate_sqInfo_nullptr_Fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,nullptr, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtSqCqCreate_cqInfo_nullptr_Fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, nullptr);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtSqCqCreate_sqInfo_inputType_error_fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtSqCqCreate_cqInfo_inputType_error_fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtSqCqCreate_sqInfo_reqId_error_fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 5U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 6U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtSqCqCreate_cqInfo_reqId_error_fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 5U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 6U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtSqCqCreate_getDevice_nullptr_fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    manage->deviceMap_[0] = nullptr;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;

    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_DEVICE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtSqCqCreate_tprtSqCqAlloc_error_Fail)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_ALLOC_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_ALLOC_CQ_TYPE;
    MOCKER_CPP(&TprtDevice::TprtSqCqAlloc).stubs().will(returnValue(TPRT_SQ_HANDLE_INVALID));
    uint32_t error = TprtSqCqCreate(devId,&sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_SQ_HANDLE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);    
}

TEST_F(TprtApiTest, tprtOpSqCqInfo_opInfo_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtSqCqOpInfo_t* opInfo = nullptr;
    uint32_t error = TprtOpSqCqInfo(devId, opInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_); 
}

TEST_F(TprtApiTest, tprtOpSqCqInfo_dev_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_CONFIG_SQ;
    opInfo.reqId = 1U;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_SET_STATUS_QUIT;
    uint32_t error = TprtOpSqCqInfo(devId, &opInfo);
    EXPECT_EQ(error, TPRT_DEVICE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtOpSqCqInfo_sqHandle_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_CONFIG_SQ;
    opInfo.reqId = 1U;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_SET_STATUS_QUIT;
    TprtManage *manage = TprtManage::Instance();
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;

    uint32_t error = TprtOpSqCqInfo(devId, &opInfo);
    EXPECT_EQ(error, TPRT_SQ_HANDLE_INVALID);

    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtOpSqCqInfo_success)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtSqCqOpInfo_t opInfo = {};
    opInfo.type = TPRT_CONFIG_SQ;
    opInfo.reqId = 1U;
    opInfo.prop = TPRT_SQCQ_PROP_SQ_SET_STATUS_QUIT;
    TprtManage *manage = TprtManage::Instance();
    TprtDevice *tprtDev = new TprtDevice(0);
    TprtSqHandle *sqHandle = new TprtSqHandle(0, 1);
    tprtDev->sqHandleMap_[1] = sqHandle;
    manage->deviceMap_[0] = tprtDev;

    uint32_t error = TprtOpSqCqInfo(devId, &opInfo);
    EXPECT_EQ(error, TPRT_SUCCESS);

    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtCqReportRecv_cqeAddr_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_QUERY_CQ_INFO;
    repRecvInfo.cqId = 1U;
    repRecvInfo.cqeAddr = nullptr;
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.reportCqeNum = 32U;

    uint32_t error = TprtCqReportRecv(devId, &repRecvInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtCqReportRecv_cqeInfo_type_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtLogicCqReport_t reportInfo[32U] = {};
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_INVALID_TYPE;
    repRecvInfo.cqId = 1U;
    repRecvInfo.cqeAddr = TprtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo);
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.reportCqeNum = 32U;

    uint32_t error = TprtCqReportRecv(devId, &repRecvInfo);
    EXPECT_EQ(error, TPRT_INPUT_OP_TYPE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtCqReportRecv_dev_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtLogicCqReport_t reportInfo[32U] = {};
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_QUERY_CQ_INFO;
    repRecvInfo.cqId = 1U;
    repRecvInfo.cqeAddr = TprtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo);
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.reportCqeNum = 32U;

    uint32_t error = TprtCqReportRecv(devId, &repRecvInfo);
    EXPECT_EQ(error, TPRT_DEVICE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtCqReportRecv_cqHandle_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtLogicCqReport_t reportInfo[32U] = {};
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_QUERY_CQ_INFO;
    repRecvInfo.cqId = 1U;
    repRecvInfo.cqeAddr = TprtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo);
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.reportCqeNum = 32U;
    TprtManage *manage = TprtManage::Instance();
    TprtDevice *tprtDev = new TprtDevice(0);
    TprtSqHandle *sqHandle = new TprtSqHandle(0, 1);
    tprtDev->sqHandleMap_[1] = sqHandle;
    manage->deviceMap_[0] = tprtDev;

    uint32_t error = TprtCqReportRecv(devId, &repRecvInfo);
    EXPECT_EQ(error, TPRT_CQ_HANDLE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtCqReportRecv_success)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtLogicCqReport_t reportInfo[32U] = {};
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_QUERY_CQ_INFO;
    repRecvInfo.cqId = 1U;
    repRecvInfo.cqeAddr = TprtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo);
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.reportCqeNum = 32U;
    TprtManage *manage = TprtManage::Instance();
    TprtDevice *tprtDev = new TprtDevice(0);
    TprtSqHandle *sqHandle = new TprtSqHandle(0, 1);
    tprtDev->sqHandleMap_[1] = sqHandle;
    TprtCqHandle *cqHandle = new TprtCqHandle(0, 1);
    tprtDev->cqHandleMap_[1] = cqHandle;
    manage->deviceMap_[0] = tprtDev;

    uint32_t error = TprtCqReportRecv(devId, &repRecvInfo);
    EXPECT_EQ(error, TPRT_SUCCESS);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, tprtCqReportRecv_success_02)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    uint32_t devId = 0U;
    TprtLogicCqReport_t reportInfo[32U] = {};
    TprtReportCqeInfo_t repRecvInfo = {};
    repRecvInfo.type = TPRT_QUERY_CQ_INFO;
    repRecvInfo.cqId = 1U;
    repRecvInfo.cqeAddr = TprtPtrToPtr<uint8_t *, TprtLogicCqReport_t *>(reportInfo);
    repRecvInfo.cqeNum = 32U;
    repRecvInfo.reportCqeNum = 32U;
    TprtManage *manage = TprtManage::Instance();
    TprtDevice *tprtDev = new TprtDevice(0);
    TprtSqHandle *sqHandle = new TprtSqHandle(0, 1);
    tprtDev->sqHandleMap_[1] = sqHandle;
    TprtCqHandle *cqHandle = new TprtCqHandle(0, 1);
    cqHandle->cqTail_.store(10);
    tprtDev->cqHandleMap_[1] = cqHandle;
    manage->deviceMap_[0] = tprtDev;
    manage->sqcqMaxDepth_ = 1024U;

    uint32_t error = TprtCqReportRecv(devId, &repRecvInfo);
    EXPECT_EQ(error, TPRT_SUCCESS);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqCqDestroy_sqInfo_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t cqId = 1U;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_FREE_CQ_TYPE;

    uint32_t error = TprtSqCqDestroy(devId, nullptr, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqCqDestroy_cqInfo_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_FREE_SQ_TYPE;

    uint32_t error = TprtSqCqDestroy(devId, &sqInfo, nullptr);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqCqDestroy_sqInfo_type_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_INVALID_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_FREE_CQ_TYPE;

    uint32_t error = TprtSqCqDestroy(devId, &sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqCqDestroy_cqInfo_type_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxNum_ = 10U;
    TprtDevice *tprtDev = new TprtDevice(0);
    manage->deviceMap_[0] = tprtDev;
    MOCKER(mmGetTid).stubs().will(returnValue(101));

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_FREE_SQ_TYPE;

    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_INVALID_TYPE;

    uint32_t error = TprtSqCqDestroy(devId, &sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqCqDestroy_GetDevice_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();

    uint32_t devId = 0U;
    uint32_t sqId = 1U;
    uint32_t cqId = 1U;
    TprtSqCqInputInfo sqInfo = {0, TPRT_INVALID_TYPE};
    sqInfo.reqId = sqId;
    sqInfo.inputType = TPRT_FREE_SQ_TYPE;
    TprtSqCqInputInfo cqInfo = {0, TPRT_INVALID_TYPE};
    cqInfo.reqId = cqId;
    cqInfo.inputType = TPRT_FREE_CQ_TYPE;
    MOCKER_CPP(&TprtManage::GetDeviceByDevId).stubs().will(returnValue((TprtDevice *)nullptr));

    uint32_t error = TprtSqCqDestroy(devId, &sqInfo, &cqInfo);
    EXPECT_EQ(error, TPRT_DEVICE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqPushTask_sendInfo_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 1024U;
    uint32_t devId = 0U;
    uint32_t error = TprtSqPushTask(devId, nullptr);
    EXPECT_EQ(error, TPRT_INPUT_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqPushTask_device_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 1024U;
    uint32_t devId = 0U;
    TprtSqe_t tprtSqe[5U] = {};
    TprtSqe_t *sqeAddr = tprtSqe;
    TprtTaskSendInfo_t sendInfo = {};
    sendInfo.sqeNum = 1U;
    sendInfo.sqId = 1U;
    MOCKER_CPP(&TprtManage::GetDeviceByDevId).stubs().will(returnValue((TprtDevice *)nullptr));
    uint32_t error = TprtSqPushTask(devId, &sendInfo);
    EXPECT_EQ(error, TPRT_DEVICE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqPushTask_sqHandle_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 1024U;
    uint32_t devId = 0U;
    TprtSqe_t tprtSqe[5U] = {};
    TprtSqe_t *sqeAddr = tprtSqe;
    TprtTaskSendInfo_t sendInfo = {};
    sendInfo.sqeNum = 1U;
    sendInfo.sqId = 1U;
    TprtDevice *dev;
    MOCKER_CPP(&TprtManage::GetDeviceByDevId).stubs().will(returnValue(dev));
    MOCKER_CPP(&TprtDevice::TprtGetSqHandleBySqId).stubs().will(returnValue((TprtSqHandle *)nullptr));
    uint32_t error = TprtSqPushTask(devId, &sendInfo);
    EXPECT_EQ(error, TPRT_SQ_HANDLE_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqPushTask_worker_null_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 1024U;
    uint32_t devId = 0U;
    TprtSqe_t tprtSqe[5U] = {};
    TprtSqe_t *sqeAddr = tprtSqe;
    TprtTaskSendInfo_t sendInfo = {};
    sendInfo.sqeNum = 1U;
    sendInfo.sqId = 1U;
    TprtDevice *dev;
    MOCKER_CPP(&TprtManage::GetDeviceByDevId).stubs().will(returnValue(dev));
    TprtSqHandle *sqHandle;
    MOCKER_CPP(&TprtDevice::TprtGetSqHandleBySqId).stubs().will(returnValue(sqHandle));
    MOCKER_CPP(&TprtDevice::TprtGetWorkHandleBySqHandle).stubs().will(returnValue((TprtWorker *)nullptr));
    uint32_t error = TprtSqPushTask(devId, &sendInfo);
    EXPECT_EQ(error, TPRT_WORKER_INVALID);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtSqPushTask_SqPushTask_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 1024U;
    uint32_t devId = 0U;
    TprtSqe_t tprtSqe[5U] = {};
    TprtSqe_t *sqeAddr = tprtSqe;
    TprtTaskSendInfo_t sendInfo = {};
    sendInfo.sqeNum = 1U;
    sendInfo.sqId = 1U;
    TprtDevice *dev;
    MOCKER_CPP(&TprtManage::GetDeviceByDevId).stubs().will(returnValue(dev));
    TprtSqHandle *sqHandle;
    MOCKER_CPP(&TprtDevice::TprtGetSqHandleBySqId).stubs().will(returnValue(sqHandle));
    TprtWorker *worker;
    MOCKER_CPP(&TprtDevice::TprtGetWorkHandleBySqHandle).stubs().will(returnValue(worker));
    MOCKER_CPP(&TprtSqHandle::SqPushTask).stubs().will(returnValue(TPRT_SQ_QUEUE_FULL));
    uint32_t error = TprtSqPushTask(devId, &sendInfo);
    EXPECT_EQ(error, TPRT_SQ_QUEUE_FULL);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, IsQueueFull_true)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    manage->sqcqMaxDepth_ = 4U;
    uint16_t head = 0U;
    uint16_t tail = 3U;
    uint32_t allocNum = 1U;

    bool res = manage->IsQueueFull(head, tail, allocNum);
    EXPECT_EQ(res, true);
    DELETE_O(cce::tprt::TprtManage::tprt_);
}

TEST_F(TprtApiTest, TprtDeviceOpen_device_exits_error)
{
    cce::tprt::TprtManage::tprt_ = new (std::nothrow) cce::tprt::TprtManage();
    TprtManage *manage = TprtManage::Instance();
    TprtDevice *dev;
    uint32_t devId = 0U;
    TprtCfgInfo_t cfg = {0U, 1024U, 100U, 1000U};
    TprtDevice *device = new TprtDevice(devId);
    manage->deviceMap_.insert(std::make_pair(devId, device));
    uint32_t error = manage->TprtDeviceOpen(devId, &cfg);
    EXPECT_EQ(error, TPRT_DEVICE_INVALID);
    manage->deviceMap_.erase(devId);
    DELETE_O(device)
    DELETE_O(cce::tprt::TprtManage::tprt_);
}