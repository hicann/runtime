/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "memory_list.hpp"
#include "error_message_manage.hpp"

namespace cce {
namespace runtime {
MemoryList::MemoryList() : NoCopy() {}

MemoryList::~MemoryList() noexcept
{
    ListNode* cur = head_;
    ListNode* next;
    while (cur != nullptr) {
        next = cur->next;
        delete cur->block;
        delete cur;
        cur = next;
    }
}

// 添加内存块到链表
rtError_t MemoryList::AddBlock(void *address, size_t size)
{
    rtError_t error = RT_ERROR_NONE;
    MemoryBlock* block = new (std::nothrow) MemoryBlock;
    NULL_PTR_RETURN(block , RT_ERROR_MEMORY_ALLOCATION);
    block->address = address;
    block->size = size;

    ListNode* node = new (std::nothrow) ListNode;
    COND_GOTO_ERROR_MSG_AND_ASSIGN_CALL(ERR_MODULE_SYSTEM, node == nullptr, BLOCK_FREE,
        error, RT_ERROR_MEMORY_ALLOCATION, "allocate memory failed.");
    node->block = block;
    node->next = nullptr;

    // 如果链表为空，将头结点和尾节点都指向新节点
    if (head_ == nullptr) {
        head_ = node;
        tail_ = node;
    } else {
        // 否则将新节点添加到链表末尾
        tail_->next = node;
        tail_ = node;
    }
    return error;
BLOCK_FREE:
    DELETE_O(block);
    return RT_ERROR_MEMORY_ALLOCATION;
}

// 获取符合要求的内存块
void* MemoryList::GetBlock(size_t size)
{
    ListNode* node = head_;
    while (node != nullptr) {
        if (node->block->size >= size) {
            void* address = node->block->address;
            if (node->block->size == size) {
                // 从链表中删除节点
                RemoveNode(node);
            } else {
                // 更新链表中的地址
                node->block->address = RtPtrToPtr<void *>(RtPtrToPtr<uint8_t *>(node->block->address) + size);
                node->block->size -= size;
            }
            return address;
        }
        node = node->next;
    }
    return nullptr; // 没有找到符合要求的内存块
}

// 删除链表中的节点
void MemoryList::RemoveNode(ListNode* node)
{
    if (node == head_) {
        head_ = node->next;
        if (node == tail_) {
            tail_ = nullptr; // 如果删除的是唯一节点，更新尾指针
        }
    } else {
        ListNode* prev = head_;
        while (prev->next != node) {
            prev = prev->next;
        }
        prev->next = node->next;
        if (node == tail_) {
            tail_ = prev; // 如果删除的是尾节点，更新尾指针
        }
    }
    delete node->block;
    delete node;
}

// 查看地址是否在链表中存储
bool MemoryList::ContainsAddress(void* address) const
{
    ListNode* current = head_;
    
    while (current != nullptr) {
        // 使用指针比较来检查地址是否在当前内存块范围内
        int8_t* blockStart = static_cast<int8_t*>(current->block->address);
        int8_t* blockEnd = blockStart + current->block->size;

        if (address >= blockStart && address < blockEnd) {
            return true; // 找到地址
        }
        current = current->next;
    }
    
    return false; // 没有找到地址
}
}  // namespace runtime
}  // namespace cce
