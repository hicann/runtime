/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TSD_HASH_VERIFY_H
#define TSD_HASH_VERIFY_H
#include <map>
#include <mutex>
#include "inc/internal_api.h"
#include "inc/tsd_event_interface.h"

namespace tsd {
    enum class HashMapType : uint32_t {
        DRV_BASIC_HASHMAP = 0U, // DRV包
        AICPU_KERNELS_HASHMAP = 1U,  // 算子包、算子扩展包等
        HASHMAP_MAX = 2U
    };

    using VerifyHashMapCallback = std::function<void(const HashMapType)>;

    class TsdHashVerify {
    public:
        TsdHashVerify()
        {
        }
        static TsdHashVerify* GetInstance();
        void ReadAndUpdateTsdHashValue(const std::string &hashFile, const HashMapType hashMapType);
        std::string GetSubProcHashValue(const TsdSubProcessType procType, const uint32_t uniqueVfId);
        void VerifyTsdHashMap(const HashMapType hashMapType, const uint32_t deviceId, const uint32_t vfId);

    private:
        TsdHashVerify(TsdHashVerify const&) = delete;
        TsdHashVerify& operator=(TsdHashVerify const&) = delete;
        TsdHashVerify(TsdHashVerify&&) = delete;
        TsdHashVerify& operator=(TsdHashVerify&&) = delete;
        void InsertOrUpdateHashValue(const std::string &readData, const HashMapType hashMapType);
        void VerifyHashMapPostProcess(const HashMapType hashMapType, const uint32_t deviceId, const uint32_t vfId) const;
        bool VerifyHashValueOnce(const std::string fileName, const std::string hashValue, const HashMapType hashMapType,
                                 const uint32_t deviceId, const uint32_t vfId) const;
        std::string GetRealFileName(const std::string fileName, const HashMapType hashMapType,
                                    const uint32_t uniqueVfId) const;
        bool GetSubProcPreFixConfFromCompat(const TsdSubProcessType procType, std::string &filePreFix,
                                            std::string &valuePreFix) const;
        std::string GetSubProcHashValueFromCompat(const TsdSubProcessType procType,
                                                  const uint32_t uniqueVfId) const;
        std::mutex subProcHashMtx_;
        std::map<std::string, std::string> hashMap_[static_cast<uint32_t>(HashMapType::HASHMAP_MAX)];
    };
}
#endif