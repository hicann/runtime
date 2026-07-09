/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
// 端到端用例（强制规则）：
//   - 必须从 ComputeProcessMain(argc, argv) 入口启动，禁止直调 AICPUExecuteTask/DoOnce/InitAICPUScheduler
//   - ComputeProcessMain 阻塞在 WaitForShutDown，须在子线程运行
//   - 设备拓扑由 sim_hal_device_stub.c 提供 6 核（0=CCPU,1=DCPU,2-5=AICPU）
//   - 事件注入：Esched().InjectEvent(devId, groupId, EventInfoBuilder()...Build())
//   - 应答断言：Esched().TakeAckRecords() 取 hwts_response_t
//   - 参数区隔离：每算子用独立栈变量，禁止 static
//   - 看门狗：SimNotifyShutdown() 后带超时（≤5s）轮询主线程退出
//   - 用例隔离：SetUp 调 SimPlatform::Reset() + aicpusdInitFlagMap_.clear()；TearDown 调 verify() + Reset()
// 日志控制：ASCEND_GLOBAL_LOG_LEVEL(0=DEBUG..3=ERROR) / ASCEND_SIM_LOG_FILE=1 落盘
#include <gtest/gtest.h>
#include <dlfcn.h>
#include <securec.h>
#include <vector>
#include <thread>
#include <atomic>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

#include "mockcpp/mockcpp.hpp"
#include "ascend_hal.h"

#define private public
#define protected public
#include "aicpusd_event_manager.h"
#include "aicpusd_event_process.h"
#include "aicpusd_interface_process.h"
#include "aicpusd_worker.h"
#include "aicpusd_drv_manager.h"
#include "aicpusd_message_queue.h"
#include "aicpusd_threads_process.h"
#include "aicpusd_model_execute.h"
#include "aicpusd_queue_event_process.h"
#include "aicpusd_feature_ctrl.h"
#include "core/dfx/dump_task.h"
#include "aicpu_msg.h"
#undef private
#undef protected

#include "aicpusd_info.h"
#include "aicpusd_interface.h"
#include "aicpusd_status.h"
#include "aicpu_event_struct.h"
#include "aicpu_engine.h"
#include "ae_kernel_lib_aicpu.hpp"
#include "aicpu_async_event.h"
#include "ae_so_manager.hpp"
#include "../aicpusd_msq_operator_stub.h"
#include "op_mapping_info.pb.h"

#include "sim/sim_platform.h"
#include "sim_tsd.h"

// ComputeProcessMain 由 execute/main.cpp 在 aicpusd_UT 宏下提供
int32_t ComputeProcessMain(int32_t argc, char* argv[]);

using namespace AicpuSchedule;
using namespace sim;

namespace {
constexpr uint32_t kDevId = 0U;

static uint64_t g_simResBuffer[8192];
drvError_t HalResAddrMapSimStub(unsigned int devId, struct res_addr_info* resInfo, unsigned long* va, unsigned int* len)
{
    (void)devId;
    (void)resInfo;
    if (va != nullptr) {
        *va = reinterpret_cast<unsigned long>(g_simResBuffer);
    }
    if (len != nullptr) {
        *len = static_cast<unsigned int>(sizeof(g_simResBuffer));
    }
    return DRV_ERROR_NONE;
}

// 测试算子桩：SimTestOp(读magic写result+1) / SimParallelOp(ParallelFor 4分片) / SimFailOp(返回1)
// GetApiMixed 桩按 funcName 路由到上述算子，新增算子类型时在 GetApiMixed 中扩展分支
struct SimOpParam {
    uint32_t magic;
    uint32_t result;
};
uint32_t SimTestOpSuccess(void* param)
{
    auto* p = static_cast<SimOpParam*>(param);
    if (p != nullptr) {
        p->result = p->magic + 1U;
    }
    return 0U;
}
uint32_t SimTestOpFail(void* param)
{
    (void)param;
    return 1U;
}

struct ParallelForOpParam {
    uint32_t magic;
    uint32_t result;
    std::atomic<uint32_t> subtaskCount;
};

// ParallelFor(40, 10, work)，cpuCoreNum=4 时产生 4 个分片
uint32_t SimTestOpParallelFor(void* param)
{
    auto* p = static_cast<ParallelForOpParam*>(param);
    p->subtaskCount.store(0U);
    aicpu::SharderWork work = [p](int64_t start, int64_t limit) {
        (void)start;
        (void)limit;
        p->subtaskCount.fetch_add(1U);
    };
    ParallelFor(40, 10, work);
    p->result = p->subtaskCount.load();
    return 0U;
}

char g_simOpName[] = "SimTestOp";
char g_simSoName[] = "libSimTest.so";
char g_simParallelOpName[] = "SimParallelOp";
char g_simFailOpName[] = "SimFailOp";

// 打桩 GetApi：直接返回测试算子函数地址，不走真实 dlopen/dlsym
aeStatus_t GetApiSimSuccess(
    cce::MultiSoManager* self, aicpu::KernelType kt, const char* soName, const char* funcName, void** funcAddr)
{
    (void)self;
    (void)kt;
    (void)soName;
    (void)funcName;
    if (funcAddr != nullptr) {
        *funcAddr = reinterpret_cast<void*>(&SimTestOpSuccess);
    }
    return AE_STATUS_SUCCESS;
}
aeStatus_t GetApiParallelFor(
    cce::MultiSoManager* self, aicpu::KernelType kt, const char* soName, const char* funcName, void** funcAddr)
{
    (void)self;
    (void)kt;
    (void)soName;
    (void)funcName;
    if (funcAddr != nullptr) {
        *funcAddr = reinterpret_cast<void*>(&SimTestOpParallelFor);
    }
    return AE_STATUS_SUCCESS;
}
// 混合路由：按 kernel name 分发到不同测试算子
aeStatus_t GetApiMixed(
    cce::MultiSoManager* self, aicpu::KernelType kt, const char* soName, const char* funcName, void** funcAddr)
{
    (void)self;
    (void)kt;
    (void)soName;
    if (funcAddr == nullptr) {
        return AE_STATUS_SUCCESS;
    }
    if (funcName != nullptr && strcmp(funcName, g_simParallelOpName) == 0) {
        *funcAddr = reinterpret_cast<void*>(&SimTestOpParallelFor);
    } else if (funcName != nullptr && strcmp(funcName, g_simFailOpName) == 0) {
        *funcAddr = reinterpret_cast<void*>(&SimTestOpFail);
    } else {
        *funcAddr = reinterpret_cast<void*>(&SimTestOpSuccess);
    }
    return AE_STATUS_SUCCESS;
}

static IDE_SESSION IdeDumpStartStub(const char* connectInfo)
{
    (void)connectInfo;
    return reinterpret_cast<IDE_SESSION>(0x1);
}

static void InjectCtrlEvent(EschedSimEngine& eng, const TsAicpuMsgInfo& msgInfo, uint32_t subeventId = 0U)
{
    SimEvent ev;
    ev.eventId = EVENT_TS_CTRL_MSG;
    ev.subeventId = subeventId;
    ev.msg.resize(sizeof(TsAicpuMsgInfo));
    (void)memcpy_s(ev.msg.data(), ev.msg.size(), &msgInfo, sizeof(TsAicpuMsgInfo));
    eng.InjectEvent(kDevId, 0U, ev);
}

static void InjectMsgVersionEvent(EschedSimEngine& eng)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.cmd_type = TS_AICPU_MSG_VERSION;
    msgInfo.u.aicpu_msg_version.magic_num = 0x5A5A;
    msgInfo.u.aicpu_msg_version.version = 1;
    InjectCtrlEvent(eng, msgInfo);
}

static void InjectDumpLoadEvent(
    EschedSimEngine& eng, uint64_t protoAddr, uint32_t protoLen, uint32_t taskId, uint16_t streamId)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.cmd_type = TS_AICPU_DATADUMP_INFO_LOAD;
    msgInfo.u.ts_to_aicpu_datadump_info_load.dumpinfoPtr = protoAddr;
    msgInfo.u.ts_to_aicpu_datadump_info_load.length = protoLen;
    msgInfo.u.ts_to_aicpu_datadump_info_load.task_id = taskId;
    msgInfo.u.ts_to_aicpu_datadump_info_load.stream_id = streamId;
    InjectCtrlEvent(eng, msgInfo);
}

static void InjectDumpDataEvent(EschedSimEngine& eng, uint32_t dumpTaskId, uint16_t dumpStreamId)
{
    TsAicpuMsgInfo msgInfo{};
    msgInfo.cmd_type = TS_AICPU_NORMAL_DATADUMP_REPORT;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_task_id = dumpTaskId;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_stream_id = dumpStreamId;
    msgInfo.u.ts_to_aicpu_normal_datadump.is_model = 0;
    msgInfo.u.ts_to_aicpu_normal_datadump.dump_type = 0;
    InjectCtrlEvent(eng, msgInfo);
}

static void RemoveDirRecursive(const std::string& path)
{
    DIR* dir = opendir(path.c_str());
    if (dir == nullptr) {
        return;
    }
    struct dirent* entry = nullptr;
    while ((entry = readdir(dir)) != nullptr) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
            continue;
        }
        std::string fullPath = path + "/" + entry->d_name;
        struct stat st;
        if (stat(fullPath.c_str(), &st) == 0) {
            if (S_ISDIR(st.st_mode)) {
                RemoveDirRecursive(fullPath);
            } else {
                unlink(fullPath.c_str());
            }
        }
    }
    closedir(dir);
    rmdir(path.c_str());
}

class AicpuSchedSimTEST : public testing::Test {
protected:
    static constexpr const char* kSoDirs[] = {
        "/usr/lib64/aicpu_kernels/", "/usr/lib64/aicpu_kernels/0/aicpu_kernels_device/",
        "/usr/lib64/aicpu_kernels/0/aicpu_kernels_device/0_0/"};
    static constexpr const char* kSimSoName = "libSimTest.so";

    void CreateSimSoFiles()
    {
        for (const char* dir : kSoDirs) {
            (void)system((std::string("mkdir -p ") + dir + " && gcc -shared -o " + dir + kSimSoName +
                          " /dev/null 2>/dev/null || touch " + dir + kSimSoName)
                             .c_str());
        }
    }
    void RemoveSimSoFiles()
    {
        for (const char* dir : kSoDirs) {
            (void)system((std::string("rm -f ") + dir + kSimSoName).c_str());
        }
    }

    void SetUp() override
    {
        CreateSimSoFiles();
        SimPlatform::Reset();
        AicpuScheduleInterface::GetInstance().aicpusdInitFlagMap_.clear();
        AicpuEventManager::GetInstance().InitEventFunc(SCHED_MODE_INTERRUPT);
    }
    void TearDown() override
    {
        cce::AIKernelsLibAiCpu::DestroyInstance();
        DumpSessionManager::GetInstance().CloseAllSessions();
        GlobalMockObject::verify();
        SimPlatform::Reset();
        RemoveSimSoFiles();
    }
    EschedSimEngine& Esched() { return SimPlatform::Esched(); }

    using GetApiStub = aeStatus_t (*)(cce::MultiSoManager*, aicpu::KernelType, const char*, const char*, void**);

    static GetApiStub g_currentGetApi;

    static void* KernelDlsymRouterWrapper(const char* funcName)
    {
        void* funcAddr = nullptr;
        if (g_currentGetApi != nullptr) {
            (void)g_currentGetApi(nullptr, aicpu::KERNEL_TYPE_AICPU, g_simSoName, funcName, &funcAddr);
        }
        return funcAddr;
    }

    void SetupCommonMocks(GetApiStub getApi)
    {
        g_currentGetApi = getApi;
        AicpuScheduleUtStub::SetDlsymRouter(&KernelDlsymRouterWrapper);
        MOCKER_CPP(&AicpuDrvManager::CheckBindHostPid).stubs().will(returnValue(0));
        MOCKER(&cce::SingleSoManager::GetFunc, aeStatus_t(void*, const char*, void**))
            .stubs()
            .will(invoke(&AicpuScheduleUtStub::SingleSoManagerGetFuncStub));
        MOCKER(halResAddrMap).stubs().will(invoke(HalResAddrMapSimStub));
        Esched().SetSubmitLoopback(true);
    }

    void LaunchAndInit(std::atomic<int32_t>& mainRet, std::atomic<bool>& mainDone, std::thread& mainThread)
    {
        static const char* argv[] = {"aicpusd",
                                     "--deviceId=0",
                                     "--pid=100",
                                     "--pidSign=000000000000000000000000000000000000000000000000",
                                     "--groupNameNum=0",
                                     "--groupNameList=",
                                     nullptr};
        const int32_t argc = static_cast<int32_t>(sizeof(argv) / sizeof(argv[0]) - 1);
        mainThread = std::thread([&argc, &argv, &mainRet, &mainDone]() {
            mainRet.store(ComputeProcessMain(argc, const_cast<char**>(argv)));
            mainDone.store(true);
        });
        for (uint32_t i = 0U; i < 5000U; ++i) {
            if (AicpuScheduleInterface::GetInstance().IsInitialized(kDevId)) {
                break;
            }
            usleep(1000U);
        }
        ASSERT_TRUE(AicpuScheduleInterface::GetInstance().IsInitialized(kDevId))
            << "InitAICPUScheduler not completed within timeout";
    }

    void ShutdownAndJoin(
        std::atomic<int32_t>& mainRet, std::atomic<bool>& mainDone, std::thread& mainThread, uint32_t maxJoinMs = 5000U)
    {
        SimNotifyShutdown();
        bool mainExited = false;
        for (uint32_t i = 0U; i < maxJoinMs; ++i) {
            if (mainDone.load()) {
                mainExited = true;
                break;
            }
            usleep(1000U);
        }
        if (mainExited) {
            mainThread.join();
            EXPECT_EQ(mainRet.load(), 0);
        } else {
            mainThread.detach();
            ADD_FAILURE() << "ComputeProcessMain 未在 " << maxJoinMs << "ms 内退出";
        }
        AicpuScheduleInterface::GetInstance().aicpusdInitFlagMap_.clear();
    }

    void InjectHwtsOpEvent(uint32_t subeventId, const char* opName, uint64_t paramBase)
    {
        Esched().InjectEvent(
            kDevId, 0U,
            EventInfoBuilder()
                .EventId(EVENT_TS_HWTS_KERNEL)
                .SubeventId(subeventId)
                .Payload(HwtsTsTaskBuilder()
                             .KernelType(aicpu::KERNEL_TYPE_AICPU)
                             .KernelName(reinterpret_cast<uint64_t>(opName))
                             .KernelSo(reinterpret_cast<uint64_t>(g_simSoName))
                             .ParamBase(paramBase)
                             .Build())
                .Build());
    }
};

AicpuSchedSimTEST::GetApiStub AicpuSchedSimTEST::g_currentGetApi = nullptr;

// ComputeProcessMain → 4 worker → 注入 HWTS → ParallelFor 4 分片 → shutdown
TEST_F(AicpuSchedSimTEST, EndToEnd_ParallelFor_4Workers_Success)
{
    SetupCommonMocks(GetApiParallelFor);

    std::atomic<int32_t> mainRet{-1};
    std::atomic<bool> mainDone{false};
    std::thread mainThread;
    LaunchAndInit(mainRet, mainDone, mainThread);

    ParallelForOpParam param;
    param.magic = 42U;
    param.result = 0U;
    param.subtaskCount.store(0U);
    InjectHwtsOpEvent(1U, g_simOpName, reinterpret_cast<uint64_t>(&param));

    for (uint32_t i = 0U; i < 10000U; ++i) {
        if (param.subtaskCount.load() >= 4U) {
            break;
        }
        usleep(1000U);
    }
    EXPECT_EQ(param.subtaskCount.load(), 4U);

    for (uint32_t i = 0U; i < 5000U; ++i) {
        if (Esched().AckedEventCount(EVENT_TS_HWTS_KERNEL) >= 1U) {
            break;
        }
        usleep(1000U);
    }
    EXPECT_TRUE(Esched().AckedEventCount(EVENT_TS_HWTS_KERNEL) >= 1U) << "算子执行后未上报 HWTS 应答";
    EXPECT_EQ(param.result, 4U);

    ShutdownAndJoin(mainRet, mainDone, mainThread);
}

// 100 个算子并发（30 分裂 + 60 普通 + 10 失败），4 worker 消费，校验结果与 ack
TEST_F(AicpuSchedSimTEST, EndToEnd_MixedBatch_100Ops_Success)
{
    SetupCommonMocks(GetApiMixed);

    std::atomic<int32_t> mainRet{-1};
    std::atomic<bool> mainDone{false};
    std::thread mainThread;
    LaunchAndInit(mainRet, mainDone, mainThread);

    constexpr int32_t kOpCount = 100;
    constexpr int32_t kParallelCount = 30;
    constexpr int32_t kNormalCount = 60;
    constexpr int32_t kFailCount = 10;
    enum class OpType { PARALLEL, NORMAL, FAIL };
    struct OpCtx {
        OpType type;
        SimOpParam normalParam;
        ParallelForOpParam parallelParam;
        uint32_t subeventId;
    };
    std::vector<OpCtx> ctxs(kOpCount);

    for (int32_t i = 0; i < kOpCount; ++i) {
        ctxs[i].subeventId = static_cast<uint32_t>(i + 1);
        if (i < kParallelCount) {
            ctxs[i].type = OpType::PARALLEL;
            ctxs[i].parallelParam.magic = static_cast<uint32_t>(1000 + i);
            ctxs[i].parallelParam.result = 0U;
            ctxs[i].parallelParam.subtaskCount.store(0U);
        } else if (i < kParallelCount + kNormalCount) {
            ctxs[i].type = OpType::NORMAL;
            ctxs[i].normalParam.magic = static_cast<uint32_t>(2000 + i);
            ctxs[i].normalParam.result = 0U;
        } else {
            ctxs[i].type = OpType::FAIL;
            ctxs[i].normalParam.magic = static_cast<uint32_t>(3000 + i);
            ctxs[i].normalParam.result = 0U;
        }
    }

    for (int32_t i = 0; i < kOpCount; ++i) {
        const char* opName = nullptr;
        uint64_t paramBase = 0U;
        if (ctxs[i].type == OpType::PARALLEL) {
            opName = g_simParallelOpName;
            paramBase = reinterpret_cast<uint64_t>(&ctxs[i].parallelParam);
        } else {
            opName = (ctxs[i].type == OpType::FAIL) ? g_simFailOpName : g_simOpName;
            paramBase = reinterpret_cast<uint64_t>(&ctxs[i].normalParam);
        }
        InjectHwtsOpEvent(ctxs[i].subeventId, opName, paramBase);
    }

    // 等待全部算子执行完成（以 ack 为准，不检查非原子 result 字段）
    for (uint32_t i = 0U; i < 30000U; ++i) {
        if (Esched().AckedEventCount(EVENT_TS_HWTS_KERNEL) >= static_cast<size_t>(kOpCount)) {
            break;
        }
        usleep(1000U);
    }
    EXPECT_EQ(Esched().AckedEventCount(EVENT_TS_HWTS_KERNEL), static_cast<size_t>(kOpCount)) << "HWTS 应答数不足";

    // 逐个断言算子执行结果（ack 到达后 result 已可见）
    int32_t parallelOk = 0;
    int32_t normalOk = 0;
    for (int32_t i = 0; i < kOpCount; ++i) {
        if (ctxs[i].type == OpType::PARALLEL) {
            EXPECT_EQ(ctxs[i].parallelParam.subtaskCount.load(), 4U) << "分裂算子[" << i << "] 分片未全部执行";
            EXPECT_EQ(ctxs[i].parallelParam.result, 4U) << "分裂算子[" << i << "] result 不正确";
            if (ctxs[i].parallelParam.subtaskCount.load() == 4U) {
                ++parallelOk;
            }
        } else if (ctxs[i].type == OpType::NORMAL) {
            EXPECT_EQ(ctxs[i].normalParam.result, ctxs[i].normalParam.magic + 1U)
                << "普通算子[" << i << "] result 不正确";
            if (ctxs[i].normalParam.result == ctxs[i].normalParam.magic + 1U) {
                ++normalOk;
            }
        }
    }
    EXPECT_EQ(parallelOk, kParallelCount) << "分裂算子未全部执行成功";
    EXPECT_EQ(normalOk, kNormalCount) << "普通算子未全部执行成功";

    // 校验 ack 的 result 和 status
    auto acks = Esched().TakeAckRecords();
    ASSERT_EQ(acks.size(), static_cast<size_t>(kOpCount));
    int32_t failAckOk = 0;
    int32_t succAckOk = 0;
    for (const auto& ack : acks) {
        ASSERT_GE(ack.msg.size(), sizeof(hwts_response_t));
        const auto* resp = reinterpret_cast<const hwts_response_t*>(ack.msg.data());
        const uint32_t subId = ack.subeventId;
        ASSERT_GE(subId, 1U);
        ASSERT_LE(subId, static_cast<uint32_t>(kOpCount));
        const int32_t idx = static_cast<int32_t>(subId) - 1;
        if (ctxs[idx].type == OpType::FAIL) {
            EXPECT_EQ(resp->status, static_cast<uint32_t>(TASK_FAIL))
                << "异常算子[" << idx << "] ack status 应为 TASK_FAIL";
            EXPECT_EQ(resp->result, 1U) << "异常算子[" << idx << "] ack result 应为 1";
            ++failAckOk;
        } else {
            EXPECT_EQ(resp->status, static_cast<uint32_t>(TASK_SUCC))
                << "成功算子[" << idx << "] ack status 应为 TASK_SUCC";
            EXPECT_EQ(resp->result, 0U) << "成功算子[" << idx << "] ack result 应为 0";
            ++succAckOk;
        }
    }
    EXPECT_EQ(failAckOk, kFailCount);
    EXPECT_EQ(succAckOk, kParallelCount + kNormalCount);

    ShutdownAndJoin(mainRet, mainDone, mainThread, 10000U);
}

// dump 精度调试：20 算子 + 5 对 LoadOpMapping/DumpData = 30 任务
TEST_F(AicpuSchedSimTEST, EndToEnd_Dump_30Tasks_Success)
{
    SetupCommonMocks(GetApiSimSuccess);
    MOCKER(IdeDumpStart).stubs().will(invoke(IdeDumpStartStub));

    const std::string dumpDir = "/tmp/sim_dump_test";
    RemoveDirRecursive(dumpDir);

    std::atomic<int32_t> mainRet{-1};
    std::atomic<bool> mainDone{false};
    std::thread mainThread;
    LaunchAndInit(mainRet, mainDone, mainThread);

    // 1. 发送 MSG_VERSION 设置 tsMsgVersion=1
    InjectMsgVersionEvent(Esched());
    usleep(10000U);

    // 2. 构造 dump 映射 protobuf 并发送 Load 事件
    constexpr int32_t kDumpOpCount = 5;
    constexpr int32_t kNormalOpCount = 20;
    std::vector<std::string> protoBuffers(kDumpOpCount);
    std::vector<uint32_t> dumpTaskIds(kDumpOpCount);
    for (int32_t i = 0; i < kDumpOpCount; ++i) {
        dumpTaskIds[i] = static_cast<uint32_t>(100 + i);
        aicpu::dump::OpMappingInfo opMappingInfo;
        opMappingInfo.set_dump_path(dumpDir);
        opMappingInfo.set_flag(0x01U);
        auto* task = opMappingInfo.add_task();
        task->set_task_id(dumpTaskIds[i]);
        task->set_stream_id(0xFFFFU);
        auto* op = task->mutable_op();
        op->set_op_name("DumpTestOp" + std::to_string(i));
        op->set_op_type("TestType");
        auto* input = task->add_input();
        input->set_data_type(0);
        input->set_format(0);
        input->set_address(reinterpret_cast<uint64_t>(g_simResBuffer));
        input->set_size(64);
        auto* output = task->add_output();
        output->set_data_type(0);
        output->set_format(0);
        output->set_address(reinterpret_cast<uint64_t>(g_simResBuffer + 100));
        output->set_size(64);
        protoBuffers[i] = opMappingInfo.SerializeAsString();
    }

    for (int32_t i = 0; i < kDumpOpCount; ++i) {
        InjectDumpLoadEvent(
            Esched(), reinterpret_cast<uint64_t>(protoBuffers[i].data()), static_cast<uint32_t>(protoBuffers[i].size()),
            dumpTaskIds[i], 0U);
    }

    // 3. 发送 DumpData 事件
    for (int32_t i = 0; i < kDumpOpCount; ++i) {
        InjectDumpDataEvent(Esched(), dumpTaskIds[i], 0xFFFFU);
    }

    // 4. 注入 20 个普通算子事件
    std::vector<SimOpParam> opParams(kNormalOpCount);
    for (int32_t i = 0; i < kNormalOpCount; ++i) {
        opParams[i].magic = static_cast<uint32_t>(5000 + i);
        opParams[i].result = 0U;
        InjectHwtsOpEvent(static_cast<uint32_t>(200 + i), g_simOpName, reinterpret_cast<uint64_t>(&opParams[i]));
    }

    // 等待全部算子执行完成（以 ack 为准，不检查非原子 result 字段）
    for (uint32_t i = 0U; i < 30000U; ++i) {
        if (Esched().AckedEventCount(EVENT_TS_HWTS_KERNEL) >= static_cast<size_t>(kNormalOpCount)) {
            break;
        }
        usleep(1000U);
    }

    // 断言普通算子全部执行成功（ack 到达后 result 已可见）
    int32_t normalOk = 0;
    for (int32_t i = 0; i < kNormalOpCount; ++i) {
        EXPECT_EQ(opParams[i].result, opParams[i].magic + 1U) << "普通算子[" << i << "] result 不正确";
        if (opParams[i].result == opParams[i].magic + 1U) {
            ++normalOk;
        }
    }
    EXPECT_EQ(normalOk, kNormalOpCount) << "普通算子未全部执行成功";

    // 断言 dump 文件已生成
    usleep(10000U);
    int dumpFileCount = 0;
    DIR* dir = opendir(dumpDir.c_str());
    if (dir != nullptr) {
        struct dirent* entry = nullptr;
        while ((entry = readdir(dir)) != nullptr) {
            if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) {
                continue;
            }
            ++dumpFileCount;
        }
        closedir(dir);
    }
    EXPECT_GE(dumpFileCount, 1) << "dump 目录下未生成任何文件";

    RemoveDirRecursive(dumpDir);

    ShutdownAndJoin(mainRet, mainDone, mainThread, 10000U);
    FeatureCtrl::ClearTsMsgVersionInfo();
}
} // namespace
