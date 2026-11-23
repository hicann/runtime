/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "prof_host_pmu_job.h"

#include <sys/resource.h>

#include <algorithm>
#include <cerrno>
#include <cinttypes>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <fstream>
#include <sstream>

#include "config/config.h"
#include "errno/error_code.h"
#include "logger/msprof_dlog.h"
#include "platform/platform.h"
#include "prof_comm_job.h"
#include "securec.h"
#include "utils/utils.h"

namespace Analysis {
namespace Dvvp {
namespace JobWrapper {
using namespace analysis::dvvp::common::config;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::common::utils;
using namespace Analysis::Dvvp::Common::Platform;
using Analysis::Dvvp::HostPmu::PmuCounterGroup;

namespace {
constexpr int32_t PMU_MAX_EVENTS = 32;
constexpr int32_t PMU_DEFAULT_INTERVAL_MS = 100;
// The sampling wait is served in slices so Stop() can end the thread promptly: the configured
// interval may be as long as an hour, and a single nanosleep() cannot be interrupted by the
// quit flag.
constexpr uint64_t PMU_WAIT_SLICE_NS = 100ULL * 1000ULL * 1000ULL; // 100 ms
constexpr uint64_t NANOS_PER_SECOND = 1000ULL * 1000ULL * 1000ULL;
constexpr int32_t MS_TO_NS = 1000000;
constexpr int32_t PMU_MAX_INTERVAL_MS = 3600000;
// Leaves room for the collector's own descriptors, the log file and the rest of the process.
constexpr int32_t PMU_FD_RESERVED = 64;
// Even with a generous limit, counting every core with a long event list can exceed it. Cap the
// number of cores instead of failing the whole job, and say so.
constexpr const char* PMU_CPU_LIST_ENV = "MSPROF_PMU_CPU_LIST";
constexpr const char* PMU_ONLINE_CPU_PATH = "/sys/devices/system/cpu/online";

int32_t ParseIntervalMs(const std::string& text, uint64_t& intervalNs)
{
    if (text.empty()) {
        intervalNs = static_cast<uint64_t>(PMU_DEFAULT_INTERVAL_MS) * MS_TO_NS;
        return PROFILING_SUCCESS;
    }
    errno = 0;
    char* end = nullptr;
    const long parsed = std::strtol(text.c_str(), &end, 10);
    if (errno != 0 || end == nullptr || *end != '\0' || parsed <= 0 || parsed > PMU_MAX_INTERVAL_MS) {
        return PROFILING_FAILED;
    }
    intervalNs = static_cast<uint64_t>(parsed) * MS_TO_NS;
    return PROFILING_SUCCESS;
}

std::string TrimText(const std::string& text)
{
    const auto begin = text.find_first_not_of(" \t\r\n");
    if (begin == std::string::npos) {
        return "";
    }
    const auto end = text.find_last_not_of(" \t\r\n");
    return text.substr(begin, end - begin + 1);
}

// Parses the kernel's online CPU list, e.g. "0-255" or "0-3,8-11". The same parser handles the UT
// override so both paths are covered by one set of cases.
// Parses one decimal CPU index. False when the text is not a number, has trailing characters or is
// negative.
bool ParseCpuIndex(const std::string& text, long& value)
{
    if (text.empty()) {
        return false;
    }
    errno = 0;
    char* end = nullptr;
    value = std::strtol(text.c_str(), &end, 10);
    return (errno == 0) && (end != nullptr) && (*end == '\0') && (value >= 0);
}

// Expands one "first-last" range. False when either bound is malformed or the range is inverted.
bool AppendCpuRange(const std::string& range, std::vector<int32_t>& cpus)
{
    const auto dash = range.find('-');
    if (dash == std::string::npos) {
        return true;
    }
    long first = 0;
    long last = 0;
    if (!ParseCpuIndex(TrimText(range.substr(0, dash)), first) ||
        !ParseCpuIndex(TrimText(range.substr(dash + 1)), last) || (last < first)) {
        return false;
    }
    for (long cpu = first; cpu <= last; ++cpu) {
        cpus.push_back(static_cast<int32_t>(cpu));
    }
    return true;
}

bool ParseCpuListText(const std::string& text, std::vector<int32_t>& cpus)
{
    const std::string trimmed = TrimText(text);
    if (trimmed.empty()) {
        return false;
    }
    std::istringstream iss(trimmed);
    std::string item;
    while (std::getline(iss, item, ',')) {
        const std::string range = TrimText(item);
        if (range.empty()) {
            continue;
        }
        if (range.find('-') == std::string::npos) {
            long single = 0;
            if (!ParseCpuIndex(range, single)) {
                return false;
            }
            cpus.push_back(static_cast<int32_t>(single));
            continue;
        }
        if (!AppendCpuRange(range, cpus)) {
            return false;
        }
    }
    std::sort(cpus.begin(), cpus.end());
    cpus.erase(std::unique(cpus.begin(), cpus.end()), cpus.end());
    return !cpus.empty();
}

std::string CpuOutputFileName(int32_t cpu)
{
    return std::string(PMU_OUTPUT_FILE_PREFIX) + "cpu" + std::to_string(cpu) + ".data";
}
} // namespace

ProfHostPmuJob::~ProfHostPmuJob() { (void)Uninit(); }

int32_t ProfHostPmuJob::CheckPreconditions() const
{
    if (collectionJobCfg_ == nullptr || collectionJobCfg_->comParams == nullptr ||
        collectionJobCfg_->comParams->params == nullptr) {
        MSPROF_LOGE("[ProfHostPmuJob] job config is null");
        return PROFILING_FAILED;
    }
    const auto& params = collectionJobCfg_->comParams->params;
    if (Platform::instance()->RunSocSide()) {
        MSPROF_LOGI("[ProfHostPmuJob] not host side, PMU counting not supported");
        return PROFILING_NOTSUPPORT;
    }
    // PMU counting stands on its own: --cpu-core-events / --os-events enable it directly. Requiring
    // --host-sys as well would make "give me cycles and instructions" fail unless the user also asked
    // for CPU/memory/disk data they may not want.
    if (params->host_pmu_profiling.compare(MSVP_PROF_ON) != 0) {
        MSPROF_LOGI("[ProfHostPmuJob] host PMU profiling not enabled");
        return PROFILING_NOTSUPPORT;
    }
    // Either switch is enough to ask for counting: --cpu-core-events and --os-events are two lists
    // of the same feature, so only having both empty is an error.
    if (params->host_pmu_events.empty() && params->host_pmu_os_events.empty()) {
        MSPROF_LOGE("[ProfHostPmuJob] PMU profiling is on but no event was requested");
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

// Appends one comma separated list to the job's event set. "osEvents" selects the strict
// software-only resolution that --os-events requires; the two lists share the 32-event ceiling
// because that ceiling comes from the row width, not from which switch named the event.
int32_t ProfHostPmuJob::AppendEventList(const std::string& list, bool osEvents)
{
    const std::vector<std::string> events = Utils::Split(list, false, "", std::string(1, PMU_EVENT_SEPARATOR));
    for (const auto& item : events) {
        if (item.empty()) {
            continue;
        }
        // Compared before the push, so this allows exactly 32 names and rejects the 33rd: when the
        // 32nd arrives the set holds 31. The CLI uses the same inclusive limit on the combined lists,
        // so a command the parser accepts cannot fail here one event later.
        if (eventNames_.size() >= static_cast<size_t>(PMU_MAX_EVENTS)) {
            MSPROF_LOGE("[ProfHostPmuJob] too many PMU events, limit is %d", PMU_MAX_EVENTS);
            return PROFILING_FAILED;
        }
        // The same name in both lists would open a second fd for the same counter and put two
        // identical columns in the file, which reads as a doubled value.
        if (std::find(eventNames_.begin(), eventNames_.end(), item) != eventNames_.end()) {
            MSPROF_LOGW("[ProfHostPmuJob] duplicate event '%s' ignored", item.c_str());
            continue;
        }
        eventNames_.push_back(item);
        // Resolve here, not only inside the collector: the header needs the source for provenance,
        // and resolving twice could disagree if sysfs changes between the two calls.
        Analysis::Dvvp::HostPmu::PmuEventSpec spec;
        std::string reason;
        Analysis::Dvvp::HostPmu::PmuEventResolver resolver;
        const bool resolved =
            osEvents ? resolver.ResolveOsEvent(item, spec, reason) : resolver.Resolve(item, spec, reason);
        if (!resolved) {
            // Record the requested name with an unknown source; the collector will report the open
            // failure with the errno-derived reason, and the column still exists so the row layout
            // matches the header.
            MSPROF_LOGW("[ProfHostPmuJob] resolve '%s' failed: %s", item.c_str(), reason.c_str());
            spec = Analysis::Dvvp::HostPmu::PmuEventSpec{};
            spec.name = item;
        }
        eventSpecs_.push_back(spec);
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostPmuJob::ParseEventList()
{
    const auto& params = collectionJobCfg_->comParams->params;
    if (AppendEventList(params->host_pmu_events, false) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (AppendEventList(params->host_pmu_os_events, true) != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (eventNames_.empty()) {
        MSPROF_LOGE(
            "[ProfHostPmuJob] no usable PMU event in '%s' (os events '%s')", params->host_pmu_events.c_str(),
            params->host_pmu_os_events.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

// Reads the CPU set to collect on: MSPROF_PMU_CPU_LIST wins over the online file so UT can pin a
// fixture, and a missing or unparsable list fails the job rather than collecting nothing silently.
int32_t ProfHostPmuJob::LoadCpuList()
{
    std::string text;
    const char* overrideList = getenv(PMU_CPU_LIST_ENV);
    if (overrideList != nullptr && overrideList[0] != '\0') {
        text = overrideList;
    } else {
        std::ifstream ifs(PMU_ONLINE_CPU_PATH);
        if (!ifs.is_open()) {
            MSPROF_LOGE("[ProfHostPmuJob] cannot read '%s': %s", PMU_ONLINE_CPU_PATH, std::strerror(errno));
            return PROFILING_FAILED;
        }
        std::ostringstream oss;
        oss << ifs.rdbuf();
        text = oss.str();
    }
    if (!ParseCpuListText(text, cpuList_)) {
        MSPROF_LOGE("[ProfHostPmuJob] cannot parse the online CPU list '%s'", text.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

// Raises the soft fd limit towards the hard one. Collecting needs one fd per event plus two files per
// CPU, which the default 1024 does not cover for a 256-core machine.
std::pair<rlim_t, bool> ProfHostPmuJob::RaiseFdLimit(size_t needed)
{
    struct rlimit limit = {0, 0};
    if (getrlimit(RLIMIT_NOFILE, &limit) != 0) {
        return std::make_pair(static_cast<rlim_t>(0), false);
    }
    if (needed > limit.rlim_cur) {
        struct rlimit raised = limit;
        raised.rlim_cur = (needed <= limit.rlim_max) ? static_cast<rlim_t>(needed) : limit.rlim_max;
        if (setrlimit(RLIMIT_NOFILE, &raised) == 0) {
            limit = raised;
            MSPROF_LOGI("[ProfHostPmuJob] raised RLIMIT_NOFILE to %" PRIu64, static_cast<uint64_t>(limit.rlim_cur));
        }
    }
    return std::make_pair(limit.rlim_cur, needed <= limit.rlim_cur);
}

// Never drops a CPU: the thread samples the cores in batches sized to the limit, so every core is
// still collected and the only cost is a coarser interval per core. A WARN names the exact reason and
// is repeated in host_pmu_status.txt, because the default log level may filter warnings out.
void ProfHostPmuJob::WarnFdShortfall(size_t perCpu, size_t needed, size_t budget)
{
    size_t allowedCpus = (perCpu == 0) ? 0 : (budget / perCpu);
    if ((allowedCpus == 0) && (budget > 0)) {
        allowedCpus = 1;
    }
    if (allowedCpus == 0) {
        MSPROF_LOGW(
            "[ProfHostPmuJob] RLIMIT_NOFILE cannot hold one CPU with %zu events; PMU data will be missing this "
            "run. Fix: raise the fd limit to at least %zu ('ulimit -n %zu', or LimitNOFILE= in a systemd unit, or "
            "--ulimit nofile= for a container), or lower the event count, or narrow the CPU set.",
            perCpu, needed, needed);
        return;
    }
    MSPROF_LOGW(
        "[ProfHostPmuJob] %zu CPUs x %zu events needs RLIMIT_NOFILE >= %zu; all CPUs are still collected in "
        "batches of about %zu, so the per-CPU interval is coarser. Raise 'ulimit -n' to %zu for the configured "
        "interval.",
        cpuList_.size(), eventNames_.size(), needed, allowedCpus, needed);
}

int32_t ProfHostPmuJob::PrepareCpuList()
{
    if (LoadCpuList() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    const size_t perCpu = eventNames_.size() + 2;
    const size_t needed = cpuList_.size() * perCpu + static_cast<size_t>(PMU_FD_RESERVED);
    const std::pair<rlim_t, bool> limit = RaiseFdLimit(needed);
    if (!limit.second) {
        const size_t budget = (limit.first > static_cast<rlim_t>(PMU_FD_RESERVED)) ?
                                  static_cast<size_t>(limit.first) - static_cast<size_t>(PMU_FD_RESERVED) :
                                  0;
        WarnFdShortfall(perCpu, needed, budget);
    }
    MSPROF_LOGI("[ProfHostPmuJob] system-wide counting on %zu CPUs", cpuList_.size());
    return PROFILING_SUCCESS;
}

int32_t ProfHostPmuJob::PrepareOutputDir()
{
    const std::string dataPath = collectionJobCfg_->jobParams.dataPath;
    if (dataPath.empty()) {
        MSPROF_LOGE("[ProfHostPmuJob] data path is empty");
        return PROFILING_FAILED;
    }
    // Host data lives under <PROF>/host/data/<feature>, next to ftrace's <PROF>/host/data/ftrace.
    // The job table already supplies "data/pmu" relative to the host result dir, so only a caller
    // that hands over a bare directory needs the subdirectory appended.
    const std::string suffix = std::string(MSVP_SLASH) + PMU_OUTPUT_SUB_DIR;
    std::string dir = dataPath;
    // result_dir may end with a slash, which shows up as host//data/pmu; collapse it so the suffix
    // check below sees the real path.
    for (size_t pos = dir.find("//"); pos != std::string::npos; pos = dir.find("//", pos)) {
        dir.erase(pos, 1);
    }
    if (dir.size() < suffix.size() || dir.compare(dir.size() - suffix.size(), suffix.size(), suffix) != 0) {
        dir += suffix;
    }
    outputDir_ = dir;
    if (Utils::CreateDir(outputDir_) != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfHostPmuJob] create '%s' failed", outputDir_.c_str());
        return PROFILING_FAILED;
    }
    return PROFILING_SUCCESS;
}

int32_t ProfHostPmuJob::WriteHeader(int32_t cpu, const std::string& path) const
{
    // A header row keeps the file self-describing: the analyser reads the event list from here
    // instead of duplicating the CLI default, and a future event rename cannot silently mislabel
    // a column. cpu travels with the counter definition, which is how a sample is attributed to a
    // core; pid is always -1 because counting is system-wide.
    FILE* fp = fopen(path.c_str(), "w");
    if (fp == nullptr) {
        MSPROF_LOGE("[ProfHostPmuJob] open '%s' failed: %s", path.c_str(), std::strerror(errno));
        return PROFILING_FAILED;
    }
    (void)fprintf(fp, "#msprof_pmu_v1\n");
    // The analyser needs a clock correspondence to place these rows on the session timeline. It is
    // sampled here, once, instead of reusing the ftrace anchor: that anchor is CLOCK_MONOTONIC_RAW
    // and this job timestamps with CLOCK_MONOTONIC, so borrowing it would shift every row by the
    // gap between the two clocks.
    uint64_t monoNs = 0;
    uint64_t epochNs = 0;
    Analysis::Dvvp::HostPmu::PmuClockAnchor(monoNs, epochNs);
    (void)fprintf(
        fp, "#pid=-1 cpu=%d intervalNs=%" PRIu64 " anchorMonoNs=%" PRIu64 " anchorEpochNs=%" PRIu64 "\n", cpu,
        intervalNs_, monoNs, epochNs);
    (void)fprintf(fp, "timestampNs");
    for (size_t i = 0; i < eventNames_.size(); ++i) {
        // The column carries "<name>/<source>". The source has to travel with the header: the
        // analyser cannot re-resolve it (the node that collected may differ from the one that
        // analyses), and without it a sysfs event and its generic namesake look identical even
        // though they count different hardware events.
        const std::string source = (i < eventSpecs_.size()) ? eventSpecs_[i].source : std::string();
        (void)fprintf(fp, ",%s/%s", eventNames_[i].c_str(), source.c_str());
    }
    (void)fprintf(fp, "\n");
    (void)fclose(fp);
    return PROFILING_SUCCESS;
}

int32_t ProfHostPmuJob::Init(const SHARED_PTR_ALIA<CollectionJobCfg> cfg)
{
    const int32_t ret = ProfHostDataBase::Init(cfg);
    if (ret != PROFILING_SUCCESS) {
        return ret;
    }
    const int32_t check = CheckPreconditions();
    if (check != PROFILING_SUCCESS) {
        return check;
    }
    collectionJobCfg_ = cfg;
    const auto& params = cfg->comParams->params;
    if (params->host_sys_pid > 0) {
        // Counting is system-wide (nsys has no process-scoped event sampling either). Saying so
        // avoids the impression that the pid narrowed the scope.
        MSPROF_LOGW("[ProfHostPmuJob] --host-sys-pid=%d is ignored: PMU counting is system-wide", params->host_sys_pid);
    }
    if (ParseIntervalMs(params->host_pmu_interval, intervalNs_) != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfHostPmuJob] invalid --event-sampling-interval '%s'", params->host_pmu_interval.c_str());
        return PROFILING_FAILED;
    }
    if (ParseEventList() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (PrepareCpuList() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    if (PrepareOutputDir() != PROFILING_SUCCESS) {
        return PROFILING_FAILED;
    }
    MSPROF_LOGI(
        "[ProfHostPmuJob] ready: cpus=%zu events=%zu intervalNs=%" PRIu64 " out=%s", cpuList_.size(),
        eventNames_.size(), intervalNs_, outputDir_.c_str());
    return PROFILING_SUCCESS;
}

int32_t ProfHostPmuJob::Process()
{
    CHECK_JOB_COMMON_PARAM_RET(collectionJobCfg_, return PROFILING_FAILED);
    for (const auto cpu : cpuList_) {
        const std::string path = outputDir_ + "/" + CpuOutputFileName(cpu);
        if (WriteHeader(cpu, path) != PROFILING_SUCCESS) {
            return PROFILING_FAILED;
        }
    }
    SHARED_PTR_ALIA<ProfHostPmuThread> thread;
    MSVP_MAKE_SHARED3(thread, ProfHostPmuThread, eventSpecs_, cpuList_, outputDir_, return PROFILING_FAILED);
    thread->SetIntervalNs(intervalNs_);
    if (thread->StartCollect() != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfHostPmuJob] start PMU collector thread failed");
        return PROFILING_FAILED;
    }
    pmuThread_ = thread;
    return PROFILING_SUCCESS;
}

int32_t ProfHostPmuJob::Uninit()
{
    if (pmuThread_ != nullptr) {
        (void)pmuThread_->Stop();
        (void)pmuThread_->Join();
        pmuThread_.reset();
    }
    (void)ProfHostDataBase::Uninit();
    return PROFILING_SUCCESS;
}

ProfHostPmuThread::ProfHostPmuThread(
    std::vector<Analysis::Dvvp::HostPmu::PmuEventSpec> eventSpecs, std::vector<int32_t> cpuList, std::string outputDir)
    : eventSpecs_(std::move(eventSpecs)), cpuList_(std::move(cpuList)), outputDir_(std::move(outputDir))
{
    SetThreadName("msprof_pmu");
    contexts_.resize(cpuList_.size());
    for (size_t i = 0; i < cpuList_.size(); ++i) {
        contexts_[i].cpu = cpuList_[i];
        contexts_[i].path = outputDir_ + "/" + CpuOutputFileName(cpuList_[i]);
        contexts_[i].timingPath = contexts_[i].path + ".timing";
        contexts_[i].sumRaw.assign(eventSpecs_.size(), 0);
        contexts_[i].sumEnabled.assign(eventSpecs_.size(), 0);
        contexts_[i].sumRunning.assign(eventSpecs_.size(), 0);
        contexts_[i].lastRaw.assign(eventSpecs_.size(), 0);
        contexts_[i].lastEnabled.assign(eventSpecs_.size(), 0);
        contexts_[i].lastRunning.assign(eventSpecs_.size(), 0);
    }
    // One outcome per CPU, written by index: a CPU is opened once per round, so appending here would
    // grow the status file with every batch cycle.
    outcomes_.resize(contexts_.size());
    for (size_t i = 0; i < contexts_.size(); ++i) {
        outcomes_[i].cpu = contexts_[i].cpu;
    }
}

// A CPU needs one fd per event plus the data file and the timing sidecar. The limit decides how many
// CPUs can hold counters at the same time; it never decides which CPUs are collected, because every
// core is sampled in one of the batches. Keeping the computation here means the caller does not have
// to know the limit, and no user-facing knob is needed.
size_t ProfHostPmuThread::ComputeBatchSize() const
{
    const size_t perCpu = eventSpecs_.size() + 2;
    struct rlimit limit = {0, 0};
    if (getrlimit(RLIMIT_NOFILE, &limit) != 0 || limit.rlim_cur <= static_cast<rlim_t>(PMU_FD_RESERVED)) {
        return 1;
    }
    const size_t budget = static_cast<size_t>(limit.rlim_cur) - static_cast<size_t>(PMU_FD_RESERVED);
    const size_t byLimit = (perCpu == 0) ? contexts_.size() : (budget / perCpu);
    if (byLimit == 0) {
        return 1;
    }
    return (byLimit < contexts_.size()) ? byLimit : contexts_.size();
}

int32_t ProfHostPmuThread::OpenFile(CpuContext& ctx)
{
    // Append: the header is already written by the job, and a batch that is sampled again must not
    // lose the rows it produced earlier.
    ctx.fp = fopen(ctx.path.c_str(), "a");
    if (ctx.fp == nullptr) {
        MSPROF_LOGE("[ProfHostPmuThread] open '%s' failed: %s", ctx.path.c_str(), std::strerror(errno));
        return PROFILING_FAILED;
    }
    // Truncated once per run: the analyser matches these lines to samples by timestamp, and a rerun
    // into the same directory must not leave lines from an earlier one behind. Later batches append.
    ctx.timingFp = fopen(ctx.timingPath.c_str(), ctx.timingTruncated ? "a" : "w");
    if (ctx.timingFp == nullptr) {
        MSPROF_LOGE("[ProfHostPmuThread] open '%s' failed: %s", ctx.timingPath.c_str(), std::strerror(errno));
        (void)fclose(ctx.fp);
        ctx.fp = nullptr;
        return PROFILING_FAILED;
    }
    ctx.timingTruncated = true;
    return PROFILING_SUCCESS;
}

// Names the events that could not be opened. Kept as one place so the failure text stays identical on
// both paths (open refused outright, or open succeeded for only part of the event list).
void ReportSkippedEvents(int32_t cpu, const std::vector<std::string>& failed)
{
    for (const auto& item : failed) {
        MSPROF_LOGW("[ProfHostPmuThread] cpu%d skipped event %s", cpu, item.c_str());
    }
}

// Opens one CPU's counters and files. False when either step fails, with the outcome recorded so the
// status file can tell "out of scope" from "could not be collected".
bool ProfHostPmuThread::OpenOneCpu(size_t index)
{
    CpuContext& ctx = contexts_[index];
    std::vector<std::string> failed;
    std::string errorMsg;
    // pid = -1 with an explicit cpu is the system-wide form: every process scheduled on that core is
    // counted. The resolved specs are passed rather than the names, so --os-events keeps its
    // software-only resolution all the way to perf_event_open.
    if (ctx.collector.OpenResolved(eventSpecs_, -1, ctx.cpu, failed, errorMsg) != 0) {
        MSPROF_LOGE("[ProfHostPmuThread] cpu%d: %s", ctx.cpu, errorMsg.c_str());
        ReportSkippedEvents(ctx.cpu, failed);
        outcomes_[index].collected = false;
        outcomes_[index].err = errno;
        return false;
    }
    ReportSkippedEvents(ctx.cpu, failed);
    if (OpenFile(ctx) != PROFILING_SUCCESS) {
        ctx.collector.Close();
        outcomes_[index].collected = false;
        outcomes_[index].err = errno;
        return false;
    }
    (void)ctx.collector.Enable();
    ResetBaseline(ctx);
    outcomes_[index].collected = true;
    outcomes_[index].err = 0;
    return true;
}

int32_t ProfHostPmuThread::OpenBatch(size_t start, size_t count)
{
    size_t opened = 0;
    const size_t end = ((start + count) < contexts_.size()) ? (start + count) : contexts_.size();
    for (size_t i = start; i < end; ++i) {
        if (OpenOneCpu(i)) {
            ++opened;
        }
    }
    return (opened == 0) ? PROFILING_FAILED : PROFILING_SUCCESS;
}

// Window delta against the previous read. read() returns the total since enable, not one window:
// adding it directly would count the same cycles again on every tick (observed: a 200 ms window
// reported 12.9e9 cycles, ~25x a core). A batch that is re-opened resets the kernel total, which is
// why ResetBaseline() clears the last values.
uint64_t WindowDelta(uint64_t current, uint64_t last) { return (current >= last) ? (current - last) : 0; }

// Folds one group of readings into the running totals of a CPU.
void ProfHostPmuThread::AccumulateGroup(CpuContext& ctx, const PmuCounterGroup& group)
{
    const size_t limit = (group.counters.size() < ctx.sumRaw.size()) ? group.counters.size() : ctx.sumRaw.size();
    for (size_t k = 0; k < limit; ++k) {
        const auto& counter = group.counters[k];
        if (!counter.valid) {
            continue;
        }
        ctx.sumRaw[k] += WindowDelta(counter.rawValue, ctx.lastRaw[k]);
        ctx.sumEnabled[k] += WindowDelta(counter.timeEnabled, ctx.lastEnabled[k]);
        ctx.sumRunning[k] += WindowDelta(counter.timeRunning, ctx.lastRunning[k]);
        ctx.lastRaw[k] = counter.rawValue;
        ctx.lastEnabled[k] = counter.timeEnabled;
        ctx.lastRunning[k] = counter.timeRunning;
    }
}

void ProfHostPmuThread::SampleOneCpu(size_t index)
{
    CpuContext& ctx = contexts_[index];
    if (ctx.fp == nullptr) {
        return;
    }
    PmuCounterGroup group;
    if (!ctx.collector.Read(group)) {
        return;
    }
    AccumulateGroup(ctx, group);
    WriteRow(ctx, group);
}

void ProfHostPmuThread::SampleBatch(size_t start, size_t count)
{
    const size_t end = ((start + count) < contexts_.size()) ? (start + count) : contexts_.size();
    for (size_t i = start; i < end; ++i) {
        SampleOneCpu(i);
    }
}

void ProfHostPmuThread::ResetBaseline(CpuContext& ctx)
{
    std::fill(ctx.lastRaw.begin(), ctx.lastRaw.end(), 0);
    std::fill(ctx.lastEnabled.begin(), ctx.lastEnabled.end(), 0);
    std::fill(ctx.lastRunning.begin(), ctx.lastRunning.end(), 0);
}

void ProfHostPmuThread::CloseBatch(size_t start, size_t count)
{
    for (size_t i = start; i < start + count && i < contexts_.size(); ++i) {
        auto& ctx = contexts_[i];
        if (ctx.fp == nullptr) {
            continue;
        }
        (void)ctx.collector.Disable();
        ctx.collector.Close();
        if (ctx.timingFp != nullptr) {
            (void)fclose(ctx.timingFp);
            ctx.timingFp = nullptr;
        }
        (void)fclose(ctx.fp);
        ctx.fp = nullptr;
    }
}

// <outputDir>/host_pmu_status.txt: "cpu,<n>,<state>,<errno>" with state 1 = collected, 0 = failed.
// A CPU that is absent never entered a batch, which cannot happen once a full sweep completes.
void ProfHostPmuThread::WriteStatusFile() const
{
    const std::string path = outputDir_ + "/" + "host_pmu_status.txt";
    FILE* fp = fopen(path.c_str(), "w");
    if (fp == nullptr) {
        MSPROF_LOGE("[ProfHostPmuThread] cannot write '%s': %s", path.c_str(), std::strerror(errno));
        return;
    }
    (void)fprintf(fp, "#msprof_pmu_status_v1\n");
    if (!statusNote_.empty()) {
        // In the data rather than only in the log: the default log level drops warnings, and this is
        // where a user looks when the sample count is lower than expected.
        (void)fprintf(fp, "#note: %s\n", statusNote_.c_str());
    }
    for (const auto& outcome : outcomes_) {
        (void)fprintf(fp, "cpu,%d,%d,%d\n", outcome.cpu, outcome.collected ? 1 : 0, outcome.err);
    }
    (void)fclose(fp);
}

namespace {
// Scales an accumulated count by enabled/running when the kernel could not keep the event on the
// counter for the whole window (the ratio is below 1 in that case). The product raw * enabled cannot
// be formed in 64 bits: a counter total of 1e13 and an accumulated window of 3.6e12 multiply to 3.6e25.
// The ratio is therefore formed first and applied in floating point: both operands stay below 2^53 in
// practice (cumulative nanoseconds, counter totals), so the ratio keeps ~15 significant digits and the
// result never overflows. The exact raw value is preserved in the .timing sidecar either way.
uint64_t ScaleForMultiplexing(uint64_t raw, uint64_t enabled, uint64_t running)
{
    if (enabled == 0 || running == 0 || running >= enabled) {
        return raw;
    }
    const double ratio = static_cast<double>(enabled) / static_cast<double>(running);
    const double scaled = static_cast<double>(raw) * ratio;
    const double maxU64 = static_cast<double>(std::numeric_limits<uint64_t>::max());
    if (!(scaled < maxU64)) { // also catches inf, keeping the output a valid uint64 value
        return std::numeric_limits<uint64_t>::max();
    }
    return static_cast<uint64_t>(scaled + 0.5);
}
} // namespace

void ProfHostPmuThread::WriteRow(CpuContext& ctx, const PmuCounterGroup& group)
{
    if (ctx.fp == nullptr) {
        return;
    }
    (void)fprintf(ctx.fp, "%" PRIu64, group.timestampNs);
    for (size_t i = 0; i < group.counters.size(); ++i) {
        const auto& counter = group.counters[i];
        if (!counter.valid || i >= ctx.sumRaw.size()) {
            (void)fprintf(ctx.fp, ",nan");
            continue;
        }
        // Publish the accumulated totals, scaled the same way the kernel total is scaled: the ratio of
        // the accumulated enabled/running times applies to the whole accumulated count.
        const uint64_t enabled = ctx.sumEnabled[i];
        const uint64_t running = ctx.sumRunning[i];
        const uint64_t scaled = ScaleForMultiplexing(ctx.sumRaw[i], enabled, running);
        (void)fprintf(ctx.fp, ",%" PRIu64, scaled);
        (void)fprintf(
            ctx.timingFp, "%" PRIu64 ",%zu,%" PRIu64 ",%" PRIu64 ",%" PRIu64 "\n", group.timestampNs, i, ctx.sumRaw[i],
            enabled, running);
    }
    (void)fprintf(ctx.fp, "\n");
    (void)fflush(ctx.fp);
    if (ctx.timingFp != nullptr) {
        (void)fflush(ctx.timingFp);
    }
}

void ProfHostPmuThread::CloseAll()
{
    for (auto& ctx : contexts_) {
        if (ctx.timingFp != nullptr) {
            (void)fclose(ctx.timingFp);
            ctx.timingFp = nullptr;
        }
        if (ctx.fp != nullptr) {
            (void)ctx.collector.Disable();
            ctx.collector.Close();
            (void)fclose(ctx.fp);
            ctx.fp = nullptr;
        }
    }
}

// Announces how the fd limit shapes this run. One batch per interval is the configured behaviour; more
// than one batch means every core is still covered, at a coarser interval per core.
void ProfHostPmuThread::ReportBatching() const
{
    if (batchCount_ > 1) {
        MSPROF_LOGW(
            "[ProfHostPmuThread] fd limit holds %zu CPUs at once; sampling %zu CPUs in %zu batches", batchSize_,
            contexts_.size(), batchCount_);
        return;
    }
    MSPROF_LOGI("[ProfHostPmuThread] collecting on %zu CPUs", contexts_.size());
}

// Writes the resource note the status file carries: the log macros are filtered by the deployment's log
// level, so a warning alone may never reach the user.
void ProfHostPmuThread::BuildStatusNote()
{
    if (batchCount_ <= 1) {
        return;
    }
    const size_t neededFds = contexts_.size() * (eventSpecs_.size() + 2) + PMU_FD_RESERVED;
    statusNote_ = "fd limit allows " + std::to_string(batchSize_) + " CPUs at once; " +
                  std::to_string(contexts_.size()) + " CPUs are still sampled, in " + std::to_string(batchCount_) +
                  " batches, so the per-CPU interval is about " + std::to_string(batchCount_) +
                  "x the configured one. Raise 'ulimit -n' to " + std::to_string(neededFds) +
                  " for the configured interval.";
}

// Number of CPUs the current batch covers, clamped to the tail when the last batch is short.
size_t ProfHostPmuThread::CurrentBatchCount() const
{
    return ((batchStart_ + batchSize_) <= contexts_.size()) ? batchSize_ : (contexts_.size() - batchStart_);
}

// Opens the batch under the cursor. Advancing by start + batchSize would drift when the last batch is
// short and revisit some cores out of order, so batch k always covers [k * batchSize, (k+1) * batchSize).
void ProfHostPmuThread::OpenCurrentBatch()
{
    batchStart_ = batchIndex_ * batchSize_;
    if (OpenBatch(batchStart_, CurrentBatchCount()) != PROFILING_SUCCESS) {
        MSPROF_LOGE("[ProfHostPmuThread] no CPU in batch at %zu could be opened", batchStart_);
    }
    batchOpen_ = true;
}

// Waits one interval in slices, checking the quit flag between them. A single nanosleep() would keep
// Stop()/Join() blocked for the whole interval, which is up to an hour when the user configures
// --event-sampling-interval=3600000.
void ProfHostPmuThread::WaitOneInterval()
{
    uint64_t remainingNs = intervalNs_;
    while ((remainingNs > 0) && !IsQuit()) {
        const uint64_t sleepNs = (remainingNs < PMU_WAIT_SLICE_NS) ? remainingNs : PMU_WAIT_SLICE_NS;
        struct timespec req = {
            static_cast<time_t>(sleepNs / NANOS_PER_SECOND), static_cast<long>(sleepNs % NANOS_PER_SECOND)};
        (void)nanosleep(&req, nullptr);
        remainingNs -= sleepNs;
    }
}

void ProfHostPmuThread::Run(const error_message::ErrorManagerContext& errorContext)
{
    (void)errorContext;
    if (contexts_.empty()) {
        return;
    }
    batchSize_ = ComputeBatchSize();
    batchCount_ = (contexts_.size() + batchSize_ - 1) / batchSize_;
    ReportBatching();
    BuildStatusNote();
    while (!IsQuit()) {
        if (!batchOpen_) {
            OpenCurrentBatch();
        }
        WaitOneInterval();
        if (IsQuit()) {
            break;
        }
        SampleBatch(batchStart_, CurrentBatchCount());
        if (batchCount_ > 1) {
            CloseBatch(batchStart_, CurrentBatchCount());
            batchOpen_ = false;
            batchIndex_ = (batchIndex_ + 1) % batchCount_;
        }
    }
    if (batchOpen_) {
        CloseBatch(batchStart_, CurrentBatchCount());
        batchOpen_ = false;
    }
    CloseAll();
    WriteStatusFile();
}

int32_t ProfHostPmuThread::StartCollect() { return Start(); }
} // namespace JobWrapper
} // namespace Dvvp
} // namespace Analysis
