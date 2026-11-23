/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"

#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

#include <chrono>
#include <cstring>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>

#include "collection_job.h"
#include "platform/platform.h"
#include "prof_comm_job.h"
#include "prof_host_pmu_job.h"
#include "transport/uploader_mgr.h"
#include "prof_params.h"

using analysis::dvvp::common::error::PROFILING_FAILED;
using analysis::dvvp::common::error::PROFILING_NOTSUPPORT;
using analysis::dvvp::common::error::PROFILING_SUCCESS;
using Analysis::Dvvp::JobWrapper::CollectionJobCfg;
using Analysis::Dvvp::JobWrapper::CollectionJobCommonParams;
using Analysis::Dvvp::JobWrapper::ProfHostPmuJob;

namespace {
const char* ROOT_ENV = "MSPROF_PMU_SYSFS_ROOT";
// Counting is system-wide, so the CPU set decides both the fd count and how many files are
// written; the override keeps the cases independent of the machine they run on.
const char* CPU_ENV = "MSPROF_PMU_CPU_LIST";

void WriteFile(const std::string& path, const std::string& content)
{
    std::ofstream ofs(path.c_str(), std::ios::trunc);
    ofs << content;
}

void MakeDir(const std::string& path) { (void)mkdir(path.c_str(), 0755); }

// Fixture tree: <root>/sys holds a fake PMU, <root>/out stands in for the job data path.
std::string MakeFixture(const std::string& tag, const std::vector<std::string>& events)
{
    const std::string root = std::string("/tmp/msprof_pmu_job_ut_") + tag;
    const std::string cmd = "rm -rf " + root;
    (void)system(cmd.c_str());
    MakeDir(root);
    MakeDir(root + "/sys");
    const std::string pmuDir = root + "/sys/armv8_pmuv3_0";
    MakeDir(pmuDir);
    WriteFile(pmuDir + "/type", "8");
    MakeDir(pmuDir + "/events");
    for (size_t i = 0; i < events.size(); ++i) {
        WriteFile(pmuDir + "/events/" + events[i], "event=0x4\n");
    }
    MakeDir(root + "/out");
    (void)setenv(ROOT_ENV, (root + "/sys").c_str(), 1);
    return root;
}

void ClearRoot() { (void)unsetenv(ROOT_ENV); }

std::string ReadWholeFile(const std::string& path)
{
    std::ifstream ifs(path.c_str());
    std::ostringstream oss;
    oss << ifs.rdbuf();
    return oss.str();
}

bool FileExists(const std::string& path) { return access(path.c_str(), F_OK) == 0; }
} // namespace

class ProfHostPmuJobUtest : public testing::Test {
protected:
    void SetUp() override
    {
        ClearRoot();
        (void)setenv(CPU_ENV, "0-1", 1);
        cfg_ = std::make_shared<CollectionJobCfg>();
        auto params = std::make_shared<analysis::dvvp::message::ProfileParams>();
        auto jobCtx = std::make_shared<analysis::dvvp::message::JobContext>();
        auto comParams = std::make_shared<CollectionJobCommonParams>();
        comParams->params = params;
        comParams->jobCtx = jobCtx;
        cfg_->comParams = comParams;
        cfg_->jobParams.events = std::make_shared<std::vector<std::string>>(0);

        // ProfHostDataBase::Init refuses to run without an uploader, so every case needs one. The
        // switch-off cases still reach it because the base Init runs before CheckPreconditions.
        upLoader_ = std::make_shared<analysis::dvvp::transport::Uploader>(nullptr);
        MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::GetUploader).stubs().with(any(), outBound(upLoader_));
        analysis::dvvp::transport::UploaderMgr::instance()->AddUploader("0", upLoader_);
        cfg_->comParams->params->job_id = "0";
    }

    void TearDown() override
    {
        cfg_.reset();
        upLoader_.reset();
        ClearRoot();
        (void)unsetenv(CPU_ENV);
        GlobalMockObject::verify();
    }

    // Host side with host profiling enabled and the PMU switch on.
    void EnableHostPmu(const std::string& events, const std::string& interval = "10")
    {
        MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide).stubs().will(returnValue(false));
        cfg_->comParams->params->hostProfiling = true;
        cfg_->comParams->params->host_pmu_profiling = "on";
        cfg_->comParams->params->host_pmu_events = events;
        cfg_->comParams->params->host_pmu_interval = interval;
    }

    std::shared_ptr<CollectionJobCfg> cfg_;
    std::shared_ptr<analysis::dvvp::transport::Uploader> upLoader_;
};

// A null config is rejected before anything else is touched.
TEST_F(ProfHostPmuJobUtest, InitRejectsNullConfig)
{
    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(nullptr), PROFILING_FAILED);
}

// On the soc side the job reports NOTSUPPORT so the scheduler skips it without logging a failure.
TEST_F(ProfHostPmuJobUtest, InitSkippedOnSocSide)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide).stubs().will(returnValue(true));
    cfg_->comParams->params->hostProfiling = true;
    cfg_->comParams->params->host_pmu_profiling = "on";
    cfg_->comParams->params->host_pmu_events = "l1d_cache";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_NOTSUPPORT);
}

// Host profiling off means the whole host path is off, so the PMU job goes with it.
// --host-sys and the PMU switches are independent: asking for cycles/instructions must not require
// also collecting CPU/memory/disk data. With --host-sys off and PMU on, the job must still start.
TEST_F(ProfHostPmuJobUtest, InitRunsWhenOnlyPmuSwitchIsOn)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide).stubs().will(returnValue(false));
    const std::string root = MakeFixture("pmuonly", {"l1d_cache"});
    cfg_->comParams->params->hostProfiling = false;
    cfg_->comParams->params->host_pmu_profiling = "on";
    cfg_->comParams->params->host_pmu_events = "l1d_cache";
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// The switch defaults to off, which must skip the job.
TEST_F(ProfHostPmuJobUtest, InitSkippedWhenSwitchNotOn)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide).stubs().will(returnValue(false));
    cfg_->comParams->params->hostProfiling = true;
    cfg_->comParams->params->host_pmu_profiling = "";
    cfg_->comParams->params->host_pmu_events = "l1d_cache";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_NOTSUPPORT);
}

// "off" is also a skip, not a failure.
TEST_F(ProfHostPmuJobUtest, InitSkippedWhenSwitchOff)
{
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide).stubs().will(returnValue(false));
    cfg_->comParams->params->hostProfiling = true;
    cfg_->comParams->params->host_pmu_profiling = "off";
    cfg_->comParams->params->host_pmu_events = "l1d_cache";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_NOTSUPPORT);
}

// Switch on with no events is a failure: the user asked for data that cannot be produced.
TEST_F(ProfHostPmuJobUtest, InitFailsOnEmptyEventList)
{
    const std::string root = MakeFixture("empty", {"l1d_cache"});
    EnableHostPmu("");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// A zero interval is rejected rather than silently collecting at some default.
TEST_F(ProfHostPmuJobUtest, InitFailsOnZeroInterval)
{
    const std::string root = MakeFixture("zero", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "0");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// An interval beyond the ceiling is rejected; the ceiling exists so a typo cannot silence the job
// for an hour without the user noticing.
TEST_F(ProfHostPmuJobUtest, InitFailsOnIntervalAboveCeiling)
{
    const std::string root = MakeFixture("ceiling", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "3600001");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// A non-numeric interval is rejected.
TEST_F(ProfHostPmuJobUtest, InitFailsOnNonNumericInterval)
{
    const std::string root = MakeFixture("nan", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "abc");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// An interval with trailing junk is rejected, so "10ms" does not silently become 10.
TEST_F(ProfHostPmuJobUtest, InitFailsOnIntervalWithTrailingJunk)
{
    const std::string root = MakeFixture("junk", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10ms");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// The interval ceiling itself is accepted.
TEST_F(ProfHostPmuJobUtest, InitAcceptsIntervalAtCeiling)
{
    const std::string root = MakeFixture("atceiling", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "3600000");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// An empty interval falls back to the documented default.
TEST_F(ProfHostPmuJobUtest, InitAcceptsEmptyIntervalAsDefault)
{
    const std::string root = MakeFixture("defint", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// A good configuration gets through Init and creates the output directory even though the file is
// only written in Process.
TEST_F(ProfHostPmuJobUtest, InitSucceedsAndCreatesOutputDir)
{
    const std::string root = MakeFixture("ok", {"l1d_cache", "dtlb_walk"});
    EnableHostPmu("l1d_cache,dtlb_walk", "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    struct stat st = {0};
    EXPECT_EQ(stat((root + "/out/data/pmu").c_str(), &st), 0) << "data/pmu must exist after Init";
    EXPECT_TRUE(S_ISDIR(st.st_mode));
}

// An empty data path is a failure, not a write into the current directory.
TEST_F(ProfHostPmuJobUtest, InitFailsOnEmptyDataPath)
{
    (void)MakeFixture("nopath", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10");
    cfg_->jobParams.dataPath = "";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// An unresolvable event does not fail Init: the name is kept as a column with an unknown source so
// the header and the rows still line up, and the collector reports the concrete reason when it
// tries to open it. Init only fails when the list itself is unusable (empty or too long).
TEST_F(ProfHostPmuJobUtest, InitKeepsUnresolvableEventAsColumn)
{
    const std::string root = MakeFixture("noresolve", {});
    EnableHostPmu("totally-unknown-event", "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// Empty items between separators are skipped rather than counted as unnamed events.
TEST_F(ProfHostPmuJobUtest, InitSkipsEmptyItemsInEventList)
{
    const std::string root = MakeFixture("gaps", {"l1d_cache"});
    EnableHostPmu("l1d_cache,,", "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// More than 32 events is rejected: the limit keeps the row width bounded. The names must be
// distinct, because duplicates are collapsed before this check runs.
TEST_F(ProfHostPmuJobUtest, InitRejectsTooManyEvents)
{
    const std::string root = MakeFixture("toomany", {"l1d_cache"});
    std::string events;
    for (int32_t i = 0; i < 40; ++i) {
        if (!events.empty()) {
            events += ",";
        }
        events += "raw:0x" + std::to_string(i + 1);
    }
    EnableHostPmu(events, "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// 31 events is under the limit and must be accepted: the ceiling is inclusive, so 31, 32 pass and
// only 33 fails. The CLI carries the same three cases, which is what keeps the two ends aligned.
TEST_F(ProfHostPmuJobUtest, InitAccepts31Events)
{
    const std::string root = MakeFixture("max31", {"l1d_cache"});
    std::string events;
    for (int32_t i = 0; i < 31; ++i) {
        if (!events.empty()) {
            events += ",";
        }
        events += "raw:0x" + std::to_string(i + 1);
    }
    EnableHostPmu(events, "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// 33 events is one past the limit and must be rejected.
TEST_F(ProfHostPmuJobUtest, InitRejects33Events)
{
    const std::string root = MakeFixture("max33", {"l1d_cache"});
    std::string events;
    for (int32_t i = 0; i < 33; ++i) {
        if (!events.empty()) {
            events += ",";
        }
        events += "raw:0x" + std::to_string(i + 1);
    }
    EnableHostPmu(events, "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// Exactly 32 events is accepted, so the boundary is inclusive.
TEST_F(ProfHostPmuJobUtest, InitAcceptsExactlyMaxEvents)
{
    const std::string root = MakeFixture("maxok", {"l1d_cache"});
    std::string events;
    for (int32_t i = 0; i < 32; ++i) {
        if (!events.empty()) {
            events += ",";
        }
        events += "raw:0x" + std::to_string(i + 1);
    }
    EnableHostPmu(events, "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
}

// Process writes the self-describing header before any sample exists, so an interrupted run still
// produces a parseable file (header only, no rows).
TEST_F(ProfHostPmuJobUtest, ProcessWritesHeader)
{
    const std::string root = MakeFixture("header", {"l1d_cache", "dtlb_walk"});
    EnableHostPmu("l1d_cache,dtlb_walk", "10");
    cfg_->jobParams.dataPath = root + "/out";
    // The collector thread must not touch real perf; report a failure to open so it exits at once.
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string path = root + "/out/data/pmu/host_pmu_cpu0.data";
    ASSERT_TRUE(FileExists(path)) << path;
    const std::string body = ReadWholeFile(path);
    EXPECT_NE(body.find("#msprof_pmu_v1"), std::string::npos) << body;
    EXPECT_NE(body.find("#pid=-1 cpu=0"), std::string::npos) << "system-wide: pid is -1 and cpu is the core";
    EXPECT_NE(body.find("intervalNs=10000000"), std::string::npos) << body;
    EXPECT_NE(body.find("anchorMonoNs="), std::string::npos) << body;
    EXPECT_NE(body.find("anchorEpochNs="), std::string::npos) << body;
    EXPECT_NE(body.find("timestampNs,l1d_cache/sysfs,dtlb_walk/sysfs"), std::string::npos) << body;
}

// A generic alias must be labelled with its own source in the header, so the analyser can tell it
// apart from a sysfs event of the same name.
TEST_F(ProfHostPmuJobUtest, ProcessLabelsGenericSourceInHeader)
{
    const std::string root = MakeFixture("gensrc", {});
    EnableHostPmu("cycles", "10");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("timestampNs,cycles/generic"), std::string::npos) << body;
}

// An unresolvable event still gets a column, but with an empty source.
TEST_F(ProfHostPmuJobUtest, ProcessWritesEmptySourceForUnknownEvent)
{
    const std::string root = MakeFixture("unksrc", {});
    EnableHostPmu("no-such-event", "10");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("timestampNs,no-such-event/"), std::string::npos) << body;
}

// Counting is system-wide: a pid on the command line must not narrow the scope, and every CPU gets
// its own file named after the core.
TEST_F(ProfHostPmuJobUtest, ProcessIgnoresPidAndWritesOneFilePerCpu)
{
    const std::string root = MakeFixture("withpid", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10");
    cfg_->comParams->params->host_sys_pid = 4321;
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string path0 = root + "/out/data/pmu/host_pmu_cpu0.data";
    const std::string path1 = root + "/out/data/pmu/host_pmu_cpu1.data";
    ASSERT_TRUE(FileExists(path0)) << path0;
    ASSERT_TRUE(FileExists(path1)) << path1;
    EXPECT_NE(ReadWholeFile(path0).find("#pid=-1 cpu=0"), std::string::npos);
    EXPECT_NE(ReadWholeFile(path1).find("#pid=-1 cpu=1"), std::string::npos);
    EXPECT_FALSE(FileExists(root + "/out/data/pmu/host_pmu_4321.data")) << "the pid must not name the file";
}

// The online CPU list comes from the kernel as ranges and comma lists; both forms expand, and a
// malformed value fails Init instead of silently collecting nothing.
TEST_F(ProfHostPmuJobUtest, ProcessExpandsCpuRangeAndList)
{
    const std::string root = MakeFixture("cpurange", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10");
    cfg_->jobParams.dataPath = root + "/out";
    (void)setenv(CPU_ENV, "2-3,5", 1);
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    for (const char* cpu : {"2", "3", "5"}) {
        const std::string path = root + "/out/data/pmu/host_pmu_cpu" + cpu + ".data";
        EXPECT_TRUE(FileExists(path)) << path;
    }
    EXPECT_FALSE(FileExists(root + "/out/data/pmu/host_pmu_cpu4.data")) << "4 is not in the list";
}

TEST_F(ProfHostPmuJobUtest, InitFailsOnMalformedCpuList)
{
    const std::string root = MakeFixture("badcpu", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10");
    cfg_->jobParams.dataPath = root + "/out";
    (void)setenv(CPU_ENV, "0-abc", 1);

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

TEST_F(ProfHostPmuJobUtest, InitFailsOnCpuListWithoutNumbers)
{
    const std::string root = MakeFixture("blankcpu", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10");
    cfg_->jobParams.dataPath = root + "/out";
    (void)setenv(CPU_ENV, " , ", 1);

    ProfHostPmuJob job;
    EXPECT_EQ(job.Init(cfg_), PROFILING_FAILED);
}

// A software event must be labelled with its own source, so the analyser can tell a kernel counter
// (page-faults) from a PMU one and never mixes them into a single ratio.
TEST_F(ProfHostPmuJobUtest, ProcessLabelsSoftwareSourceInHeader)
{
    const std::string root = MakeFixture("swsrc", {});
    EnableHostPmu("page-faults", "10");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("timestampNs,page-faults/software"), std::string::npos) << body;
}

// A mixed list keeps one column per event with the right source each: the header is the only place
// that records provenance, so a wrong source here would make the analyser compare unlike events.
TEST_F(ProfHostPmuJobUtest, ProcessKeepsMixedSourcesApart)
{
    const std::string root = MakeFixture("mixed", {"l1d_cache"});
    EnableHostPmu("cycles,page-faults,l1d_cache", "10");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("timestampNs,cycles/generic,page-faults/software,l1d_cache/sysfs"), std::string::npos) << body;
}

// --os-events and --cpu-core-events are separate lists but land in one file: the header must show
// each column's own source, and the OS list must be resolved strictly (a sysfs event with the same
// name must not be substituted).
TEST_F(ProfHostPmuJobUtest, ProcessMergesCoreAndOsEventLists)
{
    const std::string root = MakeFixture("twoLists", {"l1d_cache"});
    EnableHostPmu("cycles,l1d_cache", "10");
    cfg_->comParams->params->host_pmu_os_events = "page-faults,context-switches";
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(
        body.find("timestampNs,cycles/generic,l1d_cache/sysfs,page-faults/software,context-switches/software"),
        std::string::npos)
        << body;
}

// Only --os-events given: the job must still run, and the event list is entirely software.
TEST_F(ProfHostPmuJobUtest, ProcessAcceptsOsEventsAlone)
{
    const std::string root = MakeFixture("osOnly", {});
    MOCKER_CPP(&Analysis::Dvvp::Common::Platform::Platform::RunSocSide).stubs().will(returnValue(false));
    cfg_->comParams->params->hostProfiling = true;
    cfg_->comParams->params->host_pmu_profiling = "on";
    cfg_->comParams->params->host_pmu_events = "";
    cfg_->comParams->params->host_pmu_os_events = "page-faults";
    cfg_->comParams->params->host_pmu_interval = "10";
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("timestampNs,page-faults/software"), std::string::npos) << body;
}

// A name listed in both switches would open two fds for the same counter and write two identical
// columns, so it is collapsed with a warning instead.
TEST_F(ProfHostPmuJobUtest, ProcessDeduplicatesAcrossLists)
{
    const std::string root = MakeFixture("dedupe", {});
    EnableHostPmu("page-faults", "10");
    cfg_->comParams->params->host_pmu_os_events = "page-faults";
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    const size_t first = body.find("page-faults");
    EXPECT_NE(first, std::string::npos) << body;
    EXPECT_EQ(body.find("page-faults", first + 1), std::string::npos) << "only one column expected: " << body;
}

// A hardware name given to --os-events must not resolve, so the column shows no source rather than
// silently collecting the PMU counter the user did not ask for.
TEST_F(ProfHostPmuJobUtest, OsEventRejectsHardwareName)
{
    const std::string root = MakeFixture("osbad", {});
    EnableHostPmu("", "10");
    cfg_->comParams->params->host_pmu_os_events = "cycles";
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(returnValue(-1));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("timestampNs,cycles/"), std::string::npos) << body;
    EXPECT_EQ(body.find("cycles/generic"), std::string::npos) << "must not be resolved as a hardware alias: " << body;
}

// Process fails when the header cannot be written, e.g. because the directory was removed between
// Init and Process.
TEST_F(ProfHostPmuJobUtest, ProcessFailsWhenHeaderCannotBeWritten)
{
    const std::string root = MakeFixture("nowrite", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "10");
    cfg_->jobParams.dataPath = root + "/out";

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    const std::string cmd = "rm -rf " + root + "/out/data";
    (void)system(cmd.c_str());
    EXPECT_EQ(job.Process(), PROFILING_FAILED);
}

namespace {
// Drives the collector thread through one successful sample: a fake fd opens, one read returns a
// value, and the thread is stopped as soon as it has written a row.
int32_t FakeOpenForThread(struct perf_event_attr* attr, int32_t pid, int32_t cpu, int32_t groupFd, uint64_t flags)
{
    (void)attr;
    (void)pid;
    (void)cpu;
    (void)groupFd;
    (void)flags;
    return 77;
}

// A reading the kernel had to multiplex: the counter ran for half the window, so the collector
// reports 2 * 12345 and records the raw total plus the ratio in the sidecar.
ssize_t FakeReadMultiplexedForThread(int32_t fd, void* buf, size_t count)
{
    (void)fd;
    struct Payload {
        uint64_t value;
        uint64_t timeEnabled;
        uint64_t timeRunning;
    } payload = {12345, 1000, 500};
    const size_t n = (count < sizeof(payload)) ? count : sizeof(payload);
    (void)memcpy(buf, &payload, n);
    return static_cast<ssize_t>(n);
}

ssize_t FakeReadForThread(int32_t fd, void* buf, size_t count)
{
    (void)fd;
    struct Payload {
        uint64_t value;
        uint64_t timeEnabled;
        uint64_t timeRunning;
    } payload = {12345, 10, 10};
    const size_t n = (count < sizeof(payload)) ? count : sizeof(payload);
    (void)memcpy(buf, &payload, n);
    return static_cast<ssize_t>(n);
}
} // namespace

// A full cycle: the thread opens the counters, writes at least one row with a real value, and the
// file stays parseable afterwards.
TEST_F(ProfHostPmuJobUtest, ThreadWritesSampleRows)
{
    const std::string root = MakeFixture("rows", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "1");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(invoke(FakeOpenForThread));
    MOCKER(Analysis::Dvvp::HostPmu::PerfRead).stubs().will(invoke(FakeReadForThread));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    // Give the thread a moment to take its first sample, then stop it.
    (void)usleep(120 * 1000);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find("#msprof_pmu_v1"), std::string::npos) << body;
    EXPECT_NE(body.find(",12345"), std::string::npos) << "a sample row with the read value: " << body;
}

// An invalid read is written as "nan" rather than a stale or zero value, so the analyser can drop
// it instead of plotting a dip.
TEST_F(ProfHostPmuJobUtest, ThreadWritesNanForInvalidRead)
{
    const std::string root = MakeFixture("nan", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "1");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(invoke(FakeOpenForThread));
    // A short read marks the counter invalid.
    MOCKER(Analysis::Dvvp::HostPmu::PerfRead).stubs().will(returnValue(0));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)usleep(120 * 1000);
    (void)job.Uninit();

    const std::string body = ReadWholeFile(root + "/out/data/pmu/host_pmu_cpu0.data");
    EXPECT_NE(body.find(",nan"), std::string::npos) << body;
}

// Every valid reading records the raw total and the ratio in the timing sidecar, multiplexed or not:
// the database requires them for valid samples, and a 0 sentinel would be ambiguous.
TEST_F(ProfHostPmuJobUtest, ThreadWritesTimingForEveryValidSample)
{
    const std::string root = MakeFixture("timingrows", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "1");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(invoke(FakeOpenForThread));
    MOCKER(Analysis::Dvvp::HostPmu::PerfRead).stubs().will(invoke(FakeReadForThread));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)usleep(120 * 1000);
    (void)job.Uninit();

    const std::string dataPath = root + "/out/data/pmu/host_pmu_cpu0.data";
    const std::string body = ReadWholeFile(dataPath);
    EXPECT_NE(body.find(",12345"), std::string::npos) << body;

    const std::string timingPath = dataPath + ".timing";
    ASSERT_TRUE(FileExists(timingPath)) << timingPath;
    const std::string timing = ReadWholeFile(timingPath);
    // "<timestamp>,<eventIndex>,<rawValue>,<timeEnabled>,<timeRunning>" with te == tr here
    EXPECT_NE(timing.find(",0,12345,10,10"), std::string::npos) << timing;
}

// A multiplexed counter records the true ratio, so the scaling stays reproducible.
TEST_F(ProfHostPmuJobUtest, ThreadRecordsRatioForMultiplexedCounter)
{
    const std::string root = MakeFixture("muxrows", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "1");
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(invoke(FakeOpenForThread));
    MOCKER(Analysis::Dvvp::HostPmu::PerfRead).stubs().will(invoke(FakeReadMultiplexedForThread));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    (void)usleep(120 * 1000);
    (void)job.Uninit();

    const std::string dataPath = root + "/out/data/pmu/host_pmu_cpu0.data";
    EXPECT_NE(ReadWholeFile(dataPath).find(",24690"), std::string::npos);
    const std::string timing = ReadWholeFile(dataPath + ".timing");
    EXPECT_NE(timing.find(",0,12345,1000,500"), std::string::npos) << timing;
}

// The configured interval may be as long as an hour, but Stop()/Join() must not wait for it: the
// sampling wait is served in 100ms slices and the quit flag is checked between them.
TEST_F(ProfHostPmuJobUtest, UninitReturnsPromptlyWithLongInterval)
{
    const std::string root = MakeFixture("longint", {"l1d_cache"});
    EnableHostPmu("l1d_cache", "3600000"); // one hour, in milliseconds
    cfg_->jobParams.dataPath = root + "/out";
    MOCKER(Analysis::Dvvp::HostPmu::PerfEventOpen).stubs().will(invoke(FakeOpenForThread));
    MOCKER(Analysis::Dvvp::HostPmu::PerfRead).stubs().will(invoke(FakeReadForThread));

    ProfHostPmuJob job;
    ASSERT_EQ(job.Init(cfg_), PROFILING_SUCCESS);
    ASSERT_EQ(job.Process(), PROFILING_SUCCESS);
    // Let the thread enter the long wait, then stop it and measure how long the stop takes.
    (void)usleep(150 * 1000);
    const auto start = std::chrono::steady_clock::now();
    (void)job.Uninit();
    const auto elapsedMs =
        std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::steady_clock::now() - start).count();
    EXPECT_LT(elapsedMs, 2000) << "Uninit blocked for " << elapsedMs << " ms with a one-hour interval";
}
