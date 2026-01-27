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

#include <atomic>
#include <functional>
#include <cstring>
#include <regex.h>
#include <csignal>
#include <unistd.h>
#include <sys/time.h>
#include <sys/wait.h>
#include "external/graph/types.h"
#include "aicpu_context.h"
#include "aicpusd_feature_ctrl.h"
#include "aicpusd_status.h"
#include "aicpu_event_struct.h"
#include "profiling_adp.h"
#include "securec.h"

namespace AicpuSchedule {

constexpr int32_t MAX_ENV_CHAR_NUM = 1024;
const std::string ENV_NAME_HOME = "HOME";
const std::string ENV_NAME_BLOCK_CFG_PATH = "BLOCK_CFG_PATH";
const std::string ENV_NAME_DATAMASTER_RUN_MODE = "DATAMASTER_RUN_MODE";
const std::string ENV_NAME_AICPU_MODEL_TIMEOUT = "AICPU_MODEL_TIMEOUT";
const std::string ENV_NAME_PROCMGR_AICPU_CPUSET = "PROCMGR_AICPU_CPUSET";
const std::string ENV_NAME_LD_LIBRARY_PATH = "LD_LIBRARY_PATH";
const std::string ENV_NAME_REG_ASCEND_MONITOR = "REGISTER_TO_ASCENDMONITOR";
const std::string ENV_NAME_CUST_SO_PATH = "ASCEND_CUST_AICPU_KERNEL_CACHE_PATH";
class ScopeGuard {
public:
    explicit ScopeGuard(const std::function<void()> exitScope)
        : exitScope_(exitScope)
    {}

    ~ScopeGuard()
    {
        try {
            exitScope_();
        } catch (std::exception &funcException) {
            aicpusd_err("ScopeGuard Destruct Failed, %s", funcException.what());
        }
    }

private:
    ScopeGuard(ScopeGuard const&) = delete;
    ScopeGuard& operator=(ScopeGuard const&) = delete;
    ScopeGuard(ScopeGuard&&) = delete;
    ScopeGuard& operator=(ScopeGuard&&) = delete;

    std::function<void()> exitScope_;
};

inline uint64_t TickInterval2Microsecond(const uint64_t tickStart,
                                         const uint64_t tickEnd,
                                         const uint64_t tickFreq)
{
    if ((tickFreq == 0ULL) || (tickEnd <= tickStart)) {
        return 0UL;
    }
    // tickFreq is record by second, to microsecond need multiply 1000000
    return ((tickEnd - tickStart) * 1000000U) / tickFreq;
}
typedef struct {
    uint64_t taskId;
    uint64_t streamId;
    uint32_t threadIndex;
    uint32_t deviceId;
} ProfIdentity;

class AicpuUtil {
public:
    /**
     * @ingroup AicpusdUtil
     * @brief it is used to uniformly normalized error code.
     * @param [in] errCode: original error code.
     * @return uniformly normalized error code
     */
    static int32_t TransformInnerErrCode(const int32_t errCode)
    {
        return ((errCode > AICPU_SCHEDULE_ERROR_RESERVED) ||
                (errCode < AICPU_SCHEDULE_OK)) ? AICPU_SCHEDULE_ERROR_INNER_ERROR : errCode;
    }

    static void SetProfData(const std::shared_ptr<aicpu::ProfMessage> &profMsg,
                            const aicpu::aicpuProfContext_t &aicpuProfCtx,
                            const ProfIdentity &profIdentity)
    {
        if (profMsg != nullptr) {
            // Phase of determining whether the operator is an asynchronous operator
            std::string phaseOneValue;
            bool isPhaseOne = false;
            const auto ret = aicpu::GetThreadLocalCtx(aicpu::CONTEXT_KEY_PHASE_ONE_FLAG, phaseOneValue);
            if ((ret == aicpu::AICPU_ERROR_NONE) && (phaseOneValue == "True")) {
                isPhaseOne = true;
            }
            // The profile is not written in the first phase.
            if (!isPhaseOne) {
                const uint64_t tickAfterRun = aicpu::GetSystemTick();
                const uint64_t tickFreq = aicpu::GetSystemTickFreq();
                const uint64_t dispatchTime = TickInterval2Microsecond(aicpuProfCtx.drvSubmitTick,
                                                                       aicpuProfCtx.tickBeforeRun,
                                                                       tickFreq);
                const uint64_t totalTime = TickInterval2Microsecond(aicpuProfCtx.drvSubmitTick, tickAfterRun, tickFreq);
                (void)profMsg->SetAicpuMagicNumber(static_cast<uint16_t>(MSPROF_DATA_HEAD_MAGIC_NUM))
                    ->SetAicpuDataTag(static_cast<uint16_t>(MSPROF_AICPU_DATA_TAG))
                    ->SetStreamId(static_cast<uint16_t>(profIdentity.streamId))
                    ->SetTaskId(static_cast<uint16_t>(profIdentity.taskId))->SetThreadId(profIdentity.threadIndex)
                    ->SetDeviceId(profIdentity.deviceId)
                    ->SetKernelType(aicpuProfCtx.kernelType)->SetSubmitTick(aicpuProfCtx.drvSubmitTick)
                    ->SetScheduleTick(aicpuProfCtx.drvSchedTick)->SetTickBeforeRun(aicpuProfCtx.tickBeforeRun)
                    ->SetTickAfterRun(tickAfterRun)->SetDispatchTime(static_cast<uint32_t>(dispatchTime))
                    ->SetTotalTime(static_cast<uint32_t>(totalTime))->SetVersion(aicpu::AICPU_PROF_VERSION);
            }
            (void)aicpu::SetProfHandle(nullptr);
            (void)aicpu::SetThreadLocalCtx(aicpu::CONTEXT_KEY_PHASE_ONE_FLAG, "False");
        }
    }

    static int32_t NumElements(const int64_t * const shape, const int64_t dimSize, int64_t &elementNum)
    {
        if (shape == nullptr) {
            aicpusd_err("Shape is nullptr.");
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        int64_t num = 1;
        for (int64_t i = 0; i < dimSize; i++) {
            const int64_t dim = shape[i];
            if (dim < 0) {
                aicpusd_err("Shape[%lld] value[%lld] is invalid, must be >= 0.", i, dim);
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
            num = (num * dim);
            if (num < 0) {
                aicpusd_err("Shape total element num is invalid, must be < INT64_MAX.");
                return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
            }
        }
        elementNum = num;
        return AICPU_SCHEDULE_OK;
    }

    static int32_t CalcDataSizeByShape(const int64_t * const shape, const int64_t dimSize,
                                       const int64_t dtype, int64_t &dataSize)
    {
        int64_t elementNum = 0;
        const int32_t ret = NumElements(shape, dimSize, elementNum);
        if (ret != AICPU_SCHEDULE_OK) {
            return ret;
        }

        const int32_t elementSize = ge::GetSizeByDataType(static_cast<ge::DataType>(dtype));
        if (elementSize < 0) {
            aicpusd_err("CalcDataSizeByShape failed, elementSize[%d] must be >= 0.", elementSize);
            return AICPU_SCHEDULE_ERROR_PARAMETER_NOT_VALID;
        }

        dataSize = elementNum * static_cast<int64_t>(elementSize);
        return AICPU_SCHEDULE_OK;
    }

    /**
     * @ingroup AicpuUtil
     * @brief it is used to check exception by read FPSR Register.
     * @param [out] result : exception type.
     * @return has any exception, true if has
     */
    static bool CheckOverflow(int32_t &result)
    {
        (void)result;
#if (defined __ARM_ARCH) || (defined PLATFORM_AARCH64)
        int64_t regContent;
        __asm volatile(
          "MRS %0, FPSR"
          : "=r" (regContent)
          :
          : "memory"
        );
        aicpusd_info("Read FPSR:[%d].", regContent);
        if (regContent & (1UL << 3UL)) { // UFC(3)
            result = AICPU_SCHEDULE_ERROR_UNDERFLOW;
            return true;
        } else if (regContent & (1UL << 2UL)) { // OFC(2)
            result = AICPU_SCHEDULE_ERROR_OVERFLOW;
            return true;
        } else if (regContent & (1UL << 1UL)) { // DZC(1)
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
        aicpusd_info("Reset FPSR.");
        __asm volatile(
              "BIC x0, x0, #0xffffffff \n\t"
              "MSR FPSR, x0":::"x0"
        );
#endif
    }

    /**
     * @ingroup AicpuUtil
     * @brief Get env value by name
     * @param [in] env : env name
     * @param [in] val : env value
     * @return bool: true, if env val is not nullptr; otherwise, false
     */
    __attribute__((visibility("default"))) static bool GetEnvVal(const std::string &env, std::string &val)
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
    __attribute__((visibility("default"))) static bool IsEnvValEqual(const std::string &env,
                                                                     const std::string &expectVal)
    {
        std::string getedEnvVal;
        const bool ret = GetEnvVal(env, getedEnvVal);
        if (!ret) {
            return false;
        }

        return (getedEnvVal == expectVal) ? true : false;
    }

    static inline bool IsUint64MulOverflow(const uint64_t num1, const uint64_t num2)
    {
        if ((num1 == 0UL) || (num2 == 0UL)) {
            return false;
        }

        if ((UINT64_MAX / num1) < num2) {
            return true;
        }

        return false;
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

    static bool TransStrToUint(const std::string &para, uint32_t &value)
    {
        try {
            value = std::stoul(para);
        } catch (...) {
            return false;
        }

        return true;
    }

    static bool TransStrToull(const std::string &para, uint64_t &value)
    {
        try {
            value = std::stoull(para);
        } catch (...) {
            return false;
        }

        return true;
    }

    /**
     * @ingroup AicpuUtil
     * @brief judge the string matching pattern
     * @param [in] str : file name
     * @param [in] mode : pattern
     * @return check code
     */
    static bool ValidateStr(const std::string &str, const std::string &mode)
    {
        regex_t reg;
        int32_t ret = regcomp(&reg, mode.c_str(), REG_EXTENDED | REG_NOSUB);
        if (ret != 0) {
            return false;
        }
        ret = regexec(&reg, str.c_str(), static_cast<size_t>(0), nullptr, 0);
        if (ret != 0) {
            regfree(&reg);
            return false;
        }

        regfree(&reg);
        return true;
    }

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

        sighandler_t const oldHandler = signal(SIGCHLD, SIG_DFL);
        int32_t status = 0;
        int32_t pid = 0;
        if ((pid = vfork()) < 0) {
            status = -1;
        } else if (pid == 0) {
            (void)execl("/bin/sh", "sh", "-c", cmd.c_str(), nullptr);
            constexpr int32_t executeCmdErr = 127; // 与system实现保持一致
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

    static std::string GetDTypeString(const ge::DataType curDtype);

    static void UpdateMinData(uint64_t &dstData, const uint64_t srcData)
    {
        if (((dstData > srcData) && (srcData != 0UL)) || (dstData == 0UL)) {
            dstData = srcData;
        }
    }
    static void UpdateMaxAndSubMaxData(uint64_t &maxData, uint64_t &subMaxData, const uint64_t srcData)
    {
        if (srcData > maxData) {
            subMaxData = maxData;
            maxData = srcData;
        } else if (srcData > subMaxData) {
            subMaxData = srcData;
        } else {
            // do nothing
        }
    }

    static bool BiggerMemCpy(void *dstAddr, const size_t dstLen, const void *srcAddr, const size_t srcLen)
    {
        if ((dstAddr == nullptr) || (srcAddr == nullptr)) {
            aicpusd_err("BiggerMemCpy input param is null.");
            return false;
        }

        if (dstLen < srcLen) {
            aicpusd_err("BiggerMemCpy dstLen is[%zu] less than srcLen[%zu].", dstLen, srcLen);
            return false;
        }

        size_t remainSize = srcLen;
        while (remainSize > SECUREC_MEM_MAX_LEN) {
            const auto eRet = memcpy_s(dstAddr, SECUREC_MEM_MAX_LEN, srcAddr, SECUREC_MEM_MAX_LEN);
            if (eRet != EOK) {
                aicpusd_err("memcpy_s fail, ret is %d.", eRet);
                return false;
            }
            remainSize -= SECUREC_MEM_MAX_LEN;
            srcAddr = ValueToPtr(PtrToValue(srcAddr) + SECUREC_MEM_MAX_LEN);
            dstAddr = ValueToPtr(PtrToValue(dstAddr) + SECUREC_MEM_MAX_LEN);
        }
        if (remainSize != 0U) {
            const auto eRet = memcpy_s(dstAddr, remainSize, srcAddr, remainSize);
            if (eRet != EOK) {
                aicpusd_err("memcpy_s fail, size is %zu, ret is %d.", remainSize, eRet);
                return false;
            }
        }
        return true;
    }

    static bool IsFpga()
    {
        static const bool IS_FPGA = AicpuUtil::IsEnvValEqual(ENV_NAME_DATAMASTER_RUN_MODE, "1");
        return IS_FPGA;
    }

    /**
     * @ingroup AicpuUtil
     * @brief it use to check timeout value send by ts.
     * @param [in] timeout : the timeout value.
     * @return bool: true if is valid value, otherwise false
     */
    static inline bool IsValidTimeoutVal(const uint32_t timeout)
    {
        if (timeout == 0U) {
            aicpusd_err("Invalid timeout value send by ts which can not be zero.");
            return false;
        }

        const uint64_t sysTickFreq = aicpu::GetSystemTickFreq();
        if (sysTickFreq > (UINT64_MAX / static_cast<uint64_t>(timeout))) {
            aicpusd_err("Invalid timeout[%u] value send by ts resulting in unsigned long reverse. freq[%lu]",
                        timeout, sysTickFreq);
            return false;
        }

        return true;
    }

    /**
     * @ingroup AicpuUtil
     * @brief is use to check cust aicpu thread mode
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    static inline int32_t CheckCustAicpuThreadMode()
    {
        uint32_t runMode = 0U;
        const aicpu::status_t status = aicpu::GetAicpuRunMode(runMode);
        if (status != aicpu::AICPU_ERROR_NONE) {
            aicpusd_err("Get current aicpu ctx failed.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        if (runMode != aicpu::AicpuRunMode::THREAD_MODE) {
            aicpusd_err("Cust aicpu process does not exist.");
            aicpusd_err("Only with thread mode, cust aicpu kernel can run in aicpu-sd.");
            return AICPU_SCHEDULE_ERROR_INNER_ERROR;
        }

        return AICPU_SCHEDULE_OK;
    }

private:
    AicpuUtil() = default;
    ~AicpuUtil() = default;

    AicpuUtil(AicpuUtil const&) = delete;
    AicpuUtil& operator=(AicpuUtil const&) = delete;
    AicpuUtil(AicpuUtil&&) = delete;
    AicpuUtil& operator=(AicpuUtil&&) = delete;
};

class SpinLock {
public:
    SpinLock() = default;

    ~SpinLock() = default;

    void Lock()
    {
        while (lock_.test_and_set()) {}
    }

    void Unlock()
    {
        lock_.clear();
    }

private:
    SpinLock(const SpinLock&) = delete;
    SpinLock& operator=(const ScopeGuard&) = delete;
    SpinLock(SpinLock&&) = delete;
    SpinLock& operator=(SpinLock&&) = delete;

    std::atomic_flag lock_ = ATOMIC_FLAG_INIT;
};

inline uint64_t GetCurrentTime()
{
    uint64_t ret = 0U;
    struct timeval tv;
    if (gettimeofday(&tv, nullptr) == 0) {
        ret = (static_cast<uint64_t>(tv.tv_sec) * 1000000UL) + static_cast<uint64_t>(tv.tv_usec);
    }

    return ret;
}

} // namespace aicpu

#endif // COMMON_AICPUSD_UTIL_H

