/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "acl_rt_impl.h"

#include "runtime/rts/rts_model.h"
#include "common/log_inner.h"
#include "common/error_codes_inner.h"
#include "common/prof_reporter.h"

#ifdef __cplusplus
extern "C" {
#endif

aclError aclrtCreateLabelImpl(aclrtLabel *label)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateLabel);
    ACL_LOG_INFO("start to execute aclrtCreateLabel");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(label);

    ACL_REQUIRES_RTS_OK(rtsLabelCreate(static_cast<rtLabel_t*>(label)));

    ACL_LOG_INFO("successfully execute aclrtCreateLabel");
    return ACL_SUCCESS;
}

aclError aclrtSetLabelImpl(aclrtLabel label, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSetLabel);
    ACL_LOG_INFO("start to execute aclrtSetLabel");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(label);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    ACL_REQUIRES_RTS_OK(rtsLabelSet(static_cast<rtLabel_t>(label), static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclrtSetLabel");
    return ACL_SUCCESS;
}

aclError aclrtDestroyLabelImpl(aclrtLabel label)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyLabel);
    ACL_LOG_INFO("start to execute aclrtDestroyLabel");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(label);

    ACL_REQUIRES_RTS_OK(rtsLabelDestroy(static_cast<rtLabel_t>(label)));

    ACL_LOG_INFO("successfully execute aclrtDestroyLabel");
    return ACL_SUCCESS;
}

aclError aclrtCreateLabelListImpl(aclrtLabel *labels, size_t num, aclrtLabelList *labelList)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtCreateLabelList);
    ACL_LOG_INFO("start to execute aclrtCreateLabelList, num is [%zu]", num);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(labels);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(labelList);

    ACL_REQUIRES_RTS_OK(rtsLabelSwitchListCreate(static_cast<rtLabel_t*>(labels), num,
        reinterpret_cast<void**>(labelList)));

    ACL_LOG_INFO("successfully execute aclrtCreateLabelList");
    return ACL_SUCCESS;
}

aclError aclrtDestroyLabelListImpl(aclrtLabelList labelList)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtDestroyLabelList);
    ACL_LOG_INFO("start to execute aclrtDestroyLabelList");
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(labelList);

    ACL_REQUIRES_RTS_OK(rtsLabelSwitchListDestroy(reinterpret_cast<void*>(labelList)));

    ACL_LOG_INFO("successfully execute aclrtDestroyLabelList");
    return ACL_SUCCESS;
}

aclError aclrtSwitchLabelByIndexImpl(void *ptr, uint32_t maxValue, aclrtLabelList labelList, aclrtStream stream)
{
    ACL_PROFILING_REG(acl::AclProfType::AclrtSwitchLabelByIndex);
    ACL_LOG_INFO("start to execute aclrtSwitchLabelByIndex, maxValue is [%u]", maxValue);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(ptr);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(labelList);
    ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(stream);

    ACL_REQUIRES_RTS_OK(rtsLabelSwitchByIndex(ptr, maxValue, reinterpret_cast<void*>(labelList),
        static_cast<rtStream_t>(stream)));

    ACL_LOG_INFO("successfully execute aclrtSwitchLabelByIndex");
    return ACL_SUCCESS;
}
#ifdef __cplusplus
}
#endif
