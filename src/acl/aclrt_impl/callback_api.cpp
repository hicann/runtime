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
#include "init_callback_manager.h"

aclError aclInitCallbackRegisterImpl(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)
{
    return acl::InitCallbackManager::GetInstance().RegInitCallback(type, cbFunc, userData);
}

aclError aclInitCallbackUnRegisterImpl(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc)
{
    return acl::InitCallbackManager::GetInstance().UnRegInitCallback(type, cbFunc);
}

aclError aclFinalizeCallbackRegisterImpl(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)
{
    return acl::InitCallbackManager::GetInstance().RegFinalizeCallback(type, cbFunc, userData);
}

aclError aclFinalizeCallbackUnRegisterImpl(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc)
{
    return acl::InitCallbackManager::GetInstance().UnRegFinalizeCallback(type, cbFunc);
}