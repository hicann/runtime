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
#include "common/log_inner.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "runtime/rt_ras.h"
#undef private
#endif

class UTEST_ACL_compatibility_cast_check : public testing::Test
{
    public:
        UTEST_ACL_compatibility_cast_check() {}

    protected:
        virtual void SetUp() {}
        virtual void TearDown() {}
};

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtErrorType)
{
    EXPECT_EQ((uint64_t)ACL_RT_NO_ERROR, (uint64_t)RT_NO_ERROR);
    EXPECT_EQ((uint64_t)ACL_RT_ERROR_MEMORY, (uint64_t)RT_ERROR_MEMORY);
    EXPECT_EQ((uint64_t)ACL_RT_ERROR_L2 , (uint64_t)RT_ERROR_L2);
    EXPECT_EQ((uint64_t)ACL_RT_ERROR_AICORE , (uint64_t)RT_ERROR_AICORE);
    EXPECT_EQ((uint64_t)ACL_RT_ERROR_LINK , (uint64_t)RT_ERROR_LINK);
    EXPECT_EQ((uint64_t)ACL_RT_ERROR_OTHERS , (uint64_t)RT_ERROR_OTHERS);
    EXPECT_EQ(sizeof(aclrtErrorType), sizeof(rtErrType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtAicoreErrorType)
{
    EXPECT_EQ((uint64_t)ACL_RT_AICORE_ERROR_UNKNOWN, (uint64_t)RT_AICORE_ERROR_UNKNOWN);
    EXPECT_EQ((uint64_t)ACL_RT_AICORE_ERROR_SW, (uint64_t)RT_AICORE_ERROR_SW);
    EXPECT_EQ((uint64_t)ACL_RT_AICORE_ERROR_HW_LOCAL, (uint64_t)RT_AICORE_ERROR_HW_LOCAL);
    EXPECT_EQ(sizeof(aclrtAicoreErrorType), sizeof(rtAicoreErrorType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtErrorInfoDetail)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtErrorInfoDetail, uceInfo);
    rts_offset = OFFSET_OF_MEMBER(rtErrorInfoDetail, uceInfo); EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtErrorInfoDetail, aicoreErrType);
    rts_offset = OFFSET_OF_MEMBER(rtErrorInfoDetail, aicoreErrType);
    EXPECT_EQ(acl_offset, rts_offset);

    EXPECT_EQ(sizeof(aclrtErrorInfoDetail), sizeof(size_t) + ACL_RT_MEM_UCE_INFO_MAX_NUM * sizeof(aclrtMemUceInfo));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtErrorInfo) 
{ 
    size_t acl_offset, rts_offset; 
    acl_offset = OFFSET_OF_MEMBER(aclrtErrorInfo, tryRepair); 
    rts_offset = OFFSET_OF_MEMBER(rtErrorInfo, tryRepair); 
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtErrorInfo, hasDetail); 
    rts_offset = OFFSET_OF_MEMBER(rtErrorInfo, hasDetail); 
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtErrorInfo, detail);
    rts_offset = OFFSET_OF_MEMBER(rtErrorInfo, detail);
    EXPECT_EQ(acl_offset, rts_offset);

    EXPECT_EQ(sizeof(aclrtErrorInfo), 4 * sizeof(uint8_t) + sizeof(aclrtErrorInfoDetail) + 4);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtBinaryLoadOptionType)
{
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD, (uint64_t)RT_LOAD_BINARY_OPT_LAZY_LOAD);
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_LOAD_OPT_LAZY_MAGIC, (uint64_t)RT_LOAD_BINARY_OPT_MAGIC);
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_LOAD_OPT_MAGIC, (uint64_t)RT_LOAD_BINARY_OPT_MAGIC);
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_LOAD_OPT_CPU_KERNEL_MODE, (uint64_t)RT_LOAD_BINARY_OPT_CPU_KERNEL_MODE);

    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionType), sizeof(rtLoadBinaryOption));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtLaunchKernelAttrId)
{
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE, (uint64_t)RT_LAUNCH_KERNEL_ATTR_SCHEM_MODE);
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE, (uint64_t)RT_LAUNCH_KERNEL_ATTR_ENGINE_TYPE);
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET, (uint64_t)RT_LAUNCH_KERNEL_ATTR_BLOCKDIM_OFFSET);
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH, (uint64_t)RT_LAUNCH_KERNEL_ATTR_BLOCK_TASK_PREFETCH);
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_DATA_DUMP, (uint64_t)RT_LAUNCH_KERNEL_ATTR_DATA_DUMP);
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT, (uint64_t)RT_LAUNCH_KERNEL_ATTR_TIMEOUT);
    EXPECT_EQ((uint64_t)ACL_RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US, (uint64_t)RT_LAUNCH_KERNEL_ATTR_TIMEOUT_US);

    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrId), sizeof(rtLaunchKernelAttrId));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMemcpyKind)
{
    EXPECT_EQ((uint64_t)ACL_MEMCPY_HOST_TO_HOST, (uint64_t)RT_MEMCPY_KIND_HOST_TO_HOST);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_HOST_TO_DEVICE, (uint64_t)RT_MEMCPY_KIND_HOST_TO_DEVICE);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_DEVICE_TO_HOST, (uint64_t)RT_MEMCPY_KIND_DEVICE_TO_HOST);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_DEVICE_TO_DEVICE, (uint64_t)RT_MEMCPY_KIND_DEVICE_TO_DEVICE);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_DEFAULT, (uint64_t)RT_MEMCPY_KIND_DEFAULT);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_HOST_TO_BUF_TO_DEVICE, (uint64_t)RT_MEMCPY_KIND_HOST_TO_BUF_TO_DEVICE);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_INNER_DEVICE_TO_DEVICE, (uint64_t)RT_MEMCPY_KIND_INNER_DEVICE_TO_DEVICE);
    EXPECT_EQ((uint64_t)ACL_MEMCPY_INTER_DEVICE_TO_DEVICE, (uint64_t)RT_MEMCPY_KIND_INTER_DEVICE_TO_DEVICE);

    EXPECT_EQ(sizeof(aclrtMemcpyKind), sizeof(rtMemcpyKind));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtBinaryLoadOption)
{
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtBinaryLoadOption, type), OFFSET_OF_MEMBER(rtLoadBinaryOption_t , optionId));
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtBinaryLoadOption, value), OFFSET_OF_MEMBER(rtLoadBinaryOption_t, value));

    EXPECT_EQ(sizeof(aclrtBinaryLoadOption), sizeof(rtLoadBinaryOption_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtBinaryLoadOptions)
{
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtBinaryLoadOptions, options), OFFSET_OF_MEMBER(rtLoadBinaryConfig_t, options));
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtBinaryLoadOptions, numOpt), OFFSET_OF_MEMBER(rtLoadBinaryConfig_t, numOpt));

    EXPECT_EQ(sizeof(aclrtBinaryLoadOptions), sizeof(rtLoadBinaryConfig_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtLaunchKernelAttr)
{
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtLaunchKernelAttr, id), OFFSET_OF_MEMBER(rtLaunchKernelAttr_t , id));
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtLaunchKernelAttr, value), OFFSET_OF_MEMBER(rtLaunchKernelAttr_t, value));

    EXPECT_EQ(sizeof(aclrtLaunchKernelAttr), sizeof(rtLaunchKernelAttr_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtLaunchKernelCfg)
{
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtLaunchKernelCfg, attrs), OFFSET_OF_MEMBER(rtKernelLaunchCfg_t , attrs));
    EXPECT_EQ(OFFSET_OF_MEMBER(aclrtLaunchKernelCfg, numAttrs), OFFSET_OF_MEMBER(rtKernelLaunchCfg_t, numAttrs));

    EXPECT_EQ(sizeof(aclrtLaunchKernelCfg), sizeof(rtKernelLaunchCfg_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtBinaryLoadOptionValue)
{
    size_t aclAlign = alignof(decltype(aclrtBinaryLoadOptionValue::isLazyLoad));
    EXPECT_EQ(aclAlign, alignof(decltype(rtLoadBinaryOptionValue_t::isLazyLoad)));

    EXPECT_EQ(sizeof(aclrtBinaryLoadOptionValue), sizeof(rtLoadBinaryOptionValue_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtLaunchKernelAttrValue)
{
    size_t aclAlign = alignof(decltype(aclrtLaunchKernelAttrValue::schemMode));
    EXPECT_EQ(aclAlign, alignof(decltype(rtLaunchKernelAttrVal_t::schemMode)));
    EXPECT_EQ(sizeof(aclrtLaunchKernelAttrValue), sizeof(rtLaunchKernelAttrVal_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMemMallocPolicy)
{
    EXPECT_EQ((uint64_t)ACL_MEM_MALLOC_HUGE_FIRST, (uint64_t)RT_MEM_MALLOC_HUGE_FIRST);
    EXPECT_EQ((uint64_t)ACL_MEM_MALLOC_HUGE_ONLY, (uint64_t)RT_MEM_MALLOC_HUGE_ONLY);
    EXPECT_EQ((uint64_t)ACL_MEM_MALLOC_NORMAL_ONLY, (uint64_t)RT_MEM_MALLOC_NORMAL_ONLY);
    EXPECT_EQ((uint64_t)ACL_MEM_MALLOC_HUGE_FIRST_P2P, (uint64_t)RT_MEM_MALLOC_HUGE_FIRST_P2P);
    EXPECT_EQ((uint64_t)ACL_MEM_MALLOC_HUGE_ONLY_P2P, (uint64_t)RT_MEM_MALLOC_HUGE_ONLY_P2P);
    EXPECT_EQ((uint64_t)ACL_MEM_MALLOC_NORMAL_ONLY_P2P, (uint64_t)RT_MEM_MALLOC_NORMAL_ONLY_P2P);
    EXPECT_EQ((uint64_t)ACL_MEM_TYPE_LOW_BAND_WIDTH, (uint64_t)RT_MEM_TYPE_LOW_BAND_WIDTH);
    EXPECT_EQ((uint64_t)ACL_MEM_TYPE_HIGH_BAND_WIDTH, (uint64_t)RT_MEM_TYPE_HIGH_BAND_WIDTH);
    EXPECT_EQ((uint64_t)ACL_MEM_ACCESS_USER_SPACE_READONLY, (uint64_t)RT_MEM_ACCESS_USER_SPACE_READONLY);

    // check total size
    EXPECT_EQ(sizeof(aclrtMemMallocPolicy), sizeof(rtMallocPolicy));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtHostRegisterType)
{
    EXPECT_EQ((uint64_t)ACL_HOST_REGISTER_MAPPED, (uint64_t)RT_HOST_REGISTER_MAPPED);
    EXPECT_EQ((uint64_t)ACL_HOST_REGISTER_IOMEMORY, (uint64_t)RT_HOST_REGISTER_IOMEMORY);
    EXPECT_EQ((uint64_t)ACL_HOST_REGISTER_READONLY, (uint64_t)RT_HOST_REGISTER_READONLY);

    // check total size
    EXPECT_EQ(sizeof(aclrtHostRegisterType), sizeof(rtHostRegisterType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMallocAttrType)
{
    EXPECT_EQ((uint64_t)ACL_RT_MEM_ATTR_RSV, (uint64_t)RT_MEM_MALLOC_ATTR_RSV);
    EXPECT_EQ((uint64_t)ACL_RT_MEM_ATTR_MODULE_ID, (uint64_t)RT_MEM_MALLOC_ATTR_MODULE_ID);
    EXPECT_EQ((uint64_t)ACL_RT_MEM_ATTR_DEVICE_ID, (uint64_t)RT_MEM_MALLOC_ATTR_DEVICE_ID);

    // check total size
    EXPECT_EQ(sizeof(aclrtMallocAttrType), sizeof(rtMallocAttr));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtCmoType)
{
    EXPECT_EQ((uint64_t)ACL_RT_CMO_TYPE_PREFETCH + 6UL, (uint64_t)RT_CMO_PREFETCH);
    EXPECT_EQ((uint64_t)ACL_RT_CMO_TYPE_WRITEBACK + 6UL, (uint64_t)RT_CMO_WRITEBACK);
    EXPECT_EQ((uint64_t)ACL_RT_CMO_TYPE_INVALID + 6UL, (uint64_t)RT_CMO_INVALID);
    EXPECT_EQ((uint64_t)ACL_RT_CMO_TYPE_FLUSH + 6UL, (uint64_t)RT_CMO_FLUSH);

    // check total size
    EXPECT_EQ(sizeof(aclrtCmoType), sizeof(rtCmoOpCode_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMallocAttrValue)
{
    // check total size
    EXPECT_EQ(sizeof(aclrtMallocAttrValue), sizeof(rtMallocAttrValue));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMallocAttribute)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtMallocAttribute, attr);
    rts_offset = OFFSET_OF_MEMBER(rtMallocAttribute_t, attr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMallocAttribute, value);
    rts_offset = OFFSET_OF_MEMBER(rtMallocAttribute_t, value);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtMallocAttribute), sizeof(rtMallocAttribute_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMallocConfig)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtMallocConfig, attrs);
    rts_offset = OFFSET_OF_MEMBER(rtMallocConfig_t, attrs);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMallocConfig, numAttrs);
    rts_offset = OFFSET_OF_MEMBER(rtMallocConfig_t, numAttrs);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtMallocConfig), sizeof(rtMallocConfig_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMemLocation)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtMemLocation, id);
    rts_offset = OFFSET_OF_MEMBER(rtMemLocation, id);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMemLocation, type);
    rts_offset = OFFSET_OF_MEMBER(rtMemLocation, type);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtMemLocation), sizeof(rtMemLocation));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtUuid)
{
    size_t acl_offset, rt_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtUuid, bytes);
    rt_offset = OFFSET_OF_MEMBER(rtUuid_t, bytes);
    EXPECT_EQ(acl_offset, rt_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtUuid), sizeof(rtUuid_t));
}
TEST_F(UTEST_ACL_compatibility_cast_check, aclrtPtrAttributes)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtPtrAttributes, location);
    rts_offset = OFFSET_OF_MEMBER(rtPtrAttributes_t, location);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtPtrAttributes, pageSize);
    rts_offset = OFFSET_OF_MEMBER(rtPtrAttributes_t, pageSize);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtPtrAttributes, rsv);
    rts_offset = OFFSET_OF_MEMBER(rtPtrAttributes_t, rsv);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtPtrAttributes), sizeof(rtPtrAttributes_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtStreamAttrValue)
{
    // check total size
    EXPECT_EQ(sizeof(aclrtStreamAttrValue), sizeof(rtStreamAttrValue_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, device_get_capability_flags)
{
    EXPECT_EQ((uint64_t)ACL_DEV_FEATURE_SUPPORT, (uint64_t)FEATURE_SUPPORT);
    EXPECT_EQ((uint64_t)ACL_DEV_FEATURE_NOT_SUPPORT, (uint64_t)FEATURE_NOT_SUPPORT);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtStreamAttr)
{
    EXPECT_EQ((uint64_t)ACL_STREAM_ATTR_FAILURE_MODE, (uint64_t)RT_STREAM_ATTR_FAILURE_MODE);
    EXPECT_EQ((uint64_t)ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK, (uint64_t)RT_STREAM_ATTR_FLOAT_OVERFLOW_CHECK);
    EXPECT_EQ((uint64_t)ACL_STREAM_ATTR_USER_CUSTOM_TAG, (uint64_t)RT_STREAM_ATTR_USER_CUSTOM_TAG);
    EXPECT_EQ((uint64_t)ACL_STREAM_ATTR_CACHE_OP_INFO, (uint64_t)RT_STREAM_ATTR_CACHE_OP_INFO);

    // check total size
    EXPECT_EQ(sizeof(aclrtStreamAttr), sizeof(rtStreamAttr));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtDevAttr)
{
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_AICPU_CORE_NUM, (uint64_t)RT_DEV_ATTR_AICPU_CORE_NUM);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_AICORE_CORE_NUM, (uint64_t)RT_DEV_ATTR_AICORE_CORE_NUM);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_VECTOR_CORE_NUM, (uint64_t)RT_DEV_ATTR_VECTOR_CORE_NUM);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_CUBE_CORE_NUM, (uint64_t)RT_DEV_ATTR_CUBE_CORE_NUM);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_WARP_SIZE, (uint64_t)RT_DEV_ATTR_WARP_SIZE);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE, (uint64_t)RT_DEV_ATTR_MAX_THREAD_PER_VECTOR_CORE);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE, (uint64_t)RT_DEV_ATTR_LOCAL_MEM_PER_VECTOR_CORE);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE, (uint64_t)RT_DEV_ATTR_TOTAL_GLOBAL_MEM_SIZE);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_L2_CACHE_SIZE, (uint64_t)RT_DEV_ATTR_L2_CACHE_SIZE);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_SMP_ID, (uint64_t)RT_DEV_ATTR_SMP_ID);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_PHY_CHIP_ID, (uint64_t)RT_DEV_ATTR_PHY_CHIP_ID);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_SUPER_POD_DEVIDE_ID, (uint64_t)RT_DEV_ATTR_SUPER_POD_DEVICE_ID);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_SUPER_POD_SERVER_ID, (uint64_t)RT_DEV_ATTR_SUPER_POD_SERVER_ID);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_SUPER_POD_ID, (uint64_t)RT_DEV_ATTR_SUPER_POD_ID);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_CUST_OP_PRIVILEGE, (uint64_t)RT_DEV_ATTR_CUST_OP_PRIVILEGE);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_MAINBOARD_ID, (uint64_t)RT_DEV_ATTR_MAINBOARD_ID);
    EXPECT_EQ((uint64_t)ACL_DEV_ATTR_IS_VIRTUAL, (uint64_t)RT_DEV_ATTR_IS_VIRTUAL);

    // check total size
    EXPECT_EQ(sizeof(aclrtDevAttr), sizeof(rtDevAttr));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtDevFeatureType)
{
    EXPECT_EQ((uint64_t)ACL_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV, (uint64_t)RT_FEATURE_TSCPU_TASK_UPDATE_SUPPORT_AIC_AIV);
    EXPECT_EQ((uint64_t)ACL_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV, (uint64_t)RT_FEATURE_SYSTEM_MEMQ_EVENT_CROSS_DEV);

    // check total size
    EXPECT_EQ(sizeof(aclrtDevFeatureType), sizeof(rtDevFeatureType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtReduceKind)
{
    EXPECT_EQ((uint64_t)ACL_RT_MEMCPY_SDMA_AUTOMATIC_SUM, (uint64_t)RT_MEMCPY_SDMA_AUTOMATIC_ADD);
    EXPECT_EQ((uint64_t)ACL_RT_MEMCPY_SDMA_AUTOMATIC_MAX, (uint64_t)RT_MEMCPY_SDMA_AUTOMATIC_MAX);
    EXPECT_EQ((uint64_t)ACL_RT_MEMCPY_SDMA_AUTOMATIC_MIN, (uint64_t)RT_MEMCPY_SDMA_AUTOMATIC_MIN);
    EXPECT_EQ((uint64_t)ACL_RT_MEMCPY_SDMA_AUTOMATIC_EQUAL, (uint64_t)RT_MEMCPY_SDMA_AUTOMATIC_EQUAL);

    // check total size
    EXPECT_EQ(sizeof(aclrtReduceKind), sizeof(rtReduceKind));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtDevResLimitType)
{
    EXPECT_EQ((uint64_t)ACL_RT_DEV_RES_CUBE_CORE, (uint64_t)RT_DEV_RES_CUBE_CORE);
    EXPECT_EQ((uint64_t)ACL_RT_DEV_RES_VECTOR_CORE, (uint64_t)RT_DEV_RES_VECTOR_CORE);

    // check total size
    EXPECT_EQ(sizeof(aclrtDevResLimitType), sizeof(rtDevResLimitType_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtCondition)
{
    EXPECT_EQ((uint64_t)ACL_RT_EQUAL, (uint64_t)RT_EQUAL);
    EXPECT_EQ((uint64_t)ACL_RT_NOT_EQUAL, (uint64_t)RT_NOT_EQUAL);
    EXPECT_EQ((uint64_t)ACL_RT_GREATER, (uint64_t)RT_GREATER);
    EXPECT_EQ((uint64_t)ACL_RT_GREATER_OR_EQUAL, (uint64_t)RT_GREATER_OR_EQUAL);
    EXPECT_EQ((uint64_t)ACL_RT_LESS, (uint64_t)RT_LESS);
    EXPECT_EQ((uint64_t)ACL_RT_LESS_OR_EQUAL, (uint64_t)RT_LESS_OR_EQUAL);

    // check total size
    EXPECT_EQ(sizeof(aclrtCondition), sizeof(rtCondition_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtCompareDataType)
{
    EXPECT_EQ((uint64_t)ACL_RT_SWITCH_INT32, (uint64_t)RT_SWITCH_INT32);
    EXPECT_EQ((uint64_t)ACL_RT_SWITCH_INT64, (uint64_t)RT_SWITCH_INT64);

    // check total size
    EXPECT_EQ(sizeof(aclrtCompareDataType), sizeof(rtSwitchDataType_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtEngineType)
{
    EXPECT_EQ((uint64_t)ACL_RT_ENGINE_TYPE_AIC, (uint64_t)RT_ENGINE_TYPE_AIC);
    EXPECT_EQ((uint64_t)ACL_RT_ENGINE_TYPE_AIV, (uint64_t)RT_ENGINE_TYPE_AIV);

    // check total size
    EXPECT_EQ(sizeof(aclrtEngineType), sizeof(rtEngineType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtBarrierCmoInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtBarrierCmoInfo, cmoType);
    rts_offset = OFFSET_OF_MEMBER(rtBarrierCmoInfo_t, cmoType);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtBarrierCmoInfo, barrierId);
    rts_offset = OFFSET_OF_MEMBER(rtBarrierCmoInfo_t, logicId);
    EXPECT_EQ(acl_offset, rts_offset + 2);

    // check total size
    EXPECT_EQ(sizeof(aclrtBarrierCmoInfo), sizeof(rtBarrierCmoInfo_t) + 2);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtBarrierTaskInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtBarrierTaskInfo, barrierNum);
    rts_offset = OFFSET_OF_MEMBER(rtBarrierTaskInfo_t, logicIdNum);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtBarrierTaskInfo, cmoInfo);
    rts_offset = OFFSET_OF_MEMBER(rtBarrierTaskInfo_t, cmoInfo);
    EXPECT_EQ(acl_offset, rts_offset + 7);

    // check total size
    EXPECT_EQ(sizeof(aclrtBarrierTaskInfo), sizeof(rtBarrierTaskInfo_t) + 19);
}

TEST_F(UTEST_ACL_compatibility_cast_check, devs_topology)
{
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_HCCS, (uint64_t)RT_DEVS_TOPOLOGY_HCCS);
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_PIX, (uint64_t)RT_DEVS_TOPOLOGY_PIX);
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_PIB, (uint64_t)RT_DEVS_TOPOLOGY_PIB);
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_PHB, (uint64_t)RT_DEVS_TOPOLOGY_PHB);
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_SYS, (uint64_t)RT_DEVS_TOPOLOGY_SYS);
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_SIO, (uint64_t)RT_DEVS_TOPOLOGY_SIO);
    EXPECT_EQ((uint64_t)ACL_RT_DEVS_TOPOLOGY_HCCS_SW, (uint64_t)RT_DEVS_TOPOLOGY_HCCS_SW);
}

TEST_F(UTEST_ACL_compatibility_cast_check, cmo_max_barrier_num)
{
    EXPECT_EQ((uint64_t)ACL_RT_CMO_MAX_BARRIER_NUM, (uint64_t)RT_CMO_MAX_BARRIER_NUM);
}

TEST_F(UTEST_ACL_compatibility_cast_check, dev_binary_magic_elf_flags)
{
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_MAGIC_ELF_AICORE, (uint64_t)RT_DEV_BINARY_MAGIC_ELF);
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE, (uint64_t)RT_DEV_BINARY_MAGIC_ELF_AIVEC);
    EXPECT_EQ((uint64_t)ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE, (uint64_t)RT_DEV_BINARY_MAGIC_ELF_AICUBE);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMemcpyBatchAttr)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtMemcpyBatchAttr, dstLoc);
    rts_offset = OFFSET_OF_MEMBER(rtMemcpyBatchAttr, dstLoc);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMemcpyBatchAttr, srcLoc);
    rts_offset = OFFSET_OF_MEMBER(rtMemcpyBatchAttr, srcLoc);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMemcpyBatchAttr, rsv);
    rts_offset = OFFSET_OF_MEMBER(rtMemcpyBatchAttr, rsv);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtMemcpyBatchAttr), sizeof(rtMemcpyBatchAttr));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtPlaceHolderInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtPlaceHolderInfo, addrOffset);
    rts_offset = OFFSET_OF_MEMBER(rtPlaceHolderInfo_t, addrOffset);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtPlaceHolderInfo, dataOffset);
    rts_offset = OFFSET_OF_MEMBER(rtPlaceHolderInfo_t, dataOffset);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtPlaceHolderInfo), sizeof(rtPlaceHolderInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtRandomParaInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, isAddr);
    rts_offset = OFFSET_OF_MEMBER(rtRandomParaInfo_t, isAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, valueOrAddr);
    rts_offset = OFFSET_OF_MEMBER(rtRandomParaInfo_t, valueOrAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, size);
    rts_offset = OFFSET_OF_MEMBER(rtRandomParaInfo_t, size);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomParaInfo, rsv);
    rts_offset = OFFSET_OF_MEMBER(rtRandomParaInfo_t, rsv);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtRandomParaInfo), sizeof(rtRandomParaInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtDropoutBitmaskInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtDropoutBitmaskInfo, dropoutRation);
    rts_offset = OFFSET_OF_MEMBER(rtDropoutBitMaskInfo_t, dropoutRation);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtDropoutBitmaskInfo), sizeof(rtDropoutBitMaskInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtUniformDisInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtUniformDisInfo, min);
    rts_offset = OFFSET_OF_MEMBER(rtUniformDisInfo_t, min);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtUniformDisInfo, max);
    rts_offset = OFFSET_OF_MEMBER(rtUniformDisInfo_t, max);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtUniformDisInfo), sizeof(rtUniformDisInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtNormalDisInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtNormalDisInfo, mean);
    rts_offset = OFFSET_OF_MEMBER(rtNormalDisInfo_t, mean);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtNormalDisInfo, stddev);
    rts_offset = OFFSET_OF_MEMBER(rtNormalDisInfo_t, stddev);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtNormalDisInfo), sizeof(rtNormalDisInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtRandomNumFuncType)
{
    EXPECT_EQ((uint64_t)ACL_RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK, (uint64_t)RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK);
    EXPECT_EQ((uint64_t)ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS, (uint64_t)RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS);
    EXPECT_EQ((uint64_t)ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS, (uint64_t)RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS);
    EXPECT_EQ((uint64_t)ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS, (uint64_t)RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS);
    // check total size
    EXPECT_EQ(sizeof(aclrtRandomNumFuncType), sizeof(rtRandomNumFuncType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtRandomNumFuncParaInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumFuncParaInfo, funcType);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumFuncParaInfo_t, funcType);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumFuncParaInfo, paramInfo);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumFuncParaInfo_t, paramInfo);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtRandomNumFuncParaInfo), sizeof(rtRandomNumFuncParaInfo_t));
}


TEST_F(UTEST_ACL_compatibility_cast_check, aclrtRandomNumTaskInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, dataType);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, dataType);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomNumFuncParaInfo);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, randomNumFuncParaInfo);
    EXPECT_EQ(acl_offset, rts_offset);
    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomParaAddr);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, randomParaAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomResultAddr);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, randomResultAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomCounterAddr);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, randomCounterAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomSeed);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, randomSeed);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomNumTaskInfo, randomNum);
    rts_offset = OFFSET_OF_MEMBER(rtRandomNumTaskInfo_t, randomNum);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtRandomNumTaskInfo), sizeof(rtRandomNumTaskInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtDeviceTaskAbortStage)
{
    EXPECT_EQ((uint64_t)ACL_RT_DEVICE_TASK_ABORT_PRE, (uint64_t)RT_DEVICE_TASK_ABORT_PRE);
    EXPECT_EQ((uint64_t)ACL_RT_DEVICE_TASK_ABORT_POST, (uint64_t)RT_DEVICE_TASK_ABORT_POST);

    // check total size
    EXPECT_EQ(sizeof(aclrtDeviceTaskAbortStage), sizeof(rtDeviceTaskAbortStage));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtUpdateTaskAttrId)
{
    EXPECT_EQ((uint64_t)ACL_RT_UPDATE_RANDOM_TASK, (uint64_t)RT_UPDATE_DSA_TASK);
    EXPECT_EQ((uint64_t)ACL_RT_UPDATE_AIC_AIV_TASK, (uint64_t)RT_UPDATE_AIC_AIV_TASK);

    // check total size
    EXPECT_EQ(sizeof(aclrtUpdateTaskAttrId), sizeof(rtUpdateTaskAttrId));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtRandomTaskUpdateAttr)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtRandomTaskUpdateAttr, srcAddr);
    rts_offset = OFFSET_OF_MEMBER(rtDsaTaskUpdateAttr_t, srcAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtRandomTaskUpdateAttr, size);
    rts_offset = OFFSET_OF_MEMBER(rtDsaTaskUpdateAttr_t, size);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtRandomTaskUpdateAttr), sizeof(rtDsaTaskUpdateAttr_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtAicAivTaskUpdateAttr)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtAicAivTaskUpdateAttr, binHandle);
    rts_offset = OFFSET_OF_MEMBER(rtAicAivTaskUpdateAttr_t, binHandle);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtAicAivTaskUpdateAttr, funcEntryAddr);
    rts_offset = OFFSET_OF_MEMBER(rtAicAivTaskUpdateAttr_t, funcEntryAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtAicAivTaskUpdateAttr, blockDimAddr);
    rts_offset = OFFSET_OF_MEMBER(rtAicAivTaskUpdateAttr_t, blockDimAddr);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtAicAivTaskUpdateAttr), sizeof(rtAicAivTaskUpdateAttr_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtUpdateTaskAttrVal)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtUpdateTaskAttrVal, randomTaskAttr);
    rts_offset = OFFSET_OF_MEMBER(rtUpdateTaskAttrVal_t, dsaTaskAttr);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtUpdateTaskAttrVal, aicAivTaskAttr);
    rts_offset = OFFSET_OF_MEMBER(rtUpdateTaskAttrVal_t, aicAivTaskAttr);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtUpdateTaskAttrVal), sizeof(rtUpdateTaskAttrVal_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtTaskUpdateInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtTaskUpdateInfo, id);
    rts_offset = OFFSET_OF_MEMBER(rtTaskUpdateCfg_t, id);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtTaskUpdateInfo, val);
    rts_offset = OFFSET_OF_MEMBER(rtTaskUpdateCfg_t, val);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtTaskUpdateInfo), sizeof(rtTaskUpdateCfg_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtDeviceState)
{
    EXPECT_EQ((uint64_t)ACL_RT_DEVICE_STATE_SET_PRE, (uint64_t)RT_DEVICE_STATE_SET_PRE);
    EXPECT_EQ((uint64_t)ACL_RT_DEVICE_STATE_SET_POST, (uint64_t)RT_DEVICE_STATE_SET_POST);
    EXPECT_EQ((uint64_t)ACL_RT_DEVICE_STATE_RESET_PRE, (uint64_t)RT_DEVICE_STATE_RESET_PRE);
    EXPECT_EQ((uint64_t)ACL_RT_DEVICE_STATE_RESET_POST, (uint64_t)RT_DEVICE_STATE_RESET_POST);
    // check total size
    EXPECT_EQ(sizeof(aclrtDeviceState), sizeof(rtDeviceState));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtStreamState)
{
    EXPECT_EQ((uint64_t)ACL_RT_STREAM_STATE_CREATE_POST, (uint64_t)RT_STREAM_STATE_CREATE_POST);
    EXPECT_EQ((uint64_t)ACL_RT_STREAM_STATE_DESTROY_PRE, (uint64_t)RT_STREAM_STATE_DESTROY_PRE);
    // check total size
    EXPECT_EQ(sizeof(aclrtStreamState), sizeof(rtStreamState));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtCntNotifyRecordInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyRecordInfo, mode);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyRecordInfo_t, mode);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyRecordInfo, value);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyRecordInfo_t, value);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtCntNotifyRecordInfo), sizeof(rtCntNotifyRecordInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtCntNotifyWaitInfo)
{
    size_t acl_offset, rts_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, mode);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyWaitInfo_t, mode);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, value);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyWaitInfo_t, value);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, timeout);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyWaitInfo_t, timeout);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, isClear);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyWaitInfo_t, isClear);
    EXPECT_EQ(acl_offset, rts_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtCntNotifyWaitInfo, rsv);
    rts_offset = OFFSET_OF_MEMBER(rtCntNotifyWaitInfo_t, rev);
    EXPECT_EQ(acl_offset, rts_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtCntNotifyWaitInfo), sizeof(rtCntNotifyWaitInfo_t));
}

TEST_F(UTEST_ACL_compatibility_cast_check, ipc_flag)
{
    EXPECT_EQ((uint64_t)ACL_RT_NOTIFY_EXPORT_FLAG_DEFAULT, (uint64_t)RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_EQ((uint64_t)ACL_RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION, (uint64_t)RT_NOTIFY_EXPORT_FLAG_DISABLE_PID_VALIDATION);

    EXPECT_EQ((uint64_t)ACL_RT_NOTIFY_IMPORT_FLAG_DEFAULT, (uint64_t)RT_NOTIFY_FLAG_DEFAULT);
    EXPECT_EQ((uint64_t)ACL_RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS, (uint64_t)RT_NOTIFY_IMPORT_FLAG_ENABLE_PEER_ACCESS);

    EXPECT_EQ((uint64_t)ACL_RT_IPC_MEM_EXPORT_FLAG_DEFAULT, (uint64_t)RT_IPC_MEM_FLAG_DEFAULT);
    EXPECT_EQ((uint64_t)ACL_RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION, (uint64_t)RT_IPC_MEM_EXPORT_FLAG_DISABLE_PID_VALIDATION);

    EXPECT_EQ((uint64_t)ACL_RT_IPC_MEM_IMPORT_FLAG_DEFAULT, (uint64_t)RT_IPC_MEM_FLAG_DEFAULT);
    EXPECT_EQ((uint64_t)ACL_RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS, (uint64_t)RT_IPC_MEM_IMPORT_FLAG_ENABLE_PEER_ACCESS);

    EXPECT_EQ((uint64_t)ACL_RT_VMM_EXPORT_FLAG_DEFAULT, (uint64_t)RT_VMM_FLAG_DEFAULT);
    EXPECT_EQ((uint64_t)ACL_RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION, (uint64_t)RT_VMM_EXPORT_FLAG_DISABLE_PID_VALIDATION);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMemAccessFlags)
{
    EXPECT_EQ((uint64_t)ACL_RT_MEM_ACCESS_FLAGS_NONE, (uint64_t)RT_MEM_ACCESS_FLAGS_NONE);
    EXPECT_EQ((uint64_t)ACL_RT_MEM_ACCESS_FLAGS_READ, (uint64_t)RT_MEM_ACCESS_FLAGS_READ);
    EXPECT_EQ((uint64_t)ACL_RT_MEM_ACCESS_FLAGS_READWRITE, (uint16_t)RT_MEM_ACCESS_FLAGS_READWRITE);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtMemAccessDesc)
{
    size_t acl_offset, rt_offset;
    acl_offset = OFFSET_OF_MEMBER(aclrtMemAccessDesc, location);
    rt_offset = OFFSET_OF_MEMBER(rtMemAccessDesc, location);
    EXPECT_EQ(acl_offset, rt_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMemAccessDesc, flags);
    rt_offset = OFFSET_OF_MEMBER(rtMemAccessDesc, flags);
    EXPECT_EQ(acl_offset, rt_offset);

    acl_offset = OFFSET_OF_MEMBER(aclrtMemAccessDesc, rsv);
    rt_offset = OFFSET_OF_MEMBER(rtMemAccessDesc, rsv);
    EXPECT_EQ(acl_offset, rt_offset);

    // check total size
    EXPECT_EQ(sizeof(aclrtMemAccessDesc), sizeof(rtMemAccessDesc));
}

TEST_F(UTEST_ACL_compatibility_cast_check, process_state)
{
  EXPECT_EQ((uint64_t)ACL_RT_PROCESS_STATE_RUNNING, (uint64_t)RT_PROCESS_STATE_RUNNING);
  EXPECT_EQ((uint64_t)ACL_RT_PROCESS_STATE_LOCKED, (uint64_t)RT_PROCESS_STATE_LOCKED);
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtKernelType)
{
    EXPECT_EQ((uint64_t)ACL_KERNEL_TYPE_AICORE, (uint64_t)RT_KERNEL_ATTR_TYPE_AICORE);
    EXPECT_EQ((uint64_t)ACL_KERNEL_TYPE_CUBE, (uint64_t)RT_KERNEL_ATTR_TYPE_CUBE);
    EXPECT_EQ((uint64_t)ACL_KERNEL_TYPE_VECTOR, (uint64_t)RT_KERNEL_ATTR_TYPE_VECTOR);
    EXPECT_EQ((uint64_t)ACL_KERNEL_TYPE_MIX, (uint64_t)RT_KERNEL_ATTR_TYPE_MIX);
    EXPECT_EQ((uint64_t)ACL_KERNEL_TYPE_AICPU, (uint64_t)RT_KERNEL_ATTR_TYPE_AICPU);

    EXPECT_EQ(sizeof(aclrtKernelType), sizeof(rtKernelAttrType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtFuncAttribute)
{
    EXPECT_EQ((uint64_t)ACL_FUNC_ATTR_KERNEL_TYPE, (uint64_t)RT_FUNCTION_ATTR_KERNEL_TYPE);

    EXPECT_EQ(sizeof(aclrtFuncAttribute), sizeof(rtFuncAttribute));
}
TEST_F(UTEST_ACL_compatibility_cast_check, aclrtHacType)
{
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_STARS, (uint32_t)RT_HAC_TYPE_STARS);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_AICPU, (uint32_t)RT_HAC_TYPE_AICPU);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_AIC, (uint32_t)RT_HAC_TYPE_AIC);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_AIV, (uint32_t)RT_HAC_TYPE_AIV);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_PCIEDMA, (uint32_t)RT_HAC_TYPE_PCIEDMA);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_RDMA, (uint32_t)RT_HAC_TYPE_RDMA);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_SDMA, (uint32_t)RT_HAC_TYPE_SDMA);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_DVPP, (uint32_t)RT_HAC_TYPE_DVPP);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_UDMA, (uint32_t)RT_HAC_TYPE_UDMA);
   EXPECT_EQ((uint32_t)ACL_RT_HAC_TYPE_CCU, (uint32_t)RT_HAC_TYPE_CCU);
   EXPECT_EQ(sizeof(aclrtHacType), sizeof(rtHacType));
}

TEST_F(UTEST_ACL_compatibility_cast_check, aclrtHostMemMapCapability)
{
   EXPECT_EQ((uint32_t)ACL_RT_HOST_MEM_MAP_NOT_SUPPORTED, (uint32_t)RT_HOST_MEM_MAP_NOT_SUPPORTED);
   EXPECT_EQ((uint32_t)ACL_RT_HOST_MEM_MAP_SUPPORTED, (uint32_t)RT_HOST_MEM_MAP_SUPPORTED);

   EXPECT_EQ(sizeof(aclrtHostMemMapCapability), sizeof(rtHostMemMapCapability));

}
