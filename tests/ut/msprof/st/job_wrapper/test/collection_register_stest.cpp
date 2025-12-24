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
#include "utils/utils.h"
#include "errno/error_code.h"
#include "collection_register.h"


using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::message;

class UtestCollectionJob : public Analysis::Dvvp::JobWrapper::ICollectionJob
{
public:
    UtestCollectionJob();
    virtual ~UtestCollectionJob();
    int Init(const std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> cfg);
    int Process();
    int Uninit();
};

UtestCollectionJob::UtestCollectionJob()
{
}

UtestCollectionJob::~UtestCollectionJob()
{
}

int UtestCollectionJob::Init(const std::shared_ptr<Analysis::Dvvp::JobWrapper::CollectionJobCfg> cfg)
{
    return PROFILING_SUCCESS;
}

int UtestCollectionJob::Process()
{
    return PROFILING_SUCCESS;
}

int UtestCollectionJob::Uninit()
{
    return PROFILING_SUCCESS;
}

class JOB_WRAPPER_COLLECTION_REGISTRT_UTEST: public testing::Test {
protected:
    virtual void SetUp() {
        
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }

};

TEST_F(JOB_WRAPPER_COLLECTION_REGISTRT_UTEST, CollectionRegisterMgr) {
    Analysis::Dvvp::JobWrapper::CollectionRegisterMgr mgr;
    std::shared_ptr<Analysis::Dvvp::JobWrapper::ICollectionJob> instance = std::make_shared<UtestCollectionJob>();
    //CollectionJobRegisterAndRun param error 
    int ret = mgr.CollectionJobRegisterAndRun(0, Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB, instance);
    EXPECT_EQ(PROFILING_FAILED, ret);
    //CollectionJobRegisterAndRun param error 
    ret = mgr.CollectionJobRegisterAndRun(-1, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB, instance);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = mgr.CollectionJobRegisterAndRun(0, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB, instance);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret = mgr.CollectionJobRegisterAndRun(0, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB, instance);
    EXPECT_EQ(PROFILING_FAILED, ret);

    //CollectionJobUnregisterAndStop param error 
    ret = mgr.CollectionJobUnregisterAndStop(0, Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB);
    EXPECT_EQ(PROFILING_FAILED, ret);
    //CollectionJobUnregisterAndStop param error 
    ret = mgr.CollectionJobUnregisterAndStop(-1, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB);
    EXPECT_EQ(PROFILING_FAILED, ret);

    ret = mgr.CollectionJobUnregisterAndStop(0, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    //delete the job and register
    ret = mgr.CollectionJobRegisterAndRun(0, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB, instance);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    //stop the job and unregister
    ret = mgr.CollectionJobUnregisterAndStop(0, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB);
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    //stop the job and unregister
    ret = mgr.CollectionJobUnregisterAndStop(0, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB);
    EXPECT_EQ(PROFILING_FAILED, ret);

    //CheckCollectionJobIsNoRegister param error 
    int a = 0;
    bool rets = mgr.CheckCollectionJobIsNoRegister(a, Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB);
    EXPECT_EQ(false, rets);
    //CheckCollectionJobIsNoRegister param error 
    a = -1;
    rets = mgr.CheckCollectionJobIsNoRegister(a, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB);
    EXPECT_EQ(false, rets);

    //InsertCollectionJob param error 
    rets = mgr.InsertCollectionJob(0, Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB, instance);
    EXPECT_EQ(false, rets);
    //InsertCollectionJob param error 
    rets = mgr.InsertCollectionJob(-1, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB, instance);
    EXPECT_EQ(false, rets);

    //GetAndDelCollectionJob param error 
    rets = mgr.GetAndDelCollectionJob(0, Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB, instance);
    EXPECT_EQ(false, rets);
    //GetAndDelCollectionJob param error 
    rets = mgr.GetAndDelCollectionJob(-1, Analysis::Dvvp::JobWrapper::DDR_DRV_COLLECTION_JOB, instance);
    EXPECT_EQ(false, rets);
}

TEST_F(JOB_WRAPPER_COLLECTION_REGISTRT_UTEST, CollectionJobRun) {
    Analysis::Dvvp::JobWrapper::CollectionRegisterMgr mgr;
    std::shared_ptr<Analysis::Dvvp::JobWrapper::ICollectionJob> instance = std::make_shared<UtestCollectionJob>();
    EXPECT_EQ(PROFILING_FAILED, mgr.CollectionJobRun(0, Analysis::Dvvp::JobWrapper::NR_MAX_COLLECTION_JOB));
    mgr.CollectionJobRegisterAndRun(0, Analysis::Dvvp::JobWrapper::AICPU_COLLECTION_JOB, instance);
    EXPECT_EQ(PROFILING_SUCCESS, mgr.CollectionJobRun(0, Analysis::Dvvp::JobWrapper::AICPU_COLLECTION_JOB));
}