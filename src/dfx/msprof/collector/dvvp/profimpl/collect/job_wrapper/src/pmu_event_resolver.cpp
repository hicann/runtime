/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "pmu_event_resolver.h"

#include <dirent.h>
#include <linux/perf_event.h>

#include <algorithm>
#include <cctype>
#include <cerrno>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <map>
#include <sstream>

#include "logger/msprof_dlog.h"

#ifndef _WIN32

namespace Analysis {
namespace Dvvp {
namespace HostPmu {
namespace {
constexpr const char* PMU_DEVICE_ROOT = "/sys/bus/event_source/devices";
// Follows the MSPROF_FTRACE_COLLECTOR precedent: an environment override lets the resolver run
// against a fixture tree, so the sysfs parsing paths can be covered by UT on a machine that has no
// PMU (or a different one) without adding a test-only API to the class.
constexpr const char* PMU_ROOT_ENV = "MSPROF_PMU_SYSFS_ROOT";
constexpr const char* PMU_PREFERRED = "armv8_pmuv3";
constexpr uint32_t HEX_BASE = 16;

std::string PmuDeviceRoot()
{
    const char* overrideRoot = getenv(PMU_ROOT_ENV);
    if (overrideRoot != nullptr && overrideRoot[0] != '\0') {
        return overrideRoot;
    }
    return PMU_DEVICE_ROOT;
}

// Generic events every armv8 platform may or may not implement. BRANCH_INSTRUCTIONS is listed
// because users ask for it, but on Kunpeng-920 the kernel rejects it with ENOENT: keeping it in
// the table lets Resolve say "not supported by this PMU" instead of "unknown event".
struct GenericAlias {
    const char* name;
    uint64_t config;
};

constexpr GenericAlias GENERIC_ALIASES[] = {
    {"cycles", PERF_COUNT_HW_CPU_CYCLES},
    {"cpu-cycles", PERF_COUNT_HW_CPU_CYCLES},
    {"instructions", PERF_COUNT_HW_INSTRUCTIONS},
    {"cache-references", PERF_COUNT_HW_CACHE_REFERENCES},
    {"cache-misses", PERF_COUNT_HW_CACHE_MISSES},
    {"branch-instructions", PERF_COUNT_HW_BRANCH_INSTRUCTIONS},
    {"branches", PERF_COUNT_HW_BRANCH_INSTRUCTIONS},
    {"branch-misses", PERF_COUNT_HW_BRANCH_MISSES},
    {"bus-cycles", PERF_COUNT_HW_BUS_CYCLES},
    {"stalled-cycles-frontend", PERF_COUNT_HW_STALLED_CYCLES_FRONTEND},
    {"stalled-cycles-backend", PERF_COUNT_HW_STALLED_CYCLES_BACKEND},
};

// Software events are counted by the kernel, not by the CPU PMU, so they stay available when the
// PMU is absent, virtualised, or its event set does not include what the user needs. Names follow
// `perf list sw`; keeping that spelling means a command line copied from a perf cheatsheet works.
constexpr GenericAlias SOFTWARE_ALIASES[] = {
    {"page-faults", PERF_COUNT_SW_PAGE_FAULTS},
    {"minor-faults", PERF_COUNT_SW_PAGE_FAULTS_MIN},
    {"major-faults", PERF_COUNT_SW_PAGE_FAULTS_MAJ},
    {"context-switches", PERF_COUNT_SW_CONTEXT_SWITCHES},
    {"cpu-migrations", PERF_COUNT_SW_CPU_MIGRATIONS},
    {"alignment-faults", PERF_COUNT_SW_ALIGNMENT_FAULTS},
    {"emulation-faults", PERF_COUNT_SW_EMULATION_FAULTS},
    {"task-clock", PERF_COUNT_SW_TASK_CLOCK},
    {"cpu-clock", PERF_COUNT_SW_CPU_CLOCK},
};

bool ReadFileToString(const std::string& path, std::string& out)
{
    std::ifstream ifs(path);
    if (!ifs.is_open()) {
        return false;
    }
    std::ostringstream oss;
    oss << ifs.rdbuf();
    out = oss.str();
    return true;
}

std::string Trim(const std::string& s)
{
    const auto begin = s.find_first_not_of(" \t\r\n");
    if (begin == std::string::npos) {
        return "";
    }
    const auto end = s.find_last_not_of(" \t\r\n");
    return s.substr(begin, end - begin + 1);
}

bool ParseHex(const std::string& text, uint64_t& value)
{
    if (text.empty()) {
        return false;
    }
    errno = 0;
    char* end = nullptr;
    const uint64_t parsed = std::strtoull(text.c_str(), &end, HEX_BASE);
    if (errno != 0 || end == nullptr || *end != '\0') {
        return false;
    }
    value = parsed;
    return true;
}

// Picks the PMU directory to read events from.
// The directory name is not stable: the kernel registers the CPU PMU as "armv8_pmuv3_0" (an
// instance suffix is appended when a PMU has multiple units), and a plain "armv8_pmuv3" exists only
// on some kernels. Hard-coding either name means the resolver silently finds no events on the
// other layout, which is exactly the bug this comment prevents.
bool FindPmuDir(std::string& dir)
{
    const std::string root = PmuDeviceRoot();
    DIR* handle = opendir(root.c_str());
    if (handle == nullptr) {
        return false;
    }
    std::vector<std::string> candidates;
    struct dirent* entry = nullptr;
    while ((entry = readdir(handle)) != nullptr) {
        const std::string name = entry->d_name;
        if (name == "." || name == "..") {
            continue;
        }
        if (name.compare(0, strlen(PMU_PREFERRED), PMU_PREFERRED) == 0) {
            candidates.push_back(name);
        }
    }
    (void)closedir(handle);
    if (candidates.empty()) {
        return false;
    }
    // Prefer the suffix-less name when both exist, so the choice is stable across kernels.
    std::sort(candidates.begin(), candidates.end());
    const auto plain = std::find(candidates.begin(), candidates.end(), std::string(PMU_PREFERRED));
    dir = root + "/" + ((plain != candidates.end()) ? *plain : candidates.front());
    return true;
}
} // namespace

// Reads "event=0xNN,param=0xNN" from a sysfs events file and returns the event term. Only "event" is
// required: the remaining terms are filter fields this collector never sets.
bool ReadEventConfig(const std::string& path, uint64_t& config)
{
    std::string eventText;
    if (!ReadFileToString(path, eventText)) {
        return false;
    }
    std::istringstream iss(Trim(eventText));
    std::string term;
    while (std::getline(iss, term, ',')) {
        const auto eq = term.find('=');
        if (eq == std::string::npos) {
            continue;
        }
        if (Trim(term.substr(0, eq)) == "event") {
            return ParseHex(Trim(term.substr(eq + 1)), config);
        }
    }
    return false;
}

bool PmuEventResolver::ResolveFromSysfs(const std::string& name, PmuEventSpec& spec) const
{
    std::string pmuDir;
    if (!FindPmuDir(pmuDir)) {
        return false;
    }
    std::string typeText;
    if (!ReadFileToString(pmuDir + "/type", typeText)) {
        return false;
    }
    uint64_t type = 0;
    if (!ParseHex(Trim(typeText), type)) {
        return false;
    }
    // The events file uses "event=0xNN,param=0xNN". Only "event" is required; the rest describe
    // filter fields that this collector does not set.
    uint64_t config = 0;
    if (!ReadEventConfig(pmuDir + "/events/" + name, config)) {
        return false;
    }
    spec.name = name;
    spec.type = static_cast<uint32_t>(type);
    spec.config = config;
    spec.source = "sysfs";
    return true;
}

bool PmuEventResolver::ResolveFromAlias(const std::string& name, PmuEventSpec& spec) const
{
    for (const auto& alias : GENERIC_ALIASES) {
        if (name != alias.name) {
            continue;
        }
        spec.name = name;
        spec.type = PERF_TYPE_HARDWARE;
        spec.config = alias.config;
        spec.source = "generic";
        return true;
    }
    return false;
}

bool PmuEventResolver::ResolveFromSoftware(const std::string& name, PmuEventSpec& spec) const
{
    for (const auto& alias : SOFTWARE_ALIASES) {
        if (name != alias.name) {
            continue;
        }
        spec.name = name;
        spec.type = PERF_TYPE_SOFTWARE;
        spec.config = alias.config;
        spec.source = "software";
        return true;
    }
    return false;
}

// True for the raw encodings perf also accepts: "raw:" followed by anything, or "r" followed by hex
// digits. They are refused rather than passed through because the encoding depends on the exact CPU
// model, so a name that works on one node can count something else on another.
bool IsRawEncoding(const std::string& name)
{
    if (name.compare(0, 4, "raw:") == 0) {
        return true;
    }
    if (name.size() <= 1 || name[0] != 'r') {
        return false;
    }
    return std::all_of(name.begin() + 1, name.end(), [](char chr) {
        return (chr >= '0' && chr <= '9') || (chr >= 'a' && chr <= 'f') || (chr >= 'A' && chr <= 'F');
    });
}

bool PmuEventResolver::Resolve(const std::string& name, PmuEventSpec& spec, std::string& reason) const
{
    const std::string trimmed = Trim(name);
    if (trimmed.empty()) {
        reason = "event name is empty";
        return false;
    }
    // sysfs first: a raw PMU event named "cycles" must win over the generic alias, because the
    // two count different things on armv8.
    if (ResolveFromSysfs(trimmed, spec)) {
        return true;
    }
    if (ResolveFromAlias(trimmed, spec)) {
        return true;
    }
    // Software events come after the hardware aliases: a name that exists in both tables must keep
    // meaning the PMU event, so adding a software entry can never silently change an existing
    // command's meaning.
    if (ResolveFromSoftware(trimmed, spec)) {
        return true;
    }
    if (IsRawEncoding(trimmed)) {
        reason = "raw PMU encodings are not supported; use an event name";
        return false;
    }
    reason = "unknown PMU event '" + trimmed + "'; run with --host-pmu-list to see the events this node supports";
    return false;
}

bool PmuEventResolver::ResolveOsEvent(const std::string& name, PmuEventSpec& spec, std::string& reason) const
{
    const std::string trimmed = Trim(name);
    if (trimmed.empty()) {
        reason = "event name is empty";
        return false;
    }
    if (ResolveFromSoftware(trimmed, spec)) {
        return true;
    }
    // Deliberately no sysfs or raw fall-back: a name given to --os-events cannot mean a PMU event,
    // and guessing here is how a user ends up with a counter that looks right but measures the PMU.
    reason = "unknown OS event '" + trimmed + "'; supported: ";
    const std::vector<std::string> known = ListSoftwareEvents();
    for (size_t i = 0; i < known.size(); ++i) {
        reason += (i == 0) ? known[i] : (", " + known[i]);
    }
    return false;
}

std::vector<std::string> PmuEventResolver::ListSoftwareEvents()
{
    std::vector<std::string> names;
    for (const auto& alias : SOFTWARE_ALIASES) {
        names.push_back(alias.name);
    }
    return names;
}

std::vector<std::string> PmuEventResolver::ListAvailable() const
{
    std::vector<std::string> names;
    std::string pmuDir;
    if (!FindPmuDir(pmuDir)) {
        return names;
    }
    const std::string eventsDir = pmuDir + "/events";
    // opendir/readdir keeps this dependency free; std::filesystem is not used elsewhere in this
    // module and pulling it in would change the build flags for the whole job wrapper.
    DIR* dir = opendir(eventsDir.c_str());
    if (dir == nullptr) {
        return names;
    }
    struct dirent* entry = nullptr;
    while ((entry = readdir(dir)) != nullptr) {
        const std::string fileName = entry->d_name;
        if (fileName == "." || fileName == "..") {
            continue;
        }
        names.push_back(fileName);
    }
    (void)closedir(dir);
    std::sort(names.begin(), names.end());
    return names;
}
} // namespace HostPmu
} // namespace Dvvp
} // namespace Analysis
#endif
