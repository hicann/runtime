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

#ifndef private
#define private public
#include "acl/acl.h"
#include "acl/acl_prof.h"
#include "acl/acl_tdt.h"
#include "acl/acl_tdt_queue.h"
#include "runtime/base.h"
#include "common/prof_reporter.h"
#undef private
#endif

class UTEST_ACL_compatibility_enum_check : public testing::Test
{
    public:
        UTEST_ACL_compatibility_enum_check() {}
    protected:
        virtual void SetUp() {}
        virtual void TearDown() {}
};

// 测试aclrtErrorType枚举值
TEST_F(UTEST_ACL_compatibility_enum_check, aclrtErrorType) {
    aclrtErrorType type;

    type = (aclrtErrorType)0;
    EXPECT_EQ(type, ACL_RT_NO_ERROR);

    type = (aclrtErrorType)1;
    EXPECT_EQ(type, ACL_RT_ERROR_MEMORY);

    type = (aclrtErrorType)2;
    EXPECT_EQ(type, ACL_RT_ERROR_L2);

    type = (aclrtErrorType)3;
    EXPECT_EQ(type, ACL_RT_ERROR_AICORE);

    type = (aclrtErrorType)4;
    EXPECT_EQ(type, ACL_RT_ERROR_LINK);

    type = (aclrtErrorType)0xFFFF;
    EXPECT_EQ(type, ACL_RT_ERROR_OTHERS);
}

// 测试aclrtAicoreErrorType枚举值
TEST_F(UTEST_ACL_compatibility_enum_check, aclrtAicoreErrorType) {
    aclrtAicoreErrorType type;

    type = (aclrtAicoreErrorType)0;
    EXPECT_EQ(type, ACL_RT_AICORE_ERROR_UNKNOWN);

    type = (aclrtAicoreErrorType)1;
    EXPECT_EQ(type, ACL_RT_AICORE_ERROR_SW);

    type = (aclrtAicoreErrorType)2;
    EXPECT_EQ(type, ACL_RT_AICORE_ERROR_HW_LOCAL);
}

TEST_F(UTEST_ACL_compatibility_enum_check, acltdtQueueAttrType)
{
    EXPECT_EQ(ACL_TDT_QUEUE_PERMISSION_MANAGE, 1);
    EXPECT_EQ(ACL_TDT_QUEUE_PERMISSION_DEQUEUE, 2);
    EXPECT_EQ(ACL_TDT_QUEUE_PERMISSION_ENQUEUE, 4);
    acltdtQueueAttrType type;
    type = (acltdtQueueAttrType)0;
    EXPECT_EQ(type, ACL_TDT_QUEUE_NAME_PTR);
    type = (acltdtQueueAttrType)1;
    EXPECT_EQ(type, ACL_TDT_QUEUE_DEPTH_UINT32);
}

TEST_F(UTEST_ACL_compatibility_enum_check, acltdtQueueRouteParamType)
{
    acltdtQueueRouteParamType type;
    type = (acltdtQueueRouteParamType)0;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_SRC_UINT32);
    type = (acltdtQueueRouteParamType)1;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_DST_UINT32);
    type = (acltdtQueueRouteParamType)2;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_STATUS_INT32);
}

TEST_F(UTEST_ACL_compatibility_enum_check, acltdtQueueRouteQueryMode)
{
    EXPECT_EQ(ACL_TDT_QUEUE_ROUTE_UNBIND, 0);
    EXPECT_EQ(ACL_TDT_QUEUE_ROUTE_BIND, 1);
    EXPECT_EQ(ACL_TDT_QUEUE_ROUTE_BIND_ABNORMAL, 2);
    acltdtQueueRouteQueryMode type;
    type = (acltdtQueueRouteQueryMode)0;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_SRC);
    type = (acltdtQueueRouteQueryMode)1;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_DST);
    type = (acltdtQueueRouteQueryMode)2;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST);
    type = (acltdtQueueRouteQueryMode)100;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_ABNORMAL);
}

TEST_F(UTEST_ACL_compatibility_enum_check, acltdtQueueRouteQueryInfoParamType)
{
    acltdtQueueRouteQueryInfoParamType type;
    type = (acltdtQueueRouteQueryInfoParamType)0;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM);
    type = (acltdtQueueRouteQueryInfoParamType)1;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32);
    type = (acltdtQueueRouteQueryInfoParamType)2;
    EXPECT_EQ(type, ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclDataType)
{
    aclDataType dataType;
    dataType = (aclDataType)-1;
    EXPECT_EQ(dataType, ACL_DT_UNDEFINED);

    dataType = (aclDataType)0;
    EXPECT_EQ(dataType, ACL_FLOAT);

    dataType = (aclDataType)1;
    EXPECT_EQ(dataType, ACL_FLOAT16);

    dataType = (aclDataType)2;
    EXPECT_EQ(dataType, ACL_INT8);

    dataType = (aclDataType)3;
    EXPECT_EQ(dataType, ACL_INT32);

    dataType = (aclDataType)4;
    EXPECT_EQ(dataType, ACL_UINT8);

    dataType = (aclDataType)6;
    EXPECT_EQ(dataType, ACL_INT16);

    dataType = (aclDataType)7;
    EXPECT_EQ(dataType, ACL_UINT16);

    dataType = (aclDataType)8;
    EXPECT_EQ(dataType, ACL_UINT32);

    dataType = (aclDataType)9;
    EXPECT_EQ(dataType, ACL_INT64);

    dataType = (aclDataType)10;
    EXPECT_EQ(dataType, ACL_UINT64);

    dataType = (aclDataType)11;
    EXPECT_EQ(dataType, ACL_DOUBLE);

    dataType = (aclDataType)12;
    EXPECT_EQ(dataType, ACL_BOOL);

    dataType = (aclDataType)13;
    EXPECT_EQ(dataType, ACL_STRING);

    dataType = (aclDataType)16;
    EXPECT_EQ(dataType, ACL_COMPLEX64);

    dataType = (aclDataType)17;
    EXPECT_EQ(dataType, ACL_COMPLEX128);

    dataType = (aclDataType)27;
    EXPECT_EQ(dataType, ACL_BF16);

    dataType = (aclDataType)29;
    EXPECT_EQ(dataType, ACL_INT4);

    dataType = (aclDataType)30;
    EXPECT_EQ(dataType, ACL_UINT1);

    dataType = (aclDataType)33;
    EXPECT_EQ(dataType, ACL_COMPLEX32);

    dataType = (aclDataType)34;
    EXPECT_EQ(dataType, ACL_HIFLOAT8);

    dataType = (aclDataType)35;
    EXPECT_EQ(dataType, ACL_FLOAT8_E5M2);

    dataType = (aclDataType)36;
    EXPECT_EQ(dataType, ACL_FLOAT8_E4M3FN);

    dataType = (aclDataType)37;
    EXPECT_EQ(dataType, ACL_FLOAT8_E8M0);

    dataType = (aclDataType)38;
    EXPECT_EQ(dataType, ACL_FLOAT6_E3M2);

    dataType = (aclDataType)39;
    EXPECT_EQ(dataType, ACL_FLOAT6_E2M3);

    dataType = (aclDataType)40;
    EXPECT_EQ(dataType, ACL_FLOAT4_E2M1);

    dataType = (aclDataType)41;
    EXPECT_EQ(dataType, ACL_FLOAT4_E1M2);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclFormat)
{
    aclFormat format;
    format = (aclFormat)-1;
    EXPECT_EQ(format, ACL_FORMAT_UNDEFINED);

    format = (aclFormat)0;
    EXPECT_EQ(format, ACL_FORMAT_NCHW);

    format = (aclFormat)1;
    EXPECT_EQ(format, ACL_FORMAT_NHWC);

    format = (aclFormat)2;
    EXPECT_EQ(format, ACL_FORMAT_ND);

    format = (aclFormat)3;
    EXPECT_EQ(format, ACL_FORMAT_NC1HWC0);

    format = (aclFormat)4;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_Z);

    format = (aclFormat)12;
    EXPECT_EQ(format, ACL_FORMAT_NC1HWC0_C04);

    format = (aclFormat)16;
    EXPECT_EQ(format, ACL_FORMAT_HWCN);

    format = (aclFormat)27;
    EXPECT_EQ(format, ACL_FORMAT_NDHWC);

    format = (aclFormat)29;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_NZ);

    format = (aclFormat)30;
    EXPECT_EQ(format, ACL_FORMAT_NCDHW);

    format = (aclFormat)32;
    EXPECT_EQ(format, ACL_FORMAT_NDC1HWC0);

    format = (aclFormat)33;
    EXPECT_EQ(format, ACL_FRACTAL_Z_3D);

    format = (aclFormat)35;
    EXPECT_EQ(format, ACL_FORMAT_NC);

    format = (aclFormat)47;
    EXPECT_EQ(format, ACL_FORMAT_NCL);

    format = (aclFormat)50;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_NZ_C0_16);

    format = (aclFormat)51;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_NZ_C0_32);

    format = (aclFormat)52;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_NZ_C0_2);

    format = (aclFormat)53;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_NZ_C0_4);

    format = (aclFormat)54;
    EXPECT_EQ(format, ACL_FORMAT_FRACTAL_NZ_C0_8);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclMemType)
{
    aclMemType memType;
    memType = (aclMemType)0;
    EXPECT_EQ(memType, ACL_MEMTYPE_DEVICE);

    memType = (aclMemType)1;
    EXPECT_EQ(memType, ACL_MEMTYPE_HOST);

    memType = (aclMemType)2;
    EXPECT_EQ(memType, ACL_MEMTYPE_HOST_COMPILE_INDEPENDENT);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclprofAicoreMetrics)
{
    aclprofAicoreMetrics aicoreMetrics;
    aicoreMetrics = (aclprofAicoreMetrics)0;
    EXPECT_EQ(aicoreMetrics, ACL_AICORE_ARITHMETIC_UTILIZATION);

    aicoreMetrics = (aclprofAicoreMetrics)1;
    EXPECT_EQ(aicoreMetrics, ACL_AICORE_PIPE_UTILIZATION);

    aicoreMetrics = (aclprofAicoreMetrics)2;
    EXPECT_EQ(aicoreMetrics, ACL_AICORE_MEMORY_BANDWIDTH);

    aicoreMetrics = (aclprofAicoreMetrics)3;
    EXPECT_EQ(aicoreMetrics, ACL_AICORE_L0B_AND_WIDTH);

    aicoreMetrics = (aclprofAicoreMetrics)4;
    EXPECT_EQ(aicoreMetrics, ACL_AICORE_RESOURCE_CONFLICT_RATIO);

    aicoreMetrics = (aclprofAicoreMetrics)0xFF;
    EXPECT_EQ(aicoreMetrics, ACL_AICORE_NONE);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtRunMode)
{
    aclrtRunMode runMode;
    runMode = (aclrtRunMode)0;
    EXPECT_EQ(runMode, ACL_DEVICE);

    runMode = (aclrtRunMode)1;
    EXPECT_EQ(runMode, ACL_HOST);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtTsId)
{
    aclrtTsId tsId;
    tsId = (aclrtTsId)0;
    EXPECT_EQ(tsId, ACL_TS_ID_AICORE);

    tsId = (aclrtTsId)1;
    EXPECT_EQ(tsId, ACL_TS_ID_AIVECTOR);

    tsId = (aclrtTsId)2;
    EXPECT_EQ(tsId, ACL_TS_ID_RESERVED);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtEventStatus)
{
    aclrtEventStatus eventStatus;
    eventStatus = (aclrtEventStatus)0;
    EXPECT_EQ(eventStatus, ACL_EVENT_STATUS_COMPLETE);

    eventStatus = (aclrtEventStatus)1;
    EXPECT_EQ(eventStatus, ACL_EVENT_STATUS_NOT_READY);

    eventStatus = (aclrtEventStatus)2;
    EXPECT_EQ(eventStatus, ACL_EVENT_STATUS_RESERVED);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtEventRecordedStatus)
{
    aclrtEventRecordedStatus eventStatus;
    eventStatus = (aclrtEventRecordedStatus)0;
    EXPECT_EQ(eventStatus, ACL_EVENT_RECORDED_STATUS_NOT_READY);

    eventStatus = (aclrtEventRecordedStatus)1;
    EXPECT_EQ(eventStatus, ACL_EVENT_RECORDED_STATUS_COMPLETE);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtEventWaitStatus)
{
    aclrtEventStatus eventStatus;
    eventStatus = (aclrtEventStatus)0;
    EXPECT_EQ(eventStatus, ACL_EVENT_WAIT_STATUS_COMPLETE);

    eventStatus = (aclrtEventStatus)1;
    EXPECT_EQ(eventStatus, ACL_EVENT_WAIT_STATUS_NOT_READY);

    eventStatus = (aclrtEventStatus)0xffff;
    EXPECT_EQ(eventStatus, ACL_EVENT_WAIT_STATUS_RESERVED);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtStreamStatus)
{
    aclrtStreamStatus status;
    status = (aclrtStreamStatus)0;
    EXPECT_EQ(status, ACL_STREAM_STATUS_COMPLETE);

    status = (aclrtStreamStatus)1;
    EXPECT_EQ(status, ACL_STREAM_STATUS_NOT_READY);

    status = (aclrtStreamStatus)0xFFFF;
    EXPECT_EQ(status, ACL_STREAM_STATUS_RESERVED);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtCallbackBlockType)
{
    aclrtCallbackBlockType blockType;
    blockType = (aclrtCallbackBlockType)0;
    EXPECT_EQ(blockType, ACL_CALLBACK_NO_BLOCK);

    blockType = (aclrtCallbackBlockType)1;
    EXPECT_EQ(blockType, ACL_CALLBACK_BLOCK);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemcpyKind)
{
    aclrtMemcpyKind memoryKind;
    memoryKind = (aclrtMemcpyKind)0;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_HOST_TO_HOST);

    memoryKind = (aclrtMemcpyKind)1;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_HOST_TO_DEVICE);

    memoryKind = (aclrtMemcpyKind)2;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_DEVICE_TO_HOST);

    memoryKind = (aclrtMemcpyKind)3;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_DEVICE_TO_DEVICE);

    memoryKind = (aclrtMemcpyKind)4;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_DEFAULT);

    memoryKind = (aclrtMemcpyKind)5;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE);

    memoryKind = (aclrtMemcpyKind)6;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_INNER_DEVICE_TO_DEVICE);

    memoryKind = (aclrtMemcpyKind)7;
    EXPECT_EQ(memoryKind, ACL_MEMCPY_INTER_DEVICE_TO_DEVICE);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclSysParamOpt)
{
    aclSysParamOpt sysParamOpt;
    sysParamOpt = (aclSysParamOpt)0;
    EXPECT_EQ(sysParamOpt, ACL_OPT_DETERMINISTIC);

    sysParamOpt = (aclSysParamOpt)1;
    EXPECT_EQ(sysParamOpt, ACL_OPT_ENABLE_DEBUG_KERNEL);

    sysParamOpt = (aclSysParamOpt)2;
    EXPECT_EQ(sysParamOpt, ACL_OPT_STRONG_CONSISTENCY);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemMallocPolicy)
{
    aclrtMemMallocPolicy policy;
    policy = (aclrtMemMallocPolicy)0;
    EXPECT_EQ(policy, ACL_MEM_MALLOC_HUGE_FIRST);

    policy = (aclrtMemMallocPolicy)1;
    EXPECT_EQ(policy, ACL_MEM_MALLOC_HUGE_ONLY);

    policy = (aclrtMemMallocPolicy)2;
    EXPECT_EQ(policy, ACL_MEM_MALLOC_NORMAL_ONLY);

    policy = (aclrtMemMallocPolicy)3;
    EXPECT_EQ(policy, ACL_MEM_MALLOC_HUGE_FIRST_P2P);

    policy = (aclrtMemMallocPolicy)4;
    EXPECT_EQ(policy, ACL_MEM_MALLOC_HUGE_ONLY_P2P);

    policy = (aclrtMemMallocPolicy)5;
    EXPECT_EQ(policy, ACL_MEM_MALLOC_NORMAL_ONLY_P2P);

    policy = (aclrtMemMallocPolicy)0x0100;
    EXPECT_EQ(policy, ACL_MEM_TYPE_LOW_BAND_WIDTH);

    policy = (aclrtMemMallocPolicy)0x1000;
    EXPECT_EQ(policy, ACL_MEM_TYPE_HIGH_BAND_WIDTH);

    policy = (aclrtMemMallocPolicy)0x100000U;
    EXPECT_EQ(policy, ACL_MEM_ACCESS_USER_SPACE_READONLY);

    EXPECT_EQ(sizeof(aclrtMemMallocPolicy), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemAttr)
{
    aclrtMemAttr memAttr;
    memAttr = (aclrtMemAttr)0;
    EXPECT_EQ(memAttr, ACL_DDR_MEM);

    memAttr = (aclrtMemAttr)1;
    EXPECT_EQ(memAttr, ACL_HBM_MEM);

    memAttr = (aclrtMemAttr)2;
    EXPECT_EQ(memAttr, ACL_DDR_MEM_HUGE);

    memAttr = (aclrtMemAttr)3;
    EXPECT_EQ(memAttr, ACL_DDR_MEM_NORMAL);

    memAttr = (aclrtMemAttr)4;
    EXPECT_EQ(memAttr, ACL_HBM_MEM_HUGE);

    memAttr = (aclrtMemAttr)5;
    EXPECT_EQ(memAttr, ACL_HBM_MEM_NORMAL);

    memAttr = (aclrtMemAttr)6;
    EXPECT_EQ(memAttr, ACL_DDR_MEM_P2P_HUGE);

    memAttr = (aclrtMemAttr)7;
    EXPECT_EQ(memAttr, ACL_DDR_MEM_P2P_NORMAL);

    memAttr = (aclrtMemAttr)8;
    EXPECT_EQ(memAttr, ACL_HBM_MEM_P2P_HUGE);

    memAttr = (aclrtMemAttr)9;
    EXPECT_EQ(memAttr, ACL_HBM_MEM_P2P_NORMAL);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtIpcMemAttrType)
{
    aclrtIpcMemAttrType ipcMemAttrType;
    ipcMemAttrType = (aclrtIpcMemAttrType)0;
    EXPECT_EQ(ipcMemAttrType, ACL_RT_IPC_MEM_ATTR_ACCESS_LINK);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtGroupAttr)
{
    aclrtGroupAttr groupAttr;
    groupAttr = (aclrtGroupAttr)0;
    EXPECT_EQ(groupAttr, ACL_GROUP_AICORE_INT);

    groupAttr = (aclrtGroupAttr)1;
    EXPECT_EQ(groupAttr, ACL_GROUP_AIV_INT);

    groupAttr = (aclrtGroupAttr)2;
    EXPECT_EQ(groupAttr, ACL_GROUP_AIC_INT);

    groupAttr = (aclrtGroupAttr)3;
    EXPECT_EQ(groupAttr, ACL_GROUP_SDMANUM_INT);

    groupAttr = (aclrtGroupAttr)4;
    EXPECT_EQ(groupAttr, ACL_GROUP_ASQNUM_INT);

    groupAttr = (aclrtGroupAttr)5;
    EXPECT_EQ(groupAttr, ACL_GROUP_GROUPID_INT);
}

TEST_F(UTEST_ACL_compatibility_enum_check, acltdtTensorType)
{
    acltdtTensorType tensorType;
    tensorType = (acltdtTensorType)-1;
    EXPECT_EQ(tensorType, ACL_TENSOR_DATA_UNDEFINED);

    tensorType = (acltdtTensorType)0;
    EXPECT_EQ(tensorType, ACL_TENSOR_DATA_TENSOR);

    tensorType = (acltdtTensorType)1;
    EXPECT_EQ(tensorType, ACL_TENSOR_DATA_END_OF_SEQUENCE);

    tensorType = (acltdtTensorType)2;
    EXPECT_EQ(tensorType, ACL_TENSOR_DATA_ABNORMAL);

    tensorType = (acltdtTensorType)3;
    EXPECT_EQ(tensorType, ACL_TENSOR_DATA_SLICE_TENSOR);

    tensorType = (acltdtTensorType)4;
    EXPECT_EQ(tensorType, ACL_TENSOR_DATA_END_TENSOR);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtFloatOverflowMode)
{
    aclrtFloatOverflowMode mode;
    mode = (aclrtFloatOverflowMode)0;
    EXPECT_EQ(mode, ACL_RT_OVERFLOW_MODE_SATURATION);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_SATURATION);
    mode = (aclrtFloatOverflowMode)1;
    EXPECT_EQ(mode, ACL_RT_OVERFLOW_MODE_INFNAN);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_INFNAN);
    mode = (aclrtFloatOverflowMode)2;
    EXPECT_EQ(mode, ACL_RT_OVERFLOW_MODE_UNDEF);
    EXPECT_EQ(mode, RT_OVERFLOW_MODE_UNDEF);
}


TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemLocationType)
{
    aclrtMemLocationType memLocationType;
    memLocationType = (aclrtMemLocationType)0;
    EXPECT_EQ(memLocationType, ACL_MEM_LOCATION_TYPE_HOST);

    memLocationType = (aclrtMemLocationType)1;
    EXPECT_EQ(memLocationType, ACL_MEM_LOCATION_TYPE_DEVICE);

    memLocationType = (aclrtMemLocationType)2;
    EXPECT_EQ(memLocationType, ACL_MEM_LOCATION_TYPE_UNREGISTERED);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemAllocationType)
{
    aclrtMemAllocationType memAllocationType;
    memAllocationType = (aclrtMemAllocationType)0;
    EXPECT_EQ(memAllocationType, ACL_MEM_ALLOCATION_TYPE_PINNED);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemHandleType)
{
    aclrtMemHandleType memHandleType;
    memHandleType = (aclrtMemHandleType)0;
    EXPECT_EQ(memHandleType, ACL_MEM_HANDLE_TYPE_NONE);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemSharedHandleType)
{
    aclrtMemSharedHandleType memSharedHandleType;
    memSharedHandleType = (aclrtMemSharedHandleType)1;
    EXPECT_EQ(memSharedHandleType, ACL_MEM_SHARE_HANDLE_TYPE_DEFAULT);

    memSharedHandleType = (aclrtMemSharedHandleType)2;
    EXPECT_EQ(memSharedHandleType, ACL_MEM_SHARE_HANDLE_TYPE_FABRIC);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtDeviceStatus)
{
    aclrtDeviceStatus status;
    status = (aclrtDeviceStatus)0;
    EXPECT_EQ(status, ACL_RT_DEVICE_STATUS_NORMAL);

    status = (aclrtDeviceStatus)1;
    EXPECT_EQ(status, ACL_RT_DEVICE_STATUS_ABNORMAL);

    status = (aclrtDeviceStatus)0xFFFF;
    EXPECT_EQ(status, ACL_RT_DEVICE_STATUS_END);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemGranularityOptions)
{
    aclrtMemGranularityOptions status;
    status = (aclrtMemGranularityOptions)0;
    EXPECT_EQ(status, ACL_RT_MEM_ALLOC_GRANULARITY_MINIMUM);

    status = (aclrtMemGranularityOptions)1;
    EXPECT_EQ(status, ACL_RT_MEM_ALLOC_GRANULARITY_RECOMMENDED);

    status = (aclrtMemGranularityOptions)0xFFFF;
    EXPECT_EQ(status, ACL_RT_MEM_ALLOC_GRANULARITY_UNDEF);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclCannAttr)
{
    aclCannAttr attr;
    attr = (aclCannAttr)-1;
    EXPECT_EQ(attr, ACL_CANN_ATTR_UNDEFINED);

    attr = (aclCannAttr)0;
    EXPECT_EQ(attr, ACL_CANN_ATTR_INF_NAN);

    attr = (aclCannAttr)1;
    EXPECT_EQ(attr, ACL_CANN_ATTR_BF16);

    attr = (aclCannAttr)2;
    EXPECT_EQ(attr, ACL_CANN_ATTR_JIT_COMPILE);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclInfoType)
{
    aclDeviceInfo infoType;
    infoType = (aclDeviceInfo)-1;
    EXPECT_EQ(infoType, ACL_DEVICE_INFO_UNDEFINED);

    infoType = (aclDeviceInfo)0;
    EXPECT_EQ(infoType, ACL_DEVICE_INFO_AI_CORE_NUM);

    infoType = (aclDeviceInfo)1;
    EXPECT_EQ(infoType, ACL_DEVICE_INFO_VECTOR_CORE_NUM);

    infoType = (aclDeviceInfo)2;
    EXPECT_EQ(infoType, ACL_DEVICE_INFO_L2_SIZE);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclCmoType)
{
    aclrtCmoType cmoType;
    cmoType = (aclrtCmoType)0;
    EXPECT_EQ(cmoType, ACL_RT_CMO_TYPE_PREFETCH);

    cmoType = (aclrtCmoType)1;
    EXPECT_EQ(cmoType, ACL_RT_CMO_TYPE_WRITEBACK);

    cmoType = (aclrtCmoType)2;
    EXPECT_EQ(cmoType, ACL_RT_CMO_TYPE_INVALID);

    cmoType = (aclrtCmoType)3;
    EXPECT_EQ(cmoType, ACL_RT_CMO_TYPE_FLUSH);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtLastErrLevel)
{
  aclrtLastErrLevel level;
  level = (aclrtLastErrLevel)0;
  EXPECT_EQ(level, ACL_RT_THREAD_LEVEL);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtBinaryLoadOptionType)
{
    aclrtBinaryLoadOptionType type;
    type = (aclrtBinaryLoadOptionType)1;
    EXPECT_EQ(type, ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD);

    type = (aclrtBinaryLoadOptionType)2;
    EXPECT_EQ(type, ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC);
    EXPECT_EQ(type, ACL_RT_BINARY_LOAD_OPT_MAGIC);

    type = (aclrtBinaryLoadOptionType)3;
    EXPECT_EQ(type, ACL_RT_BINARY_LOAD_OPT_CPU_KERNEL_MODE);

    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionType), sizeof(int32_t));
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtLaunchKernelAttrId)
{
    aclrtLaunchKernelAttrId id;
    id = (aclrtLaunchKernelAttrId)1;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE);

    id = (aclrtLaunchKernelAttrId)3;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE);

    id = (aclrtLaunchKernelAttrId)4;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET);

    id = (aclrtLaunchKernelAttrId)5;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH);

    id = (aclrtLaunchKernelAttrId)6;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_DATA_DUMP);

    id = (aclrtLaunchKernelAttrId)7;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT);

    id = (aclrtLaunchKernelAttrId)8;
    EXPECT_EQ(id, ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US);
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrId), sizeof(int32_t));
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtBinaryLoadOptionValue)
{
    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionValue::isLazyLoad), sizeof(uint32_t));
    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionValue::magic), sizeof(uint32_t));
    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionValue::cpuKernelMode), sizeof(int32_t));
    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionValue::rsv), sizeof(uint32_t) * 4U);

    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionValue), sizeof(uint32_t) * 4U);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtLaunchKernelAttrValue)
{
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::schemMode), sizeof(uint8_t));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::localMemorySize), sizeof(uint32_t));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::engineType), sizeof(aclrtEngineType));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::blockDimOffset), sizeof(uint32_t));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::isBlockTaskPrefetch), sizeof(uint8_t));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::isDataDump), sizeof(uint8_t));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::timeout), sizeof(uint16_t));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue::rsv), sizeof(uint32_t) * 4U);

    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue), sizeof(uint32_t) * 4U);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtHostRegisterType)
{
  aclrtHostRegisterType value;
  value = (aclrtHostRegisterType)0;
  EXPECT_EQ(value, ACL_HOST_REGISTER_MAPPED);

  EXPECT_EQ(sizeof(aclrtHostRegisterType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMallocAttrType)
{
  aclrtMallocAttrType value;
  value = (aclrtMallocAttrType)0;
  EXPECT_EQ(value, ACL_RT_MEM_ATTR_RSV);

  value = (aclrtMallocAttrType)1;
  EXPECT_EQ(value, ACL_RT_MEM_ATTR_MODULE_ID);

  value = (aclrtMallocAttrType)2;
  EXPECT_EQ(value, ACL_RT_MEM_ATTR_DEVICE_ID);

  EXPECT_EQ(sizeof(aclrtMallocAttrType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtStreamAttr)
{
  aclrtStreamAttr value;
  value = (aclrtStreamAttr)1;
  EXPECT_EQ(value, ACL_STREAM_ATTR_FAILURE_MODE);

  value = (aclrtStreamAttr)2;
  EXPECT_EQ(value, ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK);

  value = (aclrtStreamAttr)3;
  EXPECT_EQ(value, ACL_STREAM_ATTR_USER_CUSTOM_TAG);

  value = (aclrtStreamAttr)4;
  EXPECT_EQ(value, ACL_STREAM_ATTR_CACHE_OP_INFO);

  EXPECT_EQ(sizeof(aclrtStreamAttr), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtDevAttr)
{
  aclrtDevAttr value;
  value = (aclrtDevAttr)1U;
  EXPECT_EQ(value, ACL_DEV_ATTR_AICPU_CORE_NUM);

  value = (aclrtDevAttr)101U;
  EXPECT_EQ(value, ACL_DEV_ATTR_AICORE_CORE_NUM);

  value = (aclrtDevAttr)102U;
  EXPECT_EQ(value, ACL_DEV_ATTR_CUBE_CORE_NUM);

  value = (aclrtDevAttr)201U;
  EXPECT_EQ(value, ACL_DEV_ATTR_VECTOR_CORE_NUM);

  value = (aclrtDevAttr)202U;
  EXPECT_EQ(value, ACL_DEV_ATTR_WARP_SIZE);

  value = (aclrtDevAttr)203U;
  EXPECT_EQ(value, ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE);

  value = (aclrtDevAttr)204U;
  EXPECT_EQ(value, ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE);

  value = (aclrtDevAttr)301U;
  EXPECT_EQ(value, ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE);

  value = (aclrtDevAttr)302U;
  EXPECT_EQ(value, ACL_DEV_ATTR_L2_CACHE_SIZE);

  value = (aclrtDevAttr)401U;
  EXPECT_EQ(value, ACL_DEV_ATTR_SMP_ID);

  value = (aclrtDevAttr)402U;
  EXPECT_EQ(value, ACL_DEV_ATTR_PHY_CHIP_ID);

  value = (aclrtDevAttr)403U;
  EXPECT_EQ(value, ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID);

  value = (aclrtDevAttr)404U;
  EXPECT_EQ(value, ACL_DEV_ATTR_SUPER_POD_SERVER_ID);

  value = (aclrtDevAttr)405U;
  EXPECT_EQ(value, ACL_DEV_ATTR_SUPER_POD_ID);

  value = (aclrtDevAttr)406U;
  EXPECT_EQ(value, ACL_DEV_ATTR_CUST_OP_PRIVILEGE);

  value = (aclrtDevAttr)407U;
  EXPECT_EQ(value, ACL_DEV_ATTR_MAINBOARD_ID);

  value = (aclrtDevAttr)501U;
  EXPECT_EQ(value, ACL_DEV_ATTR_IS_VIRTUAL);

  EXPECT_EQ(sizeof(aclrtDevAttr), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtDevFeatureType)
{
  aclrtDevFeatureType value;
  value = (aclrtDevFeatureType)1U;
  EXPECT_EQ(value, ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV);

  value = (aclrtDevFeatureType)21U;
  EXPECT_EQ(value, ACL_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV);

  EXPECT_EQ(sizeof(aclrtDevFeatureType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtReduceKind)
{
  aclrtReduceKind value;
  value = (aclrtReduceKind)10U;
  EXPECT_EQ(value, ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM);

  value = (aclrtReduceKind)11U;
  EXPECT_EQ(value, ACL_RT_MEMCPY_SDMA_AUTOMATIC_MAX);

  value = (aclrtReduceKind)12U;
  EXPECT_EQ(value, ACL_RT_MEMCPY_SDMA_AUTOMATIC_MIN);

  value = (aclrtReduceKind)13U;
  EXPECT_EQ(value, ACL_RT_MEMCPY_SDMA_AUTOMATIC_EQUAL);

  EXPECT_EQ(sizeof(aclrtReduceKind), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtDevResLimitType)
{
  aclrtDevResLimitType value;
  value = (aclrtDevResLimitType)0U;
  EXPECT_EQ(value, ACL_RT_DEV_RES_CUBE_CORE);

  value = (aclrtDevResLimitType)1U;
  EXPECT_EQ(value, ACL_RT_DEV_RES_VECTOR_CORE);

  EXPECT_EQ(sizeof(aclrtDevResLimitType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtCondition)
{
  aclrtCondition value;
  value = (aclrtCondition)0U;
  EXPECT_EQ(value, ACL_RT_EQUAL);

  value = (aclrtCondition)1U;
  EXPECT_EQ(value, ACL_RT_NOT_EQUAL);

  value = (aclrtCondition)2U;
  EXPECT_EQ(value, ACL_RT_GREATER);

  value = (aclrtCondition)3U;
  EXPECT_EQ(value, ACL_RT_GREATER_OR_EQUAL);

  value = (aclrtCondition)4U;
  EXPECT_EQ(value, ACL_RT_LESS);

  value = (aclrtCondition)5U;
  EXPECT_EQ(value, ACL_RT_LESS_OR_EQUAL);

  EXPECT_EQ(sizeof(aclrtCondition), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtCompareDataType)
{
  aclrtCompareDataType value;
  value = (aclrtCompareDataType)0U;
  EXPECT_EQ(value, ACL_RT_SWITCH_INT32);

  value = (aclrtCompareDataType)1U;
  EXPECT_EQ(value, ACL_RT_SWITCH_INT64);

  EXPECT_EQ(sizeof(aclrtCompareDataType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtEngineType)
{
  aclrtEngineType value;
  value = (aclrtEngineType)0U;
  EXPECT_EQ(value, ACL_RT_ENGINE_TYPE_AIC);

  value = (aclrtEngineType)1U;
  EXPECT_EQ(value, ACL_RT_ENGINE_TYPE_AIV);

  EXPECT_EQ(sizeof(aclrtEngineType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, AclProfType)
{
  acl::AclProfType value;
  value = (acl::AclProfType)0x300DCU;
  EXPECT_EQ(value, acl::AclrtMemExportToShareableHandleV2);

  value = (acl::AclProfType)0x300DDU;
  EXPECT_EQ(value, acl::AclrtMemImportFromShareableHandleV2);

  value = (acl::AclProfType)0x300DEU;
  EXPECT_EQ(value, acl::AclrtMemSetPidToShareableHandleV2);

  EXPECT_EQ(sizeof(acl::AclProfType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtCntNotifyRecordMode)
{
  aclrtCntNotifyRecordMode value;
  value = (aclrtCntNotifyRecordMode)0U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_RECORD_SET_VALUE_MODE);

  value = (aclrtCntNotifyRecordMode)1U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_RECORD_ADD_MODE);

  value = (aclrtCntNotifyRecordMode)2U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_RECORD_BIT_OR_MODE);

  value = (aclrtCntNotifyRecordMode)4U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_RECORD_BIT_AND_MODE);

  EXPECT_EQ(sizeof(aclrtCntNotifyRecordMode), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtCntNotifyWaitMode)
{
  aclrtCntNotifyWaitMode value;
  value = (aclrtCntNotifyWaitMode)0U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_WAIT_LESS_MODE);

  value = (aclrtCntNotifyWaitMode)1U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_WAIT_EQUAL_MODE);

  value = (aclrtCntNotifyWaitMode)2U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_WAIT_BIGGER_MODE);

  value = (aclrtCntNotifyWaitMode)3U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_WAIT_BIGGER_OR_EQUAL_MODE);

  value = (aclrtCntNotifyWaitMode)4U;
  EXPECT_EQ(value, ACL_RT_CNT_NOTIFY_WAIT_EQUAL_WITH_BITMASK_MODE);

  EXPECT_EQ(sizeof(aclrtCntNotifyWaitMode), 4);

}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtMemAccessFlags)
{
    aclrtMemAccessFlags value;
    value = (aclrtMemAccessFlags)0;
    EXPECT_EQ(value, ACL_RT_MEM_ACCESS_FLAGS_NONE);

    value = (aclrtMemAccessFlags)1;
    EXPECT_EQ(value, ACL_RT_MEM_ACCESS_FLAGS_READ);

    value = (aclrtMemAccessFlags)3;
    EXPECT_EQ(value, ACL_RT_MEM_ACCESS_FLAGS_READWRITE);

    EXPECT_EQ(sizeof(aclrtMemAccessFlags), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtProcessState)
{
  aclrtProcessState value;
  value = (aclrtProcessState)0U;
  EXPECT_EQ(value, ACL_RT_PROCESS_STATE_RUNNING);

  value = (aclrtProcessState)1U;
  EXPECT_EQ(value, ACL_RT_PROCESS_STATE_LOCKED);

  EXPECT_EQ(sizeof(aclrtProcessState), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtKernelType)
{
  aclrtKernelType value;
  value = (aclrtKernelType)0U;
  EXPECT_EQ(value, ACL_KERNEL_TYPE_AICORE);

  value = (aclrtKernelType)1U;
  EXPECT_EQ(value, ACL_KERNEL_TYPE_CUBE);

  value = (aclrtKernelType)2U;
  EXPECT_EQ(value, ACL_KERNEL_TYPE_VECTOR);

  value = (aclrtKernelType)3U;
  EXPECT_EQ(value, ACL_KERNEL_TYPE_MIX);

  value = (aclrtKernelType)100U;
  EXPECT_EQ(value, ACL_KERNEL_TYPE_AICPU);

  EXPECT_EQ(sizeof(aclrtKernelType), 4);
}

TEST_F(UTEST_ACL_compatibility_enum_check, aclrtFuncAttribute)
{
  aclrtFuncAttribute value;
  value = (aclrtFuncAttribute)1U;
  EXPECT_EQ(value, ACL_FUNC_ATTR_KERNEL_TYPE);

  EXPECT_EQ(sizeof(aclrtFuncAttribute), 4);
}