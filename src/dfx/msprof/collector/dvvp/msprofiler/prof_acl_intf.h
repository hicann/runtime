/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef PROF_ACL_API_H
#define PROF_ACL_API_H
namespace Msprof {
namespace Engine {
namespace Intf {
enum ProfType {
    ACL_API_TYPE,
    ACL_GRPH_API_TYPE,
    OP_TYPE
};

enum AclProfOpType {
    ACL_OP_DESC_SIZE,
    ACL_OP_TYPE_LEN,
    ACL_OP_NUM,
    ACL_OP_TYPE,
    ACL_OP_NAME_LEN,
    ACL_OP_NAME,
    ACL_OP_START,
    ACL_OP_END,
    ACL_OP_DURATION,
    ACL_OP_GET_FLAG,
    ACL_OP_GET_ATTR,
};
}
}
}
#endif
