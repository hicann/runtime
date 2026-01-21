/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <string.h>
#include "log_inner.h"
#include "runtime/rt.h"
#include "ge_executor_rt.h"
#include "mmpa_api.h"
#include "ref_obj.h"
#include "acl/acl.h"

#ifdef __cplusplus
extern "C"{
#endif

static RefObj gInitRefCount;

static inline bool PathIsLegal(const char *cfg) {
  mmFileHandle *fd = mmOpenFile(cfg, FILE_READ);
  if (fd == NULL) {
    return false;
  }
  (void)mmSeekFile(fd, 0, MM_SEEK_FILE_END);
  bool isLegal = mmTellFile(fd) == 0 ? false : true;
  mmCloseFile(fd);
  return isLegal;
}

static void *InitHookFunc(RefObj *obj, const void *userData) {
  const rtError_t rtErr = rtInit();
  if (rtErr != RT_ERROR_NONE) {
    ACL_LOG_INNER_ERROR("rt init fail, ret = %d", rtErr);
    return NULL;
  }
  Status ret = GeInitialize();
  if (ret != (Status)SUCCESS) {
    ACL_LOG_INNER_ERROR("ge init fail, ret = %d", ret);
    (void)rtDeinit();
    return NULL;
  }
  const char *configPath = (const char *)userData;
  if (PathIsLegal(configPath)) {
    ret = GeDbgInit(configPath);
    if (ret != (Status)SUCCESS) {
      (void)GeFinalize();
      (void)rtDeinit();
      return NULL;
    }
  }
  return obj;
}

aclError aclInit(const char *configPath) {
  if (GetObjRefWithUserData(&gInitRefCount, configPath, InitHookFunc) == NULL) {
    ACL_LOG_ERROR("Add refCount err");
    return ACL_ERROR_INTERNAL_ERROR;
  }
  ACL_LOG_INFO("Increased refCount: %lu", (uint64_t)gInitRefCount.refCount);
  return ACL_SUCCESS;
}

static void DeinitHookFunc(RefObj *obj) {
  (void)obj;
  (void)GeDbgDeInit();
  (void)GeFinalize();
  (void)rtDeinit();
}
aclError aclFinalize() {
  ReleaseObjRef(&gInitRefCount, DeinitHookFunc);
  ACL_LOG_INFO("Decreased refCount: %lu", (uint64_t)gInitRefCount.refCount);
  return ACL_SUCCESS;
}

aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion,
                         int32_t *patchVersion) {
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(majorVersion);
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(minorVersion);
  ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(patchVersion);
  // Acl version is (*majorVersion).(*minorVersion).(*patchVersion) 
  *majorVersion = ACL_MAJOR_VERSION;
  *minorVersion = ACL_MINOR_VERSION;
  *patchVersion = ACL_PATCH_VERSION;
  ACL_LOG_INFO("acl version is %d.%d.%d", *majorVersion, *minorVersion,
               *patchVersion);

  return ACL_SUCCESS;
}

const char *aclGetRecentErrMsg() {
  return GetErrorMessage();
}

#ifdef __cplusplus
}
#endif