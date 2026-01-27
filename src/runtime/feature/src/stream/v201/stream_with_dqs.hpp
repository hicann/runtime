/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef __CCE_RUNTIME_STREAM_WITH_DQS_HPP__
#define __CCE_RUNTIME_STREAM_WITH_DQS_HPP__
#include "stream_david.hpp"
#include "tsch_cmd.h"
#include "task_dqs.hpp"
#include "count_notify.hpp"
#include "notify_c.hpp"

namespace cce {
namespace runtime {

class StreamWithDqs : public DavidStream {
public:
    using DavidStream::DavidStream;
    ~StreamWithDqs() override;

    rtError_t SetupByFlagAndCheck(void) override;
    rtError_t Setup(void) override;
    rtError_t TearDown(const bool terminal = false, bool flag = true) override;
    rtError_t SetDqsSchedCfg(const rtDqsSchedCfg_t * const cfg);

    stars_dqs_ctrl_space_t *GetDqsCtrlSpace() const
    {
        return dqsCtrlSpace_;
    }

    void SetDqsNotify(Notify *notify)
    {
        dqsNotify_ = notify;
    }
 
    const Notify *GetDqsNotify() const
    {
        return dqsNotify_;
    }
 
    void SetDqsCountNotify(CountNotify *notify)
    {
        dqsCountNotify_ = notify;
    }
    
    const CountNotify *GetDqsCountNotify() const
    {
        return dqsCountNotify_;
    }

    stars_dqs_inter_chip_space_t *GetDqsInterChipSpace() const
    {
        return dqsInterChipSpace_;
    }

    void SetAccSubInfo(const stars_queue_subscribe_acc_param_t &param)
    {
        accSubInfo_ = param;
    }

private:
    rtError_t CreateDqsCtrlSpace(void);
    rtError_t DestroyDqsCtrlSpace(void);
    rtError_t DestroyAccSubInfo(void);
    rtError_t SetStreamCtrlSpaceInfo(const rtDqsSchedCfg_t * const dqsSchedCfg);
    rtError_t SetCtrlSpaceInputQueInfo(const rtDqsSchedCfg_t * const dqsSchedCfg);
    rtError_t SetCtrlSpaceOutputQueInfo(const rtDqsSchedCfg_t * const dqsSchedCfg);
    rtError_t InitDqsInterChipSpace(void);

    void SetDqsCtrlSpace(stars_dqs_ctrl_space_t *ctrlSpace)
    {
        dqsCtrlSpace_ = ctrlSpace;
    }

    void SetDqsInterChipSpace(stars_dqs_inter_chip_space_t *interChipSpace)
    {
        dqsInterChipSpace_ = interChipSpace;
    }

    Notify *dqsNotify_ = nullptr;
    CountNotify *dqsCountNotify_ = nullptr;
    stars_dqs_ctrl_space_t *dqsCtrlSpace_ = nullptr;
    stars_dqs_inter_chip_space_t *dqsInterChipSpace_ = nullptr;
    stars_queue_subscribe_acc_param_t accSubInfo_ = {};
};

} // runtime
} // cce
#endif // __CCE_RUNTIME_STREAM_WITH_DQS_HPP__