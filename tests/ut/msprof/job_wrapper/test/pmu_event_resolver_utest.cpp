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

#include <linux/perf_event.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

#include <fstream>
#include <string>
#include <vector>

#include "pmu_event_resolver.h"

using Analysis::Dvvp::HostPmu::PmuEventResolver;
using Analysis::Dvvp::HostPmu::PmuEventSpec;

namespace {
// Every case rewrites this fixture tree and points the resolver at it. The env override exists so
// the sysfs parsing paths can be exercised on a machine whose real PMU differs from the fixture.
const char* ROOT_ENV = "MSPROF_PMU_SYSFS_ROOT";

void WriteFile(const std::string& path, const std::string& content)
{
    std::ofstream ofs(path.c_str(), std::ios::trunc);
    ofs << content;
}

void MakeDir(const std::string& path) { (void)mkdir(path.c_str(), 0755); }

std::string MakeFixture(const std::string& tag)
{
    const std::string root = std::string("/tmp/msprof_pmu_ut_") + tag;
    const std::string cmd = "rm -rf " + root;
    (void)system(cmd.c_str());
    MakeDir(root);
    return root;
}

void SetRoot(const std::string& root) { (void)setenv(ROOT_ENV, root.c_str(), 1); }

void ClearRoot() { (void)unsetenv(ROOT_ENV); }

// Creates <root>/<pmuName>/{type,events/<event>}.
void MakePmu(
    const std::string& root, const std::string& pmuName, const std::string& type, const std::string& eventName,
    const std::string& eventBody)
{
    const std::string pmuDir = root + "/" + pmuName;
    MakeDir(pmuDir);
    WriteFile(pmuDir + "/type", type);
    MakeDir(pmuDir + "/events");
    if (!eventName.empty()) {
        WriteFile(pmuDir + "/events/" + eventName, eventBody);
    }
}
} // namespace

class PmuEventResolverUtest : public testing::Test {
protected:
    void SetUp() override { ClearRoot(); }
    void TearDown() override
    {
        ClearRoot();
        GlobalMockObject::verify();
    }
};

// A sysfs event is read from <pmu>/type and <pmu>/events/<name> and reports source "sysfs".
TEST_F(PmuEventResolverUtest, ResolveSysfsEvent)
{
    const std::string root = MakeFixture("sysfs");
    MakePmu(root, "armv8_pmuv3_0", "8", "l1d_cache", "event=0x4\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("l1d_cache", spec, reason)) << reason;
    EXPECT_EQ(spec.name, "l1d_cache");
    EXPECT_EQ(spec.type, 8U);
    EXPECT_EQ(spec.config, 0x4U);
    EXPECT_EQ(spec.source, "sysfs");
}

// The events file may carry extra filter terms; only "event" is required.
TEST_F(PmuEventResolverUtest, ResolveSysfsEventWithExtraTerms)
{
    const std::string root = MakeFixture("extra");
    MakePmu(root, "armv8_pmuv3_0", "8", "ll_cache_miss", "event=0x37,param1=0x2,param2=0x9\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("ll_cache_miss", spec, reason)) << reason;
    EXPECT_EQ(spec.config, 0x37U);
}

// Surrounding whitespace in either file is tolerated.
TEST_F(PmuEventResolverUtest, ResolveSysfsToleratesWhitespace)
{
    const std::string root = MakeFixture("space");
    MakePmu(root, "armv8_pmuv3_0", "  8\n", "stall_backend", "  event = 0x24  \n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("stall_backend", spec, reason)) << reason;
    EXPECT_EQ(spec.type, 8U);
    EXPECT_EQ(spec.config, 0x24U);
}

// An events file without an "event" term is not a usable event.
TEST_F(PmuEventResolverUtest, ResolveSysfsWithoutEventTermFails)
{
    const std::string root = MakeFixture("noterm");
    MakePmu(root, "armv8_pmuv3_0", "8", "weird", "param=0x1,other=0x2\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("weird", spec, reason));
}

// A non-hex event body is rejected rather than silently becoming 0.
TEST_F(PmuEventResolverUtest, ResolveSysfsWithBadHexFails)
{
    const std::string root = MakeFixture("badhex");
    MakePmu(root, "armv8_pmuv3_0", "8", "broken", "event=zzzz\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("broken", spec, reason));
}

// A missing /type file makes the whole PMU unusable.
TEST_F(PmuEventResolverUtest, ResolveSysfsWithoutTypeFails)
{
    const std::string root = MakeFixture("notype");
    MakePmu(root, "armv8_pmuv3_0", "8", "l1d_cache", "event=0x4\n");
    (void)unlink((root + "/armv8_pmuv3_0/type").c_str());
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("l1d_cache", spec, reason));
}

// An unparsable type falls through as well.
TEST_F(PmuEventResolverUtest, ResolveSysfsWithBadTypeFails)
{
    const std::string root = MakeFixture("badtype");
    MakePmu(root, "armv8_pmuv3_0", "nothex", "l1d_cache", "event=0x4\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("l1d_cache", spec, reason));
}

// Generic aliases resolve to PERF_TYPE_HARDWARE with the matching config.
TEST_F(PmuEventResolverUtest, ResolveGenericAliases)
{
    // Isolate from the host PMU: a real sysfs event named "cycles" would take precedence over the
    // generic alias and make this case depend on the machine it runs on.
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    const struct {
        const char* name;
        uint64_t config;
    } cases[] = {
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
    for (const auto& item : cases) {
        PmuEventSpec spec;
        std::string reason;
        ASSERT_TRUE(resolver.Resolve(item.name, spec, reason)) << item.name << ": " << reason;
        EXPECT_EQ(spec.type, static_cast<uint32_t>(PERF_TYPE_HARDWARE)) << item.name;
        EXPECT_EQ(spec.config, item.config) << item.name;
        EXPECT_EQ(spec.source, "generic") << item.name;
        EXPECT_EQ(spec.name, item.name) << item.name;
    }
}

// Raw encodings are out of scope: the encoding is CPU-model specific, so accepting one would let a
// command line silently count a different event on a different node. The resolver must say so
// instead of reporting a spelling problem.
TEST_F(PmuEventResolverUtest, ResolveRejectsRawEncodings)
{
    (void)MakeFixture("rawreject");
    PmuEventResolver resolver;
    const char* forms[] = {"raw:0x13", "r13", "raw:0x4"};
    for (const char* form : forms) {
        PmuEventSpec spec;
        std::string reason;
        EXPECT_FALSE(resolver.Resolve(form, spec, reason)) << form;
        EXPECT_NE(reason.find("raw"), std::string::npos) << form << ": " << reason;
    }
}

// A single "r" prefix with a non-hex body is rejected, and a bare name never reaches raw parsing.
TEST_F(PmuEventResolverUtest, ResolveRawEdgeCasesFail)
{
    const std::string root = MakeFixture("rawedge");
    MakePmu(root, "armv8_pmuv3_0", "8", "", "");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("r", spec, reason)) << "single r has an empty body";
    EXPECT_FALSE(resolver.Resolve("provided", spec, reason)) << "bare name is neither alias nor raw";
}

// An empty or blank name is reported with its own reason.
TEST_F(PmuEventResolverUtest, ResolveEmptyNameFails)
{
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("", spec, reason));
    EXPECT_FALSE(reason.empty());

    reason.clear();
    EXPECT_FALSE(resolver.Resolve("   \t\n ", spec, reason));
    EXPECT_FALSE(reason.empty());
}

// An unknown name reports a reason that names the input.
TEST_F(PmuEventResolverUtest, ResolveUnknownNameMentionsInput)
{
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("no-such-event", spec, reason));
    EXPECT_NE(reason.find("no-such-event"), std::string::npos) << reason;
}

// sysfs wins over the generic alias: a PMU event literally named "cycles" must not be mapped to
// PERF_TYPE_HARDWARE, because the two count different hardware events.
TEST_F(PmuEventResolverUtest, SysfsWinsOverGenericAlias)
{
    const std::string root = MakeFixture("precedence");
    MakePmu(root, "armv8_pmuv3_0", "8", "cycles", "event=0x11\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("cycles", spec, reason)) << reason;
    EXPECT_EQ(spec.source, "sysfs");
    EXPECT_EQ(spec.type, 8U);
    EXPECT_EQ(spec.config, 0x11U);
}

// The directory name carries a per-instance suffix; a suffixed directory alone must still be found.
TEST_F(PmuEventResolverUtest, FindsSuffixedPmuDir)
{
    const std::string root = MakeFixture("suffixed");
    MakePmu(root, "armv8_pmuv3_0", "8", "l1d_cache", "event=0x4\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("l1d_cache", spec, reason)) << reason;
    EXPECT_EQ(spec.source, "sysfs");
}

// When both the plain and the suffixed name exist, the plain one wins so the choice is stable.
TEST_F(PmuEventResolverUtest, PrefersUnsuffixedPmuDir)
{
    const std::string root = MakeFixture("prefer");
    MakePmu(root, "armv8_pmuv3", "8", "l1d_cache", "event=0x4\n");
    MakePmu(root, "armv8_pmuv3_0", "9", "l1d_cache", "event=0x5\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("l1d_cache", spec, reason)) << reason;
    EXPECT_EQ(spec.type, 8U) << "the unsuffixed directory has type 8";
    EXPECT_EQ(spec.config, 0x4U);
}

// A root that does not exist yields no candidates rather than crashing.
TEST_F(PmuEventResolverUtest, MissingRootFails)
{
    SetRoot("/tmp/msprof_pmu_ut_does_not_exist");
    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("l1d_cache", spec, reason));
    EXPECT_TRUE(resolver.ListAvailable().empty());
}

// A root with directories that do not match the PMU prefix is ignored.
TEST_F(PmuEventResolverUtest, NonMatchingDirsAreIgnored)
{
    const std::string root = MakeFixture("nomatch");
    MakePmu(root, "intel_pt", "2", "l1d_cache", "event=0x4\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.Resolve("l1d_cache", spec, reason));
}

// ListAvailable returns every event file, sorted, and skips the dot entries.
TEST_F(PmuEventResolverUtest, ListAvailableReturnsSortedEvents)
{
    const std::string root = MakeFixture("list");
    MakePmu(root, "armv8_pmuv3_0", "8", "l1d_cache", "event=0x4\n");
    WriteFile(root + "/armv8_pmuv3_0/events/cycles", "event=0x11\n");
    WriteFile(root + "/armv8_pmuv3_0/events/dtlb_walk", "event=0x34\n");
    SetRoot(root);

    PmuEventResolver resolver;
    const std::vector<std::string> names = resolver.ListAvailable();
    ASSERT_EQ(names.size(), 3U);
    EXPECT_EQ(names[0], "cycles");
    EXPECT_EQ(names[1], "dtlb_walk");
    EXPECT_EQ(names[2], "l1d_cache");
}

// No events directory means an empty list, which is the normal case for an unusable PMU.
TEST_F(PmuEventResolverUtest, ListAvailableWithoutEventsDirIsEmpty)
{
    const std::string root = MakeFixture("nolist");
    MakeDir(root + "/armv8_pmuv3_0");
    WriteFile(root + "/armv8_pmuv3_0/type", "8");
    SetRoot(root);

    PmuEventResolver resolver;
    EXPECT_TRUE(resolver.ListAvailable().empty());
}

// Software events resolve to PERF_TYPE_SOFTWARE and need no PMU directory at all: a node whose PMU
// is absent or restricted must still be able to report page faults and scheduling counts.
TEST_F(PmuEventResolverUtest, ResolveSoftwareAliases)
{
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    const struct {
        const char* name;
        uint64_t config;
    } cases[] = {
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
    for (const auto& item : cases) {
        PmuEventSpec spec;
        std::string reason;
        ASSERT_TRUE(resolver.Resolve(item.name, spec, reason)) << item.name << ": " << reason;
        EXPECT_EQ(spec.type, static_cast<uint32_t>(PERF_TYPE_SOFTWARE)) << item.name;
        EXPECT_EQ(spec.config, item.config) << item.name;
        EXPECT_EQ(spec.source, "software") << item.name;
        EXPECT_EQ(spec.name, item.name) << item.name;
    }
}

// A hardware alias and a software event must not be confused: both are handled by name tables, and
// the hardware table is consulted first so an existing command keeps its meaning.
TEST_F(PmuEventResolverUtest, HardwareAliasIsNotTreatedAsSoftware)
{
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("cycles", spec, reason)) << reason;
    EXPECT_EQ(spec.source, "generic");
    EXPECT_EQ(spec.type, static_cast<uint32_t>(PERF_TYPE_HARDWARE));
}

// A sysfs event still wins over a software alias of the same name, so adding the software table
// cannot change what an existing sysfs event resolves to.
TEST_F(PmuEventResolverUtest, SysfsWinsOverSoftwareAlias)
{
    const std::string root = MakeFixture("swprec");
    MakePmu(root, "armv8_pmuv3_0", "8", "page-faults", "event=0x77\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.Resolve("page-faults", spec, reason)) << reason;
    EXPECT_EQ(spec.source, "sysfs");
    EXPECT_EQ(spec.type, 8U);
    EXPECT_EQ(spec.config, 0x77U);
}

// The --os-events entry point must ignore sysfs entirely: when the user says "this is an OS event",
// a PMU event that happens to share the name must not be substituted.
TEST_F(PmuEventResolverUtest, ResolveOsEventIgnoresSysfsEventOfSameName)
{
    const std::string root = MakeFixture("osstrict");
    MakePmu(root, "armv8_pmuv3_0", "8", "page-faults", "event=0x77\n");
    SetRoot(root);

    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    ASSERT_TRUE(resolver.ResolveOsEvent("page-faults", spec, reason)) << reason;
    EXPECT_EQ(spec.source, "software");
    EXPECT_EQ(spec.type, static_cast<uint32_t>(PERF_TYPE_SOFTWARE));
    EXPECT_EQ(spec.config, PERF_COUNT_SW_PAGE_FAULTS);
}

// A hardware alias given to --os-events is rejected, not silently mapped: cycles is not an OS event.
TEST_F(PmuEventResolverUtest, ResolveOsEventRejectsHardwareName)
{
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.ResolveOsEvent("cycles", spec, reason));
    EXPECT_NE(reason.find("cycles"), std::string::npos) << reason;
    // The message must name the supported values so the user does not have to guess.
    EXPECT_NE(reason.find("page-faults"), std::string::npos) << reason;
}

// Raw encodings are PMU by definition and are rejected on the OS path.
TEST_F(PmuEventResolverUtest, ResolveOsEventRejectsRaw)
{
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    PmuEventSpec spec;
    std::string reason;
    EXPECT_FALSE(resolver.ResolveOsEvent("raw:0x13", spec, reason));
    EXPECT_FALSE(resolver.ResolveOsEvent("r13", spec, reason));
    EXPECT_FALSE(resolver.ResolveOsEvent("", spec, reason));
}

// The published list must match what the resolver actually accepts.
TEST_F(PmuEventResolverUtest, ListSoftwareEventsMatchesResolution)
{
    const std::vector<std::string> names = PmuEventResolver::ListSoftwareEvents();
    ASSERT_EQ(names.size(), 9U);
    SetRoot("/tmp/msprof_pmu_ut_no_pmu_dir");
    PmuEventResolver resolver;
    for (const auto& name : names) {
        PmuEventSpec spec;
        std::string reason;
        EXPECT_TRUE(resolver.ResolveOsEvent(name, spec, reason)) << name << ": " << reason;
        EXPECT_EQ(spec.source, "software") << name;
    }
}
