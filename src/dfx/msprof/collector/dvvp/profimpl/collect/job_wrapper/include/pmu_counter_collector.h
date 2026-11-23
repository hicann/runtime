/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PMU_COUNTER_COLLECTOR_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PMU_COUNTER_COLLECTOR_H

#include <cstdint>
#include <cstddef>
#include <string>
#include <vector>

#include "pmu_event_resolver.h"

struct perf_event_attr;

namespace Analysis {
namespace Dvvp {
namespace HostPmu {

// Syscall wrappers. They are declared here rather than kept file-local because the UT has to drive
// the open/ioctl/read paths, and the raw variadic syscalls cannot be stubbed (mockcpp cannot take a
// function with a trailing "..."). Production behaviour is unchanged: each wrapper is a one-line
// forward to the real call.
int32_t PerfEventOpen(struct perf_event_attr* attr, int32_t pid, int32_t cpu, int32_t groupFd, uint64_t flags);
int32_t PerfIoctl(int32_t fd, unsigned long request, unsigned long arg);
ssize_t PerfRead(int32_t fd, void* buf, size_t count);

// Samples CLOCK_MONOTONIC and CLOCK_REALTIME as one pair, for the file header's clock anchor.
// Rows are stamped with CLOCK_MONOTONIC (perf reports that clock), but the analyser aligns them to
// wall-clock session times. One sampled pair lets it convert, and it must be sampled here rather
// than reusing the ftrace anchor: that one is CLOCK_MONOTONIC_RAW, whose offset from
// CLOCK_MONOTONIC is tens of milliseconds -- larger than one sampling interval, so every row would
// be shifted by it.
void PmuClockAnchor(uint64_t& monoNs, uint64_t& epochNs);

// Reads PMU counters for one target process (or, with pid == -1, for one CPU).
// Counting is opened with inherit = 0 and group = 0 on purpose:
//   * inherit = 1 is rejected with EINVAL when the fd is also mmap'd, and inheriting children is
//     documented to lose samples, so the sampling path cannot use it. Counting keeps the same
//     open flags so both paths agree on what a process sees.
//   * No mmap is needed for counting: the kernel keeps the total and read() returns it, so a
//     short-lived thread does not need its own fd and cannot be missed the way a sampling fd can.
// Each read() returns the accumulated total since the counter was enabled, so the collector emits
// absolute values and lets the analyser derive deltas from consecutive rows.
class PmuCounterCollector {
public:
    PmuCounterCollector() = default;
    ~PmuCounterCollector();

    // Opens every resolved event for "pid" (-1 = all CPUs of "cpu"). The caller resolves the names
    // (including the stricter --os-events rules) and passes the specs in, so an event cannot be
    // re-resolved differently here than it was labelled in the file header. Events that fail to open
    // are reported through "failed" and the remaining ones still work: on armv8 a partially available
    // event list is the normal case. A failed event keeps its slot, so a row always has one column per
    // requested event and its value is reported invalid.
    int32_t OpenResolved(
        const std::vector<PmuEventSpec>& specs, int32_t pid, int32_t cpu, std::vector<std::string>& failed,
        std::string& errorMsg);

    // Convenience overload that resolves the names with the generic rules. Kept for callers without
    // pre-resolved specs (tests, standalone tools); the profiler passes specs so that --os-events
    // stays software-only.
    int32_t Open(
        const std::vector<std::string>& eventNames, int32_t pid, int32_t cpu, std::vector<std::string>& failed,
        std::string& errorMsg);

    int32_t Enable();
    int32_t Disable();

    // Reads one row of values. Returns false when no fd is open.
    bool Read(PmuCounterGroup& group);

    void Close();

    bool IsOpen() const { return !fds_.empty(); }
    // Number of requested events, i.e. the number of columns one row carries.
    size_t EventCount() const { return slots_.size(); }

private:
    struct OpenEvent {
        std::string name;
        int32_t fd = -1;
    };
    // One slot per requested event, in request order, so a row stays aligned with its header even
    // when an event could not be opened. "fdIndex" indexes fds_ and is -1 for a failed event.
    struct EventSlot {
        std::string name;
        std::string source;
        int32_t fdIndex = -1;
    };
    std::vector<OpenEvent> fds_;
    std::vector<EventSlot> slots_;
    int32_t pid_ = -1;
    int32_t cpu_ = -1;
    bool enabled_ = false;
};
} // namespace HostPmu
} // namespace Dvvp
} // namespace Analysis
#endif
