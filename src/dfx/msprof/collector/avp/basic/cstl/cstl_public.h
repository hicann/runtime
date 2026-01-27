/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef BASIC_CSTL_CSTL_PUBLIC_H
#define BASIC_CSTL_CSTL_PUBLIC_H
#include <stdint.h>
#include <stdbool.h>
#define CSTL_OK (0)
#define CSTL_ERR (-1)
typedef void (*CstlFreeFunc)(void *ptr);

/**
 * @ingroup cstl_public
 * @brief： 比较函数原型，用于排序场景
 * @attention 注意：这里只定义了比较函数原型，由于不知道数据类型和长度，因此钩子函数需要业务自己实现。\n
 * 当前源码内有默认的比较函数：该函数不对外提供，但是用户如果不指定默认比较方法会调用它，对此简单解释：
 * 其比较方式为把当前数据转化为有符号数进行比较，即处理含有负数的场景，比较方式为升序。
 * 如果用户需要存储的数据是无符号整数类型。此时排序结果可能不是预期的。
 * 这种场景下的数据比较，用户需要自定义比较函数来解决这种情况的数据比较。
 * 例如对于大数A = uintptr_t(-1) 和 大数 B = 1ULL << 50，目前的函数会认为A < B，实际上A是大于B的。
 * 综上所述，用户对于使用什么样的比较函数，应该根据自己的数据类型来编写(包括降序或其它比较规则)
 * @param key1    [IN] key1
 * @param key2    [IN] key2
 * @retval >0 升序排序
 * @retval =0 不做交换
 * @retval <0 降序排序
 */
typedef int32_t (*CstlKeyCmpFunc)(uintptr_t key1, uintptr_t key2);

#define CSTL_CONTAINER_OF(ptr, type, member) \
    ((type *)((uintptr_t)(ptr) - (uintptr_t)(&(((type *)0)->member))))
#endif
