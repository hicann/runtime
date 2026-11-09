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
#define private public
#include "runtime.hpp"
#include "program.hpp"
#undef private
#include "kernel.hpp"
#include "kernel_utils.hpp"
#include "task_info.hpp"
#include "thread_local_container.hpp"
#include "para_convertor.hpp"
#include "args_buffer_guard.hpp"
#include "args_handle_allocator.hpp"

using namespace testing;
using namespace cce::runtime;

class KernelTest : public testing::Test {
protected:
    static void SetUpTestCase() {}

    static void TearDownTestCase() {}

    virtual void SetUp() {}

    virtual void TearDown() { GlobalMockObject::verify(); }
};

TEST_F(KernelTest, kernel_create)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun1;
    Kernel* k1 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    k1->SetStub_(&fun1);

    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ((Program*)k1->Program_(), program);

    delete k1;
}

TEST_F(KernelTest, kernel_create_second)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun1;
    Kernel* k1 = new Kernel("f1", 1, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    k1->SetStub_(&fun1);

    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ(k1->TilingKey(), 1);
    EXPECT_EQ((Program*)k1->Program_(), program);

    delete k1;
}

TEST_F(KernelTest, kernel_create_third)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun1;
    Kernel* k1 = new Kernel("f1", 1, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    k1->SetStub_(&fun1);
    k1->SetMixType(3);
    k1->SetOffset2(11);
    EXPECT_EQ(k1->Name_(), "f1");
    EXPECT_EQ(k1->Stub_(), &fun1);
    EXPECT_EQ(k1->Offset_(), 10);
    EXPECT_EQ(k1->TilingKey(), 1);
    EXPECT_EQ(k1->Offset2_(), 11);
    EXPECT_EQ(k1->GetMixType(), 3);
    EXPECT_EQ((Program*)k1->Program_(), program);

    delete k1;
}

TEST_F(KernelTest, kernel_lookup)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun1, fun2;

    MOCKER_CPP(&Runtime::GetProgram).stubs().will(returnValue(true));

    Kernel* k1 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    Kernel* k2 = new Kernel("f2", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    k1->SetStub_(&fun1);
    k2->SetStub_(&fun2);

    error = table.Add(k1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.Add(k2);
    EXPECT_EQ(error, RT_ERROR_NONE);
    auto& str = program->GetKernelNamesBuffer();
    const Kernel* kernel;

    kernel = table.Lookup(&fun1);
    EXPECT_EQ(kernel, k1);

    kernel = table.Lookup(&fun2);
    EXPECT_EQ(kernel, k2);
}

TEST_F(KernelTest, kernel_remove)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun1, fun2;

    Kernel* k1 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    Kernel* k2 = new Kernel("f2", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    k1->SetStub_(&fun1);
    k2->SetStub_(&fun2);

    error = table.Add(k1);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.Add(k2);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.RemoveAll(program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    const Kernel* kernel;

    kernel = table.Lookup(&fun1);
    EXPECT_EQ(kernel, (const Kernel*)NULL);

    kernel = table.Lookup(&fun2);
    EXPECT_EQ(kernel, (const Kernel*)NULL);
}

TEST_F(KernelTest, kernel_table_destroy_releases_remaining_kernels)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    KernelTable* table = new KernelTable();
    int32_t fun1, fun2;

    Kernel* k1 = new Kernel("destroy_f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    Kernel* k2 = new Kernel("destroy_f2", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    k1->SetStub_(&fun1);
    k2->SetStub_(&fun2);

    EXPECT_EQ(table->Add(k1), RT_ERROR_NONE);
    EXPECT_EQ(table->Add(k2), RT_ERROR_NONE);

    delete table;
    SUCCEED();
}

TEST_F(KernelTest, kernel_alloc_kernel_arr)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun[2049], f[2049];
    Kernel* k[2049];

    for (int i = 0; i < 2049; i++) {
        k[i] = new Kernel("f[i]", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
        k[i]->SetStub_(&fun[i]);

        error = table.Add(k[i]);
        EXPECT_EQ(error, RT_ERROR_NONE);
    }

    error = table.AllocKernelArr();
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelTest, kernel_all_kernel_add)
{
    rtError_t error;
    KernelTable table;

    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;

    PlainProgram stubProg2(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program2 = &stubProg2;
    uint64_t key1 = 1U;
    uint64_t key2 = 2U;
    Kernel* k1 = new Kernel("", key1, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    Kernel* k2 = new Kernel("", key2, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    Kernel* k3 = new Kernel("", key1, program2, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    bool addKernelFlag = true;

    program->kernelCount_ = 2;
    program2->kernelCount_ = 1;
    if (program->KernelTable_ == nullptr) {
        program->KernelTable_ = new rtKernelArray_t[program->kernelCount_];
    }

    if (program2->KernelTable_ == nullptr) {
        program2->KernelTable_ = new rtKernelArray_t[program2->kernelCount_];
    }

    error = program->AllKernelAdd(k1, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = program->AllKernelAdd(k1, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = program2->AllKernelAdd(k3, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    MOCKER_CPP(&Runtime::GetProgram).stubs().will(returnValue(true));

    const Kernel* kernel;
    kernel = program->AllKernelLookup(1);
    EXPECT_NE(kernel, (const Kernel*)NULL);

    error = program->AllKernelAdd(k2, addKernelFlag);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.RemoveAll(program);
    EXPECT_EQ(error, RT_ERROR_NONE);

    error = table.RemoveAll(program2);
    EXPECT_EQ(error, RT_ERROR_NONE);
}

TEST_F(KernelTest, kernel_info_extern_lookup)
{
    rtError_t error;
    KernelTable table;
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    int32_t fun1, fun2;

    MOCKER_CPP(&Runtime::GetProgram).stubs().will(returnValue(true));
    Kernel* k1 = new Kernel("f1", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    error = table.Add(k1);
    const char_t* const stubFunc = "test";
    const Kernel* tempKernel = table.KernelInfoExtLookup(stubFunc);
    EXPECT_EQ(tempKernel, nullptr);
}

TEST_F(KernelTest, Kernel_ParamInfo_GetParamInfo_Success)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(2);
    kernel->SetParamInfos(paramInfos);

    uint32_t offset = 0;
    uint32_t size = 0;
    rtError_t error = kernel->GetParamInfo(0, &offset, &size);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(offset, 0);
    EXPECT_EQ(size, 16);

    error = kernel->GetParamInfo(1, &offset, &size);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(offset, 16);
    EXPECT_EQ(size, 32);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_GetParamInfo_InvalidIndex)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[1]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(1);
    kernel->SetParamInfos(paramInfos);

    uint32_t offset = 0;
    uint32_t size = 0;
    rtError_t error = kernel->GetParamInfo(2, &offset, &size);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_GetParamInfo_NoParamInfo)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetHasParamSummary(false);
    kernel->SetParamCount(0);

    uint32_t offset = 0;
    uint32_t size = 0;
    rtError_t error = kernel->GetParamInfo(0, &offset, &size);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_GetParamInfo_NullptrParamInfos)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(1);
    kernel->SetParamInfos(std::shared_ptr<ElfParamInfo[]>());

    uint32_t offset = 0;
    uint32_t size = 0;
    rtError_t error = kernel->GetParamInfo(0, &offset, &size);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_GetParamInfo_NullptrOutput)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[1]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(1);
    kernel->SetParamInfos(paramInfos);

    rtError_t error = kernel->GetParamInfo(0, nullptr, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);

    uint32_t offset = 0;
    error = kernel->GetParamInfo(0, &offset, nullptr);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(offset, 0);

    uint32_t size = 0;
    error = kernel->GetParamInfo(0, nullptr, &size);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(size, 16);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_CopyParamsToBuffer_Success)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(2);
    kernel->SetParamInfos(paramInfos);

    char src1[16] = {0};
    char src2[32] = {0};
    void* argsArray[2] = {src1, src2};
    char dest[48] = {0};

    rtError_t error = CopyKernelParamsToBuffer(kernel, argsArray, dest);
    EXPECT_EQ(error, RT_ERROR_NONE);

    delete kernel;
}

// M1（b043e8fb1）：CopyKernelParamsToBuffer 新增的 outArgsArray 回填分支。
// 回填值必须是 dest 内该参数的目标地址（dest + paramInfo.offset），调用方
// CreateArgsArrayBlock 据此把 placeHolder 表指向 block 内部；故除地址外还校验
// 经回填指针读到的就是刚拷入的数据。
TEST_F(KernelTest, Kernel_ParamInfo_CopyParamsToBuffer_BackfillsOutArgsArray)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(2);
    kernel->SetParamInfos(paramInfos);

    char src1[16] = {0};
    char src2[32] = {0};
    (void)memset_s(src1, sizeof(src1), 0xA1, sizeof(src1));
    (void)memset_s(src2, sizeof(src2), 0xB2, sizeof(src2));
    void* argsArray[2] = {src1, src2};
    char dest[48] = {0};
    void* outArgsArray[2] = {nullptr, nullptr};

    rtError_t error = CopyKernelParamsToBuffer(kernel, argsArray, dest, outArgsArray);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(outArgsArray[0], static_cast<void*>(dest));
    EXPECT_EQ(outArgsArray[1], static_cast<void*>(dest + 16));
    EXPECT_EQ(static_cast<unsigned char*>(outArgsArray[0])[0], 0xA1U);
    EXPECT_EQ(static_cast<unsigned char*>(outArgsArray[1])[0], 0xB2U);

    delete kernel;
}

// 入口空指针守卫：kernel/argsArray/dest 任一为空即返回 RT_ERROR_INVALID_VALUE，
// 且不得因 outArgsArray 非空而先行回填。
TEST_F(KernelTest, Kernel_ParamInfo_CopyParamsToBuffer_NullEntryGuard)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    char src[16] = {0};
    void* argsArray[1] = {src};
    char dest[16] = {0};
    void* outArgsArray[1] = {nullptr};

    EXPECT_EQ(CopyKernelParamsToBuffer(nullptr, argsArray, dest, outArgsArray), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(CopyKernelParamsToBuffer(kernel, nullptr, dest, outArgsArray), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(CopyKernelParamsToBuffer(kernel, argsArray, nullptr, outArgsArray), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(outArgsArray[0], nullptr);

    delete kernel;
}

// §14.14（690bfe0cd）：GetKernelTaskParams 删除 fallback 分支后，缺缓存必须报 EE1004，
// 不得再从 H2D 后的设备缓冲区合成答案（那会把 funcHandle 报成 GetInnerHandle()、
// argsType 强制成 DEVICE_BUFFER）。唯一可达触发是 DEFAULT_TILING_KEY：
// stream_c.cc:66-72 令 registeredKernel = nullptr 且成功返回，SetKernelLaunchParams 因而不建缓存。
TEST_F(KernelTest, Kernel_TaskParams_GetKernelTaskParams_NoCacheReportsInvalidValue)
{
    TaskInfo taskInfo{};
    rtTaskParams params{};

    // 子情形一：launch 未建缓存，updateInfo 为空
    taskInfo.updateInfo = nullptr;
    EXPECT_EQ(GetKernelTaskParams(&taskInfo, &params), RT_ERROR_INVALID_VALUE);
    // 守卫必须在写 params->type 之前返回：merge-base 的实现在函数首行就置 RT_TASK_KERNEL，
    // 再走 fallback 合成答案；此断言即钉住"上报而非合成"，并保证失败时出参不被部分改写
    EXPECT_EQ(params.type, RT_TASK_DEFAULT);

    // 子情形二：updateInfo 已分配但尚未 publish（isValid != 1）
    TaskUpdateInfo updateInfo{};
    updateInfo.latestParams.isValid = 0U;
    taskInfo.updateInfo = &updateInfo;
    EXPECT_EQ(GetKernelTaskParams(&taskInfo, &params), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(params.type, RT_TASK_DEFAULT);
}

// §14.14：SIMT 形态同一守卫。本函数为 PR 全新增加（merge-base 无），故此处钉的是新代码契约。
// 注释已说明 SIMT 侧连"无缓存"都不可达（SetSimtTaskParams 是 simtParamOffset 的唯一写者，
// 且每次 SIMT launch 都经 StreamLaunchKernelV2 在入口解引用 kernel），因此只验证守卫不被绕过。
TEST_F(KernelTest, Kernel_TaskParams_GetSimtKernelTaskParams_NoCacheReportsInvalidValue)
{
    TaskInfo taskInfo{};
    rtTaskParams params{};

    taskInfo.updateInfo = nullptr;
    EXPECT_EQ(GetSimtKernelTaskParams(&taskInfo, &params), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(params.type, RT_TASK_DEFAULT);

    TaskUpdateInfo updateInfo{};
    updateInfo.latestParams.isValid = 0U;
    taskInfo.updateInfo = &updateInfo;
    EXPECT_EQ(GetSimtKernelTaskParams(&taskInfo, &params), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(params.type, RT_TASK_DEFAULT);
}

// CacheSimtKernelTaskParams 是 aclmdlRITaskSetParams 的 SIMT 缓存装配入口。
// 其成功路径末尾的 CommitKernelUpdateInfo 无条件解引用 taskInfo->stream 并 dynamic_cast 成
// CaptureModel，且假定 updateInfo 已由调用方（api_impl_standard_soc.cc:1295）分配，故成功路径
// 只能由 910B 捕获态 E2E 覆盖。此处直调覆盖三个入口守卫，以及 ARRAY 形态从装配到
// CacheArgsArrayForm 失败返回的完整链路（该链路在触及 stream 之前就已返回）。
TEST_F(KernelTest, Kernel_TaskParams_CacheSimtKernelTaskParams_GuardsAndArrayForm)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(2);
    kernel->SetParamInfos(paramInfos);
    // 非零才会越过 CacheArgsArrayForm 的零参数短路，进入 CreateArgsArrayBlock
    kernel->SetParamTotalSize(48ULL);

    TaskInfo taskInfo{};
    rtTaskParams params{};
    params.type = RT_TASK_SIMT_KERNEL;

    // 守卫一：CheckCacheKernelTaskCommon 要求任务类型是 AICORE 或 AIVEC
    taskInfo.type = TS_TASK_TYPE_CAPTURE_WAIT;
    EXPECT_EQ(CacheSimtKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // 守卫二：CheckCacheKernelTaskCommon 要求 params->taskGrp 为空
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    int taskGrp = 0;
    params.taskGrp = &taskGrp;
    EXPECT_EQ(CacheSimtKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    params.taskGrp = nullptr;

    // 守卫三：目标任务必须是纯 SIMT 任务（simtParamOffset != 0）
    taskInfo.u.aicTaskInfo.simtParamOffset = 0U;
    EXPECT_EQ(CacheSimtKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    taskInfo.u.aicTaskInfo.simtParamOffset = 64U;

    // 守卫四：kernel 为空
    EXPECT_EQ(CacheSimtKernelTaskParams(&taskInfo, &params, nullptr), RT_ERROR_INVALID_VALUE);

    // ARRAY 形态装配：cfg 允许为空（ConvertLaunchCfgToTaskCfg 显式支持），
    // argsArray[0] 为空使 CopyKernelParamsToBuffer 报 EE1004，CreateArgsArrayBlock
    // 随即释放已分配的块并返回，故不泄漏也不触及 stream
    void* argsArray[2] = {nullptr, nullptr};
    params.simtKernelTaskParams.func = kernel;
    params.simtKernelTaskParams.cfg = nullptr;
    params.simtKernelTaskParams.gridDimX = 2U;
    params.simtKernelTaskParams.gridDimY = 3U;
    params.simtKernelTaskParams.gridDimZ = 1U;
    params.simtKernelTaskParams.blockDimX = 32U;
    params.simtKernelTaskParams.blockDimY = 1U;
    params.simtKernelTaskParams.blockDimZ = 1U;
    params.simtKernelTaskParams.dynUbufSize = 128U;
    params.simtKernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;
    params.simtKernelTaskParams.argsArray = argsArray;
    EXPECT_EQ(CacheSimtKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    // 装配失败不得发布缓存
    EXPECT_EQ(taskInfo.updateInfo, nullptr);

    delete kernel;
}

// CacheKernelTaskParams 是 aclmdlRITaskSetParams 的非 SIMT 缓存装配入口，与 SIMT 版同样
// 只在成功路径末尾的 CommitKernelUpdateInfo 才需要真实 stream/CaptureModel，故此处直调
// 覆盖全部入口守卫与两种 args 形态的校验链（均在触及 stream 之前返回）。
TEST_F(KernelTest, Kernel_TaskParams_CacheKernelTaskParams_GuardsAndArgsForms)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(2);
    kernel->SetParamInfos(paramInfos);
    kernel->SetParamTotalSize(48ULL);

    TaskInfo taskInfo{};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    rtTaskParams params{};
    params.type = RT_TASK_KERNEL;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;

    // 入口守卫：kernel 为空
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, nullptr), RT_ERROR_INVALID_VALUE);

    // argsType 为 0 时按旧形态解释三字段；此处三字段全空，由还原后的 args 判空守卫
    // 按历史行为报 EE1004（而非 argsType 域错误）
    params.kernelTaskParams.argsType = static_cast<rtKernelArgsType>(0);
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_ARRAY;

    // ARRAY 形态：AICPU 注册类型不支持
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_CPU);
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_FEATURE_NOT_SUPPORT);
    kernel->SetKernelRegisterType(RT_KERNEL_REG_TYPE_NON_CPU);

    // ARRAY 形态：paramCount > 0 时 argsArray 不得为空
    params.kernelTaskParams.argsArray = nullptr;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // ARRAY 形态：kernel 缺参数描述信息
    kernel->SetHasParamSummary(false);
    char src[16] = {0};
    void* argsArray[2] = {src, src};
    params.kernelTaskParams.argsArray = argsArray;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    kernel->SetHasParamSummary(true);

    // ARRAY 形态：装配时 argsArray[0] 为空使 CopyKernelParamsToBuffer 报错，
    // CreateArgsArrayBlock 释放已分配的块后返回，故不泄漏也不触及 stream
    void* badArgsArray[2] = {nullptr, nullptr};
    params.kernelTaskParams.argsArray = badArgsArray;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(taskInfo.updateInfo, nullptr);

    // HOST_BUFFER 形态：hostArgs 为空
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    params.kernelTaskParams.hostBuffer.hostArgs = nullptr;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // HOST_BUFFER 形态：hostArgsSize 为 0
    char hostArgs[32] = {0};
    params.kernelTaskParams.hostBuffer.hostArgs = hostArgs;
    params.kernelTaskParams.hostBuffer.hostArgsSize = 0U;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // HOST_BUFFER 形态：placeHolderNum > 0 但数组为空
    params.kernelTaskParams.hostBuffer.hostArgsSize = sizeof(hostArgs);
    params.kernelTaskParams.hostBuffer.placeHolderNum = 1U;
    params.kernelTaskParams.hostBuffer.placeHolderArray = nullptr;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // HOST_BUFFER 形态：placeHolder 偏移越界，CheckPlaceHolderOffsets 报错
    rtPlaceHolderInfo_t placeHolder{};
    placeHolder.addrOffset = 64U;
    placeHolder.dataOffset = 0U;
    params.kernelTaskParams.hostBuffer.placeHolderArray = &placeHolder;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // dataOffset 越界同样被拒
    placeHolder.addrOffset = 0U;
    placeHolder.dataOffset = 64U;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);
    EXPECT_EQ(taskInfo.updateInfo, nullptr);

    // HOST_BUFFER 形态：placeHolder 偏移合法，但 memcpy_s 失败使深拷贝报错，经 HOST_BUFFER
    // 错误分支返回，不触及 stream。此处同时充当"argsType 是形态判别位"的鉴别断言：故意让遗留
    // 三字段非零（GetParams 会回填它们，故 Get→改→Set 往返必然如此），若遗留字段仍被拒绝会得到
    // INVALID_VALUE，实际拿到 SEC_HANDLE 即证明确实走进了 HOST_BUFFER 深拷贝、遗留字段被忽略
    placeHolder.addrOffset = 8U;
    placeHolder.dataOffset = 16U;
    params.kernelTaskParams.args = hostArgs;
    params.kernelTaskParams.isHostArgs = 1U;
    params.kernelTaskParams.argsSize = sizeof(hostArgs);
    MOCKER(memcpy_s).stubs().will(returnValue(1));
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_SEC_HANDLE);
    EXPECT_EQ(taskInfo.updateInfo, nullptr);

    delete kernel;
}

// 旧形态（args/isHostArgs/argsSize）的入口守卫：argsType 为 0 时按历史版本解释三字段，
// 校验顺序与错误码与历史实现逐字一致。成功路径末尾的 CommitKernelUpdateInfo 会解引用
// taskInfo->stream 并 dynamic_cast 成 CaptureModel，故成功路径由 910B 捕获态用例覆盖，
// 此处只覆盖在触及 stream 之前就返回的守卫。
TEST_F(KernelTest, Kernel_TaskParams_CacheKernelTaskParams_LegacyArgsFormGuards)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    TaskInfo taskInfo{};
    taskInfo.type = TS_TASK_TYPE_KERNEL_AICORE;
    rtTaskParams params{};
    params.type = RT_TASK_KERNEL;
    // argsType 保持 0，即旧形态

    // 全空输入：历史行为是按 args 判空报 EE1004，不是 argsType 域错误
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // args 为空
    params.kernelTaskParams.argsSize = 16U;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // argsSize 为 0
    char legacyArgs[16] = {0};
    params.kernelTaskParams.args = legacyArgs;
    params.kernelTaskParams.argsSize = 0U;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // argsType 是判别位：非零时遗留三字段被忽略而非拒绝。此处 argsType 为 HOST_BUFFER 而
    // hostBuffer.hostArgs 为空，报的是 HOST_BUFFER 形态自身的守卫，与遗留字段取值无关
    params.kernelTaskParams.argsSize = sizeof(legacyArgs);
    params.kernelTaskParams.isHostArgs = 1U;
    params.kernelTaskParams.argsType = RT_KERNEL_ARGS_HOST_BUFFER;
    params.kernelTaskParams.hostBuffer.hostArgs = nullptr;
    EXPECT_EQ(CacheKernelTaskParams(&taskInfo, &params, kernel), RT_ERROR_INVALID_VALUE);

    // 任一守卫失败都不得发布缓存
    EXPECT_EQ(taskInfo.updateInfo, nullptr);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_CopyParamsToBuffer_GetParamInfoFailure)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetHasParamSummary(false);
    kernel->SetParamCount(1);

    char src[16] = {0};
    void* argsArray[1] = {src};
    char dest[16] = {0};

    rtError_t error = CopyKernelParamsToBuffer(kernel, argsArray, dest);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_CopyParamsToBuffer_MemcpyFailure)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[1]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(1);
    kernel->SetParamInfos(paramInfos);

    char src[16] = {0};
    void* argsArray[1] = {src};
    char dest[16] = {0};

    MOCKER(memcpy_s).stubs().will(returnValue(1));
    rtError_t error = CopyKernelParamsToBuffer(kernel, argsArray, dest);
    EXPECT_EQ(error, RT_ERROR_SEC_HANDLE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_CopyParamsToBuffer_NullArrayElement)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetHasParamSummary(true);
    kernel->SetParamCount(1);

    void* argsArray[1] = {nullptr};
    char dest[16] = {0};

    rtError_t error = CopyKernelParamsToBuffer(kernel, argsArray, dest);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_SetAndGetParamTotalSize)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetParamTotalSize(128);
    uint64_t size = kernel->GetParamTotalSize();
    EXPECT_EQ(size, 128);

    kernel->SetParamTotalSize(256);
    size = kernel->GetParamTotalSize();
    EXPECT_EQ(size, 256);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_SetAndGetParamCount)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetParamCount(5);
    uint32_t count = kernel->GetParamCount();
    EXPECT_EQ(count, 5);

    kernel->SetParamCount(10);
    count = kernel->GetParamCount();
    EXPECT_EQ(count, 10);

    delete kernel;
}

TEST_F(KernelTest, Kernel_ParamInfo_SetAndGetHasParamSummary)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;
    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);

    kernel->SetHasParamSummary(true);
    bool hasInfo = kernel->HasParamSummary();
    EXPECT_TRUE(hasInfo);

    kernel->SetHasParamSummary(false);
    hasInfo = kernel->HasParamSummary();
    EXPECT_FALSE(hasInfo);

    delete kernel;
}

// ConvertArgsArrayToArgsEx tests
TEST(ParaConvertorTest, ConvertArgsArrayToArgsEx_ZeroSize)
{
    PlainProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("test", 0ULL, &program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    kernel.SetParamTotalSize(0);

    void* argsArray[2] = {(void*)0x10, (void*)0x20};
    rtArgsEx_t argsEx = {};

    rtError_t error = ConvertArgsArrayToArgsEx(argsEx, &kernel, argsArray);

    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(argsEx.args, nullptr);
    EXPECT_EQ(argsEx.argsSize, 0U);
    EXPECT_EQ(argsEx.isNoNeedH2DCopy, 1U);
}

TEST(ParaConvertorTest, ConvertArgsArrayToArgsEx_CopyParamsFail)
{
    PlainProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("test", 0ULL, &program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    kernel.SetParamTotalSize(48);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(2);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel.SetParamInfos(paramInfos);

    char src[16] = {0};
    void* argsArray[2] = {src, nullptr}; // argsArray[1]为nullptr会导致CopyParams失败

    rtArgsEx_t argsEx = {};

    rtError_t error = ConvertArgsArrayToArgsEx(argsEx, &kernel, argsArray);

    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);
}

TEST(ParaConvertorTest, ConvertArgsArrayToArgsEx_Success)
{
    PlainProgram program(RT_KERNEL_ATTR_TYPE_AICORE);
    Kernel kernel("test", 0ULL, &program, RT_KERNEL_ATTR_TYPE_AICORE, 10);
    kernel.SetParamTotalSize(48);
    kernel.SetHasParamSummary(true);
    kernel.SetParamCount(2);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel.SetParamInfos(paramInfos);

    char src1[16] = {1};
    char src2[32] = {2};
    void* argsArray[2] = {src1, src2};
    rtArgsEx_t argsEx = {};

    rtError_t error = ConvertArgsArrayToArgsEx(argsEx, &kernel, argsArray);

    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_NE(argsEx.args, nullptr);
    EXPECT_EQ(argsEx.argsSize, 48U);
    EXPECT_EQ(argsEx.isNoNeedH2DCopy, 0U);
}

// ArgsBufferGuard tests
TEST(ArgsBufferGuardTest, FirstAlloc)
{
    ArgsBufferGuard guard;
    EXPECT_EQ(guard.buffer_, nullptr);

    void* buffer = guard.EnsureCapacity(1024);

    EXPECT_NE(buffer, nullptr);
    EXPECT_EQ(guard.size_, 4096ULL);
}

TEST(ArgsBufferGuardTest, BufferEnough)
{
    ArgsBufferGuard guard;
    guard.EnsureCapacity(2048);

    void* buffer1 = guard.buffer_;
    void* buffer2 = guard.EnsureCapacity(1024);

    EXPECT_EQ(buffer2, buffer1);
    EXPECT_EQ(guard.size_, 4096ULL);
}

TEST(ArgsBufferGuardTest, ReallocNeeded)
{
    ArgsBufferGuard guard;
    guard.EnsureCapacity(1024); // size_=4096

    void* oldBuffer = guard.buffer_;
    uint64_t oldSize = guard.size_;

    void* newBuffer = guard.EnsureCapacity(4096 * 2); // request 8192 > 4096

    EXPECT_NE(newBuffer, nullptr);
    EXPECT_EQ(guard.size_, 8192ULL); // 验证size确实更新了
    // 如果size更新了，那么buffer一定重新分配了
}

TEST(ArgsBufferGuardTest, MallocFail)
{
    ArgsBufferGuard guard;
    MOCKER(malloc).stubs().will(returnValue((void*)nullptr));

    void* buffer = guard.EnsureCapacity(1024);

    EXPECT_EQ(buffer, nullptr);
}

TEST_F(KernelTest, Kernel_GetParamInfo_Success)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;

    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    kernel->SetParamCount(3);
    kernel->SetHasParamSummary(true);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[3]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    paramInfos[2].info.offset = 48;
    paramInfos[2].info.size = 64;
    kernel->SetParamInfos(paramInfos);

    uint32_t paramOffset = 0;
    uint32_t paramSize = 0;

    rtError_t error = kernel->GetParamInfo(0, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(paramOffset, 0U);
    EXPECT_EQ(paramSize, 16U);

    error = kernel->GetParamInfo(1, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(paramOffset, 16U);
    EXPECT_EQ(paramSize, 32U);

    error = kernel->GetParamInfo(2, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_NONE);
    EXPECT_EQ(paramOffset, 48U);
    EXPECT_EQ(paramSize, 64U);

    delete kernel;
}

TEST_F(KernelTest, Kernel_GetParamInfo_NoParamSummary)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;

    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    kernel->SetParamCount(3);
    kernel->SetHasParamSummary(false);

    uint32_t paramOffset = 0;
    uint32_t paramSize = 0;

    rtError_t error = kernel->GetParamInfo(0, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_GetParamInfo_IndexOutOfRange)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;

    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    kernel->SetParamCount(2);
    kernel->SetHasParamSummary(true);

    std::shared_ptr<ElfParamInfo[]> paramInfos(new ElfParamInfo[2]);
    paramInfos[0].info.offset = 0;
    paramInfos[0].info.size = 16;
    paramInfos[1].info.offset = 16;
    paramInfos[1].info.size = 32;
    kernel->SetParamInfos(paramInfos);

    uint32_t paramOffset = 0;
    uint32_t paramSize = 0;

    rtError_t error = kernel->GetParamInfo(5, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}

TEST_F(KernelTest, Kernel_GetParamInfo_NullParamInfos)
{
    PlainProgram stubProg(RT_KERNEL_ATTR_TYPE_AICPU);
    Program* program = &stubProg;

    Kernel* kernel = new Kernel("test", 0ULL, program, RT_KERNEL_ATTR_TYPE_AICPU, 10);
    kernel->SetParamCount(2);
    kernel->SetHasParamSummary(true);
    kernel->SetParamInfos(std::shared_ptr<ElfParamInfo[]>()); // nullptr

    uint32_t paramOffset = 0;
    uint32_t paramSize = 0;

    rtError_t error = kernel->GetParamInfo(0, &paramOffset, &paramSize);
    EXPECT_EQ(error, RT_ERROR_INVALID_VALUE);

    delete kernel;
}
