/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef OP_API_COMMON_INC_OPDEV_INTERNAL_OP_CACHE_CONTAINER_H
#define OP_API_COMMON_INC_OPDEV_INTERNAL_OP_CACHE_CONTAINER_H

#include <type_traits>
#include <utility>
#include <algorithm>
#include <functional>

namespace op {
namespace internal {

const size_t primeList[] = {
    2ul, 3ul, 5ul, 7ul, 11ul, 13ul, 17ul, 19ul, 23ul, 29ul, 31ul,
    37ul, 41ul, 43ul, 47ul, 53ul, 59ul, 61ul, 67ul, 71ul, 73ul, 79ul,
    83ul, 89ul, 97ul, 103ul, 109ul, 113ul, 127ul, 137ul, 139ul, 149ul,
    157ul, 167ul, 179ul, 193ul, 199ul, 211ul, 227ul, 241ul, 257ul,
    277ul, 293ul, 313ul, 337ul, 359ul, 383ul, 409ul, 439ul, 467ul,
    503ul, 541ul, 577ul, 619ul, 661ul, 709ul, 761ul, 823ul, 887ul,
    953ul, 1031ul, 1109ul, 1193ul, 1289ul, 1381ul, 1493ul, 1613ul,
    1741ul, 1879ul, 2029ul, 2179ul, 2357ul, 2549ul, 2753ul, 2971ul,
    3209ul, 3469ul, 3739ul, 4027ul, 4349ul, 4703ul, 5087ul, 5503ul,
    5953ul, 6427ul, 6949ul, 7517ul, 8123ul, 8783ul, 9497ul, 10273ul,
    11113ul, 12011ul, 12983ul, 14033ul, 15173ul, 16411ul, 17749ul,
    19183ul, 20753ul, 22447ul, 24281ul, 26267ul, 28411ul, 30727ul,
    33223ul, 35933ul, 38873ul, 42043ul, 45481ul, 49201ul, 53201ul,
    57557ul, 62233ul, 67307ul, 72817ul, 78779ul, 85229ul, 92203ul,
    99733ul, 107897ul, 116731ul, 126271ul, 136607ul, 147793ul,
    159871ul, 172933ul, 187091ul, 202409ul, 218971ul, 236897ul,
    256279ul, 277261ul, 299951ul, 324503ul, 351061ul, 379787ul,
    410857ul, 444487ul, 480881ul, 520241ul, 562841ul, 608903ul,
    658753ul, 712697ul, 771049ul, 834181ul, 902483ul, 976369ul,
    1056323ul, 1142821ul, 1236397ul, 1337629ul, 1447153ul, 1565659ul,
    1693859ul, 1832561ul, 1982627ul, 2144977ul, 2320627ul, 2510653ul,
    2716249ul, 2938679ul, 3179303ul, 3439651ul, 3721303ul, 4026031ul,
    4355707ul, 4712381ul, 5098259ul, 5515729ul, 5967347ul, 6456007ul,
    6984629ul, 7556579ul, 8175383ul, 8844859ul, 9569143ul, 10352717ul,
    11200489ul, 12117689ul, 13109983ul, 14183539ul, 15345007ul,
    16601593ul, 17961079ul, 19431899ul, 21023161ul, 22744717ul,
    24607243ul, 26622317ul, 28802401ul, 31160981ul, 33712729ul,
    36473443ul, 39460231ul, 42691603ul, 46187573ul, 49969847ul,
    54061849ul, 58488943ul, 63278561ul, 68460391ul, 74066549ul,
    80131819ul, 86693767ul, 93793069ul, 101473717ul, 109783337ul,
    118773397ul, 128499677ul, 139022417ul, 150406843ul, 162723577ul,
    176048909ul, 190465427ul, 206062531ul, 222936881ul, 241193053ul,
    260944219ul, 282312799ul, 305431229ul, 330442829ul, 357502601ul,
    386778277ul, 418451333ul, 452718089ul, 489790921ul, 529899637ul,
    573292817ul, 620239453ul, 671030513ul, 725980837ul, 785430967ul,
    849749479ul, 919334987ul, 994618837ul, 1076067617ul, 1164186217ul,
    1259520799ul, 1362662261ul, 1474249943ul, 1594975441ul, 1725587117ul,
    1866894511ul, 2019773507ul, 2185171673ul, 2364114217ul, 2557710269ul,
    2767159799ul, 2993761039ul, 3238918481ul, 3504151727ul, 3791104843ul,
    4101556399ul, 4294967291ul
};

struct ListHead {
    ListHead()
    {
        prev_ = this;
        next_ = this;
    }

    inline void Add(ListHead *head)
    {
        head->next_->prev_ = this;
        next_ = head->next_;
        prev_ = head;
        head->next_ = this;
    }

    inline void Del()
    {
        next_->prev_ = prev_;
        prev_->next_ = next_;
    }

    inline bool Empty()
    {
        return next_ == this;
    }

    ListHead *prev_ = nullptr;
    ListHead *next_ = nullptr;
};

struct HlistNode {
    HlistNode() = default;

    inline void Del()
    {
        HlistNode *next = next_;
        HlistNode **pprev = pprev_;
        *pprev = next;
        if (next) {
            next->pprev_ = pprev;
        }
    }

    HlistNode *next_ = nullptr;
    HlistNode **pprev_ = nullptr;
};

struct HlistHead {
    HlistHead() = default;
    bool empty()
    {
        return !first_;
    }

    inline void Add(HlistNode *node)
    {
        node->next_ = first_;
        if (first_) {
            first_->pprev_ = &node->next_;
        }
        first_ = node;
        node->pprev_ = &first_;
    }
    struct HlistNode *first_ = nullptr;
};

class Lru {
public:
    Lru() = default;
    ~Lru() = default;

    inline ListHead *Head()
    {
        return lruList_.next_;
    }

    inline ListHead *Tail()
    {
        return lruList_.prev_;
    }

    inline ListHead *Sentinel()
    {
        return &lruList_;
    }

    void Active(ListHead &entry)
    {
        entry.Del();
        entry.Add(&lruList_);
    }

    void Del(ListHead &entry)
    {
        entry.Del();
    }
private:
    ListHead lruList_;
};

template<typename KeyType,
         typename ValueType,
         std::enable_if_t<std::is_base_of_v<KeyType, ValueType>, bool> = true,
         std::enable_if_t<std::is_base_of_v<ListHead, ValueType>, bool> = true,
         std::enable_if_t<std::is_base_of_v<HlistNode, ValueType>, bool> = true>
class OpCacheContainerIterator {
public:
    using key_type = KeyType;
    using value_type = ValueType;
    using pointer = value_type *;
    using reference = value_type &;

    OpCacheContainerIterator(pointer ptr, ListHead *sentinel, bool reverse = false)
        : ptr_(ptr), sentinel_(sentinel), reverse_(reverse) {}

    OpCacheContainerIterator(const OpCacheContainerIterator<KeyType, ValueType> &iter)
        : ptr_(iter.ptr_) {}

    inline reference operator*() const
    {
        return *ptr_;
    }

    inline pointer operator->() const
    {
        return ptr_;
    }

    inline bool operator==(const OpCacheContainerIterator<KeyType, ValueType> &iter)
    {
        return ptr_ == iter.operator->();
    }

    inline bool operator!=(const OpCacheContainerIterator<KeyType, ValueType> &iter)
    {
        return ptr_ != iter.operator->();
    }

    inline OpCacheContainerIterator &operator++()
    {
        ListHead *node = dynamic_cast<ListHead *>(ptr_);
        ptr_ = reverse_ ? static_cast<pointer>(node->prev_) : static_cast<pointer>(node->next_);
        node = dynamic_cast<ListHead *>(ptr_);
        if (node == sentinel_) {
            ptr_ = nullptr;
        }
        return *this;
    }

    OpCacheContainerIterator operator++(int)
    {
        OpCacheContainerIterator tmp = *this;
        ++*this;
        return tmp;
    }
private:
    pointer ptr_;
    ListHead *sentinel_ = nullptr;
    bool reverse_ = false;
};

template<typename KeyType,
         typename ValueType,
         typename HashFunc = std::hash<KeyType>,
         typename EqualFunc = std::equal_to<KeyType>,
         std::enable_if_t<std::is_base_of_v<KeyType, ValueType>, bool> = true,
         std::enable_if_t<std::is_base_of_v<ListHead, ValueType>, bool> = true,
         std::enable_if_t<std::is_base_of_v<HlistNode, ValueType>, bool> = true>
class OpCacheContainer {
public:
    friend class OpCacheContainerIterator<KeyType, ValueType>;

    using key_type = KeyType;
    using value_type = ValueType;
    using hasher = HashFunc;
    using key_equal = EqualFunc;
    using pointer = value_type *;
    using reference = value_type &;

    OpCacheContainer(const hasher &hash = hasher(), const key_equal &equal = key_equal())
        : hasher_(hash), equal_(equal) {}

    ~OpCacheContainer()
    {
        clear();
    }

    void clear()
    {
        for (auto it = begin(); it != end();) {
            pointer value = it.operator->();
            ++it;
            erase(*value);
            delete value;
        }
        delete[] buckets_;
    }

    bool init(size_t capacity)
    {
        constexpr size_t INIT_BUCKET_NUM = 3;
        constexpr size_t BUCKET_NUM_FACTOR = 2;
        size_t n = INIT_BUCKET_NUM;
        while (n <= capacity) {
            n = *std::lower_bound(primeList, primeList + sizeof(primeList) / sizeof(size_t) - 1, n);
            n *= BUCKET_NUM_FACTOR;
        }
        bucketNum_ = *std::lower_bound(primeList, primeList + sizeof(primeList) / sizeof(size_t) - 1, n);
        buckets_ = new HlistHead[bucketNum_];
        return true;
    }

    using iterator = OpCacheContainerIterator<key_type, value_type>;
    iterator find(const key_type &key)
    {
        HlistHead &bucket = GetBucket(key);
        if (!bucket.empty()) {
            for (HlistNode *node = bucket.first_; node; node = node->next_) {
                pointer value = static_cast<pointer>(node);
                if (equal_(key, dynamic_cast<key_type &>(*value))) {
                    lru_.Active(dynamic_cast<ListHead &>(*value));
                    return iterator(value, lru_.Sentinel());
                }
            }
        }
        return end();
    }

    std::pair<iterator, bool> insert(reference value)
    {
        key_type &key = dynamic_cast<key_type &>(value);
        HlistHead &bucket = GetBucket(key);
        if (!bucket.empty()) {
            for (HlistNode *node = bucket.first_; node; node = node->next_) {
                pointer tmp = static_cast<pointer>(node);
                if (equal_(key, dynamic_cast<key_type &>(*tmp))) {
                    lru_.Active(dynamic_cast<ListHead &>(*tmp));
                    return std::make_pair(iterator(tmp, lru_.Sentinel()), false);
                }
            }
        }
        pointer pv = new value_type(value);
        bucket.Add(dynamic_cast<HlistNode *>(pv));
        lru_.Active(dynamic_cast<ListHead &>(*pv));
        entryNum_++;
        return std::make_pair(iterator(pv, lru_.Sentinel()), true);
    }

    bool erase(reference value)
    {
        HlistNode &hnode = dynamic_cast<HlistNode &>(value);
        hnode.Del();
        ListHead &node = dynamic_cast<ListHead &>(value);
        lru_.Del(node);
        entryNum_--;
        return true;
    }

    inline iterator begin()
    {
        return empty() ? end() : iterator(static_cast<pointer>(lru_.Head()), lru_.Sentinel());
    }

    inline iterator end()
    {
        return iterator(nullptr, lru_.Sentinel());
    }

    inline iterator rbegin()
    {
        return empty() ? rend() : iterator(static_cast<pointer>(lru_.Tail()), lru_.Sentinel(), true);
    }

    inline iterator rend()
    {
        return iterator(nullptr, lru_.Sentinel());
    }

    inline size_t size() const
    {
        return entryNum_;
    }

    inline bool empty() const
    {
        return entryNum_ == 0;
    }

    inline size_t bucket(const KeyType &key)
    {
        return hasher_(key) % bucketNum_;
    }

    inline size_t bucket_count() const
    {
        return bucketNum_;
    }

    reference operator[](const KeyType &key)
    {
        HlistHead &bucket = GetBucket(key);
        if (!bucket.empty()) {
            for (HlistNode *node = bucket.first_; node; node = node->next_) {
                pointer value = static_cast<pointer>(node);
                if (equal_(key, dynamic_cast<key_type &>(*value))) {
                    lru_.Active(dynamic_cast<ListHead &>(*value));
                    return *value;
                }
            }
        }
        pointer pv = new value_type();
        bucket.Add(dynamic_cast<HlistNode *>(pv));
        lru_.Active(dynamic_cast<ListHead &>(*pv));
        entryNum_++;
        return *pv;
    }

private:
    inline HlistHead &GetBucket(const key_type &key)
    {
        return buckets_[bucket(key)];
    }

    hasher hasher_ = nullptr;
    key_equal equal_ = nullptr;
    size_t entryNum_ = 0;
    size_t bucketNum_ = 0;
    HlistHead *buckets_ = nullptr;
    Lru lru_;
    uint8_t reserved_field_[8];
};

}
}
#endif