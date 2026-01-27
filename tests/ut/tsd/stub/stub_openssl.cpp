/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "openssl/md5.h"
#include <iostream>
int MD5_Init(MD5_CTX *c)
{
    return 1;
}

int MD5_Update(MD5_CTX *c, const void *data, size_t len)
{
    return 1;
}

int MD5_Final(unsigned char *md, MD5_CTX *c)
{
    if (md == nullptr) {
        return 0;
    } else {
        for (int i = 0; i < 16; ++i) {
            md[i] = i;
        }
    }
    return 1;
}

void SHA256(const unsigned char *message, size_t message_len, unsigned char *hash)
{
    std::cout<<"thi is fake SHA256" <<std::endl;
    return;
}