#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import time
import unittest

ROOT = Path(__file__).resolve().parents[6]
HEADER = """#pragma once
#define ACL_FUNC_VISIBILITY
using aclError = int;
constexpr int ACL_ERROR_COMPILING_STUB_MODE = 100;
extern "C" {
ACL_FUNC_VISIBILITY aclError aclReviewBefore(void);
}
"""
EXTRA = """#pragma once
#include "../acl_fixture.h"
extern "C" {
ACL_FUNC_VISIBILITY aclError aclReviewAdded(void);
}
"""


class StubHeaderDependencyTest(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix="runtime-stub-dependencies-")
        self.addCleanup(temporary.cleanup)
        self.source = Path(temporary.name) / "source"
        self.build = Path(temporary.name) / "build"
        (self.source / "stub").mkdir(parents=True)
        self.headers = self.source / "include/external/acl"
        self.headers.mkdir(parents=True)
        (self.headers / "nested").mkdir()
        self.header = self.headers / "acl_fixture.h"
        self.header.write_text(HEADER)
        for name in ("CMakeLists.txt", "gen_stubapi.py"):
            shutil.copyfile(ROOT / "stub" / name, self.source / "stub" / name)
        (self.source / "CMakeLists.txt").write_text(
            "cmake_minimum_required(VERSION 3.16)\n"
            "project(StubDependencyTest CXX)\n"
            f'set(RUNTIME_PYTHON "{sys.executable}")\n'
            "add_library(intf_pub INTERFACE)\n"
            "add_subdirectory(stub)\n"
        )
        self.generated = self.build / "stub/acl_stub.cpp"

    def run_command(self, *command):
        result = subprocess.run(command, text=True, capture_output=True)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        return result.stdout

    def configure(self):
        self.run_command("cmake", "-S", str(self.source), "-B", str(self.build))

    def build_symbols(self):
        self.run_command("cmake", "--build", str(self.build), "--target", "stub_acl_rt")
        return self.run_command(
            "nm", "-D", "--defined-only", str(self.build / "stub/stub/libacl_rt.so")
        )

    def add_nested_header(self):
        nested = self.headers / "nested/acl_extra.h"
        nested.parent.mkdir(exist_ok=True)
        nested.write_text(EXTRA)
        return nested

    def test_edit_existing_header_regenerates_source_and_symbol(self):
        self.configure()
        self.assertIn("aclReviewBefore", self.build_symbols())
        before = self.generated.read_bytes()
        directory_mtime = self.headers.stat().st_mtime_ns
        time.sleep(1.1)
        self.header.write_text(
            HEADER
            + 'extern "C" {\nACL_FUNC_VISIBILITY aclError aclReviewAdded(void);\n}\n'
        )
        self.assertEqual(self.headers.stat().st_mtime_ns, directory_mtime)
        self.assertIn("aclReviewAdded", self.build_symbols())
        self.assertNotEqual(self.generated.read_bytes(), before)

    def test_add_nested_header_regenerates_source_and_symbol(self):
        self.configure()
        self.build_symbols()
        time.sleep(1.1)
        self.add_nested_header()
        self.assertIn("aclReviewAdded", self.build_symbols())

    def test_remove_nested_header_regenerates_source_and_symbol(self):
        nested = self.add_nested_header()
        self.configure()
        self.assertIn("aclReviewAdded", self.build_symbols())
        time.sleep(1.1)
        nested.unlink()
        self.assertNotIn("aclReviewAdded", self.build_symbols())
        self.assertNotIn("acl_extra.h", self.generated.read_text())

    def test_unchanged_headers_do_not_regenerate(self):
        self.configure()
        self.build_symbols()
        before = self.generated.stat().st_mtime_ns
        self.build_symbols()
        self.assertEqual(self.generated.stat().st_mtime_ns, before)


if __name__ == "__main__":
    unittest.main()
