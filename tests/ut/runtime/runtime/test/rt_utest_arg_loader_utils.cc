/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "arg_loader_utils.hpp"
#include "base.hpp"

using namespace cce::runtime;

TEST(ArgLoaderUtilsTest, HostInputRequiresCompleteAddressField)
{
    uint64_t buffer[3] = {11U, 22U, 33U};
    rtHostInputInfo_t inputs[2] = {{0U, 0U}, {16U, 0U}};
    rtArgsEx_t args{};
    args.args = buffer;
    args.argsSize = sizeof(buffer);
    args.hostInputInfoNum = 2U;
    args.hostInputInfoPtr = inputs;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_NONE);

    inputs[1].addrOffset = 17U;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
    inputs[1].addrOffset = UINT32_MAX;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
    args.argsSize = 7U;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
    args.hostInputInfoPtr = nullptr;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
}

TEST(ArgLoaderUtilsTest, TilingRequiresCompleteAddressField)
{
    rtArgsEx_t args{};
    args.argsSize = 24U;
    args.hasTiling = 1U;
    args.tilingAddrOffset = 16U;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_NONE);
    args.tilingAddrOffset = 17U;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
    args.tilingAddrOffset = UINT32_MAX;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
    args.tilingAddrOffset = 0U;
    args.argsSize = 7U;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_INVALID_VALUE);
    args.hasTiling = 0U;
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_NONE);
}

TEST(ArgLoaderUtilsTest, AicpuChecksHostInputAndKernelOffsetFields)
{
    rtHostInputInfo_t input{16U, 0U};
    rtHostInputInfo_t kernelOffset{16U, 0U};
    rtAicpuArgsEx_t cpu{};
    cpu.argsSize = 24U;
    cpu.hostInputInfoNum = 1U;
    cpu.hostInputInfoPtr = &input;
    cpu.kernelOffsetInfoNum = 1U;
    cpu.kernelOffsetInfoPtr = &kernelOffset;
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_NONE);

    input.addrOffset = 17U;
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_INVALID_VALUE);
    input.addrOffset = 16U;
    cpu.hostInputInfoPtr = nullptr;
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_INVALID_VALUE);
    cpu.hostInputInfoPtr = &input;
    kernelOffset.addrOffset = 17U;
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_INVALID_VALUE);
    kernelOffset.addrOffset = UINT32_MAX;
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_INVALID_VALUE);
    cpu.kernelOffsetInfoPtr = nullptr;
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_INVALID_VALUE);
}

TEST(ArgLoaderUtilsTest, FusionRequiresCompleteHostInputAddressField)
{
    rtHostInputInfo_t input{16U, 0U};
    rtFusionArgsEx_t fusion{};
    fusion.argsSize = 24U;
    fusion.hostInputInfoNum = 1U;
    fusion.hostInputInfoPtr = &input;
    EXPECT_EQ(CheckArgsAddressFields(&fusion), RT_ERROR_NONE);

    input.addrOffset = 17U;
    EXPECT_EQ(CheckArgsAddressFields(&fusion), RT_ERROR_INVALID_VALUE);
    input.addrOffset = UINT32_MAX;
    EXPECT_EQ(CheckArgsAddressFields(&fusion), RT_ERROR_INVALID_VALUE);
    input.addrOffset = 0U;
    fusion.argsSize = 7U;
    EXPECT_EQ(CheckArgsAddressFields(&fusion), RT_ERROR_INVALID_VALUE);
    fusion.hostInputInfoPtr = nullptr;
    EXPECT_EQ(CheckArgsAddressFields(&fusion), RT_ERROR_INVALID_VALUE);
}

TEST(ArgLoaderUtilsTest, EmptyMetadataDoesNotRequireAddressFields)
{
    rtArgsEx_t args{};
    rtAicpuArgsEx_t cpu{};
    rtFusionArgsEx_t fusion{};
    EXPECT_EQ(CheckArgsAddressFields(&args), RT_ERROR_NONE);
    EXPECT_EQ(CheckArgsAddressFields(&cpu), RT_ERROR_NONE);
    EXPECT_EQ(CheckArgsAddressFields(&fusion), RT_ERROR_NONE);
}
