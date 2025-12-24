/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "log_file_dump_c.h"
#include "log_get_file.h"
#include "server_register.h"
#include "log_print.h"
#include "log_system_api.h"
using namespace Adx;

int32_t FileDumpInit(void)
{
    int32_t err = SYS_ERROR;
    std::unique_ptr<AdxComponent> cpn(new(std::nothrow)LogGetFile());
    ONE_ACT_ERR_LOG(cpn == nullptr, return err, "init component error");
    err = AdxRegisterComponentFunc(HDC_SERVICE_TYPE_IDE_FILE_TRANS, cpn);
    ONE_ACT_ERR_LOG(err != SYS_OK, return err, "register component func error");
    return err;
}

void FileDumpExit(void)
{
}