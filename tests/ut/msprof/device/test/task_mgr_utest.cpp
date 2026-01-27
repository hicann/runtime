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
#include <memory>
#include "securec.h"
#include "errno/error_code.h"
#include "task_manager.h"
#include "collection_entry.h"

using namespace analysis::dvvp::common::error;

class TASK_MGR_TEST: public testing::Test {
protected:
    virtual void SetUp() {
        HDC_SESSION session = (HDC_SESSION)0x12345678;
        _transport = std::shared_ptr<analysis::dvvp::transport::HDCTransport>(
            new analysis::dvvp::transport::HDCTransport(session));
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
        _transport.reset();
    }
public:
    std::shared_ptr<analysis::dvvp::transport::HDCTransport> _transport;
};

TEST_F(TASK_MGR_TEST, Init) {
    auto taskMgr = analysis::dvvp::device::TaskManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
}

TEST_F(TASK_MGR_TEST, init1) {
    analysis::dvvp::device::TaskManager taskMgr;
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr.Init());
}


TEST_F(TASK_MGR_TEST, Uninit) {

    MOCKER_CPP(&analysis::dvvp::device::TaskManager::ClearTask)
        .stubs();

    auto taskMgr = analysis::dvvp::device::TaskManager::instance();
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Uninit());
}

TEST_F(TASK_MGR_TEST, ClearTask) {

    auto taskMgr = analysis::dvvp::device::TaskManager::instance();
    
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
    auto task = taskMgr->CreateTask(0, "0x123456789", _transport);
    MOCKER_CPP_VIRTUAL(task.get(), &analysis::dvvp::device::ProfJobHandler::OnConnectionReset)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Uninit());
}

TEST_F(TASK_MGR_TEST, ConnectionReset) {

    auto taskMgr = analysis::dvvp::device::TaskManager::instance();
    
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
    auto task = taskMgr->CreateTask(0, "0x123456789", _transport);
    MOCKER_CPP_VIRTUAL(task.get(), &analysis::dvvp::device::ProfJobHandler::OnConnectionReset)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    taskMgr->ConnectionReset(nullptr);
    taskMgr->ConnectionReset(_transport);
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Uninit());
}

TEST_F(TASK_MGR_TEST, CreateTask) {

    auto taskMgr = analysis::dvvp::device::TaskManager::instance();

    //not inited
    auto task = taskMgr->CreateTask(0, "0x123456789", _transport);
    EXPECT_TRUE(task == nullptr);

    //task init failed
    MOCKER_CPP(&analysis::dvvp::device::ProfJobHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
    task = taskMgr->CreateTask(0, "0x123456789", _transport);
    EXPECT_TRUE(task == nullptr);

    task = taskMgr->CreateTask(0, "0x123456789", _transport);
    EXPECT_TRUE(task != nullptr);
    task = taskMgr->CreateTask(0, "0x123456789", _transport);
    EXPECT_TRUE(task == nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Uninit());
}

TEST_F(TASK_MGR_TEST, CreateTaskForNull) {

    auto taskMgr = analysis::dvvp::device::TaskManager::instance();

    //not inited
    auto task = taskMgr->CreateTask(0, "0x123456789", nullptr);
    EXPECT_TRUE(task == nullptr);
}

TEST_F(TASK_MGR_TEST, GetTask) {
    auto taskMgr = analysis::dvvp::device::TaskManager::instance();

    //not inited
    auto task = taskMgr->GetTask("0x123456789");
    EXPECT_TRUE(task == nullptr);

    //task init failed
    MOCKER_CPP(&analysis::dvvp::device::ProfJobHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
    task = taskMgr->CreateTask(0, "0x123456789", _transport);
    EXPECT_TRUE(task != nullptr);
    
    task = taskMgr->GetTask("0x123456789");
    EXPECT_TRUE(task != nullptr);
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Uninit());
}

TEST_F(TASK_MGR_TEST, DeleteTask) {
    auto taskMgr = analysis::dvvp::device::TaskManager::instance();
    
    //not inited
    bool flag = taskMgr->DeleteTask("0x123456789");
    EXPECT_TRUE(flag == false);


    //task init failed
    MOCKER_CPP(&analysis::dvvp::device::ProfJobHandler::Init)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Init());
    auto task = taskMgr->CreateTask(0, "0x123456789", _transport);
    EXPECT_TRUE(task != nullptr);
    
    flag = taskMgr->DeleteTask("0x123456789");
    EXPECT_TRUE(flag == true);
    flag = taskMgr->DeleteTask("0x123456789");
    EXPECT_TRUE(flag == false);
    EXPECT_EQ(PROFILING_SUCCESS, taskMgr->Uninit());
}

