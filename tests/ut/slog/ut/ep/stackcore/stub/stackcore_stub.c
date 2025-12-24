/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "stackcore_stub.h"
#include <sys/types.h>
#include <stdio.h>
#include <dirent.h>
#include <errno.h>
#include <string.h>

int CheckStackcoreFileNum(const char *path)
{
    DIR *dirStream = opendir(path);
    if (dirStream == NULL) {
        printf("opendir [%s]failed, res:%s\n", path, strerror(errno));
        return -1;
    }
    struct dirent* dirInfo;
    int num = 0;
    while((dirInfo = readdir(dirStream)) != NULL)
    {
        char *dname = dirInfo->d_name;
        if (strcmp(dname, ".") == 0 || strcmp(dname, "..") == 0) {
            continue;
        }
        printf("dir name: %s\n", dname);
        if (dirInfo->d_type == DT_REG) {
            num++;
        }
    }
    (void)closedir(dirStream);
    return num;
}

uintptr_t StackFrame_stub(int layer, uintptr_t fp, char *data, unsigned int len)
{
    static uintptr_t res = 10;
    (void)snprintf_s(data, len, len - 1, "#%d test for stackcore", layer);
    return res--;
}

int32_t raise_stub(int32_t sig)
{
    (void)sig;
    return 0;
}