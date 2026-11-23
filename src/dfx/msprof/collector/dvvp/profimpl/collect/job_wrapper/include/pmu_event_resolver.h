/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PMU_EVENT_RESOLVER_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PMU_EVENT_RESOLVER_H

#include <cstdint>
#include <string>
#include <vector>

namespace Analysis {
namespace Dvvp {
namespace HostPmu {
// One PMU counter reading. "name" is the name the user asked for; source records
// which resolution path produced it, so a report never mixes generic and raw events in one
// ratio (they are not interchangeable: cache-references and l1d_cache differ by ~0.5% on
// Kunpeng-920, which is enough to flip a cache conclusion).
struct PmuCounterValue {
    std::string name;
    std::string source; // "generic" | "sysfs" | "software"
    // "value" is what the analyser uses: the kernel total scaled by timeEnabled/timeRunning when the
    // counter had to be multiplexed. "rawValue" is the kernel total itself, and the two time fields
    // are what the kernel reported for this read. Keeping all three lets a consumer reproduce the
    // scaling instead of trusting it; they are equal when no multiplexing happened.
    uint64_t value = 0;
    uint64_t rawValue = 0;
    uint64_t timeEnabled = 0;
    uint64_t timeRunning = 0;
    bool valid = false;
};

// Per-CPU or per-process group of counters read at one point in time.
struct PmuCounterGroup {
    uint64_t timestampNs = 0;
    int32_t pid = -1; // -1 means system wide
    int32_t cpu = -1; // -1 means all CPUs (pid-based open)
    std::vector<PmuCounterValue> counters;
};

struct PmuEventSpec {
    std::string name;
    uint32_t type = 0;
    uint64_t config = 0;
    std::string source;
};

// Resolves a user supplied event name into a perf_event_attr type/config pair.
// Resolution order:
//   1. A sysfs PMU event, e.g. "l1d_cache" from
//      /sys/bus/event_source/devices/<pmu>/events/l1d_cache.
//   2. A synthetic hardware alias, e.g. "cycles" -> PERF_TYPE_HARDWARE / PERF_COUNT_HW_CPU_CYCLES.
//   3. A software event, e.g. "page-faults" -> PERF_TYPE_SOFTWARE / PERF_COUNT_SW_PAGE_FAULTS.
//      These are kernel counters rather than PMU ones: they need no PMU support and no sysfs
//      lookup, which is why they still work on a node whose CPU PMU is missing or restricted.
// An event that resolves to none of the above is reported as invalid together with a reason,
// instead of being silently dropped: on armv8 there is no BRANCH_INSTRUCTIONS event, and a
// user who asked for it must be told so rather than shown a zero.
class PmuEventResolver {
public:
    PmuEventResolver() = default;
    ~PmuEventResolver() = default;

    // Returns false and fills "reason" when the name cannot be resolved.
    bool Resolve(const std::string& name, PmuEventSpec& spec, std::string& reason) const;

    // Resolves a name that came from --os-events, i.e. a kernel counter by definition. Only the
    // software table is consulted. This is not just a stricter Resolve: the general path prefers a
    // sysfs event over a software one with the same name, so a node that happens to expose a PMU
    // event called "page-faults" would silently return that instead of the kernel counter the user
    // asked for. Going through this entry point makes the intent explicit and the failure loud.
    bool ResolveOsEvent(const std::string& name, PmuEventSpec& spec, std::string& reason) const;

    // Lists the software (kernel) counter names this build knows, for --help and error messages.
    static std::vector<std::string> ListSoftwareEvents();

    // Lists the event names this node exposes, for error messages and for --help.
    std::vector<std::string> ListAvailable() const;

private:
    bool ResolveFromSysfs(const std::string& name, PmuEventSpec& spec) const;
    bool ResolveFromAlias(const std::string& name, PmuEventSpec& spec) const;
    bool ResolveFromSoftware(const std::string& name, PmuEventSpec& spec) const;
};
} // namespace HostPmu
} // namespace Dvvp
} // namespace Analysis
#endif
