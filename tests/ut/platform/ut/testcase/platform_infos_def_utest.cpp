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
#include <mockcpp/mockcpp.hpp>
#include <string>
#include <map>
#include <vector>
#define protected public
#define private public
#include "platform/platform_infos_def.h"
#undef protected
#undef private

namespace fe {

class PlatFormInfosDefUTest : public testing::Test {
protected:
    void SetUp() { platform_infos = new PlatFormInfos(); }

    void TearDown()
    {
        delete platform_infos;
        platform_infos = nullptr;
        GlobalMockObject::verify();
    }

    PlatFormInfos* platform_infos;
};

TEST_F(PlatFormInfosDefUTest, Init_NullptrCheck_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    EXPECT_NE(platform_infos->platform_infos_impl_, nullptr);
}

TEST_F(PlatFormInfosDefUTest, GetAICoreIntrinsicDtype_NotInit_ReturnsEmpty)
{
    PlatFormInfos uninitialized;
    auto result = uninitialized.GetAICoreIntrinsicDtype();
    EXPECT_TRUE(result.empty());
}

TEST_F(PlatFormInfosDefUTest, GetVectorCoreIntrinsicDtype_NotInit_ReturnsEmpty)
{
    PlatFormInfos uninitialized;
    auto result = uninitialized.GetVectorCoreIntrinsicDtype();
    EXPECT_TRUE(result.empty());
}

TEST_F(PlatFormInfosDefUTest, GetPlatformRes_StringString_NotInit_ReturnsTrue)
{
    PlatFormInfos uninitialized;
    std::string val;
    EXPECT_FALSE(uninitialized.GetPlatformRes("label", "key", val));
}

TEST_F(PlatFormInfosDefUTest, GetPlatformResWithLock_StringString_NotInit_ReturnsTrue)
{
    PlatFormInfos uninitialized;
    std::string val;
    EXPECT_FALSE(uninitialized.GetPlatformResWithLock("label", "key", val));
}

TEST_F(PlatFormInfosDefUTest, GetPlatformRes_LabelMap_NotInit_ReturnsTrue)
{
    PlatFormInfos uninitialized;
    std::map<std::string, std::string> res;
    EXPECT_FALSE(uninitialized.GetPlatformRes("label", res));
}

TEST_F(PlatFormInfosDefUTest, GetPlatformResWithLock_LabelMap_NotInit_ReturnsTrue)
{
    PlatFormInfos uninitialized;
    std::map<std::string, std::string> res;
    EXPECT_FALSE(uninitialized.GetPlatformResWithLock("label", res));
}

TEST_F(PlatFormInfosDefUTest, GetPlatformResWithLock_MapMap_NotInit_ReturnsTrue)
{
    PlatFormInfos uninitialized;
    std::map<std::string, std::map<std::string, std::string>> res;
    EXPECT_FALSE(uninitialized.GetPlatformResWithLock(res));
}

TEST_F(PlatFormInfosDefUTest, SetAICoreIntrinsicDtype_NotInit_NoEffect)
{
    PlatFormInfos uninitialized;
    std::map<std::string, std::vector<std::string>> dtypes;
    dtypes["test"] = {"float", "int"};
    uninitialized.SetAICoreIntrinsicDtype(dtypes);
}

TEST_F(PlatFormInfosDefUTest, SetVectorCoreIntrinsicDtype_NotInit_NoEffect)
{
    PlatFormInfos uninitialized;
    std::map<std::string, std::vector<std::string>> dtypes;
    dtypes["test"] = {"float", "int"};
    uninitialized.SetVectorCoreIntrinsicDtype(dtypes);
}

TEST_F(PlatFormInfosDefUTest, SetFixPipeDtypeMap_NotInit_NoEffect)
{
    PlatFormInfos uninitialized;
    std::map<std::string, std::vector<std::string>> dtype_map;
    dtype_map["pipe1"] = {"fp16"};
    uninitialized.SetFixPipeDtypeMap(dtype_map);
}

TEST_F(PlatFormInfosDefUTest, SetCoreNum_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    uint32_t core_num = 8;
    platform_infos->SetCoreNum(core_num);
    EXPECT_EQ(platform_infos->core_num_, core_num);
}

TEST_F(PlatFormInfosDefUTest, GetCoreNum_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    platform_infos->core_num_ = 8;
    EXPECT_EQ(platform_infos->GetCoreNum(), 8);
}

TEST_F(PlatFormInfosDefUTest, GetCoreNumWithLock_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    platform_infos->core_num_ = 16;
    EXPECT_EQ(platform_infos->GetCoreNumWithLock(), 16);
}

TEST_F(PlatFormInfosDefUTest, GetCoreNumByType_VectorCore_ReturnsCorrect)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["vector_core_cnt"] = "16";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    EXPECT_EQ(platform_infos->GetCoreNumByType("VectorCore"), 16);
}

TEST_F(PlatFormInfosDefUTest, GetCoreNumByType_AIV_ReturnsCorrect)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["vector_core_cnt"] = "16";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    EXPECT_EQ(platform_infos->GetCoreNumByType("AIV"), 16);
}

TEST_F(PlatFormInfosDefUTest, GetCoreNumByType_AICore_ReturnsCorrect)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["ai_core_cnt"] = "32";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    EXPECT_EQ(platform_infos->GetCoreNumByType("AICore"), 32);
}

TEST_F(PlatFormInfosDefUTest, GetCoreNumByType_OtherType_ReturnsAICoreCnt)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["ai_core_cnt"] = "32";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    EXPECT_EQ(platform_infos->GetCoreNumByType("MIX_AIV"), 32);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemSize_L0_A_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> core_spec;
    core_spec["l0_a_size"] = "65536";
    platform_infos->SetPlatformRes("AICoreSpec", core_spec);
    uint64_t size = 0;
    platform_infos->GetLocalMemSize(LocalMemType::L0_A, size);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemSize_L1_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> core_spec;
    core_spec["l1_size"] = "131072";
    platform_infos->SetPlatformRes("AICoreSpec", core_spec);
    uint64_t size = 0;
    platform_infos->GetLocalMemSize(LocalMemType::L1, size);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemSize_L2_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> core_spec;
    core_spec["l2_size"] = "1048576";
    platform_infos->SetPlatformRes("AICoreSpec", core_spec);
    uint64_t size = 0;
    platform_infos->GetLocalMemSize(LocalMemType::L2, size);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemSize_UB_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> core_spec;
    core_spec["ub_size"] = "65536";
    platform_infos->SetPlatformRes("AICoreSpec", core_spec);
    uint64_t size = 0;
    platform_infos->GetLocalMemSize(LocalMemType::UB, size);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemBw_L0_A_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;
    memory_rates["l0_a_rate"] = "2.5";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
    uint64_t bw = 0;
    platform_infos->GetLocalMemBw(LocalMemType::L0_A, bw);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemBw_L1_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;
    memory_rates["l1_to_l0_a_rate"] = "1.5";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
    uint64_t bw = 0;
    platform_infos->GetLocalMemBw(LocalMemType::L1, bw);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemBw_L2_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;
    memory_rates["l2_rate"] = "2.0";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
    uint64_t bw = 0;
    platform_infos->GetLocalMemBw(LocalMemType::L2, bw);
}

TEST_F(PlatFormInfosDefUTest, GetLocalMemBw_HBM_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;
    memory_rates["ddr_rate"] = "3.0";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
    uint64_t bw = 0;
    platform_infos->GetLocalMemBw(LocalMemType::HBM, bw);
}

TEST_F(PlatFormInfosDefUTest, GetFixPipeDtypeMap_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::vector<std::string>> dtype_map;
    dtype_map["pipe1"] = {"fp16", "int32"};
    platform_infos->SetFixPipeDtypeMap(dtype_map);
    auto result = platform_infos->GetFixPipeDtypeMap();
    EXPECT_EQ(result.size(), 1);
    EXPECT_EQ(result["pipe1"].size(), 2);
}

TEST_F(PlatFormInfosDefUTest, SetPlatformRes_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> res;
    res["key1"] = "value1";
    res["key2"] = "value2";
    platform_infos->SetPlatformRes("label", res);
}

TEST_F(PlatFormInfosDefUTest, SetPlatformResWithLock_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> res;
    res["key1"] = "value1";
    platform_infos->SetPlatformResWithLock("label", res);
}

TEST_F(PlatFormInfosDefUTest, InitByInstance_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    PlatFormInfos other;
    EXPECT_TRUE(other.Init());
    other.core_num_ = 8;
    platform_infos->InitByInstance();
}

TEST_F(PlatFormInfosDefUTest, SaveToBuffer_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    platform_infos->core_num_ = 8;
    std::map<std::string, std::vector<std::string>> dtypes;
    dtypes["test"] = {"float"};
    platform_infos->SetAICoreIntrinsicDtype(dtypes);

#ifdef _OPEN_SOURCE_LLT_
    std::string buffer = platform_infos->SaveToBuffer();
    EXPECT_TRUE(buffer.empty());
#else
    std::string buffer = platform_infos->SaveToBuffer();
    EXPECT_FALSE(buffer.empty());
#endif
}

TEST_F(PlatFormInfosDefUTest, LoadFromBuffer_Success)
{
    PlatFormInfos loaded;
    EXPECT_TRUE(loaded.Init());

#ifdef _OPEN_SOURCE_LLT_
    EXPECT_TRUE(loaded.LoadFromBuffer(nullptr, 0));
#else
    std::string buffer = "valid_buffer_data";
    EXPECT_TRUE(loaded.LoadFromBuffer(buffer.c_str(), buffer.length()));
#endif
}

TEST_F(PlatFormInfosDefUTest, SetCoreNumByCoreType_AICore_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["ai_core_cnt"] = "32";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    platform_infos->SetCoreNumByCoreType("AICore");
    EXPECT_EQ(platform_infos->core_num_, 32);
}

TEST_F(PlatFormInfosDefUTest, SetCoreNumByCoreType_VectorCore_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["vector_core_cnt"] = "16";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    platform_infos->SetCoreNumByCoreType("VectorCore");
    EXPECT_EQ(platform_infos->core_num_, 16);
}

TEST_F(PlatFormInfosDefUTest, SetCoreNumByCoreType_MixAIC_AIV_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["ai_core_cnt"] = "32";
    soc_info["mix_vector_core_cnt"] = "8";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    platform_infos->SetCoreNumByCoreType("MIX_AIC_AIV");
    EXPECT_EQ(platform_infos->core_num_, 8);
}

TEST_F(PlatFormInfosDefUTest, SetCoreNumByCoreType_EmptyCoreNumStr_Success)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> soc_info;
    soc_info["ai_core_cnt"] = "";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);
    platform_infos->SetCoreNumByCoreType("AICore");
    EXPECT_EQ(platform_infos->core_num_, 0);
}

class OptionalInfosDefUTest : public testing::Test {
protected:
    void SetUp() { optional_infos = new OptionalInfos(); }

    void TearDown()
    {
        delete optional_infos;
        optional_infos = nullptr;
        GlobalMockObject::verify();
    }

    OptionalInfos* optional_infos;
};

TEST_F(OptionalInfosDefUTest, Init_Success) { EXPECT_TRUE(optional_infos->Init()); }

TEST_F(OptionalInfosDefUTest, GetSocVersion_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetSocVersion("Ascend910");
    EXPECT_EQ(optional_infos->GetSocVersion(), "Ascend910");
}

TEST_F(OptionalInfosDefUTest, GetCoreType_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetCoreType("AICore");
    EXPECT_EQ(optional_infos->GetCoreType(), "AICore");
}

TEST_F(OptionalInfosDefUTest, GetAICoreNum_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetAICoreNum(32);
    EXPECT_EQ(optional_infos->GetAICoreNum(), 32);
}

TEST_F(OptionalInfosDefUTest, GetL1FusionFlag_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetL1FusionFlag("enable");
    EXPECT_EQ(optional_infos->GetL1FusionFlag(), "enable");
}

TEST_F(OptionalInfosDefUTest, SetFixPipeDtypeMap_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    std::map<std::string, std::vector<std::string>> dtype_map;
    dtype_map["pipe1"] = {"fp16"};
    optional_infos->SetFixPipeDtypeMap(dtype_map);
}

TEST_F(OptionalInfosDefUTest, GetFixPipeDtypeMap_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    std::map<std::string, std::vector<std::string>> dtype_map;
    dtype_map["pipe1"] = {"fp16"};
    optional_infos->SetFixPipeDtypeMap(dtype_map);
    auto result = optional_infos->GetFixPipeDtypeMap();
    EXPECT_EQ(result.size(), 1);
}

TEST_F(OptionalInfosDefUTest, SetSocVersion_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetSocVersion("Ascend910B");
}

TEST_F(OptionalInfosDefUTest, SetSocVersionWithLock_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetSocVersionWithLock("Ascend910B2");
}

TEST_F(OptionalInfosDefUTest, SetCoreType_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetCoreType("VectorCore");
}

TEST_F(OptionalInfosDefUTest, SetAICoreNum_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetAICoreNum(16);
}

TEST_F(OptionalInfosDefUTest, SetL1FusionFlag_Success)
{
    EXPECT_TRUE(optional_infos->Init());
    optional_infos->SetL1FusionFlag("disable");
}

// 新增测试：覆盖 ParseBufferOfAICoreMemoryRates catch 分支
TEST_F(PlatFormInfosDefUTest, ParseBufferOfAICoreMemoryRates_InvalidInput)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;
    memory_rates["invalid_key"] = "invalid_value";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
}

// 新增测试：覆盖 ParseUBOfAICoreMemoryRates catch 分支
TEST_F(PlatFormInfosDefUTest, ParseUBOfAICoreMemoryRates_ExceptionHandling)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;
    memory_rates["ub_to_l1_rate"] = "exception_value";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
}

// 新增测试：覆盖所有 Parse 函数的异常分支
TEST_F(PlatFormInfosDefUTest, ParseUnzipOfAICoreSpec_OutOfRangeValues)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> core_spec;
    core_spec["unzip_max_ratios"] = "4294967296";
    core_spec["unzip_channels"] = "4294967296";
    core_spec["unzip_is_tight"] = "256";
    platform_infos->SetPlatformRes("AICoreSpec", core_spec);
}

// 新增测试：覆盖 CalculateFraction 所有异常分支
TEST_F(PlatFormInfosDefUTest, CalculateFraction_AllExceptionBranches)
{
    EXPECT_TRUE(platform_infos->Init());
    std::map<std::string, std::string> memory_rates;

    // 测试std::exception catch分支
    memory_rates["ub_to_l2_rate"] = "invalid_format";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);

    // 测试unknown exception分支
    memory_rates["ub_to_l2_rate"] = "";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);
}

// 新增测试：覆盖 PlatFormInfosImpl::operator=
TEST_F(PlatFormInfosDefUTest, PlatFormInfosImpl_CopyAssignment_Success)
{
    EXPECT_TRUE(platform_infos->Init());

    std::map<std::string, std::vector<std::string>> dtypes;
    dtypes["test"] = {"float", "int"};
    platform_infos->SetAICoreIntrinsicDtype(dtypes);

    std::map<std::string, std::string> res;
    res["key1"] = "value1";
    platform_infos->SetPlatformRes("TestSection", res);

    PlatFormInfos other;
    EXPECT_TRUE(other.Init());

    // 测试赋值运算符（通过 InitByInstance 触发）
    other.InitByInstance();
}

// 新增测试：覆盖 PlatFormInfosImpl 拷贝构造
TEST_F(PlatFormInfosDefUTest, PlatFormInfosImpl_CopyConstructor_Success)
{
    EXPECT_TRUE(platform_infos->Init());

    std::map<std::string, std::vector<std::string>> dtypes;
    dtypes["vec"] = {"fp16"};
    platform_infos->SetVectorCoreIntrinsicDtype(dtypes);

    std::map<std::string, std::string> res;
    res["config"] = "value";
    platform_infos->SetPlatformRes("Config", res);

    PlatFormInfos copy;
    EXPECT_TRUE(copy.Init());
    copy.InitByInstance();
}

// 新增测试：覆盖 platform_infos_impl.h 模板函数分支
TEST_F(PlatFormInfosDefUTest, GetPlatformResWithLock_MapMap_AllBranches)
{
    EXPECT_TRUE(platform_infos->Init());

    std::map<std::string, std::map<std::string, std::string>> res_map;
    std::map<std::string, std::string> inner_map;
    inner_map["inner_key"] = "inner_value";
    res_map["outer_key"] = inner_map;

    std::map<std::string, std::map<std::string, std::string>> result;
    EXPECT_TRUE(platform_infos->GetPlatformResWithLock(result));
}

// 新增测试：覆盖 SetCoreNumByCoreType 所有分支
TEST_F(PlatFormInfosDefUTest, SetCoreNumByCoreType_AllCoreTypes)
{
    EXPECT_TRUE(platform_infos->Init());

    std::map<std::string, std::string> soc_info;
    soc_info["ai_core_cnt"] = "32";
    soc_info["vector_core_cnt"] = "16";
    soc_info["mix_vector_core_cnt"] = "8";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);

    // 测试 AICore 类型
    platform_infos->SetCoreNumByCoreType("AICore");
    EXPECT_EQ(platform_infos->core_num_, 32);

    // 测试 VectorCore 类型
    platform_infos->SetCoreNumByCoreType("VectorCore");
    EXPECT_EQ(platform_infos->core_num_, 16);

    // 测试 AIV 类型
    platform_infos->SetCoreNumByCoreType("AIV");
    EXPECT_EQ(platform_infos->core_num_, 16);

    // 测试 MIX_AIV 类型
    platform_infos->SetCoreNumByCoreType("MIX_AIV");
    EXPECT_EQ(platform_infos->core_num_, 8);

    // 测试 MIX_VECTOR_CORE 类型
    platform_infos->SetCoreNumByCoreType("MIX_VECTOR_CORE");
    EXPECT_EQ(platform_infos->core_num_, 8);
}

// 新增测试：覆盖 GetLocalMemSize 所有类型
TEST_F(PlatFormInfosDefUTest, GetLocalMemSize_AllTypes)
{
    EXPECT_TRUE(platform_infos->Init());

    std::map<std::string, std::string> core_spec;
    core_spec["l0_a_size"] = "1024";
    core_spec["l0_b_size"] = "2048";
    core_spec["l0_c_size"] = "3072";
    core_spec["l1_size"] = "4096";
    core_spec["ub_size"] = "5120";
    platform_infos->SetPlatformRes("AICoreSpec", core_spec);

    std::map<std::string, std::string> soc_info;
    soc_info["l2_size"] = "6144";
    soc_info["memory_size"] = "7168";
    platform_infos->SetPlatformRes("SoCInfo", soc_info);

    uint64_t size = 0;

    platform_infos->GetLocalMemSize(LocalMemType::L0_A, size);
    platform_infos->GetLocalMemSize(LocalMemType::L0_B, size);
    platform_infos->GetLocalMemSize(LocalMemType::L0_C, size);
    platform_infos->GetLocalMemSize(LocalMemType::L1, size);
    platform_infos->GetLocalMemSize(LocalMemType::L2, size);
    platform_infos->GetLocalMemSize(LocalMemType::UB, size);
    platform_infos->GetLocalMemSize(LocalMemType::HBM, size);
}

// 新增测试：覆盖 GetLocalMemBw 所有类型
TEST_F(PlatFormInfosDefUTest, GetLocalMemBw_AllTypes)
{
    EXPECT_TRUE(platform_infos->Init());

    std::map<std::string, std::string> memory_rates;
    memory_rates["l2_rate"] = "2.0";
    memory_rates["ddr_rate"] = "3.0";
    platform_infos->SetPlatformRes("AICoreMemoryRates", memory_rates);

    uint64_t bw = 0;

    platform_infos->GetLocalMemBw(LocalMemType::L2, bw);
    platform_infos->GetLocalMemBw(LocalMemType::HBM, bw);
}

} // namespace fe