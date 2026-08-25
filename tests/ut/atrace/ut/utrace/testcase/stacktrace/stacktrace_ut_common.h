/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef STACKTRACE_UT_COMMON_H
#define STACKTRACE_UT_COMMON_H

#include <pwd.h>
#include <unistd.h>
#include <cstdint>
#include <cstdlib>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "securec.h"
#include "scd_dwarf.h"
#include "scd_memory.h"
#include "scd_memory_local.h"
#include "scd_memory_remote.h"

extern "C" {
void TraceInit(void);
void TraceExit(void);
}

// After the ENABLE_SCD collapse the global memory handler reads via ptrace
// (remote) in the real process, while UT reads local test buffers through
// ScdMemoryRead(NULL, ...). Redirect the remote read to the local read so the
// dwarf/unwind unit tests keep working.
inline void RedirectScdMemoryReadToLocal() { MOCKER(ScdMemoryRemoteRead).stubs().will(invoke(ScdMemoryLocalRead)); }

// Bind a dwarf context to a local-read memory covering the full address range,
// and redirect the global remote read to local. Shared by the unwind/instr
// fixtures to avoid duplicated setup.
inline void InitDwarfLocalMemory(ScdDwarf& dwarf, ScdMemory& memory)
{
    ScdMemoryInitLocal(&memory);
    dwarf.memory = &memory;
    memory.size = UINT32_MAX;
    dwarf.ehFrameHdrOffset = 0;
    RedirectScdMemoryReadToLocal();
}

// Shared fixture base for dwarf unwind tests that read local test buffers via
// a dwarf context. Avoids duplicating the identical SetUp/TearDown/members.
class DwarfLocalMemoryTest : public testing::Test {
protected:
    void SetUp() override { InitDwarfLocalMemory(dwarf, memory); }

    void TearDown() override { GlobalMockObject::verify(); }

    ScdMemory memory;
    ScdDwarf dwarf;
};

// Prepare the trace log directory and a fake home dir, then init the trace
// module. Shared by the stackcore/exec fixtures to avoid duplicated setup.
// Note: getpwuid returns a pointer into libc's static buffer and pw_dir is
// overwritten with the test directory; this matches the existing atrace UT
// fixtures (utrace_utest / trace_recorder_utest), so no extra cleanup is done.
inline void SetupTraceUtestEnv()
{
    system("mkdir -p " LLT_TEST_DIR);
    system("rm -rf " LLT_TEST_DIR "/*");
    struct passwd* pwd = getpwuid(getuid());
    if (pwd == nullptr) {
        return;
    }
    pwd->pw_dir = LLT_TEST_DIR;
    MOCKER(getpwuid).stubs().will(returnValue(pwd));
    TraceInit();
}

#endif // STACKTRACE_UT_COMMON_H
