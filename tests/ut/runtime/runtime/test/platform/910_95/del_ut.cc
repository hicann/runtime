/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
TEST_F(ApiDavidTest, AllocTaskInfoForCapture_UpdateTask)
{
    TaskInfo *task = nullptr;
    rtStream_t stream;
    rtError_t error = rtStreamCreate(&stream, 0);
    EXPECT_EQ(error, ACL_RT_SUCCESS);
    error = ((Stream *)stream)->UpdateTaskGroupStatus(StreamTaskGroupStatus::UPDATE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *dstStm = (Stream *)stream;
    uint32_t pos = 0;

    error = AllocTaskInfoForCapture(&task, (Stream *)stream, pos, dstStm);
    EXPECT_EQ(error, RT_ERROR_TASK_NOT_SUPPORT);
    error = AllocTaskInfoForCapture(&task, (Stream *)stream, pos, dstStm, 1, true);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    error = ((Stream *)stream)->UpdateTaskGroupStatus(StreamTaskGroupStatus::NONE);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(stream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(ApiDavidTest, stream_state_callback_reg_notify)
{
    rtError_t error = rtRegStreamStateCallback("test", RegStreamStateCallbackFunc);
    EXPECT_EQ(error, RT_ERROR_NONE);
    rtStream_t stream;
    EXPECT_EQ(rtStreamCreate(&stream, 0), RT_ERROR_NONE);
    EXPECT_EQ(rtStreamDestroy(stream), RT_ERROR_NONE);
    error = rtRegStreamStateCallback("test", nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(StarsTaskTest, ModelExecute_memFree)
{
    rtError_t ret;
    rtModel_t model;
    TaskInfo mdlExecTask = {};
    Stream *headSream;
    ret = rtStreamCreate((rtStream_t*)&headSream, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelCreate(&model, 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = rtModelBindStream(model, headSream, RT_HEAD_STREAM);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    headSream->SetBindFlag(true);

    InitByStream(&mdlExecTask, headSream);
    MOCKER(CheckLogLevel).stubs().will(returnValue(1));
    ret = ModelExecuteTaskInit(&mdlExecTask, (Model *)model, ((Model *)model)->Id_(), 0);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    uint32_t sqeNum = GetSendSqeNum(&mdlExecTask);
    EXPECT_EQ(sqeNum, 1U);

    TaskInfo *task = &mdlExecTask;
    rtStarsSqe_t command[3] = {};
    ToConstructSqe(task, command);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ret = FreeFuncCallHostMemAndSvmMem(task);
    EXPECT_EQ(ret, RT_ERROR_NONE);

    ret = rtModelUnbindStream(model, headSream);
    EXPECT_EQ(ret, ACL_ERROR_RT_INTERNAL_ERROR);
    headSream->DelModel((Model*)model);
    ret = rtStreamDestroy(headSream);
    EXPECT_EQ(ret, RT_ERROR_NONE);
    ((Model*)model)->ModelRemoveStream(headSream);
    ret = rtModelDestroy(model);
    EXPECT_EQ(ret, RT_ERROR_NONE);
}
TEST_F(ApiDCDisableThreadTest, kernel_launch_normal_test)
{
    rtError_t error;
    void *args[] = {&error, NULL};

    // using normal stream
    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, stream_);
    EXPECT_EQ(error, RT_ERROR_NONE);

    // using lite stream
    driver_ = ((Runtime *)Runtime::Instance())->driverFactory_.GetDriver(NPU_DRIVER);
    MOCKER_CPP_VIRTUAL((NpuDriver*)(driver_), &NpuDriver::GetRunMode)
    .stubs()
    .will(returnValue((uint32_t)RT_RUN_MODE_ONLINE));

    rtStream_t liteStream;
    error = rtStreamCreateWithFlags(&liteStream, 0, RT_STREAM_FAST_LAUNCH);
    EXPECT_EQ(error, RT_ERROR_NONE);
    Stream *stm = (Stream*)liteStream;
    EXPECT_EQ(stm->isHasPcieBar_, false);

    error = rtKernelLaunch(&function_, 1, (void *)args, sizeof(args), NULL, liteStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
    error = rtStreamDestroy(liteStream);
    EXPECT_EQ(error, RT_ERROR_NONE);
}