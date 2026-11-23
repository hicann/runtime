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

#include <errno.h>
#include <linux/perf_event.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <unistd.h>

#include <fstream>
#include <string>
#include <vector>

#include "pmu_counter_collector.h"
#include "pmu_event_resolver.h"

using Analysis::Dvvp::HostPmu::PerfEventOpen;
using Analysis::Dvvp::HostPmu::PerfIoctl;
using Analysis::Dvvp::HostPmu::PerfRead;
using Analysis::Dvvp::HostPmu::PmuClockAnchor;
using Analysis::Dvvp::HostPmu::PmuCounterCollector;
using Analysis::Dvvp::HostPmu::PmuCounterGroup;

namespace {
const char* ROOT_ENV = "MSPROF_PMU_SYSFS_ROOT";

void WriteFile(const std::string& path, const std::string& content)
{
    std::ofstream ofs(path.c_str(), std::ios::trunc);
    ofs << content;
}

void MakeDir(const std::string& path) { (void)mkdir(path.c_str(), 0755); }

// Builds a fixture PMU exposing the named events, so Open() resolves without touching real sysfs.
std::string MakePmuFixture(const std::string& tag, const std::vector<std::string>& events)
{
    const std::string root = std::string("/tmp/msprof_pmu_col_ut_") + tag;
    const std::string cmd = "rm -rf " + root;
    (void)system(cmd.c_str());
    MakeDir(root);
    const std::string pmuDir = root + "/armv8_pmuv3_0";
    MakeDir(pmuDir);
    WriteFile(pmuDir + "/type", "8");
    MakeDir(pmuDir + "/events");
    for (size_t i = 0; i < events.size(); ++i) {
        WriteFile(pmuDir + "/events/" + events[i], "event=0x4\n");
    }
    (void)setenv(ROOT_ENV, root.c_str(), 1);
    return root;
}

void ClearRoot() { (void)unsetenv(ROOT_ENV); }

// stub for perf_event_open: returns a fixed fd so the collector records the event.
int32_t FakePerfOpenOk(struct perf_event_attr* attr, int32_t pid, int32_t cpu, int32_t groupFd, uint64_t flags)
{
    (void)attr;
    (void)pid;
    (void)cpu;
    (void)groupFd;
    (void)flags;
    static int32_t next = 100;
    return next++;
}

int32_t FakePerfOpenFail(struct perf_event_attr* attr, int32_t pid, int32_t cpu, int32_t groupFd, uint64_t flags)
{
    (void)attr;
    (void)pid;
    (void)cpu;
    (void)groupFd;
    (void)flags;
    errno = EACCES;
    return -1;
}

// stub for read() with the three-field layout the collector asks for.
ssize_t FakeReadOk(int fd, void* buf, size_t count)
{
    (void)fd;
    struct Payload {
        uint64_t value;
        uint64_t timeEnabled;
        uint64_t timeRunning;
    } payload = {0, 0, 0};
    payload.value = 4242;
    payload.timeEnabled = 100;
    payload.timeRunning = 100;
    const size_t n = (count < sizeof(payload)) ? count : sizeof(payload);
    (void)memcpy(buf, &payload, n);
    return static_cast<ssize_t>(n);
}

ssize_t FakeReadShort(int fd, void* buf, size_t count)
{
    (void)fd;
    (void)buf;
    (void)count;
    return 0;
}

// Records the type/config of every open so a test can assert that the caller's spec was used as-is.
std::vector<uint32_t>& RecordedTypes()
{
    static std::vector<uint32_t> types;
    return types;
}

int32_t FakePerfOpenRecording(struct perf_event_attr* attr, int32_t pid, int32_t cpu, int32_t groupFd, uint64_t flags)
{
    (void)pid;
    (void)cpu;
    (void)groupFd;
    (void)flags;
    RecordedTypes().push_back(attr->type);
    static int32_t next = 200;
    return next++;
}

// Emits a multiplexed reading: the counter was enabled for the whole window but only ran half of it.
ssize_t FakeReadMultiplexed(int fd, void* buf, size_t count)
{
    (void)fd;
    struct Payload {
        uint64_t value;
        uint64_t timeEnabled;
        uint64_t timeRunning;
    } payload = {100, 1000, 500};
    const size_t n = (count < sizeof(payload)) ? count : sizeof(payload);
    (void)memcpy(buf, &payload, n);
    return static_cast<ssize_t>(n);
}
} // namespace

class PmuCounterCollectorUtest : public testing::Test {
protected:
    void SetUp() override { ClearRoot(); }
    void TearDown() override
    {
        ClearRoot();
        GlobalMockObject::verify();
    }
};

// A counter file whose events all resolve and open yields an open collector of the right size.
TEST_F(PmuCounterCollectorUtest, OpenResolvesAndOpensAllEvents)
{
    (void)MakePmuFixture("openall", {"l1d_cache", "dtlb_walk"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    EXPECT_EQ(collector.Open({"l1d_cache", "dtlb_walk"}, 0, -1, failed, errorMsg), 0);
    EXPECT_TRUE(failed.empty()) << (failed.empty() ? "" : failed[0]);
    EXPECT_TRUE(collector.IsOpen());
    EXPECT_EQ(collector.EventCount(), 2U);
    collector.Close();
    EXPECT_FALSE(collector.IsOpen());
}

// An event that cannot be resolved is reported in "failed" while the others still open.
TEST_F(PmuCounterCollectorUtest, OpenReportsUnresolvableEventButKeepsOthers)
{
    (void)MakePmuFixture("partial", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    EXPECT_EQ(collector.Open({"l1d_cache", "no-such-event"}, 0, -1, failed, errorMsg), 0);
    ASSERT_EQ(failed.size(), 1U);
    EXPECT_NE(failed[0].find("no-such-event"), std::string::npos);
    // The failed name keeps its slot: a row must still carry one column per requested event.
    EXPECT_EQ(collector.EventCount(), 2U);
    collector.Close();
}

// When nothing can be opened, Open returns -1 and names the first failure.
TEST_F(PmuCounterCollectorUtest, OpenFailsWhenNoEventOpens)
{
    (void)MakePmuFixture("none", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenFail));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    EXPECT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), -1);
    EXPECT_NE(errorMsg.find("no PMU event could be opened"), std::string::npos) << errorMsg;
    EXPECT_NE(errorMsg.find("permission denied"), std::string::npos) << errorMsg;
    EXPECT_FALSE(collector.IsOpen());
}

// An event list where every name fails to resolve also fails, and reports the resolve reason.
TEST_F(PmuCounterCollectorUtest, OpenFailsWhenNoEventResolves)
{
    (void)MakePmuFixture("noresolve", {});
    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    EXPECT_EQ(collector.Open({"no-such-event"}, 0, -1, failed, errorMsg), -1);
    ASSERT_EQ(failed.size(), 1U);
    EXPECT_NE(errorMsg.find("no PMU event could be opened"), std::string::npos);
}

// Open is idempotent in the sense that reopening closes the previous fds first.
TEST_F(PmuCounterCollectorUtest, ReopenClosesPreviousFds)
{
    (void)MakePmuFixture("reopen", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);
    ASSERT_EQ(collector.EventCount(), 1U);
    ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);
    EXPECT_EQ(collector.EventCount(), 1U) << "reopen must not accumulate fds";
    collector.Close();
}

// Enable and Disable are best-effort: a failing ioctl is logged, not propagated.
TEST_F(PmuCounterCollectorUtest, EnableAndDisableTolerateIoctlFailure)
{
    (void)MakePmuFixture("ioctl", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));
    MOCKER(PerfIoctl).stubs().will(returnValue(-1));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);
    EXPECT_EQ(collector.Enable(), 0);
    EXPECT_EQ(collector.Disable(), 0);
    collector.Close();
}

// Enable and Disable succeed when the ioctl succeeds.
TEST_F(PmuCounterCollectorUtest, EnableAndDisableSucceed)
{
    (void)MakePmuFixture("ioctlok", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));
    MOCKER(PerfIoctl).stubs().will(returnValue(0));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);
    EXPECT_EQ(collector.Enable(), 0);
    EXPECT_EQ(collector.Disable(), 0);
    collector.Close();
}

// Read with no open fd is a no-op that reports false.
TEST_F(PmuCounterCollectorUtest, ReadWithoutOpenReturnsFalse)
{
    PmuCounterCollector collector;
    PmuCounterGroup group;
    EXPECT_FALSE(collector.Read(group));
}

// A successful read fills the value and marks the counter valid.
TEST_F(PmuCounterCollectorUtest, ReadFillsValidCounters)
{
    (void)MakePmuFixture("readok", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));
    MOCKER(PerfRead).stubs().will(invoke(FakeReadOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    ASSERT_EQ(collector.Open({"l1d_cache"}, 123, -1, failed, errorMsg), 0);

    PmuCounterGroup group;
    ASSERT_TRUE(collector.Read(group));
    EXPECT_GT(group.timestampNs, 0U);
    EXPECT_EQ(group.pid, 123);
    EXPECT_EQ(group.cpu, -1);
    ASSERT_EQ(group.counters.size(), 1U);
    EXPECT_TRUE(group.counters[0].valid);
    EXPECT_EQ(group.counters[0].value, 4242U);
    EXPECT_EQ(group.counters[0].name, "l1d_cache");
    EXPECT_EQ(group.counters[0].source, "sysfs");
    collector.Close();
}

// A short read marks the counter invalid instead of reporting a stale value.
TEST_F(PmuCounterCollectorUtest, ReadMarksShortReadInvalid)
{
    (void)MakePmuFixture("readshort", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));
    MOCKER(PerfRead).stubs().will(invoke(FakeReadShort));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);

    PmuCounterGroup group;
    ASSERT_TRUE(collector.Read(group));
    ASSERT_EQ(group.counters.size(), 1U);
    EXPECT_FALSE(group.counters[0].valid);
    EXPECT_EQ(group.counters[0].value, 0U);
    collector.Close();
}

// Read clears counters left over from a previous call rather than appending to them.
TEST_F(PmuCounterCollectorUtest, ReadResetsCountersBetweenCalls)
{
    (void)MakePmuFixture("readreset", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));
    MOCKER(PerfRead).stubs().will(invoke(FakeReadOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);
    PmuCounterGroup group;
    ASSERT_TRUE(collector.Read(group));
    ASSERT_TRUE(collector.Read(group));
    EXPECT_EQ(group.counters.size(), 1U) << "counters must not accumulate across reads";
    collector.Close();
}

// Destroying an enabled collector disables and closes without leaking.
TEST_F(PmuCounterCollectorUtest, DestructorClosesEnabledCollector)
{
    (void)MakePmuFixture("dtor", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));
    MOCKER(PerfIoctl).stubs().will(returnValue(0));
    {
        PmuCounterCollector collector;
        std::vector<std::string> failed;
        std::string errorMsg;
        ASSERT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);
        (void)collector.Enable();
    }
    SUCCEED();
}

// Close on a never-opened collector is safe.
TEST_F(PmuCounterCollectorUtest, CloseWithoutOpenIsSafe)
{
    PmuCounterCollector collector;
    collector.Close();
    EXPECT_FALSE(collector.IsOpen());
}

// The anchor helper samples both clocks and returns plausible values.
TEST_F(PmuCounterCollectorUtest, ClockAnchorSamplesBothClocks)
{
    uint64_t monoNs = 0;
    uint64_t epochNs = 0;
    PmuClockAnchor(monoNs, epochNs);
    EXPECT_GT(monoNs, 0U);
    EXPECT_GT(epochNs, 0U);
    // "now" is well past 2020 in epoch nanoseconds, so a zero or tiny value would be a bug.
    EXPECT_GT(epochNs, 1577836800000000000ULL);
    // The wall clock is ahead of the monotonic clock on a normally booted machine.
    EXPECT_GT(epochNs, monoNs);
}

// A row must keep one column per requested event even when an event never opened: otherwise the
// analyser reads the next column's value into this column and every later counter shifts by one.
TEST_F(PmuCounterCollectorUtest, ReadKeepsColumnForEventThatFailedToOpen)
{
    (void)MakePmuFixture("align", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    // The second name cannot be resolved, so it keeps a slot with no fd behind it.
    EXPECT_EQ(collector.Open({"l1d_cache", "no-such-event"}, 0, -1, failed, errorMsg), 0);
    ASSERT_EQ(failed.size(), 1U);
    EXPECT_EQ(collector.EventCount(), 2U);

    MOCKER(PerfRead).stubs().will(invoke(FakeReadOk));
    PmuCounterGroup group;
    ASSERT_TRUE(collector.Read(group));
    ASSERT_EQ(group.counters.size(), 2U);
    EXPECT_EQ(group.counters[0].name, "l1d_cache");
    EXPECT_TRUE(group.counters[0].valid);
    EXPECT_EQ(group.counters[1].name, "no-such-event");
    EXPECT_FALSE(group.counters[1].valid) << "the failed event must be invalid, not a zero";
    collector.Close();
}

// The collector must open exactly the spec the caller resolved: passing a software spec whose name
// would also resolve as a hardware alias must reach perf_event_open as PERF_TYPE_SOFTWARE.
TEST_F(PmuCounterCollectorUtest, OpenUsesGivenSpecsWithoutReResolving)
{
    (void)MakePmuFixture("specs", {});
    RecordedTypes().clear();
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenRecording));

    Analysis::Dvvp::HostPmu::PmuEventSpec spec;
    spec.name = "cycles";
    spec.type = PERF_TYPE_SOFTWARE;
    spec.config = PERF_COUNT_SW_TASK_CLOCK;
    spec.source = "software";

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    EXPECT_EQ(
        collector.OpenResolved(std::vector<Analysis::Dvvp::HostPmu::PmuEventSpec>{spec}, 0, -1, failed, errorMsg), 0);
    ASSERT_EQ(RecordedTypes().size(), 1U);
    EXPECT_EQ(RecordedTypes()[0], static_cast<uint32_t>(PERF_TYPE_SOFTWARE))
        << "the collector must not re-resolve the name into PERF_TYPE_HARDWARE";
    collector.Close();
}

// When the kernel multiplexed the counter, the reported total must be scaled by enabled/running,
// otherwise the sample reads as a drop that never happened.
TEST_F(PmuCounterCollectorUtest, ReadScalesMultiplexedCounter)
{
    (void)MakePmuFixture("mux", {"l1d_cache"});
    MOCKER(PerfEventOpen).stubs().will(invoke(FakePerfOpenOk));

    PmuCounterCollector collector;
    std::vector<std::string> failed;
    std::string errorMsg;
    EXPECT_EQ(collector.Open({"l1d_cache"}, 0, -1, failed, errorMsg), 0);

    MOCKER(PerfRead).stubs().will(invoke(FakeReadMultiplexed));
    PmuCounterGroup group;
    ASSERT_TRUE(collector.Read(group));
    ASSERT_EQ(group.counters.size(), 1U);
    EXPECT_TRUE(group.counters[0].valid);
    // 100 counted while running half of the window -> 200 for the whole window.
    EXPECT_EQ(group.counters[0].value, 200U);
    collector.Close();
}
