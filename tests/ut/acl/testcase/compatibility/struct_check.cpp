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
#include "acl/acl_rt.h"
#include "common/log_inner.h"
#include "aclrt_impl/data_buffer_internal.h"
#undef private
#endif

class UTEST_ACL_compatibility_struct_check : public testing::Test
{
    public:
        UTEST_ACL_compatibility_struct_check() {}
    protected:
        virtual void SetUp() {}
        virtual void TearDown() {}
};

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtUtilizationInfo)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtUtilizationInfo, cubeUtilization);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtUtilizationInfo, vectorUtilization);
    EXPECT_EQ(offset, 4);

    offset = OFFSET_OF_MEMBER(aclrtUtilizationInfo, aicpuUtilization);
    EXPECT_EQ(offset, 8);

    offset = OFFSET_OF_MEMBER(aclrtUtilizationInfo, memoryUtilization);
    EXPECT_EQ(offset, 12);

    EXPECT_EQ(sizeof(aclrtUtilizationInfo), 4*4 + sizeof (aclrtUtilizationExtendInfo *));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtBinaryLoadOption)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtBinaryLoadOption, type);
    EXPECT_EQ(offset, 0U);

    offset = OFFSET_OF_MEMBER(aclrtBinaryLoadOption, value);
    EXPECT_EQ(offset, 4U);

    EXPECT_EQ(sizeof(aclrtBinaryLoadOption), sizeof(aclrtBinaryLoadOptionType) + sizeof(aclrtBinaryLoadOptionValue));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtBinaryLoadOptions)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtBinaryLoadOptions, options);
    EXPECT_EQ(offset, 0U);

    offset = OFFSET_OF_MEMBER(aclrtBinaryLoadOptions, numOpt);
    EXPECT_EQ(offset, sizeof(aclrtBinaryLoadOption*));

    EXPECT_EQ(sizeof(aclrtBinaryLoadOptions), sizeof(aclrtBinaryLoadOption*) * 2);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtLaunchKernelAttr)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtLaunchKernelAttr, id);
    EXPECT_EQ(offset, 0U);

    offset = OFFSET_OF_MEMBER(aclrtLaunchKernelAttr, value);
    EXPECT_EQ(offset, sizeof(aclrtLaunchKernelAttrId));

    EXPECT_EQ(sizeof(aclrtLaunchKernelAttr), sizeof(aclrtLaunchKernelAttrId) + sizeof(aclrtLaunchKernelAttrValue));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrId), 4U); // 4 bytes
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue), 16U); // 16 bytes
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttr), 20U); // 20 bytes
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtLaunchKernelCfg)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtLaunchKernelCfg, attrs);
    EXPECT_EQ(offset, 0U);

    offset = OFFSET_OF_MEMBER(aclrtLaunchKernelCfg, numAttrs);
    EXPECT_EQ(offset, sizeof(aclrtLaunchKernelAttr*));

    EXPECT_EQ(sizeof(aclrtLaunchKernelCfg), sizeof(aclrtLaunchKernelAttr*) * 2U);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMallocAttrValue)
{
    EXPECT_EQ(sizeof(aclrtMallocAttrValue), 8);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMallocAttribute)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtMallocAttribute, attr);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtMallocAttribute, value);
    EXPECT_EQ(offset, sizeof(aclrtMallocAttrType));

    EXPECT_EQ(sizeof(aclrtMallocAttribute), sizeof(aclrtMallocAttrType) + sizeof(aclrtMallocAttrValue));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtUuid)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtUuid, bytes);
    EXPECT_EQ(offset, 0);

    EXPECT_EQ(sizeof(aclrtUuid), sizeof(char) * 16);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMallocConfig)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtMallocConfig, attrs);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtMallocConfig, numAttrs);
    EXPECT_EQ(offset, sizeof(aclrtMallocAttribute *));

    EXPECT_EQ(sizeof(aclrtMallocConfig), sizeof(aclrtMallocAttribute *) + sizeof(size_t));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtServerPid)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtServerPid, sdid);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtServerPid, pid);
    EXPECT_EQ(offset, sizeof(int32_t *));

    offset = OFFSET_OF_MEMBER(aclrtServerPid, num);
    EXPECT_EQ(offset, sizeof(int32_t *) + sizeof(int32_t *));

    EXPECT_EQ(sizeof(aclrtServerPid), sizeof(int32_t *) + sizeof(int32_t *) + sizeof(size_t));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMemLocation)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtMemLocation, id);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtMemLocation, type);
    EXPECT_EQ(offset, sizeof(uint32_t));

    EXPECT_EQ(sizeof(aclrtMemLocation), sizeof(uint32_t) + sizeof(aclrtMemLocationType));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMemFabricHandle)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtMemFabricHandle, data);
    EXPECT_EQ(offset, 0);

    EXPECT_EQ(sizeof(aclrtMemFabricHandle), sizeof(uint8_t) * 128);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtPtrAttributes)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtPtrAttributes, location);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtPtrAttributes, pageSize);
    EXPECT_EQ(offset, sizeof(aclrtMemLocation));

    offset = OFFSET_OF_MEMBER(aclrtPtrAttributes, rsv);
    EXPECT_EQ(offset, sizeof(aclrtMemLocation) + sizeof(uint32_t));

    EXPECT_EQ(sizeof(aclrtPtrAttributes), sizeof(aclrtMemLocation) + sizeof(uint32_t) + sizeof(uint32_t) * 4);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtStreamAttrValue)
{
    EXPECT_EQ(sizeof(aclrtStreamAttrValue), 16);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtBarrierCmoInfo)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtBarrierCmoInfo, cmoType);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtBarrierCmoInfo, barrierId);
    EXPECT_EQ(offset,
        sizeof(aclrtCmoType)   // cmoType
    );

    EXPECT_EQ(sizeof(aclrtBarrierCmoInfo),
        sizeof(aclrtCmoType) + // cmoType
        sizeof(uint32_t)       // barrierId
    );
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtBarrierTaskInfo)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtBarrierTaskInfo, barrierNum);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtBarrierTaskInfo, cmoInfo);
    EXPECT_EQ(offset,
        sizeof(size_t)    // barrierNum
    );

    EXPECT_EQ(sizeof(aclrtBarrierTaskInfo),
        sizeof(size_t) +                                           // barrierNum
        sizeof(aclrtBarrierCmoInfo) * ACL_RT_CMO_MAX_BARRIER_NUM   // cmoInfo
    );
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMemcpyBatchAttr)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtMemcpyBatchAttr, dstLoc);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtMemcpyBatchAttr, srcLoc);
    EXPECT_EQ(offset, sizeof(aclrtMemLocation));

    offset = OFFSET_OF_MEMBER(aclrtMemcpyBatchAttr, rsv);
    EXPECT_EQ(offset, sizeof(aclrtMemLocation) + sizeof(aclrtMemLocation));

    EXPECT_EQ(sizeof(aclrtMemcpyBatchAttr), sizeof(aclrtMemLocation) + sizeof(aclrtMemLocation) + sizeof(uint8_t) * 16);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtPlaceHolderInfo)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtPlaceHolderInfo, addrOffset);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtPlaceHolderInfo, dataOffset);
    EXPECT_EQ(offset, sizeof(uint32_t));

    EXPECT_EQ(sizeof(aclrtPlaceHolderInfo), sizeof(uint32_t) + sizeof(uint32_t));
}

// The aclDataBuffer is simultaneously used by multiple modules, and each module
// defines the same data structure. If you modify the members of aclDataBuffer,
// please ensure that the changes have been synchronized in other components as well.
TEST_F(UTEST_ACL_compatibility_struct_check, aclDataBuffer)
{
    EXPECT_EQ(sizeof(aclDataBuffer), sizeof(void *) + sizeof(uint64_t));

    size_t offset;
    offset = OFFSET_OF_MEMBER(aclDataBuffer, data);
    EXPECT_EQ(offset, 0);
    offset = OFFSET_OF_MEMBER(aclDataBuffer, length);
    EXPECT_EQ(offset, sizeof(void *));

    aclDataBuffer dataBuffer{nullptr, 0};
    EXPECT_EQ(sizeof(dataBuffer.data), sizeof(void *));
    EXPECT_EQ(sizeof(dataBuffer.length), sizeof(uint64_t));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtRandomParaInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, isAddr);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, valueOrAddr);
  EXPECT_EQ(offset, sizeof(uint8_t));

  offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, size);
  EXPECT_EQ(offset, sizeof(uint8_t) * 9);

  offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, rsv);
  EXPECT_EQ(offset, sizeof(uint8_t) * 10);

  // check total size
  EXPECT_EQ(sizeof(aclrtRandomParaInfo), sizeof(uint8_t) * 16);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtDropoutBitmaskInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtDropoutBitmaskInfo, dropoutRation);
  EXPECT_EQ(offset, 0);

  // check total size
  EXPECT_EQ(sizeof(aclrtDropoutBitmaskInfo), sizeof(aclrtRandomParaInfo));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtUniformDisInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtUniformDisInfo, min);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtUniformDisInfo, max);
  EXPECT_EQ(offset, sizeof(aclrtRandomParaInfo));

  // check total size
  EXPECT_EQ(sizeof(aclrtUniformDisInfo),
            sizeof(aclrtRandomParaInfo) + sizeof(aclrtRandomParaInfo));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtNormalDisInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtNormalDisInfo, mean);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtNormalDisInfo, stddev);
  EXPECT_EQ(offset, sizeof(aclrtRandomParaInfo));

  // check total size
  EXPECT_EQ(sizeof(aclrtNormalDisInfo), sizeof(aclrtRandomParaInfo) * 2);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtRandomNumFuncParaInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtRandomNumFuncParaInfo, funcType);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtRandomNumFuncParaInfo, paramInfo);
  EXPECT_EQ(offset, sizeof(aclrtRandomNumFuncType));

  // check total size
  EXPECT_EQ(sizeof(aclrtRandomNumFuncParaInfo),
            sizeof(aclrtRandomNumFuncType) + sizeof(aclrtUniformDisInfo));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtRandomNumTaskInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, dataType);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomNumFuncParaInfo);
  EXPECT_EQ(offset, sizeof(aclDataType));

  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomParaAddr);
  EXPECT_EQ(offset, sizeof(aclDataType) +
                            sizeof(aclrtRandomNumFuncParaInfo));

  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomResultAddr);
  EXPECT_EQ(offset, sizeof(aclDataType) +
                        sizeof(aclrtRandomNumFuncParaInfo) + sizeof(void *));

  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomCounterAddr);
  EXPECT_EQ(offset, sizeof(aclDataType) +
                        sizeof(aclrtRandomNumFuncParaInfo) +
                        sizeof(void *) * 2);

  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomSeed);
  EXPECT_EQ(offset, sizeof(aclDataType) +
                        sizeof(aclrtRandomNumFuncParaInfo) +
                        sizeof(void *) * 3);

  offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomNum);
  EXPECT_EQ(offset, sizeof(aclDataType) +
                        sizeof(aclrtRandomNumFuncParaInfo) +
                        sizeof(void *) * 3 + sizeof(aclrtRandomParaInfo));

  // check total size
  EXPECT_EQ(sizeof(aclrtRandomNumTaskInfo),
            sizeof(aclDataType) +
                sizeof(aclrtRandomNumFuncParaInfo) + sizeof(void *) * 3 +
                sizeof(aclrtRandomParaInfo) * 2 + sizeof(uint8_t) * 8);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtRandomTaskUpdateAttr) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtRandomTaskUpdateAttr, srcAddr);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtRandomTaskUpdateAttr, size);
  EXPECT_EQ(offset, sizeof(void *));

  // check total size
  EXPECT_EQ(sizeof(aclrtRandomTaskUpdateAttr),
            sizeof(void *) + sizeof(size_t) + sizeof(uint32_t) * 4);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtAicAivTaskUpdateAttr) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtAicAivTaskUpdateAttr, binHandle);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtAicAivTaskUpdateAttr, funcEntryAddr);
  EXPECT_EQ(offset, sizeof(void *));

  offset = OFFSET_OF_MEMBER(aclrtAicAivTaskUpdateAttr, blockDimAddr);
  EXPECT_EQ(offset, sizeof(void *) * 2);

  // check total size
  EXPECT_EQ(sizeof(aclrtAicAivTaskUpdateAttr),
            sizeof(void *) * 3 + sizeof(uint32_t) * 4);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtUpdateTaskAttrVal) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtUpdateTaskAttrVal, randomTaskAttr);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtUpdateTaskAttrVal, aicAivTaskAttr);
  EXPECT_EQ(offset, 0);

  // check total size
  EXPECT_EQ(sizeof(aclrtUpdateTaskAttrVal), sizeof(aclrtAicAivTaskUpdateAttr));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtTaskUpdateInfo) 
{
  size_t offset;
  offset = OFFSET_OF_MEMBER(aclrtTaskUpdateInfo, id);
  EXPECT_EQ(offset, 0);

  offset = OFFSET_OF_MEMBER(aclrtTaskUpdateInfo, val);
  EXPECT_EQ(offset, sizeof(aclrtUpdateTaskAttrId)*2);

  // check total size
  EXPECT_EQ(sizeof(aclrtTaskUpdateInfo),
            sizeof(aclrtUpdateTaskAttrId)*2 + sizeof(aclrtUpdateTaskAttrVal));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtCntNotifyRecordInfo)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtCntNotifyRecordInfo, mode);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtCntNotifyRecordInfo, value);
    EXPECT_EQ(offset, sizeof(aclrtCntNotifyRecordMode));

    EXPECT_EQ(sizeof(aclrtCntNotifyRecordInfo), sizeof(aclrtCntNotifyRecordMode) + sizeof (uint32_t));
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtCntNotifyWaitInfo)
{
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, mode);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, value);
    EXPECT_EQ(offset, sizeof(aclrtCntNotifyWaitMode));

    offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, timeout);
    EXPECT_EQ(offset, sizeof(aclrtCntNotifyWaitMode) + sizeof(uint32_t));

    offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, isClear);
    EXPECT_EQ(offset, sizeof(aclrtCntNotifyWaitMode) + sizeof(uint32_t)*2);

    offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, rsv);
    EXPECT_EQ(offset, sizeof(aclrtCntNotifyWaitMode) + sizeof(uint32_t)*2 + sizeof(bool));

    EXPECT_EQ(sizeof(aclrtCntNotifyWaitInfo), sizeof(aclrtCntNotifyWaitMode) + sizeof(uint32_t) * 2 + sizeof(bool) + sizeof(uint8_t) * 3);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtErrorInfoDetail)
{
    size_t offset;
    // 测试结构体 memUceInfo 中的 arraySize 字段偏移量
    offset = OFFSET_OF_MEMBER(aclrtErrorInfoDetail, uceInfo.arraySize);
    EXPECT_EQ(offset, 0);

    // 测试结构体 memUceInfo 中的 memUceInfoArray 字段偏移量
    offset = OFFSET_OF_MEMBER(aclrtErrorInfoDetail, uceInfo.memUceInfoArray);
    EXPECT_EQ(offset, sizeof(size_t));

    // 测试结构体 aicoreErrType 的总大小
    offset = OFFSET_OF_MEMBER(aclrtErrorInfoDetail, aicoreErrType);
    EXPECT_EQ(offset, 0);

    // 联合体的大小由最大的成员决定
    size_t expectedSize = sizeof(size_t) +
        ACL_RT_MEM_UCE_INFO_MAX_NUM * sizeof(aclrtMemUceInfo);

    EXPECT_EQ(sizeof(aclrtErrorInfoDetail), expectedSize);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtErrorInfo)
{
    // 检查结构体成员偏移量
    size_t offset;
    offset = OFFSET_OF_MEMBER(aclrtErrorInfo, tryRepair);
    EXPECT_EQ(offset, 0);

    offset = OFFSET_OF_MEMBER(aclrtErrorInfo, hasDetail);
    EXPECT_EQ(offset, sizeof(uint8_t));

    offset = OFFSET_OF_MEMBER(aclrtErrorInfo, errorType);
    EXPECT_EQ(offset, 4*sizeof(uint8_t));

    offset = OFFSET_OF_MEMBER(aclrtErrorInfo, detail);
    EXPECT_EQ(offset, 4 * sizeof(uint8_t) + 4);

    // 检查总大小
    EXPECT_EQ(sizeof(aclrtErrorInfo),
        4 * sizeof(uint8_t) + sizeof(aclrtErrorInfoDetail) + 4);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMemAccessDesc)
{
    size_t offset;
    // 检查flags的偏移量是否为0
    offset = OFFSET_OF_MEMBER(aclrtMemAccessDesc, flags);
    EXPECT_EQ(offset, 0);

    // 检查location的偏移量是否为aclrtMemAccessFlags的大小
    offset = OFFSET_OF_MEMBER(aclrtMemAccessDesc, location);
    EXPECT_EQ(offset, sizeof(aclrtMemAccessFlags));

    // 检查rsv的偏移量是否为aclrtMemLocation + aclrtMemAccessFlags的大小
    offset = OFFSET_OF_MEMBER(aclrtMemAccessDesc, rsv);
    EXPECT_EQ(offset, sizeof(aclrtMemLocation) + sizeof(aclrtMemAccessFlags));

    // 检查整个结构体的大小是否正确
    EXPECT_EQ(sizeof(aclrtMemAccessDesc),
        sizeof(aclrtMemLocation) + 
        sizeof(aclrtMemAccessFlags) + 
        sizeof(uint8_t) * 12);
}

TEST_F(UTEST_ACL_compatibility_struct_check, aclrtMemUsageInfo)
{
    size_t offset;
    // 测试结构体 aclrtMemUsageInfo 中的 name 字段偏移量
    offset = OFFSET_OF_MEMBER(aclrtMemUsageInfo, name);
    EXPECT_EQ(offset, 0);

    // 测试结构体 aclrtMemUsageInfo 中的 curMemSize 字段偏移量
    offset = OFFSET_OF_MEMBER(aclrtMemUsageInfo, curMemSize);
    EXPECT_EQ(offset, sizeof(char) * 32);

    // 测试结构体 aclrtMemUsageInfo 中的 memPeakSize 字段偏移量
    offset = OFFSET_OF_MEMBER(aclrtMemUsageInfo, memPeakSize);
    EXPECT_EQ(offset, sizeof(char) * 32 + sizeof(uint64_t));

    // 测试结构体 aclrtMemUsageInfo 中的 reserved 字段偏移量
    offset = OFFSET_OF_MEMBER(aclrtMemUsageInfo, reserved);
    EXPECT_EQ(offset, sizeof(char) * 32 + sizeof(uint64_t) * 2);

    // 检查整个结构体的大小是否正确
    EXPECT_EQ(sizeof(aclrtMemUsageInfo),
        sizeof(char) * 32 + sizeof(uint64_t) * 2 + sizeof(size_t) * 8);
}