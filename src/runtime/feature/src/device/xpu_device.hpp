/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_XPU_DEVICE_HPP
#define CCE_RUNTIME_XPU_DEVICE_HPP

#include "raw_device.hpp"
#include "bitmap.hpp"
#include "xpu_driver.hpp"
#include "arg_loader_xpu.hpp"

namespace cce {
namespace runtime {

class XpuArgLoader;

enum class XpuThreadType : uint64_t {
    XPU_THREAD_RECYCLE,
    XPU_THREAD_MAX
};

struct XpuConfigInfo {
    double version{1.0};
    uint32_t maxStreamNum{60};
    uint32_t maxStreamDepth{1024};
    uint32_t timeoutMonitorGranularity{1000};
    uint32_t defaultTaskExeTimeout{30000};
};

class XpuDevice : public RawDevice, public ThreadRunnable {
public:
    explicit XpuDevice(const uint32_t devId);
    ~XpuDevice() noexcept override;
    rtError_t Init() override;
    rtError_t Start() override;
    rtError_t Stop() override;
    void Run(const void *param) override;
    Driver *Driver_() const override
    {
        return driver_;
    }

    XpuArgLoader *XpuArgLoader_() const
    {
        return xpuArgLoader_;
    }
    bool GetRecycleThreadRunFlag() const
    {
        return recycleThreadRunFlag_;
    }
    rtError_t InitStreamIdBitmap();
    void FreeStreamIdBitmap(const int32_t id);
    int32_t AllocStreamId() const;
    rtError_t ParseXpuConfigInfo();
    rtError_t InitXpuDriver();
    StreamSqCqManage *GetStreamSqCqManage() const override
    {
        return streamSqCqManage_;
    }
    uint32_t GetXpuStreamDepth() const
    {
        return configInfo_.maxStreamDepth;
    }
    uint32_t GetXpuMaxStream() const
    {
        return configInfo_.maxStreamNum;
    }
    rtError_t CreateRecycleThread();
    void RecycleThreadRun();
    void RecycleThreadDo() const;
	void WakeUpRecycleThread(void) override;
    rtChipType_t GetChipType() const override;
private:
    XpuArgLoader *xpuArgLoader_;
    uint32_t deviceId_;
    XpuDriver *driver_;
    Bitmap *streamIdBitmap_;
    StreamSqCqManage *streamSqCqManage_;
    XpuConfigInfo configInfo_;
	bool recycleThreadRunFlag_ = false;
    mmSem_t recycleThreadSem_;
    Thread *recycleThread_{nullptr};
};
}
}

#endif  // CCE_RUNTIME_RAW_DEVICE_HPP