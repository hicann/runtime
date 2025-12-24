/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "mockcpp/mockcpp.hpp"
#include <iostream>
#include <string>
#include <fstream>
#include <unistd.h>
#include "cli_stub.h"
#include "acl/acl.h"
#include "data_check.h"
#include "data_report_manager.h"
#include "acp_api_plugin.h"
#include "acp_command.h"
#include "acp_manager.h"
#include "op_data_manager.h"

const std::string PROF_SCRIPT_PROF_STUB = "/var/prof_collect.sh";
const std::string PROF_VERSION_STUB = "--version";
const std::string PROF_RECORD_STUB = "--record";
const std::string PROF_SCRIPT_STUB = "--script";
const std::string PROF_STAT_STUB = "--stat";

const std::string PROF_DELAY_SWITCH = "delayTime";
const std::string PROF_DURATION_SWITCH = "durationTime";

const uint32_t PROF_WAIT_START = 2;
INT32 mmCreateProcessStub(const CHAR* fileName, const mmArgvEnv *env, const CHAR* stdoutRedirectFile, mmProcess *id)
{
    if(id == NULL) {
        return EN_INVALID_PARAM;
    }

    int32_t argvCount = 0;
    int32_t envpCount = 0;
    char **argv = nullptr;
    char **envp = nullptr;
    if(env != NULL) {
        if(env->argv) {
            argv = env->argv;
            argvCount = env->argvCount;
        }

        if(env->envp) {
            envp = env->envp;
            envpCount = env->envpCount;
        }
    }

    *id = INT32_MAX;
    if (argvCount >= 3) {
        std::string argv0(argv[0]);
        std::string argv1(argv[1]);
        std::string argv2(argv[2]);
        MSPROF_LOGI("mmCreateProcessStub argv[0]: %s, mmCreateProcessStub argv[1]: %s, mmCreateProcessStub argv[2]: %s",
            argv0.c_str(), argv1.c_str(), argv2.c_str());
        if (PerfSimulator(argv0, argv1, argv2, stdoutRedirectFile) != -1) {
            return 0;
        }
    }

    return Application(argvCount, argv, envpCount, envp);
}

INT32 mmCreateProcessAcpStub(const CHAR* fileName, const mmArgvEnv *env, const CHAR* stdoutRedirectFile, mmProcess *id)
{
    if(id == nullptr) {
        return EN_INVALID_PARAM;
    }
    if (std::string("llvm-objdump").compare(fileName) == 0) {
        std::ofstream file;
        file.open(stdoutRedirectFile, std::ios::out | std::ios::trunc |std::ios::binary);
        if (!file.is_open()) {
            MSPROF_LOGE("Failed to open %s", stdoutRedirectFile);
            return 0;
        }
        file<<"0000000000001149 <main>:"<<std::endl;
        file<<"; main():"<<std::endl;
        file<<"; /mnt/wk/demo/hello.c:4"<<std::endl;
        file<<"; {"<<std::endl;
        file<<"    1149: f3 0f 1e fa                    endbr64"<<std::endl;
        file<<"    1151: 48 83 ec 10                    subq    $16, %rsp"<<std::endl;
        file<<"    1155: 89 7d fc                       movl    %edi, -4(%rbp)"<<std::endl;
        file<<std::flush;
        MSPROF_LOGI("mmCreateProcessStub llvm-objdump %s.", stdoutRedirectFile);
        file.close();
        return 0;
    }
    int32_t argvCount = 0;
    int32_t envpCount = 0;
    char **argv = nullptr;
    char **envp = nullptr;
    if(env != nullptr) {
        if(env->argv) {
            argv = env->argv;
            argvCount = env->argvCount;
        }
 
        if(env->envp) {
            envp = env->envp;
            envpCount = env->envpCount;
        }
    }
 
    *id = INT32_MAX;
    if (argvCount >= 3) {
        std::string argv0(argv[0]);
        std::string argv1(argv[1]);
        std::string argv2(argv[2]);
        MSPROF_LOGI("mmCreateProcessStub argv[0]: %s, mmCreateProcessStub argv[1]: %s, mmCreateProcessStub argv[2]: %s",
            argv0.c_str(), argv1.c_str(), argv2.c_str());
        if (PerfSimulator(argv0, argv1, argv2, stdoutRedirectFile) != -1) {
            return 0;
        }
    }
 
    return ApplicationAcp(argvCount, argv, envpCount, envp);
}

int32_t PerfSimulator(std::string argv0, std::string argv1, std::string argv2, const CHAR* stdoutRedirectFile)
{
    if (argv0 == PROF_SCRIPT_PROF_STUB || argv1 == PROF_SCRIPT_PROF_STUB)
    {
        if (argv2 == PROF_VERSION_STUB) {
            std::string stdoutRedirectFileStr(stdoutRedirectFile);
            std::string cmd = "touch " + stdoutRedirectFileStr;
            system(cmd.c_str());
            std::ofstream tmpPrintFile;
            tmpPrintFile.open(stdoutRedirectFileStr);
            if (!tmpPrintFile.is_open()) {
                MSPROF_LOGE("Can't find tmpPrint file");
            }

            tmpPrintFile << "perf";
            tmpPrintFile.close();
        }
        if (argv2 == PROF_RECORD_STUB) { // create perf.log
            system("touch ./perf/perf.log");
        }

        if (argv2 == PROF_SCRIPT_STUB) { // create tmp file ai_ctrl_cpu.data.0.txt
            system("touch ./perf/ai_ctrl_cpu.data.0.txt");
            std::ofstream aiCtrlCpuFile;
            aiCtrlCpuFile.open("./perf/ai_ctrl_cpu.data.0.txt");
            if (!aiCtrlCpuFile.is_open()) {
                MSPROF_LOGE("Can't find ai ctrl cpu file");
            }

            aiCtrlCpuFile << "perf test";
            aiCtrlCpuFile.close();
        }

        if (argv2 == PROF_STAT_STUB) {
            std::ofstream llcFile;
            llcFile.open("./perf_llc/llc.data.0");
            if (!llcFile.is_open()) {
                MSPROF_LOGE("Can't find llc file");
            }

            llcFile << "llc data test";
            llcFile.close();
        }
        MSPROF_LOGI("mmCreateProcessStub return success.");
        return 0;
    }

    return -1;
}

int32_t Application(int32_t argc, char *argv[], int32_t envc, char *envp[])
{
    unsetenv("PROFILING_MODE");
    unsetenv("PROFILER_SAMPLECONFIG");
    std::string config = *envp;
    std::string env = config.substr(std::string("PROFILER_SAMPLECONFIG=").length());
    setenv("PROFILER_SAMPLECONFIG", env.c_str(), 1);

    uint32_t delayTime = GetDynParams(PROF_DELAY_SWITCH, env, envc, envp);

    Cann::Dvvp::Test::DataCheck CheckInstance;
    if (CheckInstance.PreParamsChecker(env) != 0) {
        return -1;
    }

    if (aclInit(nullptr) != ACL_SUCCESS) {
        return -1;
    }

    if (aclrtSetDevice(0) != ACL_SUCCESS) {
        return -1;
    }

    if (delayTime != 0 && delayTime != 111) { // 0 and 111 is particular nums to identify that task do not need to wait
        MSPROF_LOGI("Dynamic aclrtSetDevice test");
        if (aclrtSetDevice(1) != ACL_SUCCESS) {
            return -1;
        }
        MSPROF_LOGI("Dynamic aclrtResetDevice test");
        if (aclrtResetDevice(1) != ACL_SUCCESS) { // check dynamic map if deduplicate
            return -1;
        }
        sleep(delayTime + PROF_WAIT_START);   // sleep add 2s to make sure profiling is start
    }

    if (DataReportMgr().SimulateReport() != 0) {
        return -1;
    }

    if (CheckInstance.bitSwitchChecker() != 0) {
        return -1;
    }

    uint32_t modelId = 0;
    // load model and report host data
    if (aclmdlLoadFromFile(nullptr, &modelId) != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
        return ACL_ERROR_INVALID_PARAM;
    }

    void *stream = &modelId; // fake stream
    if (DataReportMgr().GetMsprofTx() && aclprofMarkEx("model execute start", strlen("model execute start"), stream) != 0) {
        MSPROF_LOGE("aclprofMarkEx failed");
        return ACL_ERROR_INVALID_PARAM;
    }
    mmSleep(DataReportMgr().GetSleepTime());

    if (aclmdlExecute(modelId, nullptr, nullptr) != 0) {
        MSPROF_LOGE("aclmdlExecute failed");
        return ACL_ERROR_INVALID_PARAM;
    }

    if (aclmdlUnload(modelId) != 0) {
        MSPROF_LOGE("aclUnLoad failed");
        return ACL_ERROR_INVALID_PARAM;
    }

    if (aclFinalize() != 0) {
        return -1;
    }
    uint32_t platformType = CheckInstance.GetPlatformType();
    auto iter = CLI_CHECK_OUTPUT.find(platformType);
    if (iter == CLI_CHECK_OUTPUT.end() || CheckInstance.flushDataChecker(iter->second, "app") != 0) {
        return -1;
    }

    return 0;
}

int32_t ApplicationAcp(int32_t argc, char *argv[], int32_t envc, char*envp[])
{
    // clear acp manager singleton
    Collector::Dvvp::Acp::AcpManager::instance()->UnInit();
    Dvvp::Acp::Analyze::OpDataManager::instance()->UnInit();
    // simulate malloc device memory
    void *ptr = nullptr;
    void **upPtr = reinterpret_cast<void **>(&ptr);
    void *ptr2 = nullptr;
    void **upPtr2 = reinterpret_cast<void **>(&ptr2);
    uint64_t size = static_cast<uint64_t>(sizeof(uint32_t));
    rtMalloc(upPtr, size, 0, 0);
    *reinterpret_cast<uint32_t*>(*upPtr) = 999;
    rtMalloc(upPtr2, size, 0, 0);
    *reinterpret_cast<uint32_t*>(*upPtr2) = 888;
    MSPROF_LOGI("ptr addr: %p, ptr2 addr: %p", ptr, ptr2);
    // simulate set device
    int32_t devId = 0;
    rtSetDevice(devId);
    // simulate execute kernel
    void *stubFunc = nullptr;
    uint32_t blockDim = 8;
    rtSmDesc_t *smDesc = nullptr;
    rtStream_t stm = nullptr;
    rtArgsEx_t *argsInfo = { 0 };
    rtTaskCfgInfo_t *cfgInfo = { 0 };
    uint32_t flags = 0;
    uint8_t data = 7;
    rtDevBinary_t bin;
    bin.length = 1;
    bin.data = &data;
    void *hdl = (void*)0x12345678;
    void *kernelInfo = nullptr;
    char_t *stubName = "stubName";
    rtRegisterAllKernel(&bin, &hdl);
    // simulate free device memory middle
    rtFree(ptr2);
    ptr2 = nullptr;
    MSPROF_LOGI("ptr addr: %p, ptr2 addr: %p", ptr, ptr2);
    // simulate not copy memory
    if (DataReportMgr().GetPcSampling()) {
        Collector::Dvvp::Acp::AcpManager::instance()->ResetMallocMemory(stm);
    }
    rtKernelLaunchWithFlagV2(stubFunc, blockDim, argsInfo, smDesc, stm, flags, cfgInfo);
    // simulate free device memory finally
    rtFree(ptr);
    ptr = nullptr;
    // check if data exist
    Cann::Dvvp::Test::DataCheck CheckInstance;
    if (CheckInstance.flushDataChecker("cliAcpStest_workspace/output", "app") != 0) {
        return -1;
    }
    // if need simulate pc sampling
    if (DataReportMgr().GetPcSampling()) {
        MSPROF_LOGI("Get pc sampling switch: %d, begin to simulate dump binary.", DataReportMgr().GetPcSampling());
        Collector::Dvvp::Acp::AcpManager::instance()->AddBinary(hdl, bin);
        Collector::Dvvp::Acp::AcpManager::instance()->DumpBinary(hdl);
        rtDevBinaryRegister(&bin, &hdl);
        rtFunctionRegister(hdl, stubFunc, stubName, kernelInfo, 0);
        rtKernelLaunchWithHandleV2(hdl, 0, blockDim, argsInfo, smDesc, stm, cfgInfo);
        rtDevBinaryUnRegister(&hdl);
    }
    return 0;
}

uint32_t GetDynParams(const std::string str, std::string &env, int32_t envc, char * envp[])
{
    for (auto i = 0; i < envc; i++) {
        std::string envpDyn(envp[i]);
        if (envpDyn == "PROFILING_MODE=delay_or_duration") {
            std::string envDyn = envpDyn.substr(std::string("PROFILING_MODE=").length());
            setenv("PROFILING_MODE", envDyn.c_str(), 1);
            std::string::size_type posFront = env.find(str);
            if (posFront == -1) {
                return 0;
            }
            std::string posBackStr = env.substr(posFront + str.length() + 3);
            std::string::size_type posBack = posBackStr.find_first_of(Cann::Dvvp::Test::COMMA);
            posBackStr = posBackStr.substr(0, posBack - 1);
            if (posBackStr.empty()) {
                return 0;
            }
            uint32_t number = std::stoul(posBackStr);
            MSPROF_LOGI("Application get %s: %u", str.c_str(), number);
            return number;
        }
    }

    return 0;
}

bool executeStub()
{
    uint32_t modelId = 0;
    // load model
    auto err = aclmdlLoadFromFile(nullptr, &modelId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
    }

    // run model
    err = aclmdlExecute(modelId, nullptr, nullptr);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("Execute model failed");
        return false;
    }

    err = aclmdlUnload(modelId);
    if (err != ACL_ERROR_NONE) {
        MSPROF_LOGE("aclmdlLoadFromFile failed");
        return false;
    }
    return true;
}
