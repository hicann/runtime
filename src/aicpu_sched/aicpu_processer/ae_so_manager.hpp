/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __AE_SO_MANAGER_H__
#define __AE_SO_MANAGER_H__

#include <string>
#include <unordered_map>
#include <set>
#include <pthread.h>
#include <unordered_set>
#include "aicpu_engine.h"
#include "ae_def.hpp"
#include "aicpu_event_struct.h"
#include "aicpu_context.h"

namespace cce {

using tSoHandle = void*;

class SingleSoManager {
public:
    SingleSoManager() = default;
    ~SingleSoManager();

    /**
     * @brief Init single so manager.
     * @param [in] guardDirName: dir name
     * @param [in] soFile: full so file
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t Init(const std::string &guardDirName, const std::string &soFile);

    /**
     * @brief Get a function addr by function name from a so lib file.
     * @param [in] soName: so name
     * @param [in] funcName: kernel name
     * @param [out] funcAddrPtr: func addr
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t GetApi(const char_t * const soNamePtr, const char_t * const funcName, void ** const funcAddrPtr);

    /**
     * @brief Open a so file.
     * @param [in] soFile: full so path
     * @param [out] retHandle: so handle
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    static aeStatus_t OpenSo(const std::string &soFile, void ** const retHandle);

    /**
     * @brief Get the func addr in so handle by func name.
     * @param [in] soHandle: so handle
     * @param [in] funcName: func name
     * @param [out] retFuncAddr: func addr
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    static aeStatus_t GetFunc(void * const soHandle, const char_t * const funcName, void ** const retFuncAddr);

    /**
     * @brief Check so file.
     * @param [in] guardDirName: dir name
     * @param [in] soFile: so full path
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    static aeStatus_t CheckSoFile(const std::string &guardDirName, const std::string &soFile);

    /**
     * @brief Get a function addr and so handle by so file and function name.
     * @param [in] soFile: so full path
     * @param [in] funcName: kernel name
     * @param [out] funcAddrPtr: func addr
     * @param [out] retHandle: so handle
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    static aeStatus_t GetApi(const char_t * const soFile, const char_t * const funcName,
                             void ** const funcAddrPtr, void ** const retHandle);

    /**
     * @brief Close so.
     * @param [in] retHandle: so handle
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    static aeStatus_t CloseSo(void * const retHandle);

    static void GetCustSoPathByUniqueVfId(std::string &soPath, const uint32_t uniqueVfId);
private:
    static std::string GetRealCustSoPath();

    // so hande which opened by dlopen
    tSoHandle soHandle_ = nullptr;
    // so name
    std::string soName_;
    // api cacher
    std::unordered_map<std::string, void *> apiCacher_;
    // A Read Write lock to protect apiCacher_
    tAERwLock rwLock_ = PTHREAD_RWLOCK_INITIALIZER;
};

class MultiSoManager {
public:
    MultiSoManager() = default;
    ~MultiSoManager();

    /**
     * @brief Init multi so manager.
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t Init();

    /**
     * @brief Get a function addr by function name from a so lib file.
     * @param [in] kernelType: kernel type
     * @param [in] soName: so name
     * @param [in] funcName: kernel name
     * @param [out] funcAddrPtr: func addr
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t GetApi(const aicpu::KernelType kernelType, const char_t * const soName,
                      const char_t * const funcName, void ** const funcAddrPtr);

    /**
     * @brief Load a so lib file.
     * @param [in] kernelType: kernel type
     * @param [in] soName: so name
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t LoadSo(const aicpu::KernelType kernelType, const std::string &soName);

    /**
     * @brief Close a so.
     * @param [in] soName: so name
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t CloseSo(const std::string &soName);

private:
    /**
     * @brief Get so load path.
     * @param [in] kernelType: kernel type
     * @param [in] soName: so name
     * @param [in|out] soPath: so load path
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t GetSoPath(const aicpu::KernelType kernelType, const std::string &soName, std::string &soPath) const;

    /**
     * @brief Get so load path for cust aicpu so.
     * @param [in|out] soPath: so load path
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t GetCustSoPath(std::string &soPath) const;

    /**
     * @brief build so load path for cust aicpu so.
     * @param [in|out] soPath: so load path
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t BuildCustSoPath(std::string &soPath, const uint32_t uniqueVfId) const;

    /**
     * @brief Get so load path for inner aicpu so.
     * @param [in] soName: so name
     * @param [in|out] soPath: so load path
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t GetInnerSoPath(const std::string &soName, std::string &soPath) const;

    /**
     * @brief Load a so lib file.
     * @param [in] kernelType: kernel type
     * @param [in] soName: so name
     * @param [in|out] soMgr: single so manager
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t LoadSo(const aicpu::KernelType kernelType, const std::string &soName, SingleSoManager *&soMgr);

    /**
     * @brief Load a so lib file.
     * @param [in] kernelType: kernel type
     * @param [in] soName: so name
     * @param [in|out] soMgr: single so manager
     * @return AICPU_SCHEDULE_OK: success, other: error code
     */
    aeStatus_t CreateSingleSoMgr(const aicpu::KernelType kernelType,
                                 const std::string &soName, SingleSoManager *&soMgr);

    aeStatus_t GetThreadModeSoPath(std::string &soPath) const;

    aeStatus_t GetSoInHostPidPath(const std::string &soName, std::string &oriPath,
                                  SingleSoManager * const newSSoMngr, std::string &soFile) const;
private:
    // so cacher
    std::unordered_map<std::string, SingleSoManager *> soCacher_;
    // a read write lock to protect soCacher_ and apiCacher_
    tAERwLock rwLock_ = PTHREAD_RWLOCK_INITIALIZER;
    // aipcu kernel so path for lhisi
    std::string innerKernelPath_;
    // cust aicpu kernel so path for lhisi
    std::string custKernelPath_;
    // run mode
    uint32_t runMode_ = aicpu::AicpuRunMode::INVALID_MODE;
};

}
#endif
