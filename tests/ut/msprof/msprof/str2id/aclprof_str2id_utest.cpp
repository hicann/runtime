/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <cstdint>
#include <limits>
#include <memory>
#include <string>

#include "gtest/gtest.h"
#include "acl/acl_prof.h"
#include "prof_cann_plugin.h"
#include "hash_state.h"

namespace {
constexpr uint64_t ABC_HASH = 363002047600882ULL;
constexpr uint64_t AB_HASH = 12502649811461ULL;

class MSPROF_ACL_STR2ID_UTEST : public testing::Test {
protected:
    static void SetUpTestSuite()
    {
        // The target's $ORIGIN RPATH resolves the real test provider libprofimpl.so.
        // Public initialization loads its real ProfImplReportGetHashId via dlsym.
        ProfAPI::ProfCannPlugin::instance()->ProfApiInit();
    }

    void SetUp() override { savedState_.reset(AclprofStr2IdTest::SaveHashState()); }

    void TearDown() override { savedState_.reset(); }

    void ExpectRegisteredKeys(const std::string& expected)
    {
        std::string keys;
        EXPECT_EQ(AclprofStr2IdTest::ReadRegisteredHashKeys(keys), 0);
        EXPECT_EQ(keys, expected);
    }

private:
    std::unique_ptr<AclprofStr2IdTest::HashState, decltype(&AclprofStr2IdTest::RestoreHashState)> savedState_{
        nullptr, &AclprofStr2IdTest::RestoreHashState};
};

TEST_F(MSPROF_ACL_STR2ID_UTEST, KnownStringComputesHashAndRegistersOriginalText)
{
    // Independent polynomial result: (97*29^2 + 98*29 + 99) << 32
    //                              | (97*131^2 + 98*131 + 99).
    EXPECT_EQ(aclprofStr2Id("abc"), ABC_HASH);
    EXPECT_EQ(AclprofStr2IdTest::ReadHashInfo(ABC_HASH), "abc");
    ExpectRegisteredKeys("abc,");
}

TEST_F(MSPROF_ACL_STR2ID_UTEST, EmptyStringReturnsInvalidIdWithoutRegistration)
{
    EXPECT_EQ(aclprofStr2Id(""), std::numeric_limits<uint64_t>::max());
    ExpectRegisteredKeys("");
}

TEST_F(MSPROF_ACL_STR2ID_UTEST, RepeatedStringReusesIdWithoutDuplicateRegistration)
{
    EXPECT_EQ(aclprofStr2Id("abc"), ABC_HASH);
    EXPECT_EQ(aclprofStr2Id("abc"), ABC_HASH);
    EXPECT_EQ(AclprofStr2IdTest::ReadHashInfo(ABC_HASH), "abc");
    ExpectRegisteredKeys("abc,");
}

TEST_F(MSPROF_ACL_STR2ID_UTEST, DistinctStringsHaveIndependentIdsAndRegistration)
{
    EXPECT_EQ(aclprofStr2Id("ab"), AB_HASH);
    EXPECT_EQ(aclprofStr2Id("abc"), ABC_HASH);
    EXPECT_EQ(AclprofStr2IdTest::ReadHashInfo(AB_HASH), "ab");
    EXPECT_EQ(AclprofStr2IdTest::ReadHashInfo(ABC_HASH), "abc");
    ExpectRegisteredKeys("ab,abc,");
}

TEST_F(MSPROF_ACL_STR2ID_UTEST, CStringTerminatorExcludesTrailingBytes)
{
    const char message[] = {'a', 'b', 'c', '\0', 'x', 'y', '\0'};
    EXPECT_EQ(aclprofStr2Id(message), ABC_HASH);
    EXPECT_EQ(AclprofStr2IdTest::ReadHashInfo(ABC_HASH), "abc");
    ExpectRegisteredKeys("abc,");
}
} // namespace
