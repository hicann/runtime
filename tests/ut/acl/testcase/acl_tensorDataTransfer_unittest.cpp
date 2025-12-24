/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "acl/acl_base.h"
#include "acl/acl.h"
#include "acl/acl_tdt.h"
#include "acl/acl_tdt_queue.h"
#include "common/log_inner.h"


#include "acl_tdt_channel/tensor_data_transfer.h"

#include <gtest/gtest.h>
#include <gmock/gmock.h>
#include <memory>

#include "tdt_host_interface.h"
#include "data_common.h"
#include "acl_stub.h"

#define protected public
#define private public
#undef private
#undef protected

using namespace testing;
using namespace std;
using namespace acl;
using namespace tdt;

namespace acl {
    extern aclError TensorDatasetDeserializes(const std::vector<tdt::DataItem> &itemVec, acltdtDataset *dataset);
    extern aclError TensorDatasetSerializes(const acltdtDataset *dataset, std::vector<tdt::DataItem> &itemVec);
    extern aclError GetAclTypeByTdtDataType(tdt::TdtDataType tdtDataType, acltdtTensorType &aclType);
    extern void GetTensorDimsString(const int64_t *dims, size_t dimNum, std::string &dimsStr);
    extern aclError GetTdtDataTypeByAclDataType(acltdtTensorType aclType, tdt::TdtDataType &tdtDataType);
    extern bool GetTensorShape(const std::string &dimsStr, std::vector<int64_t> &dims);

    extern aclError acltdtReceiveTensorV2(const acltdtChannelHandle *handle, acltdtDataset *dataset, int32_t timeout);
    extern aclError acltdtSendTensorV2(const acltdtChannelHandle *handle, const acltdtDataset *dataset,
        int32_t timeout);

    extern aclError GetTdtDataTypeByAclDataTypeV2(acltdtTensorType aclType, int32_t &tdtDataType);
    extern aclError GetAclTypeByTdtDataTypeV2(int32_t tdtDataType, acltdtTensorType &aclType);
    extern aclError TensorDatasetSerializesV2(const acltdtDataset *dataset, std::vector<aclTdtDataItemInfo> &itemVec);
    extern aclError TensorDatasetDeserializesV2(const std::vector<aclTdtDataItemInfo> &itemVec, acltdtDataset *dataset);
    extern aclError UnpackageRecvDataInfo(uint8_t *outputHostAddr, size_t size, std::vector<aclTdtDataItemInfo> &itemVec);
    extern aclError TensorDataitemSerialize(std::vector<aclTdtDataItemInfo> &itemVec,
                                            std::vector<rtMemQueueBuffInfo> &qBufVec);
    extern aclError GetOrMallocHostMem(const acltdtChannelHandle *handle, acltdtDataset *dataset,
        size_t bufLen, void *& hostPtr);
}

class UTEST_tensor_data_transfer : public testing::Test
{
    public:
        UTEST_tensor_data_transfer(){}
    protected:
        void SetUp() override {
            MockFunctionTest::aclStubInstance().ResetToDefaultMock();
        }
        void TearDown() override {
            Mock::VerifyAndClear(&MockFunctionTest::aclStubInstance());
        }
};

TEST_F(UTEST_tensor_data_transfer, TestGetTensorTypeFromItem)
{
    const int64_t dims[] = {1, 3, 224, 224};
    void *data = (void*)0x1f;
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, data, 10);
    acltdtTensorType tensorType = acltdtGetTensorTypeFromItem(dataItem);
    EXPECT_EQ(tensorType, ACL_SUCCESS);
    EXPECT_NE(acltdtGetTensorTypeFromItem(nullptr), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtGetSliceInfoFromItem)
{
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    size_t sliceNum = 99;
    size_t sliceId = 99;
    EXPECT_EQ(acltdtGetSliceInfoFromItem(dataItem, &sliceNum, &sliceId), ACL_SUCCESS);
    EXPECT_EQ(sliceNum, 0);
    EXPECT_EQ(sliceId, 0);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestGetTensorInfo)
{
    const int64_t dims[] = {1, 3, 224, 224};
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, nullptr, 1);
    aclDataType dataType = acltdtGetDataTypeFromItem(dataItem);
    EXPECT_NE(dataType, ACL_SUCCESS);
    EXPECT_NE(acltdtGetDataTypeFromItem(nullptr), ACL_SUCCESS);
    int32_t tmpData = 0;
    dataItem->priorityData_ = (void *)&tmpData;
    void *dataAddr = acltdtGetDataAddrFromItem(dataItem);
    EXPECT_NE(dataAddr, nullptr);
    EXPECT_EQ(dataAddr, &tmpData);

    EXPECT_NE(acltdtGetDataSizeFromItem(dataItem), 0);
    EXPECT_EQ(acltdtGetDataSizeFromItem(nullptr), 0);

    EXPECT_NE(acltdtGetDimNumFromItem(dataItem), 0);
    EXPECT_EQ(acltdtGetDimNumFromItem(nullptr), 0);

    int64_t *dim = new int64_t[4];
    EXPECT_NE(acltdtGetDimsFromItem(dataItem, dim, 1), ACL_SUCCESS);
    EXPECT_EQ(acltdtGetDimsFromItem(dataItem, dim, 5), ACL_SUCCESS);

    EXPECT_NE(dataItem, nullptr);
    acltdtDataItem *dataItemNull = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 0, ACL_INT64, &tmpData, 10);
    EXPECT_EQ(dataItemNull, nullptr);
    EXPECT_NE(acltdtDestroyDataItem(dataItemNull), ACL_SUCCESS);

    acltdtDataset *createDataSet = acltdtCreateDataset();
    EXPECT_EQ(acltdtDestroyDataset(createDataSet), ACL_SUCCESS);
    createDataSet = acltdtCreateDataset();
    EXPECT_NE(acltdtAddDataItem(createDataSet, dataItemNull), ACL_ERROR_FEATURE_UNSUPPORTED);
    EXPECT_EQ(acltdtAddDataItem(createDataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtGetDataItem(nullptr, 0), nullptr);
    EXPECT_EQ(acltdtDestroyDataset(createDataSet), ACL_SUCCESS);

    createDataSet = acltdtCreateDataset();
    EXPECT_EQ(acltdtGetDatasetSize(createDataSet), 0);
    EXPECT_EQ(acltdtGetDatasetSize(nullptr), 0);
    EXPECT_EQ(acltdtDestroyDataset(createDataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    delete [] dim;
}

TEST_F(UTEST_tensor_data_transfer, TestTdtAddDataItem)
{
    const int64_t dims[] = {1, 3, 224, 224};
    void *data = (void*)0x1f;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, data, 1);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);

    dataSet = acltdtCreateDataset();
    dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, data, 1);
    dataSet->freeSelf = true;
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_ERROR_FEATURE_UNSUPPORTED);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtChannel01)
{
    uint32_t deviceId = 1;
    const char *name = "Pooling";
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillRepeatedly(Return((0)));
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);

    handle->recvName = "Poolings";
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostStop(_))
        .WillOnce(Return((1)));
    EXPECT_NE(acltdtStopChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtChannel02)
{
    uint32_t deviceId = 1;
    const char *name = "Pooling";
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_EQ(acltdtStopChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtChannel03)
{
    uint32_t deviceId = 1;
    const char *name = "";
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    std::map<std::string, acltdtChannelHandle *> aclChannleMap;
    aclChannleMap.erase(handle->name);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostDestroy())
        .WillOnce(Return((1)))
        .WillRepeatedly(Return(0));
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtSendTensor01)
{
    uint32_t deviceId = 0;
    const char *name = "tensor";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    aclError ret = acltdtSendTensor(handle, dataSet, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = acltdtSendTensor(nullptr, dataSet, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    ret = acltdtSendTensor(handle, nullptr, 0);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostPushData(_, _, _))
        .WillOnce(Return((1)));

    ret = acltdtSendTensor(handle, dataSet, -1);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtSendTensor02)
{
    uint32_t deviceId = 0;
    const char *name = "tensor";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostPushData(_, _, _))
        .WillOnce(Return((1)));
    aclError ret = acltdtSendTensor(handle, dataSet, -1);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtSendTensor03)
{
    uint32_t deviceId = 0;
    const char *name = "tensor";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostPushData(_, _, _))
        .WillOnce(Return(0));
    aclError ret = acltdtSendTensor(handle, dataSet, -1);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAclTdtReceiveTensor01)
{
    uint32_t deviceId = 0;
    const char *name = "Pooling";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    handle->recvName = "Poolings";

    EXPECT_EQ(acltdtReceiveTensor(nullptr, dataSet, 0), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(acltdtReceiveTensor(handle, nullptr, 0), ACL_ERROR_INVALID_PARAM);
    EXPECT_NE(acltdtReceiveTensor(handle, dataSet, -1), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(acltdtReceiveTensor(handle, dataSet, 0), ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);

    deviceId = 1;
    name = "Pooling";
    dataSet = acltdtCreateDataset();
    handle = acltdtCreateChannel(deviceId, name);
    handle->recvName = "";
    EXPECT_NE(acltdtReceiveTensor(handle, dataSet, -1), ACL_ERROR_FAILURE);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestTensorDatasetSerializes01)
{
    uint32_t deviceId = 0;
    const char *name = "Pooling";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);

    const int64_t dims[] = {1, 3, 224, 224};
    void *data = (void*)0x1f;
    acltdtDataItem *item = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_FLOAT16, data, 1);

    tdt::DataItem dataItem1 = {tdt::TDT_END_OF_SEQUENCE, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    tdt::DataItem dataItem2 = {tdt::TDT_TENSOR, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    tdt::DataItem dataItem3 = {tdt::TDT_ABNORMAL, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    tdt::DataItem dataItem4 = {tdt::TDT_DATATYPE_MAX, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    std::vector<tdt::DataItem> itemVec1;
    itemVec1.push_back(dataItem1);
    std::vector<tdt::DataItem> itemVec2;
    itemVec2.push_back(dataItem2);
    std::vector<tdt::DataItem> itemVec3;
    itemVec3.push_back(dataItem3);
    std::vector<tdt::DataItem> itemVec4;
    itemVec3.push_back(dataItem4);

    (void)TensorDatasetSerializes(dataSet, itemVec1);
    EXPECT_EQ(TensorDatasetSerializes(dataSet, itemVec2), ACL_SUCCESS);
    EXPECT_EQ(TensorDatasetSerializes(dataSet, itemVec3), ACL_SUCCESS);

    EXPECT_EQ(TensorDatasetDeserializes(itemVec1, dataSet), ACL_SUCCESS);
    EXPECT_NE(TensorDatasetDeserializes(itemVec2, dataSet), ACL_SUCCESS);
    EXPECT_NE(TensorDatasetDeserializes(itemVec3, dataSet), ACL_SUCCESS);
    EXPECT_NE(TensorDatasetDeserializes(itemVec4, dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(item), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestTensorDatasetSerializes02)
{
    acltdtDataset *dataSet = acltdtCreateDataset();
    tdt::DataItem dataItem = {tdt::TDT_END_OF_SEQUENCE, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    std::vector<tdt::DataItem> itemVec;
    itemVec.push_back(dataItem);

    const int64_t dims[] = {1, 3, 224, 224};
    void *data = (void*)0x1f;
    acltdtDataItem *item = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_FLOAT16, data, 1);
    (void)acltdtAddDataItem(dataSet, item);
    EXPECT_EQ(TensorDatasetSerializes(dataSet, itemVec), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(item), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestGetTdtDataTypeByAclDataType)
{
    tdt::TdtDataType tdtDataType1 = tdt::TDT_TFRECORD;
    aclError ret = GetTdtDataTypeByAclDataType(ACL_TENSOR_DATA_TENSOR, tdtDataType1);
    EXPECT_EQ(ret, ACL_SUCCESS);
    tdt::TdtDataType tdtDataType2 = tdt::TDT_END_OF_SEQUENCE;
    EXPECT_EQ(GetTdtDataTypeByAclDataType(ACL_TENSOR_DATA_END_OF_SEQUENCE, tdtDataType2), ACL_SUCCESS);
    tdt::TdtDataType tdtDataType3 = tdt::TDT_ABNORMAL;
    EXPECT_EQ(GetTdtDataTypeByAclDataType(ACL_TENSOR_DATA_ABNORMAL, tdtDataType3), ACL_SUCCESS);
    tdt::TdtDataType tdtDataType4 = tdt::TDT_DATATYPE_MAX;
    EXPECT_EQ(GetTdtDataTypeByAclDataType(ACL_TENSOR_DATA_UNDEFINED, tdtDataType4), ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_tensor_data_transfer, TestGetAclTypeByTdtDataType)
{
    tdt::TdtDataType tdtDataType1 = tdt::TDT_TENSOR;
    acltdtTensorType aclType1 = ACL_TENSOR_DATA_TENSOR;
    acltdtTensorType aclType2 = ACL_TENSOR_DATA_END_OF_SEQUENCE;
    tdt::TdtDataType tdtDataType2 = tdt::TDT_END_OF_SEQUENCE;
    EXPECT_EQ(GetAclTypeByTdtDataType(tdtDataType2, aclType2), ACL_SUCCESS);
    EXPECT_EQ(GetAclTypeByTdtDataType(tdtDataType1, aclType1), ACL_SUCCESS);
    tdt::TdtDataType tdtDataType3 = tdt::TDT_ABNORMAL;
    acltdtTensorType aclType3 = ACL_TENSOR_DATA_ABNORMAL;
    EXPECT_EQ(GetAclTypeByTdtDataType(tdtDataType3, aclType3), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestTensorDatasetDeserializes01)
{
    uint32_t deviceId = 0;
    const char *name = "Pooling";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);

    const int64_t dims[] = {1, 3, 224, 224};
    void *data = (void*)0x1f;
    acltdtDataItem *item = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_FLOAT16, data, 1);

    tdt::DataItem dataItem = {tdt::TDT_IMAGE_LABEL, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    std::vector<tdt::DataItem> itemVec;
    itemVec.push_back(dataItem);
    aclError ret = TensorDatasetSerializes(dataSet, itemVec);
    EXPECT_EQ(ret, ACL_SUCCESS);

    ret = TensorDatasetDeserializes(itemVec, dataSet);
    EXPECT_NE(ret, ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(item), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestTensorDatasetDeserializes02)
{
    acltdtDataset *dataSet = acltdtCreateDataset();
    tdt::DataItem dataItem = {tdt::TDT_TENSOR, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    std::vector<tdt::DataItem> itemVec;
    itemVec.push_back(dataItem);
    EXPECT_NE(TensorDatasetDeserializes(itemVec, dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestTensorDatasetDeserializes03)
{
    acltdtDataset *dataSet = acltdtCreateDataset();
    tdt::DataItem dataItem = {tdt::TDT_TENSOR, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    std::vector<tdt::DataItem> itemVec;
    itemVec.push_back(dataItem);

    const int64_t dims[] = {1, 3, 224, 224};
    void *data = (void*)0x1f;
    acltdtDataItem *item = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_FLOAT16, data, 1);
    (void)acltdtAddDataItem(dataSet, item);

    std::vector<int64_t> dims2;
    dims2.push_back(1);
    EXPECT_NE(GetTensorShape(dataItem.tensorShape_, dims2), true);

    EXPECT_NE(TensorDatasetDeserializes(itemVec, dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(item), ACL_SUCCESS);
}


TEST_F(UTEST_tensor_data_transfer, TestAcltdtReceiveTensor01)
{
    uint32_t deviceId = 0;
    const char *name = "Pooling";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    tdt::DataItem dataItem = {tdt::TDT_END_OF_SEQUENCE, "hidden", "3", "int64", 8, std::shared_ptr<void>(new int(0))};
    std::vector<tdt::DataItem> itemVec;
    itemVec.push_back(dataItem);
    EXPECT_NE(acltdtReceiveTensor(handle, dataSet, -1), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestAcltdtReceiveTensor02)
{
    uint32_t deviceId = 0;
    const char *name = "tensor";
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    handle->recvName = "test";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostPopData(_, _))
        .WillOnce(Return((1)));
    aclError ret = acltdtReceiveTensor(handle, dataSet, -1);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TestGetTensorShape)
{
    std::string dimStr1 = "[32,224]";
    std::vector<int64_t> dims;
    dims.push_back(1);
    bool ret = GetTensorShape(dimStr1, dims);
    EXPECT_EQ(ret, true);

    std::string dimStr2 = "[tensor]";
    ret = GetTensorShape(dimStr2, dims);
    EXPECT_EQ(ret, false);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCreateChannel)
{
    uint32_t deviceId = 1;
    const char *name = "name";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillOnce(Return((1)));
    acltdtChannelHandle *ret = acltdtCreateChannel(deviceId, name);
    EXPECT_EQ(ret, nullptr);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCreateDataItemTest)
{
    acltdtTensorType tdtType = ACL_TENSOR_DATA_UNDEFINED;
    int64_t *dims = (int64_t *)0x11;
    size_t dimNum = 10;
    aclDataType dataType = ACL_DT_UNDEFINED;
    void *data = nullptr;
    size_t size = 0;

    acltdtDataItem *ret = acltdtCreateDataItem(tdtType, dims, dimNum, dataType, data, size);
    EXPECT_EQ(ret, nullptr);

    dimNum = 129;
    ret = acltdtCreateDataItem(tdtType, dims, dimNum, dataType, data, size);
    EXPECT_EQ(ret, nullptr);
}

TEST_F(UTEST_tensor_data_transfer, acltdtReceiveTensorTest)
{
    uint32_t deviceId = 1;
    const char *name = "name";
    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);
    handle->recvName = "tensor";
    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);
    acltdtDestroyChannel(handle);
    acltdtDestroyDataset(dataset);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCreateChannelWithCapacityTest)
{
    uint32_t deviceId = 0;
    const char *fakeName = "aaaaaaaaaadddddddddddeeeeeeeecccccccccccdddddddaaaaaaaaaaaadadadadadadadadadadadadadadadadadadaaadaaaadaadadddaddddddddddddddddda";
    size_t capacity = 1;
    acltdtChannelHandle *ret = acltdtCreateChannelWithCapacity(deviceId, fakeName, capacity);
    EXPECT_EQ(ret, nullptr);
    const char *name = "thj_queue";
    capacity = 2;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueInit(_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = acltdtCreateChannelWithCapacity(deviceId, name, capacity);
    EXPECT_EQ(ret, nullptr);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueInit(_))
        .WillOnce(Return(ACL_ERROR_RT_FEATURE_NOT_SUPPORT))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = acltdtCreateChannelWithCapacity(deviceId, name, capacity);
    EXPECT_EQ(ret, nullptr);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueCreate(_,_,_))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillRepeatedly(Return(RT_ERROR_NONE));
    ret = acltdtCreateChannelWithCapacity(deviceId, name, capacity);
    EXPECT_EQ(ret, nullptr);

    ret = acltdtCreateChannelWithCapacity(deviceId, name, capacity);
    EXPECT_NE(ret, nullptr);
    EXPECT_EQ(acltdtDestroyChannel(ret), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtGetDimsFromItemTest)
{
    int64_t *dims = nullptr;
    size_t dimNum = 10;
    acltdtDataItem *dataItem = (acltdtDataItem *)0x11;
    aclError ret = acltdtGetDimsFromItem(dataItem, dims, dimNum);
    EXPECT_NE(ret, ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, TensorDatasetSerializesV2)
{
    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);
    acltdtDataItem item;
    item.tdtType = ACL_TENSOR_DATA_TENSOR;
    dataset->blobs.push_back(&item);
    std::vector<aclTdtDataItemInfo> itemVec;
    auto ret = TensorDatasetSerializesV2(dataset, itemVec);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(itemVec.size(), 1);
    acltdtDestroyDataset(dataset);
}

TEST_F(UTEST_tensor_data_transfer, TensorDatasetDeserializesV2)
{
    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);
    std::vector<aclTdtDataItemInfo> itemVec;
    aclTdtDataItemInfo info;
    info.ctrlInfo.dataType = 1;
    itemVec.push_back(info);
    info.ctrlInfo.dataType = 0;
    itemVec.push_back(info);
    auto ret = TensorDatasetDeserializesV2(itemVec, dataset);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(acltdtGetDatasetSize(dataset), 2);
    acltdtDestroyDataset(dataset);
    dataset = acltdtCreateDataset();
    acltdtDataItem item;
    dataset->blobs.push_back(&item);
    ret = TensorDatasetDeserializesV2(itemVec, dataset);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    acltdtDestroyDataset(dataset);
}

TEST_F(UTEST_tensor_data_transfer, acltdtSendTensorV2)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    acltdtChannelHandle *handle = acltdtCreateChannelWithCapacity(0, "test", 3);
    EXPECT_NE(handle, nullptr);
    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);
    int32_t timeout = 300;

    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    void *data = (void*)(&tmpData);
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, data, sizeof(int32_t));
    dataset->blobs.push_back(dataItem);
    dataset->blobs[0]->tdtType = ACL_TENSOR_DATA_UNDEFINED;
    auto ret = acltdtSendTensor(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    dataset->blobs[0]->tdtType = ACL_TENSOR_DATA_TENSOR;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueueBuff(_,_,_,_))
        .WillOnce(Return((ACL_ERROR_RT_QUEUE_FULL)))
        .WillOnce(Return((ACL_ERROR_RT_INTERNAL_ERROR)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    ret = acltdtSendTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_FULL);

    ret = acltdtSendTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);

    ret = acltdtSendTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    acltdtDestroyDataItem(dataItem);
    acltdtDestroyChannel(handle);
    acltdtDestroyDataset(dataset);
}

TEST_F(UTEST_tensor_data_transfer, acltdtSendTensorV2_Device)
{
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtGetRunMode(_))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    acltdtChannelHandle *handle = acltdtCreateChannelWithCapacity(0, "test", 3);
    EXPECT_NE(handle, nullptr);
    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);
    int32_t timeout = 300;

    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    void *data = (void*)(&tmpData);
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, data, sizeof(int32_t));
    dataset->blobs.push_back(dataItem);
    dataset->blobs[0]->tdtType = ACL_TENSOR_DATA_UNDEFINED;
    dataset->memType = MEM_DEVICE;
    auto ret = acltdtSendTensor(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    dataset->blobs[0]->tdtType = ACL_TENSOR_DATA_TENSOR;

    // SaveCtrlSharedPtrToVec中不分配内存，也不拷贝
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMalloc).WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemcpy).WillRepeatedly(Return(RT_ERROR_NONE));
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueEnQueueBuff(_,_,_,_))
        .WillOnce(Return((ACL_ERROR_RT_QUEUE_FULL)))
        .WillOnce(Return((ACL_ERROR_RT_INTERNAL_ERROR)))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    ret = acltdtSendTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_FULL);

    ret = acltdtSendTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);

    ret = acltdtSendTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    acltdtDestroyDataItem(dataItem);
    acltdtDestroyChannel(handle);
    acltdtDestroyDataset(dataset);
}

TEST_F(UTEST_tensor_data_transfer, acltdtReceiveTensorV2)
{
    acltdtChannelHandle *handle = acltdtCreateChannelWithCapacity(0, "TF_RECEIVE_1", 3);
    EXPECT_NE(handle, nullptr);

    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);

    int32_t timeout = 300;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueuePeek(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_EMPTY))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    auto ret = acltdtReceiveTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = acltdtReceiveTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_EMPTY);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueDeQueueBuff(_, _, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID))
        .WillOnce(Return(ACL_ERROR_RT_QUEUE_EMPTY))
        .WillRepeatedly(Return((RT_ERROR_NONE)));
    ret = acltdtReceiveTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = acltdtReceiveTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_ERROR_RT_QUEUE_EMPTY);

    ret = acltdtReceiveTensorV2(handle, dataset, timeout);
    EXPECT_EQ(ret, ACL_SUCCESS);
    acltdtDestroyChannel(handle);
    acltdtDestroyDataset(dataset);
}

TEST_F(UTEST_tensor_data_transfer, acltdtQueryChannelSize)
{
    size_t size = 999;
    aclError ret = acltdtQueryChannelSize(nullptr, &size);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    acltdtChannelHandle *handle = acltdtCreateChannelWithCapacity(0, "TF_RECEIVE_1", 3);
    EXPECT_NE(handle, nullptr);

    ret = acltdtQueryChannelSize(handle, nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);

    handle->isTdtProcess = true;
    ret = acltdtQueryChannelSize(handle, &size);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
    EXPECT_EQ(size, 999);

    handle->isTdtProcess = false;
    ret = acltdtQueryChannelSize(handle, &size);
    EXPECT_EQ(ret, ACL_SUCCESS);

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueQueryInfo(_, _, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));
    ret = acltdtQueryChannelSize(handle, &size);

    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);

    acltdtDestroyChannel(handle);
}

TEST_F(UTEST_tensor_data_transfer, GetTdtDataTypeByAclDataTypeV2)
{
    acltdtTensorType aclType = ACL_TENSOR_DATA_END_OF_SEQUENCE;
    int32_t tdtDataType;
    aclError ret = GetTdtDataTypeByAclDataTypeV2(aclType, tdtDataType);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclType = ACL_TENSOR_DATA_ABNORMAL;
    ret = GetTdtDataTypeByAclDataTypeV2(aclType, tdtDataType);
    EXPECT_EQ(ret, ACL_SUCCESS);

    aclType = (acltdtTensorType)(5);
    ret = GetTdtDataTypeByAclDataTypeV2(aclType, tdtDataType);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
}

TEST_F(UTEST_tensor_data_transfer, GetAclTypeByTdtDataTypeV2)
{
    int32_t tdtDataType = 0;
    acltdtTensorType aclType;
    aclError ret = GetAclTypeByTdtDataTypeV2(tdtDataType, aclType);
    EXPECT_EQ(ret, ACL_SUCCESS);

    tdtDataType = 2;
    ret = GetAclTypeByTdtDataTypeV2(tdtDataType, aclType);
    EXPECT_EQ(ret, ACL_SUCCESS);

    tdtDataType = 3;
    ret = GetAclTypeByTdtDataTypeV2(tdtDataType, aclType);
    EXPECT_EQ(ret, ACL_SUCCESS);

    tdtDataType = 4;
    ret = GetAclTypeByTdtDataTypeV2(tdtDataType, aclType);
    EXPECT_EQ(ret, ACL_SUCCESS);

    tdtDataType = 5;
    ret = GetAclTypeByTdtDataTypeV2(tdtDataType, aclType);
    EXPECT_EQ(ret, ACL_ERROR_UNSUPPORTED_DATA_TYPE);
}

TEST_F(UTEST_tensor_data_transfer, UnpackageRecvDataInfoSuccess)
{
    size_t size = sizeof(ItemInfo) + sizeof(int64_t) + 100;
    uint8_t *outputHostAddr = static_cast<uint8_t *>(malloc(size));
    EXPECT_NE(outputHostAddr, nullptr);
    ItemInfo *head = reinterpret_cast<ItemInfo *>(outputHostAddr);
    head->cnt = 1;
    head->curCnt = 0;
    head->dataLen = 100;
    head->dimNum = 1;
    std::vector<aclTdtDataItemInfo> itemVec;
    aclError ret = UnpackageRecvDataInfo(outputHostAddr, size, itemVec);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(itemVec.size(), 1);
    EXPECT_EQ(itemVec[0].dataPtr, nullptr);
    EXPECT_EQ(itemVec[0].priorityDataPtr_, (outputHostAddr + size - 100));
    free(outputHostAddr);
}

TEST_F(UTEST_tensor_data_transfer, UnpackageRecvDataInfoTest)
{
    size_t itemSize = sizeof(ItemInfo) + sizeof(int64_t) + 100;
    uint8_t *outputHostAddr = new uint8_t[itemSize]{0};
    EXPECT_NE(outputHostAddr, nullptr);
    ItemInfo *head = reinterpret_cast<ItemInfo *>(outputHostAddr);
    head->cnt = 1;
    head->curCnt = 0;
    head->dataLen = 100;
    head->dimNum = 1;
    size_t size = 0;
    aclTdtDataItemInfo tdtDataItemInfo;
    tdtDataItemInfo.dataPtr = std::shared_ptr<int>(new int(10));
    tdtDataItemInfo.dims.push_back(1);
    std::vector<aclTdtDataItemInfo> itemVec;
    itemVec.push_back(tdtDataItemInfo);

    aclError ret = UnpackageRecvDataInfo(outputHostAddr, size, itemVec);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);

    size = 65;
    ret = UnpackageRecvDataInfo(outputHostAddr, size, itemVec);
    EXPECT_EQ(ret, ACL_ERROR_FAILURE);
    delete[] outputHostAddr;
}

TEST_F(UTEST_tensor_data_transfer, acltdtGetDatasetName)
{
    EXPECT_EQ(acltdtGetDatasetName(nullptr), nullptr);
    acltdtDataset *dataset = acltdtCreateDataset();
    EXPECT_NE(dataset, nullptr);
    std::string datasetNameAcquied = acltdtGetDatasetName(dataset);
    EXPECT_EQ(datasetNameAcquied, "");
    std::vector<aclTdtDataItemInfo> itemVec;
    std::string datasetName("123");
    std::shared_ptr<uint8_t> data(new uint8_t[datasetName.size()], [] (uint8_t *p) {delete[] p;});
    const auto retCopy = memcpy_s(data.get(), datasetName.size(), datasetName.c_str(), datasetName.size());
    EXPECT_EQ(retCopy, 0);
    aclTdtDataItemInfo info;
    info.ctrlInfo.dataType = ACL_TENSOR_DATA_TENSOR;
    info.ctrlInfo.version = 1;
    info.ctrlInfo.dataLen = datasetName.size();
    info.dataPtr = data;
    itemVec.push_back(info);
    auto ret = TensorDatasetDeserializesV2(itemVec, dataset);
    EXPECT_EQ(ret, ACL_SUCCESS);
    datasetNameAcquied = acltdtGetDatasetName(dataset);
    EXPECT_EQ(datasetNameAcquied, datasetName);
    EXPECT_EQ(acltdtDestroyDataset(dataset), ACL_SUCCESS);
}

rtError_t rtsPointerGetAttributesDevice(const void *ptr, rtPtrAttributes_t *attributes)
{
    (void) ptr;
    attributes->location.type = RT_MEMORY_LOC_DEVICE;
    return RT_ERROR_NONE;
}

rtError_t rtsPointerGetAttributesHost(const void *ptr, rtPtrAttributes_t *attributes)
{
    (void) ptr;
    attributes->location.type = RT_MEMORY_LOC_UNREGISTERED;
    return RT_ERROR_NONE;
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemHostHostPtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesHost))
        .WillOnce(Invoke(rtsPointerGetAttributesHost));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemDeviceDevicePtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesHost))
        .WillOnce(Invoke(rtsPointerGetAttributesHost));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemNullHostHostPtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    acltdtDataItem *dataItemEmpty = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItemEmpty), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItemEmpty), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemNullDeviceDevicePtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    acltdtDataItem *dataItemEmpty = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItemEmpty), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItemEmpty), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemDeviceHostPtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice))
        .WillOnce(Invoke(rtsPointerGetAttributesHost));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_NE(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemNullDeviceHostPtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    acltdtDataItem *dataItemEmpty = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice))
        .WillOnce(Invoke(rtsPointerGetAttributesHost));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItemEmpty), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_NE(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItemEmpty), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemDeviceNullHostPtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    acltdtDataItem *dataItemEmpty = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice))
        .WillOnce(Invoke(rtsPointerGetAttributesHost));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItemEmpty), ACL_SUCCESS);
    EXPECT_NE(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItemEmpty), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemHostDevicePtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesHost))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_NE(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemNullHostDevicePtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    acltdtDataItem *dataItemEmpty = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesHost))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItemEmpty), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_NE(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItemEmpty), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtAddDataItemHostNullDevicePtr)
{
    const int64_t dims[] = {1, 3, 224, 224};
    int32_t tmpData = 0;
    acltdtDataset *dataSet = acltdtCreateDataset();
    acltdtDataItem *dataItem = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, dims, 4, ACL_INT64, &tmpData, 4);
    acltdtDataItem *dataItemEmpty = acltdtCreateDataItem(ACL_TENSOR_DATA_TENSOR, nullptr, 0, ACL_INT64, nullptr, 0);
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtsPointerGetAttributes(_, _))
        .WillOnce(Invoke(rtsPointerGetAttributesHost))
        .WillOnce(Invoke(rtsPointerGetAttributesDevice));

    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtAddDataItem(dataSet, dataItemEmpty), ACL_SUCCESS);
    EXPECT_NE(acltdtAddDataItem(dataSet, dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataset(dataSet), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItem), ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyDataItem(dataItemEmpty), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, GetOrMallocHostMem)
{
    acltdtChannelHandle handle;
    acltdtDataset dataset;
    void *p = nullptr;
    size_t GEAR_SIZE_ZERO = 1U * 1024U * 1024U;
    size_t GEAR_SIZE_ONE = 10U * 1024U * 1024U;
    size_t GEAR_SIZE_TWO = 100U * 1024U * 1024U;
    size_t GEAR_SIZE_THREE = 500U * 1024U * 1024U;
    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtCtxGetCurrent(_))
        .WillOnce(Return((ACL_ERROR_RT_PARAM_INVALID)))
        .WillRepeatedly(Return((ACL_ERROR_RT_CONTEXT_NULL)));
    aclError ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_ZERO, p);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_ZERO, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_ZERO);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);

    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_ONE, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_ONE);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);

    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_TWO, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_TWO);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);

    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_THREE, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_THREE);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);

    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_THREE + 100, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_THREE + 100);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);

    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_THREE + 200, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_THREE + 200);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);

    ret = GetOrMallocHostMem(&handle, &dataset, GEAR_SIZE_THREE + 199, p);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(dataset.sharedMemSize_, GEAR_SIZE_THREE + 200);
    EXPECT_NE(dataset.sharedMem_, nullptr);
    EXPECT_NE(p, nullptr);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCleanChannel_succ_with_tdt)
{
    uint32_t deviceId = 1;
    const char *name = "Pooling";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillRepeatedly(Return((0)));

    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);
    handle->isTdtProcess = true;

    aclError ret = acltdtCleanChannel(handle);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCleanChannel_succ_without_tdt)
{
    uint32_t deviceId = 1;
    const char *name = "Pooling";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillRepeatedly(Return((0)));

    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);
    handle->isTdtProcess = false;

    aclError ret = acltdtCleanChannel(handle);
    EXPECT_EQ(ret, ACL_SUCCESS);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCleanChannel_failed_with_handle_nullptr)
{
    uint32_t deviceId = 1;
    const char *name = "Pooling";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillRepeatedly(Return((0)));

    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);
    handle->isTdtProcess = true;

    aclError ret = acltdtCleanChannel(nullptr);
    EXPECT_EQ(ret, ACL_ERROR_INVALID_PARAM);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCleanChannel_failed_with_rts_error)
{
    uint32_t deviceId = 1;
    const char *name = "Pooling";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillRepeatedly(Return((0)));

    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);
    handle->isTdtProcess = false;

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), rtMemQueueReset(_, _))
        .WillOnce(Return(ACL_ERROR_RT_PARAM_INVALID));

    aclError ret = acltdtCleanChannel(handle);
    EXPECT_EQ(ret, ACL_ERROR_RT_PARAM_INVALID);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

TEST_F(UTEST_tensor_data_transfer, acltdtCleanChannel_succ_receive)
{
    uint32_t deviceId = 1;
    const char *name = "TF_RECEIVE_Pooling";

    EXPECT_CALL(MockFunctionTest::aclStubInstance(), TdtHostInit(_))
        .WillRepeatedly(Return((0)));

    acltdtChannelHandle *handle = acltdtCreateChannel(deviceId, name);
    EXPECT_NE(handle, nullptr);
    handle->isTdtProcess = true;

    aclError ret = acltdtCleanChannel(handle);
    EXPECT_EQ(ret, ACL_ERROR_FEATURE_UNSUPPORTED);
    EXPECT_EQ(acltdtDestroyChannel(handle), ACL_SUCCESS);
}

