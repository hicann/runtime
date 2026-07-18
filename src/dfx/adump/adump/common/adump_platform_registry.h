/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef ADUMP_COMMON_ADUMP_PLATFORM_REGISTRY_H
#define ADUMP_COMMON_ADUMP_PLATFORM_REGISTRY_H

#include <functional>
#include <map>
#include <memory>
#include <mutex>
#include <new>
#include "adump_dsmi.h"

namespace Adx {

// 每个平台接口域（FeaturesSupport / Coredump / ExceptionDump / DataDump）各自拥有一份
// 独立的注册表，按接口类型 Iface 特化。平台只注册它支持的域；某平台在某域未注册，即表示
// 该域能力在此平台不可用，对应 Manager::Get() 返回 nullptr。
//
// 并发说明：同一进程内可能有多个模块（如 runtime 与 GE）通过 adump 接口触发注册，注册
// （写 map）与查询（读 map）可能来自不同线程并发发生，而 std::map 的并发读写属未定义行为。
// 因此这里用每个 Iface 独立的静态互斥锁保护 map 的所有读写；函数内局部静态量的初始化
// 由 C++11 保证线程安全，规避了跨翻译单元静态初始化顺序问题。
template<typename Iface>
class PlatformReflection {
public:
    using Factory = std::function<std::shared_ptr<Iface>()>;

    template<typename T>
    static void RegisterPlatform(PlatformType type)
    {
        std::lock_guard<std::mutex> lock(GetMutex());
        GetPlatformMap()[type] = []() -> std::shared_ptr<Iface> {
            return std::shared_ptr<Iface>(new (std::nothrow) T);
        };
    }

    static std::shared_ptr<Iface> CreatePlatform(PlatformType type)
    {
        Factory factory;
        {
            std::lock_guard<std::mutex> lock(GetMutex());
            auto& map = GetPlatformMap();
            auto it = map.find(type);
            if (it == map.end()) {
                return nullptr;
            }
            factory = it->second;  // 锁内取出工厂，锁外再构造对象，避免持锁做堆分配
        }
        return factory ? factory() : nullptr;
    }

private:
    // 函数内局部静态 map，规避跨翻译单元静态初始化顺序问题。
    static std::map<PlatformType, Factory>& GetPlatformMap()
    {
        static std::map<PlatformType, Factory> map;
        return map;
    }

    // 保护 GetPlatformMap() 读写的互斥锁，与 map 一样按 Iface 独立且惰性初始化。
    static std::mutex& GetMutex()
    {
        static std::mutex mtx;
        return mtx;
    }
};

template<typename Iface, typename T>
class PlatformRegister {
public:
    explicit PlatformRegister(PlatformType type)
    {
        PlatformReflection<Iface>::template RegisterPlatform<T>(type);
    }
};

// 一行注册某平台实现类 platformClass 到接口域 Iface 的工厂。
// 各平台 .cpp 顶部按支持的域写若干行；不支持的域不写。
#define ADUMP_PLATFORM_REGISTER(Iface, platformType, platformClass) \
    static Adx::PlatformRegister<Iface, platformClass> \
        g_adumpReg_##Iface##_##platformClass(platformType)

} // namespace Adx
#endif // ADUMP_COMMON_ADUMP_PLATFORM_REGISTRY_H
