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
#include "mockcpp/ChainingMockHelper.h"
#include "dlopen_stub.h"
#define private public
#define protected public
#include "bqs_so_manager.h"
#undef private
#undef protected

using namespace bqs;


namespace {
const std::string SoFileName = "libtest.so";

void Foo0() {}
void Foo1() {}
}

class BqsSoManagerUTest : public testing::Test {
protected:
    virtual void SetUp()
    {
        const qstest::FuncNamePtrMap funcMap = {
            {"Foo0", reinterpret_cast<void *>(&Foo0)},
            {"Foo1", reinterpret_cast<void *>(&Foo1)},
        };

        qstest::DlopenStub::GetInstance().RegDlopenFuncPtr(SoFileName, funcMap);

        std::cout << "Before BqsSoManagerUTest" << std::endl;
    }

    virtual void TearDown()
    {
        std::cout << "After BqsSoManagerUTest" << std::endl;
        GlobalMockObject::verify();
    }
};

TEST_F(BqsSoManagerUTest, SoManagerInitWithFuncNames)
{
    const std::vector<std::string> funcNames = {"Foo0", "Foo1"};
    MOCKER_DLFCN();
    SoManager manager(SoFileName, funcNames);
    EXPECT_NE(manager.soHandle_, nullptr);
}

TEST_F(BqsSoManagerUTest, OpenSoWithEmptyName)
{
    SoManager manager("");
    EXPECT_EQ(manager.soHandle_, nullptr);
}

TEST_F(BqsSoManagerUTest, GetFuncFromNull)
{
    SoManager manager("");
    EXPECT_EQ(manager.soHandle_, nullptr);
    const auto ret = manager.GetFuncHandle("Foo1");
    EXPECT_EQ(ret, nullptr);
}

TEST_F(BqsSoManagerUTest, DlopenFail)
{
    GlobalMockObject::verify();
    MOCKER(dlopen).stubs().will(returnValue(static_cast<void *>(nullptr)));
    SoManager manager(SoFileName);
    EXPECT_EQ(manager.soHandle_, nullptr);
}

TEST_F(BqsSoManagerUTest, DlsymFail)
{
    GlobalMockObject::verify();
    MOCKER(dlsym).stubs().will(returnValue(static_cast<void *>(nullptr)));
    MOCKER(dlclose).stubs().will(returnValue(0));
    SoManager manager(SoFileName);
    manager.soHandle_ = reinterpret_cast<void*>(0x1);
    const auto ret = manager.GetFuncHandle("Foo1");
    EXPECT_EQ(ret, nullptr);
    manager.soHandle_ = nullptr;
}
