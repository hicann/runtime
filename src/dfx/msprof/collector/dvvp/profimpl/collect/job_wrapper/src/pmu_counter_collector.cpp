/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "pmu_counter_collector.h"

#include <linux/perf_event.h>
#include <sys/ioctl.h>
#include <sys/syscall.h>
#include <unistd.h>

#include <cerrno>
#include <cstring>
#include <ctime>

#include "logger/msprof_dlog.h"
#include "securec.h"

#ifndef _WIN32

namespace Analysis {
namespace Dvvp {
namespace HostPmu {
namespace {
constexpr int32_t PERF_OPEN_FLAGS = 0;
constexpr int32_t NS_PER_SEC = 1000000000;

uint64_t NowNs()
{
    struct timespec ts = {0, 0};
    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0) {
        return 0;
    }
    return static_cast<uint64_t>(ts.tv_sec) * NS_PER_SEC + static_cast<uint64_t>(ts.tv_nsec);
}

// Reads CLOCK_MONOTONIC and CLOCK_REALTIME as one pair.
void NowNsPair(uint64_t& monoNs, uint64_t& epochNs)
{
    struct timespec mono = {0, 0};
    struct timespec real = {0, 0};
    if (clock_gettime(CLOCK_MONOTONIC, &mono) != 0) {
        monoNs = 0;
    } else {
        monoNs = static_cast<uint64_t>(mono.tv_sec) * NS_PER_SEC + static_cast<uint64_t>(mono.tv_nsec);
    }
    if (clock_gettime(CLOCK_REALTIME, &real) != 0) {
        epochNs = 0;
    } else {
        epochNs = static_cast<uint64_t>(real.tv_sec) * NS_PER_SEC + static_cast<uint64_t>(real.tv_nsec);
    }
}

} // namespace

// Both wrappers exist so the UT can drive the enable/disable and read paths: the raw variadic
// forms cannot be stubbed ("no matching function ... long int (&)(long int, ...)"). Keeping the
// calls in one place also makes the syscall surface of this file obvious.
int32_t PerfEventOpen(struct perf_event_attr* attr, int32_t pid, int32_t cpu, int32_t groupFd, uint64_t flags)
{
    return static_cast<int32_t>(syscall(__NR_perf_event_open, attr, pid, cpu, groupFd, flags));
}

int32_t PerfIoctl(int32_t fd, unsigned long request, unsigned long arg) { return ioctl(fd, request, arg); }

ssize_t PerfRead(int32_t fd, void* buf, size_t count) { return read(fd, buf, count); }

namespace {
// Turns a failed open into an actionable message. The three errors seen in practice are:
//   EACCES / EPERM : perf_event_paranoid too high, or no CAP_PERFMON
//   ENOENT         : the PMU does not implement this event on this silicon
//   EINVAL         : the event encoding is right but the kernel refuses the combination
std::string ExplainErrno(int32_t savedErrno)
{
    switch (savedErrno) {
        case EACCES:
        case EPERM:
            return "permission denied: lower /proc/sys/kernel/perf_event_paranoid or grant CAP_PERFMON";
        case ENOENT:
            return "event not implemented by this PMU";
        case EINVAL:
            return "kernel rejected the event encoding";
        case EMFILE:
            return "too many open counters";
        case ENODEV:
            return "no such PMU on this node";
        default:
            return std::string("open failed: ") + std::strerror(savedErrno);
    }
}
} // namespace

void PmuClockAnchor(uint64_t& monoNs, uint64_t& epochNs) { NowNsPair(monoNs, epochNs); }

PmuCounterCollector::~PmuCounterCollector() { Close(); }

int32_t PmuCounterCollector::Open(
    const std::vector<std::string>& eventNames, int32_t pid, int32_t cpu, std::vector<std::string>& failed,
    std::string& errorMsg)
{
    // Resolve with the generic rules, then hand the specs to the real implementation so the open
    // loop exists only once. A name that does not resolve still gets a placeholder spec, which keeps
    // its column in every row.
    std::vector<PmuEventSpec> specs;
    specs.reserve(eventNames.size());
    PmuEventResolver resolver;
    for (const auto& name : eventNames) {
        PmuEventSpec spec;
        std::string reason;
        if (!resolver.Resolve(name, spec, reason)) {
            failed.push_back(name + " (" + reason + ")");
            PmuEventSpec placeholder;
            placeholder.name = name;
            specs.push_back(placeholder);
            continue;
        }
        specs.push_back(spec);
    }
    std::vector<std::string> openFailed;
    const int32_t ret = OpenResolved(specs, pid, cpu, openFailed, errorMsg);
    failed.insert(failed.end(), openFailed.begin(), openFailed.end());
    return ret;
}

int32_t PmuCounterCollector::OpenResolved(
    const std::vector<PmuEventSpec>& specs, int32_t pid, int32_t cpu, std::vector<std::string>& failed,
    std::string& errorMsg)
{
    Close();
    pid_ = pid;
    cpu_ = cpu;
    for (const auto& spec : specs) {
        // The slot goes in first and keeps the request position even if the open below fails.
        EventSlot slot;
        slot.name = spec.name;
        slot.source = spec.source;
        slots_.push_back(slot);
        if (spec.type == 0 && spec.source.empty()) {
            // The caller already reported why this name did not resolve (it is the one that built the
            // placeholder); the column stays so the row keeps one value per requested event.
            continue;
        }
        struct perf_event_attr attr;
        (void)memset_s(&attr, sizeof(attr), 0, sizeof(attr));
        attr.type = spec.type;
        attr.size = sizeof(attr);
        attr.config = spec.config;
        attr.disabled = 1; // enabled explicitly after every event is open, so the counters
                           // cover the same window
        attr.inherit = 0;  // see the header: inherit + mmap is EINVAL
        attr.exclude_kernel = 0;
        attr.exclude_hv = 0;
        attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING;

        const int32_t fd = PerfEventOpen(&attr, pid, cpu, -1, PERF_OPEN_FLAGS);
        if (fd < 0) {
            const int32_t savedErrno = errno;
            failed.push_back(spec.name + " (" + ExplainErrno(savedErrno) + ")");
            MSPROF_LOGW("[HostPmu] open '%s' failed: %s", spec.name.c_str(), ExplainErrno(savedErrno).c_str());
            continue;
        }
        OpenEvent event;
        event.name = spec.name;
        event.fd = fd;
        slots_.back().fdIndex = static_cast<int32_t>(fds_.size());
        fds_.push_back(event);
    }
    if (fds_.empty()) {
        errorMsg = "no PMU event could be opened";
        if (!failed.empty()) {
            errorMsg += ": " + failed.front();
        }
        return -1;
    }
    return 0;
}

int32_t PmuCounterCollector::Enable()
{
    for (auto& event : fds_) {
        if (PerfIoctl(event.fd, PERF_EVENT_IOC_ENABLE, 0) != 0) {
            MSPROF_LOGW("[HostPmu] enable '%s' failed: %s", event.name.c_str(), std::strerror(errno));
        }
    }
    enabled_ = true;
    return 0;
}

int32_t PmuCounterCollector::Disable()
{
    for (auto& event : fds_) {
        if (PerfIoctl(event.fd, PERF_EVENT_IOC_DISABLE, 0) != 0) {
            MSPROF_LOGW("[HostPmu] disable '%s' failed: %s", event.name.c_str(), std::strerror(errno));
        }
    }
    enabled_ = false;
    return 0;
}

namespace {
// read_format is PERF_FORMAT_TOTAL_TIME_ENABLED | PERF_FORMAT_TOTAL_TIME_RUNNING, so the kernel
// returns { value, timeEnabled, timeRunning } per fd. Named at file scope because both Read() and
// the scaling helper use it.
struct ReadFormat {
    uint64_t value;
    uint64_t timeEnabled;
    uint64_t timeRunning;
};

// Corrects a counter the kernel multiplexed. When timeRunning < timeEnabled the counter was active
// for only part of the window, so the raw total covers less time than the interval and would read as
// a drop that never happened; perf stat applies the same correction.
// value * timeEnabled cannot be formed in 64 bits (a counter total of 1e13 times 3.6e12 nanoseconds is
// 3.6e25), so the ratio is formed first and applied in floating point: both operands stay below 2^53 in
// practice, which leaves ~15 significant digits in the result and cannot overflow.
uint64_t ScaleForMultiplexing(const ReadFormat& data)
{
    if (data.timeRunning == 0 || data.timeEnabled == 0 || data.timeRunning >= data.timeEnabled) {
        return data.value;
    }
    const double ratio = static_cast<double>(data.timeEnabled) / static_cast<double>(data.timeRunning);
    const double scaled = static_cast<double>(data.value) * ratio;
    const double maxValue = static_cast<double>(~static_cast<uint64_t>(0));
    if (!(scaled < maxValue)) { // also catches inf, keeping the result a valid uint64 value
        return ~static_cast<uint64_t>(0);
    }
    return static_cast<uint64_t>(scaled + 0.5);
}
} // namespace

bool PmuCounterCollector::Read(PmuCounterGroup& group)
{
    if (fds_.empty()) {
        return false;
    }
    group.timestampNs = NowNs();
    group.pid = pid_;
    group.cpu = cpu_;
    group.counters.clear();
    // One value per requested event, in request order. An event that never opened still occupies its
    // column, otherwise the analyser would shift every later column by one.
    for (const auto& slot : slots_) {
        PmuCounterValue counter;
        counter.name = slot.name;
        counter.source = slot.source;
        if (slot.fdIndex < 0) {
            counter.valid = false;
            group.counters.push_back(counter);
            continue;
        }
        ReadFormat data;
        (void)memset_s(&data, sizeof(data), 0, sizeof(data));
        const ssize_t got = PerfRead(fds_[slot.fdIndex].fd, &data, sizeof(data));
        if (got != static_cast<ssize_t>(sizeof(data))) {
            counter.valid = false;
            group.counters.push_back(counter);
            continue;
        }
        counter.rawValue = data.value;
        counter.timeEnabled = data.timeEnabled;
        counter.timeRunning = data.timeRunning;
        counter.value = ScaleForMultiplexing(data);
        counter.valid = true;
        group.counters.push_back(counter);
    }
    return true;
}

void PmuCounterCollector::Close()
{
    if (enabled_) {
        (void)Disable();
    }
    for (auto& event : fds_) {
        if (event.fd >= 0) {
            (void)close(event.fd);
            event.fd = -1;
        }
    }
    fds_.clear();
    // Slots describe the current open, not the collector's lifetime: a reopen must start from an
    // empty layout or every row would grow by one column per request.
    slots_.clear();
}
} // namespace HostPmu
} // namespace Dvvp
} // namespace Analysis
#endif
