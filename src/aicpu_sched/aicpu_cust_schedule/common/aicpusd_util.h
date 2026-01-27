/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef COMMON_AICPUSD_UTIL_H
#define COMMON_AICPUSD_UTIL_H

#include <signal.h>
#include <sys/wait.h>
#include <functional>
#include <string.h>
#include "aicpusd_status.h"
#include "aicpusd_info.h"
#include "profiling_adp.h"
#include "aicpu_context.h"
#include "aicpusd_drv_manager.h"

namespace AicpuSchedule {
constexpr int32_t MAX_ENV_CHAR_NUM = 1024;
const std::string ENV_NAME_PROCMGR_AICPU_CPUSET = "PROCMGR_AICPU_CPUSET";

inline uint64_t TickInterval2Microsecond(const uint64_t tickStart,
                                         const uint64_t tickEnd,
                                         const uint64_t tickFreq)
{
    if ((tickFreq == 0UL) || (tickEnd <= tickStart)) {
        return 0UL;
    }
    // tickFreq is record by second, to microsecond need multiply 1000000
    return ((tickEnd - tickStart) * 1000000UL) / tickFreq;
}

class AicpuUtil {
public:
    static int32_t ExecuteCmd(const std::string &cmd)
    {
        /**
         * system() may fail due to  "No child processes".
         * if SIGCHLD is set to SIG_IGN, waitpid() may report ECHILD error because it cannot find the child process.
         * The reason is that the system() relies on a feature of the system, that is,
         * when the kernel initializes the process, the processing mode of SIGCHLD signal is SIG_IGN.
         */
        if (cmd.empty()) {
            return -1;
        }

        const sighandler_t oldHandler = signal(SIGCHLD, SIG_DFL);
        int32_t status = 0;
        int32_t pid = 0;
        if ((pid = vfork()) < 0) {
            status = -1;
        } else if (pid == 0) {
            (void)execl("/bin/sh", "sh", "-c", cmd.c_str(), nullptr);
            constexpr int32_t executeCmdErr = 127;
            _exit(executeCmdErr);
        } else {
            while (waitpid(pid, &status, 0) < 0) {
                if (errno != EINTR) {
                    status = -1;
                    break;
                }
            }
        }
        (void)signal(SIGCHLD, oldHandler);
        return status;
    }
    static void SetProfData(const std::shared_ptr<aicpu::ProfMessage> profMsg,
                            const aicpu::aicpuProfContext_t &aicpuProfCtx,
                            const uint32_t threadIndex,
                            const uint64_t streamId,
                            const uint64_t taskId)
    {
        if (profMsg == nullptr) {
            return;
        }

        const uint64_t tickAfterRun = aicpu::GetSystemTick();
        const uint64_t tickFreq = aicpu::GetSystemTickFreq();
        const uint64_t dispatchTime = TickInterval2Microsecond(aicpuProfCtx.drvSubmitTick,
                                                               aicpuProfCtx.tickBeforeRun,
                                                               tickFreq);
        const uint64_t totalTime = TickInterval2Microsecond(aicpuProfCtx.drvSubmitTick,
                                                            tickAfterRun,
                                                            tickFreq);

        (void)profMsg->SetAicpuMagicNumber(static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM))
            ->SetAicpuDataTag(static_cast<uint16_t>(MSPROF_AICPU_DATA_TAG))
            ->SetStreamId(static_cast<uint16_t>(streamId))
            ->SetTaskId(static_cast<uint16_t>(taskId))
            ->SetThreadId(threadIndex)
            ->SetDeviceId(AicpuDrvManager::GetInstance().GetDeviceId())
            ->SetKernelType(aicpuProfCtx.kernelType)
            ->SetSubmitTick(aicpuProfCtx.drvSubmitTick)
            ->SetScheduleTick(aicpuProfCtx.drvSchedTick)
            ->SetTickBeforeRun(aicpuProfCtx.tickBeforeRun)
            ->SetTickAfterRun(tickAfterRun)
            ->SetDispatchTime(static_cast<uint32_t>(dispatchTime))
            ->SetTotalTime(static_cast<uint32_t>(totalTime))
            ->SetVersion(aicpu::AICPU_PROF_VERSION);

        (void)aicpu::SetProfHandle(nullptr);
    }
    /**
     * @ingroup AicpusdUtil
     * @brief it is used to uniformly normalized error code.
     * @param [in] errCode: original error code.
     * @return uniformly normalized error code
     */
    static int32_t TransformInnerErrCode(const int32_t errCode)
    {
        return ((errCode > AICPU_SCHEDULE_ERROR_RESERVED) || (errCode < AICPU_SCHEDULE_OK)) ?
            AICPU_SCHEDULE_ERROR_INNER_ERROR : errCode;
    }

    /**
     * @ingroup AicpuUtil
     * @brief it is used to check exception by read FPSR Register.
     * @param [out] result : exception type.
     * @return has any exception, true if has
     */
    static bool CheckOverflow(int32_t &result)
    {
#if (defined __ARM_ARCH) || (defined PLATFORM_AARCH64)
        int64_t regContent;
        __asm volatile(
          "MRS %0, FPSR"
          : "=r" (regContent)
          :
          : "memory"
        );
        aicpusd_info("Custom Scheduler Read FPSR:[%d].", regContent);
        if ((regContent & (1 << 3)) != 0) { // UFC(3)
            result = AICPU_SCHEDULE_ERROR_UNDERFLOW;
            return true;
        } else if ((regContent & (1 << 2)) != 0) { // OFC(2)
            result = AICPU_SCHEDULE_ERROR_OVERFLOW;
            return true;
        } else if ((regContent & (1 << 1)) != 0) { // DZC(1)
            result = AICPU_SCHEDULE_ERROR_DIVISIONZERO;
            return true;
        }
#endif
        return false;
    }

    /**
     * @ingroup AicpuUtil
     * @brief it is used to reset FPSR Register.
     */
    static void ResetFpsr()
    {
#if (defined __ARM_ARCH) || (defined PLATFORM_AARCH64)
        aicpusd_info("Custom Scheduler Reset FPSR.");
        __asm volatile(
              "BIC x0, x0, #0xffffffff \n\t"
              "MSR FPSR, x0":::"x0"
        );
#endif
    }

    static bool TransStrToUint(const std::string &para, uint32_t &value)
    {
        try {
            value = std::stoul(para);
        } catch (...) {
            return false;
        }

        return true;
    }

    static bool TransStrToInt(const std::string &para, int32_t &value)
    {
        try {
            value = std::stoi(para);
        } catch (...) {
            return false;
        }

        return true;
    }

    static bool GetEnvVal(const std::string &env, std::string &val)
    {
        if (env.empty()) {
            return false;
        }

        const char *const tmpVal = std::getenv(env.c_str());
        if ((tmpVal == nullptr) || (strnlen(tmpVal, MAX_ENV_CHAR_NUM) >= MAX_ENV_CHAR_NUM)) {
            val = "";
            return false;
        }

        val = tmpVal;
        return true;
    }

    /**
     * @ingroup AicpuUtil
     * @brief Is env value is same as expected value
     * @param [in] env : env name
     * @param [in] expectVal : expected env value
     * @return bool: true, if env val is same as expected value; otherwise, false
     */
    static bool IsEnvValEqual(const std::string &env, const std::string &expectVal)
    {
        std::string getedEnvVal;
        const bool ret = GetEnvVal(env, getedEnvVal);
        if (!ret) {
            return false;
        }

        return (getedEnvVal == expectVal) ? true : false;
    }

    static void GetProfilingInfo(uint32_t flag, ProfilingMode &profilingMode, bool &kernelFlag)
    {
        // set or unset mode
        const bool isStart = (flag & (1U << aicpu::PROFILING_FEATURE_SWITCH)) > 0U;
        // if set or unset kernel profiling mode
        kernelFlag = (flag & (1U << aicpu::PROFILING_FEATURE_KERNEL_MODE)) > 0U;
        if (isStart) {
            profilingMode = PROFILING_OPEN;
        }
    }

private:
    AicpuUtil() = default;
    ~AicpuUtil() = default;

    AicpuUtil(AicpuUtil const&) = delete;
    AicpuUtil& operator=(AicpuUtil const&) = delete;
    AicpuUtil(AicpuUtil&&) = delete;
    AicpuUtil& operator=(AicpuUtil&&) = delete;
};

/**
 * @ingroup aicpu_cust_schedule
 * @brief Pointer move
 * @param [in] T : type T, sizeof(T) mast be 1
 * @param [in] ptr : The pointer
 * @param [in] offset : Move offset
 * @return The pointer after move offset
 */
template <typename T, typename = typename std::enable_if<sizeof(T) == 1UL, void>::type>
inline T *MovePtrByOffset(const T * const ptr, const uint64_t offset)
{
    return reinterpret_cast<T *>(reinterpret_cast<uintptr_t>(ptr) + offset);
}

class ScopeGuard {
public:
    explicit ScopeGuard(const std::function<void()> exitScope)
        : exitScope_(exitScope)
    {}

    ~ScopeGuard()
    {
        exitScope_();
    }

private:
    ScopeGuard(ScopeGuard const&) = delete;
    ScopeGuard& operator=(ScopeGuard const&) = delete;
    ScopeGuard(ScopeGuard&&) = delete;
    ScopeGuard& operator=(ScopeGuard&&) = delete;

private:
    std::function<void()> exitScope_;
};
} // namespace aicpu

#endif // COMMON_AICPUSD_UTIL_H