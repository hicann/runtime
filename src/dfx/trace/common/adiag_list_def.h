/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef TRACE_LIST_DEF_H
#define TRACE_LIST_DEF_H

#include <stddef.h>
#include <stdbool.h>

#ifdef __cplusplus
extern "C" {
#endif

struct ListHead {
    struct ListHead *next;
    struct ListHead *prev;
};

#define INIT_LIST_HEAD(ptr) do { \
    (ptr)->next = (ptr); (ptr)->prev = (ptr); \
} while (0)

/**
 * @brief       Insert a new entry between two known consecutive entries.
 * @param [in]  item:    new entry to be added
 * @param [in]  prev:    previous entry to add it after
 * @param [in]  next:    next entry to add it before
 * @return      NA
 */
static inline void ListAdd(struct ListHead *item, struct ListHead *prev, struct ListHead *next)
{
    next->prev = item;
    item->next = next;
    item->prev = prev;
    prev->next = item;
}

/**
 * @brief       Insert a new entry after the specified head.
 * @param [in]  item:    new entry to be added
 * @param [in]  head:    list head to add it after
 * @return      NA
 */
static inline void ListAddAfterEntry(struct ListHead *item, struct ListHead *head)
{
    ListAdd(item, head, head->next);
}

/**
 * @brief       Insert a new entry before the specified head.
 * @param [in]  item:    new entry to be added
 * @param [in]  head:    list head to add it before
 * @return      NA
 */
static inline void ListAddBeforeEntry(struct ListHead *item, struct ListHead *head)
{
    ListAdd(item, head->prev, head);
}

/*
 * @brief       Delete an existing entry between two known consecutive entries.
 * @param [in]  prev:    previous entry to delete it after
 * @param [in]  next:    next entry to delete it before
 * @return      NA
 */
static inline void ListDel(struct ListHead *prev, struct ListHead *next)
{
    next->prev = prev;
    prev->next = next;
}

/**
 * @brief       Delete an existing entry specified by entry.
 * @param [in]  entry:    entry to be deleted
 * @return      NA
 */
static inline void ListDelEntry(struct ListHead *entry)
{
    ListDel(entry->prev, entry->next);
    entry->next = entry;
    entry->prev = entry;
}

/**
 * @brief       Check the head list empty or not specified by head.
 * @param [in]  head:    list head to be checked
 * @return      true or false
 */
static inline bool ListEmpty(const struct ListHead *head)
{
    return (const struct ListHead *)head->next == head;
}

#define LIST_ENTRY(ptr, type, member) \
    ((type *)((char *)(ptr) - offsetof(type, member)))

#define LIST_FIRST_ENTRY(ptr, type, member) \
    LIST_ENTRY((ptr)->next, type, member)

#define LIST_FOR_EACH(pos, head) \
    for ((pos) = (head)->next; ((pos) != NULL) && ((head) != (pos)); (pos) = (pos)->next)

#define LIST_FOR_EACH_ENTRY(pos, head, type, member) \
    for ((pos) = LIST_ENTRY((head)->next, type, member); \
        ((pos) != NULL) && (&(pos)->member != (head)); \
        (pos) = LIST_ENTRY((pos)->member.next, type, member))

#ifdef __cplusplus
}
#endif

#endif