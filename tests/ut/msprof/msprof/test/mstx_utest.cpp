/**
* Copyright (c) 2026 Huawei Technologies Co., Ltd.
* This program is free software, you can redistribute it and/or modify it under the terms and conditions of
* CANN Open Software License Agreement Version 2.0 (the "License").
* Please refer to the License for details. You may not use this file except in compliance with the License.
* THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
* INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
* See LICENSE in the root of the software repository for the full text of the License.
*/

#include <thread>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "mstx_data_handler.h"
#include "mstx_inject.h"
#include "mstx_domain_mgr.h"
#include "msprof_tx_manager.h"
#include "error_code.h"
#include "transport/hash_data.h"

using namespace Collector::Dvvp::Mstx;
using namespace Msprof::MsprofTx;
using namespace analysis::dvvp::common::utils;
using namespace analysis::dvvp::transport;
using namespace analysis::dvvp::common::error;

std::vector<MsprofAdditionalInfo> g_txdataList_;

int32_t MstxAdditionalInfoReportCallbackStub(uint32_t agingFlag, const VOID_PTR data, uint32_t len)
{
    g_txdataList_.push_back(*(reinterpret_cast<const MsprofAdditionalInfo *>(data)));
    return PROFILING_SUCCESS;
}

class MstxUtest : public testing::Test {
protected:
virtual void SetUp()
{
    g_txdataList_.clear();
    MsprofTxManager::instance()->RegisterReporterCallback(MstxAdditionalInfoReportCallbackStub);
    MsprofTxManager::instance()->Init();
}
virtual void TearDown()
{
    MsprofTxManager::instance()->UnInit();
    MsprofTxManager::instance()->reporter_.reset();
    MsprofTxManager::instance()->stampPool_.reset();
    g_txdataList_.clear();
}
private:
    std::string emptyMstxDomainInclude = "";
    std::string emptyMstxDomainExclude = "";
};

MstxFuncPointer g_mstxMarkAPtr;
MstxFuncPointer g_mstxRangeStartAPtr;
MstxFuncPointer g_mstxRangeEndPtr;
MstxFuncPointer g_mstxDomainCreateAPtr;
MstxFuncPointer g_mstxDomainDestroyPtr;
MstxFuncPointer g_mstxDomainMarkAPtr;
MstxFuncPointer g_mstxDomainRangeStartAPtr;
MstxFuncPointer g_mstxDomainRangeEndPtr;

struct MstxContext {
    MstxFuncPointer* mstxCoreFuncTable[MSTX_FUNC_END + 1];
    MstxFuncPointer* mstxCore2FuncTable[MSTX_FUNC_DOMAIN_END + 1];
};

struct MstxContext g_ctx = {
    {
      0,
      &g_mstxMarkAPtr,
      &g_mstxRangeStartAPtr,
      &g_mstxRangeEndPtr,
      0,
    },
    {
      0,
      &g_mstxDomainCreateAPtr,
      &g_mstxDomainDestroyPtr,
      &g_mstxDomainMarkAPtr,
      &g_mstxDomainRangeStartAPtr,
      &g_mstxDomainRangeEndPtr,
      0
    }
};

void MstxApiThreadFunc()
{
    uint64_t testDomain = 0;
    uint64_t markEventId = 1;
    uint64_t rangeEventId = 2;
    MstxDataHandler::instance()->SaveMstxData("test_mark", markEventId, MstxDataType::DATA_MARK, testDomain);
    MstxDataHandler::instance()->SaveMstxData("test_range_start", rangeEventId, MstxDataType::DATA_RANGE_START,
                                            testDomain);
    MstxDataHandler::instance()->SaveMstxData(nullptr, rangeEventId, MstxDataType::DATA_RANGE_END);
}

uint64_t CalculateHash(const std::string &str)
{
    const uint32_t uint32Bits = 32;   // the number of uint32_t bits
    uint32_t prime[2] = { 29, 131 };  // hash step size,
    uint32_t hash[2] = { 0 };

    for (const char d : str) {
        hash[0] = hash[0] * prime[0] + static_cast<uint32_t>(d);
        hash[1] = hash[1] * prime[1] + static_cast<uint32_t>(d);
    }

    return (((static_cast<uint64_t>(hash[0])) << uint32Bits) | hash[1]);
}

int GetFuncTableReturnFailStub(MstxFuncModule module, MstxFuncTable *outTable, unsigned int *outSize)
{
    return MSTX_FAIL;
}

int GetFuncTableReturnInvalidOutsizeStub(MstxFuncModule module, MstxFuncTable *outTable, unsigned int *outSize)
{
    return MSTX_SUCCESS;
}

int GetFuncTableReturnValidOutsizeStub(MstxFuncModule module, MstxFuncTable *outTable, unsigned int *outSize)
{
    switch (module) {
      case MSTX_API_MODULE_CORE:
          *outTable = g_ctx.mstxCoreFuncTable;
          *outSize = MSTX_FUNC_END;
          break;
      case MSTX_API_MODULE_CORE_DOMAIN:
          *outTable = g_ctx.mstxCore2FuncTable;
          *outSize = MSTX_FUNC_DOMAIN_END;
          break;
      default:
          return MSTX_FAIL;
    }
    return MSTX_SUCCESS;
}

TEST_F(MstxUtest, GetModuleTableFuncWillReturnSuccWhenCallGetFuncTableFailed)
{
    EXPECT_EQ(MSTX_SUCCESS, MsprofMstxApi::GetModuleTableFunc(GetFuncTableReturnFailStub));
}

TEST_F(MstxUtest, GetModuleTableFuncWillReturnSuccWhenGetFuncTableReturnInvalidOutsize)
{
    EXPECT_EQ(MSTX_SUCCESS, MsprofMstxApi::GetModuleTableFunc(GetFuncTableReturnInvalidOutsizeStub));
}

TEST_F(MstxUtest, GetModuleTableFuncWillReturnSuccWhenGetFuncTableReturnValidOutsize)
{
    EXPECT_EQ(MSTX_SUCCESS, MsprofMstxApi::GetModuleTableFunc(GetFuncTableReturnValidOutsizeStub));
}

TEST_F(MstxUtest, MstxDataHandlerWillSaveDataWhileRunSucc)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    EXPECT_EQ(true, MstxDataHandler::instance()->IsStart());
    std::thread t(MstxApiThreadFunc);
    t.join();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(2, g_txdataList_.size());
    for (size_t i = 0; i < g_txdataList_.size(); i++) {
        EXPECT_EQ(MSPROF_REPORT_TX_LEVEL, g_txdataList_[i].level);
        EXPECT_EQ(sizeof(MsprofTxInfo), g_txdataList_[i].dataLen);
    }
}

TEST_F(MstxUtest, MstxDataHandlerStartWillReturnSuccWhileRepeatStart)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
}

TEST_F(MstxUtest, MstxDataHandlerReturnFailWhileSaveInvalidRangeEndId)
{
    GlobalMockObject::verify();
    uint64_t invalidId = 10;
    EXPECT_EQ(PROFILING_FAILED, MstxDataHandler::instance()->SaveMstxData("test", invalidId,
                                                                        MstxDataType::DATA_RANGE_END));
}

TEST_F(MstxUtest, MstxMarkAFuncWillReturnWhenMstxDataHandlerNotStartYet)
{
    GlobalMockObject::verify();
    const char* msg = "test";
    MsprofMstxApi::MstxMarkAFunc(msg, nullptr);
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillReturnWhenMsgIsNull)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxMarkAFunc(nullptr, nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillSaveDataWhenMsgIsLongerThanMaxLen)
{
    GlobalMockObject::verify();
    std::string msg(MAX_MESSAGE_LEN + 1, 'a');
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxMarkAFunc(msg.c_str(), nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(2, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillReturnInputDataStartsWithInvalidChar)
{
    // 校验框架内置通信打点数据
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    std::string msg = "+invalidChar";
    MsprofMstxApi::MstxMarkAFunc(msg.c_str(), nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillSaveDataInputCommunicationDataMsgLengthLargerThanMaxValue)
{
    // 校验框架内置通信打点数据
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    std::string msg = "{\\\"count\\\": \\\"16\\\", \\\"dataType\\\": \\\"fp32\\\","
                    "\\\"groupName\\\": \\\"hccl_world_groupxxxxxxxx\\\", \\\"op_name\\\": \\\"HcclSend\\\", "
                    "\\\"DstRank\\\": \\\"100\\\", \\\"streamId\\\": \\\"5\\\", \\\"taskId\\\": \\\"1\\\", "
                    "\\\"opType\\\": \\\"SUM\\\", \\\"linkType\\\": \\\"ub\\\", \\\"transportType\\\": "
                    "\\\"SDMA\\\", \\\"SrcRank\\\": \\\"50\\\" }";
    MsprofMstxApi::MstxMarkAFunc(msg.c_str(), nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(2, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillSaveDataInputCommunicationDataMsgLengthSmallerThanMaxValue)
{
    // 校验框架内置通信打点数据
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    std::string msg = "{\\\"count\\\": \\\"16\\\", \\\"dataType\\\": \\\"fp32\\\","
                    "\\\"groupName\\\": \\\"hccl_world_groupxxxxxxxx\\\", \\\"op_name\\\": \\\"HcclSend\\\","
                    "\\\"streamId\\\": \\\"5\\\"}";
    MsprofMstxApi::MstxMarkAFunc(msg.c_str(), nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillReturnWhenProfilerMarkExFail)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MsprofMstxApi::MstxMarkAFunc(msg, stream);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillReturnWhenSaveMstxDataFail)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MOCKER_CPP(&Collector::Dvvp::Mstx::MstxDataHandler::SaveMstxData)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MsprofMstxApi::MstxMarkAFunc(msg, stream);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillSaveMstxDataWhenSaveMstxDataSuccWithInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    MsprofMstxApi::MstxMarkAFunc(msg, stream);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxMarkAFuncWillSaveMstxDataWhenSaveMstxDataSuccWithNoInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    const char* msg = "record";
    MsprofMstxApi::MstxMarkAFunc(msg, nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillReturnZeroWhenMstxDataHandlerNotStartYet)
{
    GlobalMockObject::verify();
    const char* msg = "record";
    EXPECT_EQ(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr));
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillReturnZeroWhenMsgIsNull)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    EXPECT_EQ(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(nullptr, nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillReturnZeroWhenMsgIsLongerThanMaxValue)
{
    GlobalMockObject::verify();
    std::string msg(MAX_MESSAGE_LEN + 1, 'a');
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    EXPECT_NE(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(msg.c_str(), nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillReturnZeroWhenProfilerMarkExFail)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    EXPECT_EQ(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(msg, stream));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillReturnZeroWhenSaveMstxDataFail)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x87654321;
    const char* msg = "test";
    MOCKER_CPP(&Collector::Dvvp::Mstx::MstxDataHandler::SaveMstxData)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(msg, stream));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillNotSaveMstxDataWhenMstxRangeEndIsNotCalledWithInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_NE(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(msg, stream));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillNotSaveMstxDataWhenMstxRangeEndIsNotCalledWithNotInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    EXPECT_NE(MSTX_INVALID_RANGE_ID, MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr));
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillSaveMstxDataWhenMstxRangeEndIsCalledWithInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char* msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, stream);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);
    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeStartAFuncWillSaveMstxDataWhenMstxRangeEndIsCalledWithNotInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    const char* msg = "record";
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);
    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillReturnWhenMstxDataHandlerNotStartYet)
{
    GlobalMockObject::verify();
    uint64_t id = 0;
    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillReturnWhenInputInvalidRangeId)
{
    GlobalMockObject::verify();
    uint64_t id = 0;
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillNotSaveMstxDataWhenSaveMstxDataFail)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MOCKER_CPP(&Collector::Dvvp::Mstx::MstxDataHandler::SaveMstxData)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS)) // for range start
        .then(returnValue(PROFILING_FAILED)); // for range end
    const char *msg = "record";
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);

    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillSaveMstxDataWhenSaveMstxDataSuccWithNotInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    const char *msg = "record";
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);

    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillNotSaveMstxDataWhenDefaultDomainIsNotEnabled)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    const char *msg = "record";
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);

    MOCKER_CPP(&MstxDomainMgr::IsDomainEnabled)
        .stubs()
        .will(returnValue(false));
    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillSaveMstxDataWhenSaveMstxDataSuccWithInputStream)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    aclrtStream stream = (aclrtStream)0x12345678;
    const char *msg = "record";
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, stream);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);

    MsprofMstxApi::MstxRangeEndFunc(id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxRangeEndFuncWillNotSaveMstxDataWhenInputDomainDifferFromInputDomainForRangeStartFunc)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    auto domainHandler = MsprofMstxApi::MstxDomainCreateAFunc("domain");
    EXPECT_NE(nullptr, domainHandler);
    const char *msg = "record";
    uint64_t id = MsprofMstxApi::MstxRangeStartAFunc(msg, nullptr);
    EXPECT_NE(MSTX_INVALID_RANGE_ID, id);
    MsprofMstxApi::MstxDomainRangeEndFunc(domainHandler, id);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(domainHandler);
}

TEST_F(MstxUtest, MstxDomainCreateAFuncWillReturnNullWhenInputInvalidMsg)
{
    GlobalMockObject::verify();
    EXPECT_EQ(nullptr, MsprofMstxApi::MstxDomainCreateAFunc(nullptr));
}

TEST_F(MstxUtest, MstxDomainCreateAFuncWillReturnHandleWhenInputValidMsg)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc(nullptr);
    EXPECT_EQ(nullptr, handle);
    EXPECT_EQ(0, MstxDomainMgr::domainHandleMap_.size());

    handle = MsprofMstxApi::MstxDomainCreateAFunc("+");
    EXPECT_EQ(nullptr, handle);
    EXPECT_EQ(0, MstxDomainMgr::domainHandleMap_.size());

    handle = MsprofMstxApi::MstxDomainCreateAFunc("nullptr");
    EXPECT_NE(nullptr, handle);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());

    auto handle2 = MsprofMstxApi::MstxDomainCreateAFunc("nullptr");
    EXPECT_EQ(handle, handle2);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());

    auto handle3 = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_NE(handle3, handle2);
    EXPECT_EQ(2, MstxDomainMgr::domainHandleMap_.size());

    MsprofMstxApi::MstxDomainDestroyFunc(handle);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle2);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle3);
    EXPECT_EQ(0, MstxDomainMgr::domainHandleMap_.size());
}

TEST_F(MstxUtest, MstxDomainDestroyFuncWillRunWhenInputValidDomain)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_NE(nullptr, handle);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());

    MsprofMstxApi::MstxDomainDestroyFunc(nullptr);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());

    MsprofMstxApi::MstxDomainDestroyFunc(handle);
    EXPECT_EQ(0, MstxDomainMgr::domainHandleMap_.size());
}

TEST_F(MstxUtest, GetDomainNameHashByHandleWillReturnFalseWhenInputInvalidDomain)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_NE(nullptr, handle);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());
    uint64_t domain = 0;
    EXPECT_FALSE(MstxDomainMgr::instance()->GetDomainNameHashByHandle(nullptr, domain));
    EXPECT_EQ(0, domain);
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, GetDomainNameHashByHandleWillReturnSuccWhenInputValidDomain)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_NE(nullptr, handle);
    EXPECT_EQ(1, MstxDomainMgr::domainHandleMap_.size());
    uint64_t domain = 0;
    EXPECT_TRUE(MstxDomainMgr::instance()->GetDomainNameHashByHandle(handle, domain));
    EXPECT_NE(0, domain);
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, GetDefaultDomainNameHashWillReturnDefaultName)
{
    GlobalMockObject::verify();
    uint64_t expectValue = CalculateHash("default");
    EXPECT_EQ(expectValue, MstxDomainMgr::instance()->GetDefaultDomainNameHash());
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillNotMarkWhenMstxDataHandlerNotStart)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    MsprofMstxApi::MstxDomainMarkAFunc(handle, "test", nullptr);
    EXPECT_EQ(0, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillNotMarkWhenInputInvalidMsg)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxDomainMarkAFunc(handle, nullptr, nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillNotMarkWhenInputInvalidDomain)
{
    GlobalMockObject::verify();
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxDomainMarkAFunc(nullptr, "nullptr", nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillNotMarkWhenSaveMstxDataFail)
{
    GlobalMockObject::verify();
    MOCKER_CPP(&Collector::Dvvp::Mstx::MstxDataHandler::SaveMstxData)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxDomainMarkAFunc(handle, "test", nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillNotMarkWhenSaveMstxDataSucc)
{
    GlobalMockObject::verify();
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxDomainMarkAFunc(handle, "test", nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillNotMarkWhenProfilerMarkExFail)
{
    GlobalMockObject::verify();
    aclrtStream stream = (aclrtStream)0x12345678;
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_FAILED));
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxDomainMarkAFunc(handle, "test", stream);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(0, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, MstxDomainMarkAFuncWillMarkWhenProfilerMarkExSucc)
{
    GlobalMockObject::verify();
    aclrtStream stream = (aclrtStream)0x12345678;
    MOCKER_CPP(&MsprofTxManager::LaunchDeviceTxTask)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    auto handle = MsprofMstxApi::MstxDomainCreateAFunc("test");
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Start(emptyMstxDomainInclude, emptyMstxDomainExclude));
    MsprofMstxApi::MstxDomainMarkAFunc(handle, "test", stream);
    EXPECT_EQ(PROFILING_SUCCESS, MstxDataHandler::instance()->Stop());
    EXPECT_EQ(1, g_txdataList_.size());
    MsprofMstxApi::MstxDomainDestroyFunc(handle);
}

TEST_F(MstxUtest, MstxDomainMgrSetMstxDomainsEnabledWilNotSetDomainWhenIncludeAndExcludeBothSet)
{
    GlobalMockObject::verify();
    MstxDomainMgr::instance()->SetMstxDomainsEnabled("xx", "yy");
    EXPECT_FALSE(MstxDomainMgr::instance()->domainSet_.load());
    size_t setDomainNum = 0;
    EXPECT_EQ(setDomainNum, MstxDomainMgr::instance()->domainSetting_.setDomains_.size());
}

TEST_F(MstxUtest, MstxDomainMgrSetMstxDomainsEnabledWilSetDomainEnabledWhenIncludeSet)
{
    GlobalMockObject::verify();
    // create domain before set include or exclude
    auto handleForXX = MstxDomainMgr::instance()->CreateDomainHandle("xx");
    auto handleForZZ = MstxDomainMgr::instance()->CreateDomainHandle("zz");

    MstxDomainMgr::instance()->SetMstxDomainsEnabled("xx,yy", "");
    EXPECT_TRUE(MstxDomainMgr::instance()->domainSet_.load());
    size_t setDomainNum = 2;
    EXPECT_TRUE(MstxDomainMgr::instance()->domainSetting_.domainInclude);
    EXPECT_EQ(setDomainNum, MstxDomainMgr::instance()->domainSetting_.setDomains_.size());

    uint64_t hashIdForXX = HashData::instance()->GenHashId("xx");
    uint64_t hashIdForYY = HashData::instance()->GenHashId("yy");
    EXPECT_EQ(1, MstxDomainMgr::instance()->domainSetting_.setDomains_.count(hashIdForXX));
    EXPECT_EQ(1, MstxDomainMgr::instance()->domainSetting_.setDomains_.count(hashIdForYY));
    EXPECT_TRUE(MstxDomainMgr::instance()->domainHandleMap_[handleForXX]->enabled);
    EXPECT_FALSE(MstxDomainMgr::instance()->domainHandleMap_[handleForZZ]->enabled);

    // create domain after set include or exclude
    auto handleForYY = MstxDomainMgr::instance()->CreateDomainHandle("yy");
    EXPECT_TRUE(MstxDomainMgr::instance()->domainHandleMap_[handleForYY]->enabled);
}

TEST_F(MstxUtest, MstxDomainMgrSetMstxDomainsEnabledWilSetDomainDisabledWhenExcludeSet)
{
    GlobalMockObject::verify();
    // create domain before set include or exclude
    auto handleForXX = MstxDomainMgr::instance()->CreateDomainHandle("xx");
    auto handleForZZ = MstxDomainMgr::instance()->CreateDomainHandle("zz");

    MstxDomainMgr::instance()->SetMstxDomainsEnabled("", "xx,yy");
    EXPECT_TRUE(MstxDomainMgr::instance()->domainSet_.load());
    size_t setDomainNum = 2;
    EXPECT_FALSE(MstxDomainMgr::instance()->domainSetting_.domainInclude);
    EXPECT_EQ(setDomainNum, MstxDomainMgr::instance()->domainSetting_.setDomains_.size());

    uint64_t hashIdForXX = HashData::instance()->GenHashId("xx");
    uint64_t hashIdForYY = HashData::instance()->GenHashId("yy");
    EXPECT_EQ(1, MstxDomainMgr::instance()->domainSetting_.setDomains_.count(hashIdForXX));
    EXPECT_EQ(1, MstxDomainMgr::instance()->domainSetting_.setDomains_.count(hashIdForYY));
    EXPECT_FALSE(MstxDomainMgr::instance()->domainHandleMap_[handleForXX]->enabled);
    EXPECT_TRUE(MstxDomainMgr::instance()->domainHandleMap_[handleForZZ]->enabled);

    // create domain after set include or exclude
    auto handleForYY = MstxDomainMgr::instance()->CreateDomainHandle("yy");
    EXPECT_FALSE(MstxDomainMgr::instance()->domainHandleMap_[handleForYY]->enabled);
}