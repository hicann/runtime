/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ASCEND_RUNTIME_INIT_CALLBACK_MANAGER_H_
#define ASCEND_RUNTIME_INIT_CALLBACK_MANAGER_H_

#include <map>
#include <mutex>
#include "acl/acl_rt.h"

namespace acl {
class ACL_FUNC_VISIBILITY InitCallbackManager {
 public:
  static InitCallbackManager &GetInstance();

  aclError RegInitCallback(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData);
  aclError UnRegInitCallback(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc);
  aclError NotifyInitCallback(aclRegisterCallbackType type, const char *configStr, size_t len);

  aclError RegFinalizeCallback(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData);
  aclError UnRegFinalizeCallback(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc);
  aclError NotifyFinalizeCallback(aclRegisterCallbackType type);

 private:
  InitCallbackManager();
  ~InitCallbackManager() = default;
  InitCallbackManager(const InitCallbackManager &other) = delete;
  InitCallbackManager &operator==(const InitCallbackManager &other) = delete;
  InitCallbackManager(const InitCallbackManager &&other) = delete;
  InitCallbackManager &operator==(const InitCallbackManager &&other) = delete;

 private:
  std::multimap<aclRegisterCallbackType, std::pair<aclInitCallbackFunc, void*>> initCallbackMap_;
  std::multimap<aclRegisterCallbackType, std::pair<aclFinalizeCallbackFunc, void*>> finalizeCallbackMap_;
  std::recursive_mutex &mutex_;
};
}

#endif  //ASCEND_RUNTIME_INIT_CALLBACK_MANAGER_H_