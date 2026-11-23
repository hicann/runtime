/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_JOB_WRAPPER_PROF_HOST_PMU_JOB_H
#define ANALYSIS_DVVP_JOB_WRAPPER_PROF_HOST_PMU_JOB_H

#include <sys/resource.h>

#include <cstdio>
#include <string>
#include <utility>
#include <vector>

#include "collection_job.h"
#include "pmu_counter_collector.h"
#include "prof_host_job.h"
#include "thread/thread.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
// Drives one PmuCounterCollector per CPU for the profiling lifetime. A thread rather than a timer
// handler: PMU counters need enable/disable around the exact window, which the timer abstraction
// cannot express.
// One thread owns every CPU rather than one thread per CPU: the work per interval is a handful of
// read() calls, so hundreds of threads would cost more than the reads themselves.
class ProfHostPmuThread : public analysis::dvvp::common::thread::Thread {
public:
    // "outputDir" is data/pmu; each CPU gets its own file host_pmu_cpu<N>.data under it.
    // The resolved specs are carried rather than the bare names: the collector must open exactly the
    // event the header advertises, so --os-events cannot be re-resolved into a hardware event later.
    ProfHostPmuThread(
        std::vector<Analysis::Dvvp::HostPmu::PmuEventSpec> eventSpecs, std::vector<int32_t> cpuList,
        std::string outputDir);
    ~ProfHostPmuThread() override = default;

    // Interval is a setter rather than a constructor argument: the tree provides MSVP_MAKE_SHARED0..4
    // and adding a fifth argument for one call site is not worth a new macro.
    void SetIntervalNs(uint64_t intervalNs) { intervalNs_ = intervalNs; }
    int32_t StartCollect();

private:
    // One CPU's collection outcome, written to host_pmu_status.txt so the analyser can tell "this CPU
    // was never in scope" (no line) from "this CPU was in scope but could not be collected".
    struct CpuOutcome {
        int32_t cpu = -1;
        bool collected = false;
        int32_t err = 0; // errno of the failure, 0 when collected
    };

    struct CpuContext {
        int32_t cpu = -1;
        std::string path;
        // One line per valid counter reading: "<timestamp>,<eventIndex>,<rawValue>,<timeEnabled>,
        // <timeRunning>". The analyser requires all three for every valid sample, because a 0 sentinel
        // cannot be told apart from a genuine value, so this file is written whenever the main file is.
        std::string timingPath;
        Analysis::Dvvp::HostPmu::PmuCounterCollector collector;
        FILE* fp = nullptr;
        FILE* timingFp = nullptr;
        bool timingTruncated = false;
        // Running totals across sampling windows. A CPU may be sampled in batches -- the fd limit
        // decides how many CPUs can hold counters at once -- so each read returns one window and the
        // totals are accumulated here, keeping the file's "cumulative since the start" meaning.
        std::vector<uint64_t> sumRaw;
        std::vector<uint64_t> sumEnabled;
        std::vector<uint64_t> sumRunning;
        // Last value read from the kernel for this open. read() returns the total since enable, so the
        // window delta is (current - last); re-opening a batch resets the kernel total, hence these are
        // cleared whenever the batch is opened again.
        std::vector<uint64_t> lastRaw;
        std::vector<uint64_t> lastEnabled;
        std::vector<uint64_t> lastRunning;
    };

    void Run(const error_message::ErrorManagerContext& errorContext) override;
    // How many CPUs can hold counters and files at once under the current fd limit. A CPU needs one fd
    // per event plus two files, so this bounds the batch, never the set of CPUs.
    size_t ComputeBatchSize() const;
    int32_t OpenBatch(size_t start, size_t count);
    bool OpenOneCpu(size_t index);
    void SampleBatch(size_t start, size_t count);
    void SampleOneCpu(size_t index);
    void AccumulateGroup(CpuContext& ctx, const Analysis::Dvvp::HostPmu::PmuCounterGroup& group);
    void CloseBatch(size_t start, size_t count);
    static void ResetBaseline(CpuContext& ctx);
    void ReportBatching() const;
    void BuildStatusNote();
    size_t CurrentBatchCount() const;
    void OpenCurrentBatch();
    void WaitOneInterval();
    void WriteStatusFile() const;
    int32_t OpenFile(CpuContext& ctx);
    void WriteRow(CpuContext& ctx, const Analysis::Dvvp::HostPmu::PmuCounterGroup& group);
    void CloseAll();

    std::vector<Analysis::Dvvp::HostPmu::PmuEventSpec> eventSpecs_;
    std::vector<int32_t> cpuList_;
    std::string outputDir_;
    uint64_t intervalNs_ = 0;
    std::vector<CpuContext> contexts_;
    std::vector<CpuOutcome> outcomes_;
    size_t batchSize_ = 0;
    size_t batchCount_ = 0;
    // Resource note repeated in the status file: the log macros are filtered by the
    // deployment's log level, so a warning alone may never reach the user.
    std::string statusNote_;
    size_t batchIndex_ = 0;
    size_t batchStart_ = 0;
    bool batchOpen_ = false;
};

// Host PMU counter job. System-wide by design, matching Nsight Systems: --event-sample has no
// process-scoped value there, and per-process counters cannot answer "what is the machine doing".
// Every online CPU gets its own perf_event_open(pid = -1, cpu = N) group and its own output file, so
// a reader can attribute a number to a core but never to a thread -- the same limitation nsys has.
// Requires /proc/sys/kernel/perf_event_paranoid <= 0: counting all processes needs the system-wide
// permission. Without it each open fails with EACCES and the job logs the reason instead of
// silently producing empty files.
// Output: <dataPath>/data/pmu/host_pmu_cpu<N>.data, one text file per CPU, one row per sample.
// Values are the absolute totals perf_event_open accumulates, so the analyser derives deltas.
class ProfHostPmuJob : public ProfHostDataBase {
public:
    ProfHostPmuJob() = default;
    ~ProfHostPmuJob() override;

    int32_t Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg) override;
    int32_t Process() override;
    int32_t Uninit() override;

    bool IsGlobalJobLevel() override { return true; }

private:
    int32_t CheckPreconditions() const;
    int32_t ParseEventList();
    // Appends one comma separated list. "osEvents" selects the software-only resolution used for
    // --os-events, which must not fall back to a PMU event of the same name.
    int32_t AppendEventList(const std::string& list, bool osEvents);
    // Reads the online CPU set (overridable through MSPROF_PMU_CPU_LIST so UT can pin a fixture)
    // and trims it to what the file-descriptor limit allows.
    int32_t PrepareCpuList();
    // Split out of PrepareCpuList so each step stays short: read the set, raise the limit, warn when it
    // still does not fit.
    int32_t LoadCpuList();
    std::pair<rlim_t, bool> RaiseFdLimit(size_t needed);
    void WarnFdShortfall(size_t perCpu, size_t needed, size_t budget);
    int32_t PrepareOutputDir();
    int32_t WriteHeader(int32_t cpu, const std::string& path) const;

    std::vector<std::string> eventNames_;
    // Resolved specs kept alongside the names so the file header can record which source produced
    // each column. Without it the analyser stores every counter as source=unknown, and a sysfs
    // "cycles" cannot be told apart from the generic PERF_COUNT_HW_CPU_CYCLES, which count
    // different hardware events on armv8.
    std::vector<Analysis::Dvvp::HostPmu::PmuEventSpec> eventSpecs_;
    std::vector<int32_t> cpuList_;
    std::string outputDir_;
    uint64_t intervalNs_ = 0;
    SHARED_PTR_ALIA<ProfHostPmuThread> pmuThread_;
};
} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis
#endif
