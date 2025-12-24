/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef CCE_RUNTIME_MEMORY_LIST_HPP
#define CCE_RUNTIME_MEMORY_LIST_HPP

#include <mutex>
#include <vector>
#include "base.hpp"

namespace cce {
namespace runtime {

// 内存块结构体
struct MemoryBlock {
    void* address; // 指向内存块的起始地址
    size_t size;   // 内存块的大小
};

// 链表节点结构体
struct ListNode {
    MemoryBlock* block; // 指向内存块结构体的指针
    ListNode* next;     // 指向下一个节点的指针
};

class MemoryList : public NoCopy {
public:
    explicit MemoryList();

    ~MemoryList() noexcept override;
    // 调用前确定是否需要加锁保护
    rtError_t AddBlock(void *address, size_t size);
    // 调用前确定是否需要加锁保护
    void* GetBlock(size_t size);
    // 查看地址是否在链表中存储
    bool ContainsAddress(void* address) const;
private:
    void RemoveNode(ListNode* node);

    ListNode* head_ = nullptr;
    ListNode* tail_ = nullptr;
};
}
}
#endif  // CCE_RUNTIME_MEMORY_LIST_HPP
