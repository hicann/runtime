#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

import csv
import importlib.util
import shutil
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


def find_generator_path():
    for parent in Path(__file__).resolve().parents:
        generator_path = parent / "scripts/package/runtime/scripts/generate_acl_api_stubs.py"
        if generator_path.is_file():
            return generator_path
    raise RuntimeError("cannot locate scripts/package/runtime/scripts/generate_acl_api_stubs.py")


GENERATOR_PATH = find_generator_path()
REPO_ROOT = GENERATOR_PATH.parents[4]
sys.path.insert(0, str(GENERATOR_PATH.parent))
SPEC = importlib.util.spec_from_file_location("generate_acl_api_stubs", GENERATOR_PATH)
GENERATOR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GENERATOR)


WRAPPER = """\
#define ACL_FUNC_MAP(_) \\
    _(aclError, aclCountOne, (uint32_t* count), (count)) \\
    _(aclError, aclUnsupported, (int32_t value), (value)) \\
    _(uint32_t, aclInvalidExceptionInfo, (), ()) \\
    _(const char*, aclNull, (), ()) \\
    _(uint32_t, aclZero, (uint32_t value), (value))
#define ACL_RT_FUNC_MAP(_)
#define ACL_RT_ALLOCATOR_FUNC_MAP(_)
#define ACL_MDLRI_FUNC_MAP(_)
#define ACL_MDL_FUNC_MAP(_)
"""


class GenerateAclApiStubsTest(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.root = Path(self.temp_dir.name)
        self.wrapper_path = self.root / "acl_rt_wrapper.h"
        self.wrapper_path.write_text(WRAPPER, encoding="utf-8")

    def tearDown(self):
        self.temp_dir.cleanup()

    def write_product(self, content):
        path = self.root / "product.def"
        path.write_text(content, encoding="utf-8")
        return path

    def run_generator(self, product_path):
        return subprocess.run(
            [
                sys.executable,
                str(GENERATOR_PATH),
                "--wrapper",
                str(self.wrapper_path),
                "--product-def",
                str(product_path),
                "--product",
                "test",
                "--output",
                str(self.root / "generated.cc"),
                "--report",
                str(self.root / "provider.csv"),
            ],
            check=False,
            capture_output=True,
            text=True,
        )

    def test_parses_repository_wrapper(self):
        entries = GENERATOR.parse_wrapper(
            REPO_ROOT / "src/acl/aclrt_impl/acl_rt_wrapper.h"
        )

        self.assertEqual(len(entries), 418)
        self.assertEqual(
            sum(entry.return_type == "aclError" for entry in entries.values()), 400
        )
        self.assertEqual(
            sum(entry.return_type != "aclError" for entry in entries.values()), 18
        )
        self.assertEqual(
            entries["aclrtRecordEventWithFlag"].impl_name,
            "aclrtRecordEventWithFlagImpl",
        )
        self.assertEqual(
            entries["aclrtNonBlockingLaunchBegin"].impl_name,
            "aclrtNonBlockingLaunchBeginImpl",
        )
        self.assertEqual(
            entries["aclrtNonBlockingLaunchEnd"].impl_name,
            "aclrtNonBlockingLaunchEndImpl",
        )
        self.assertEqual(entries["aclmdlRIGetTasks"].impl_name, "aclmdlRIGetTasksImpl")
        self.assertEqual(entries["aclmdlRIGetTasks"].return_type, "aclError")
        self.assertEqual(entries["aclmdlRIGetTasks"].arguments, "(modelRI, tasks, numTasks)")

    def test_generates_stubs_and_report(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(0)
ACL_API_STUB(aclCountOne, COUNT_ONE)
ACL_API_STUB(aclInvalidExceptionInfo, INVALID_EXCEPTION_INFO)
ACL_API_STUB(aclNull, NULLPTR)
ACL_API_STUB(aclUnsupported, RT_FEATURE_NOT_SUPPORT)
ACL_API_STUB(aclZero, ZERO)
""")
        result = self.run_generator(product)

        self.assertEqual(result.returncode, 0, result.stderr)
        source = (self.root / "generated.cc").read_text(encoding="utf-8")
        self.assertIn("aclError aclCountOneImpl(uint32_t* count)", source)
        self.assertIn("if (count == nullptr) {", source)
        self.assertIn("return ACL_ERROR_INVALID_PARAM;", source)
        self.assertIn("*count = 1U;", source)
        self.assertIn("return ACL_SUCCESS;", source)
        self.assertIn("uint32_t aclInvalidExceptionInfoImpl()", source)
        self.assertIn(
            "return static_cast<uint32_t>(ACL_ERROR_INVALID_EXCEPTION_INFO);",
            source,
        )
        self.assertIn("const char* aclNullImpl()", source)
        self.assertIn("return nullptr;", source)
        self.assertIn("return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;", source)
        self.assertIn("return {};", source)

        with (self.root / "provider.csv").open(encoding="utf-8", newline="") as report:
            rows = list(csv.DictReader(report))
        self.assertEqual(len(rows), 5)
        self.assertEqual(
            {row["acl_api"]: row["provider"] for row in rows},
            {
                "aclCountOne": "strong_stub",
                "aclInvalidExceptionInfo": "strong_stub",
                "aclNull": "strong_stub",
                "aclUnsupported": "strong_stub",
                "aclZero": "strong_stub",
            },
        )

    def test_arch5162_device_flags_are_unsupported(self):
        product = REPO_ROOT / "src/runtime/cmake/arch5162_unsupported_acl_api.def"
        _, _, product_entries = GENERATOR.parse_product_def(product)
        policies = dict(product_entries)
        for name in ("aclrtSetDeviceFlags", "aclrtGetDeviceFlags"):
            with self.subTest(api=name):
                self.assertIn(name, policies)
                self.assertEqual(policies[name], "RT_FEATURE_NOT_SUPPORT")

    def test_arch5162_product_matches_confirmed_acl_support(self):
        product = REPO_ROOT / "src/runtime/cmake/arch5162_unsupported_acl_api.def"
        wrapper = GENERATOR.parse_wrapper(
            REPO_ROOT / "src/acl/aclrt_impl/acl_rt_wrapper.h"
        )
        version, real_provider_count, product_entries = GENERATOR.parse_product_def(product)
        entries = GENERATOR.select_entries(wrapper, product_entries)

        self.assertEqual(version, 1)
        self.assertEqual(real_provider_count, 118)
        self.assertEqual(len(entries), 300)
        self.assertEqual(
            sum(entry.policy == "RT_FEATURE_NOT_SUPPORT" for entry in entries), 286
        )
        self.assertEqual(sum(entry.policy == "NULLPTR" for entry in entries), 3)
        self.assertEqual(sum(entry.policy == "INVALID_EXCEPTION_INFO" for entry in entries), 5)
        self.assertEqual(sum(entry.policy == "ZERO" for entry in entries), 3)
        self.assertEqual(sum(entry.policy == "COUNT_ONE" for entry in entries), 1)
        self.assertEqual(sum(entry.policy == "RUN_MODE_DEVICE" for entry in entries), 1)
        self.assertEqual(sum(entry.policy == "DELEGATE_ACLRT_MALLOC" for entry in entries), 1)
        GENERATOR.validate_real_provider_count(wrapper, entries, real_provider_count)
        policies = dict(product_entries)
        self.assertEqual(policies["aclrtGetDeviceCount"], "COUNT_ONE")
        self.assertEqual(policies["aclrtGetRunMode"], "RUN_MODE_DEVICE")
        self.assertEqual(policies["aclrtMallocWithCfg"], "DELEGATE_ACLRT_MALLOC")
        self.assertEqual(policies["aclmdlRIGetTasks"], "RT_FEATURE_NOT_SUPPORT")
        self.assertEqual(policies["aclrtGetSocSeries"], "NULLPTR")
        series_entry = next(entry for entry in entries if entry.public_name == "aclrtGetSocSeries")
        self.assertEqual(
            GENERATOR.render_stub(series_entry),
            "ACL_FUNC_VISIBILITY\nconst char* aclrtGetSocSeriesImpl(void)\n{\n    return nullptr;\n}",
        )
        device_count_entry = next(
            entry for entry in entries if entry.public_name == "aclrtGetDeviceCount"
        )
        self.assertEqual(
            GENERATOR.render_stub(device_count_entry),
            "ACL_FUNC_VISIBILITY\n"
            "aclError aclrtGetDeviceCountImpl(uint32_t * count)\n"
            "{\n"
            "    if (count == nullptr) {\n"
            "        return ACL_ERROR_INVALID_PARAM;\n"
            "    }\n"
            "    *count = 1U;\n"
            "    return ACL_SUCCESS;\n"
            "}",
        )
        run_mode_entry = next(entry for entry in entries if entry.public_name == "aclrtGetRunMode")
        self.assertEqual(
            GENERATOR.render_stub(run_mode_entry),
            "ACL_FUNC_VISIBILITY\n"
            "aclError aclrtGetRunModeImpl(aclrtRunMode * runMode)\n"
            "{\n"
            "    if (runMode == nullptr) {\n"
            "        return ACL_ERROR_INVALID_PARAM;\n"
            "    }\n"
            "    *runMode = ACL_DEVICE;\n"
            "    return ACL_SUCCESS;\n"
            "}",
        )
        malloc_with_cfg_entry = next(
            entry for entry in entries if entry.public_name == "aclrtMallocWithCfg"
        )
        self.assertEqual(
            GENERATOR.render_stub(malloc_with_cfg_entry),
            "ACL_FUNC_VISIBILITY\n"
            "aclError aclrtMallocWithCfgImpl"
            "(void** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig* cfg)\n"
            "{\n"
            "    (void)cfg;\n"
            "    return aclrtMallocImpl(devPtr, size, policy);\n"
            "}",
        )
        report_path = self.root / "arch5162_provider.csv"
        GENERATOR.write_report(report_path, "arch5162", wrapper, entries)
        with report_path.open(encoding="utf-8", newline="") as report:
            providers = {row["acl_api"]: row for row in csv.DictReader(report)}
        self.assertEqual(providers["aclrtGetSocSeries"]["provider"], "strong_stub")
        self.assertEqual(providers["aclrtGetSocSeries"]["policy"], "NULLPTR")
        self.assertEqual(providers["aclrtGetRunMode"]["provider"], "strong_stub")
        self.assertEqual(providers["aclrtGetRunMode"]["policy"], "RUN_MODE_DEVICE")
        for name in (
            "aclrtGetDeviceIdFromExceptionInfo",
            "aclrtGetErrorCodeFromExceptionInfo",
            "aclrtGetStreamIdFromExceptionInfo",
            "aclrtGetTaskIdFromExceptionInfo",
            "aclrtGetThreadIdFromExceptionInfo",
        ):
            self.assertEqual(policies[name], "INVALID_EXCEPTION_INFO")
        unsupported_names = {entry.public_name for entry in entries}
        for name in (
            "aclFloat16ToFloat",
            "aclmdlRIGetTasks",
            "aclmdlRITaskGetEnabled",
            "aclrtGetSocSeries",
            "aclrtMallocAlign32",
            "aclrtMallocWithCfg",
            "aclrtNonBlockingLaunchBegin",
            "aclrtNonBlockingLaunchEnd",
            "aclrtRecordEventWithFlag",
            "aclrtSetExceptionInfoCallback",
            "aclrtSnapshotProcessGetRestoreThreadId",
            "aclrtSnapshotProcessGetState",
            "aclrtTaskUpdateAsync",
        ):
            self.assertIn(name, unsupported_names)
        for name in (
            "aclFinalize",
            "aclGetRecentErrMsg",
            "aclInit",
            "aclmdlInitDump",
            "aclrtBinaryGetFunctionByEntry",
            "aclrtCreateBinary",
            "aclrtDestroyBinary",
            "aclrtGetDevice",
            "aclrtGetOpExecuteTimeout",
            "aclrtGetOpTimeOutInterval",
            "aclrtGetSocName",
            "aclrtRecordEvent",
            "aclrtValueWrite",
        ):
            self.assertNotIn(name, unsupported_names)

    def test_stream_batch_mem_op_is_unsupported_on_arch5162(self):
        wrapper = GENERATOR.parse_wrapper(
            REPO_ROOT / "src/acl/aclrt_impl/acl_rt_wrapper.h"
        )
        _, _, product_entries = GENERATOR.parse_product_def(
            REPO_ROOT / "src/runtime/cmake/arch5162_unsupported_acl_api.def"
        )
        entries = {
            entry.public_name: entry
            for entry in GENERATOR.select_entries(wrapper, product_entries)
        }
        entry = entries["aclrtStreamBatchMemOp"]
        self.assertEqual(entry.policy, "RT_FEATURE_NOT_SUPPORT")

    def test_stream_batch_mem_op_public_c_abi(self):
        compiler = shutil.which("cc") or shutil.which("gcc") or shutil.which("clang")
        self.assertIsNotNone(compiler, "C11 compiler required to validate the public C ABI")
        source = """\
#include <stddef.h>
#include "acl/acl_rt.h"

typedef aclError (*BatchMemOpFunction)(aclrtStreamBatchMemOpParams*, size_t, uint32_t, aclrtStream);
_Static_assert(_Generic(&aclrtStreamBatchMemOp, BatchMemOpFunction: 1, default: 0), "C batch signature");
_Static_assert(sizeof(aclrtStreamMemOpType) == 4, "C operation tag width");
_Static_assert(sizeof(unsigned int) == 4, "C flag width");
_Static_assert(sizeof(aclrtStreamBatchMemOpParams) == 48, "C batch ABI size");
_Static_assert(_Alignof(aclrtStreamBatchMemOpParams) == 8, "C batch ABI alignment");
_Static_assert(offsetof(aclrtStreamBatchMemOpParams, reserved) == 0, "C reserved union offset");
_Static_assert(sizeof(((aclrtStreamBatchMemOpParams*)0)->reserved) == 6 * sizeof(uint64_t), "C reserved size");
_Static_assert(offsetof(aclrtStreamBatchMemOpParams, valueWait.devAddr) == 8, "C wait address offset");
_Static_assert(offsetof(aclrtStreamBatchMemOpParams, valueWrite.devAddr) == 8, "C write address offset");
_Static_assert(offsetof(aclrtStreamBatchMemOpParams, valueWait.value) == 16, "C wait value offset");
_Static_assert(offsetof(aclrtStreamBatchMemOpParams, valueWrite.flag) == 24, "C write flag offset");
"""
        result = subprocess.run(
            [compiler, "-std=c11", "-fsyntax-only", "-x", "c",
             "-I", str(REPO_ROOT / "include/external"), "-"],
            input=source, capture_output=True, text=True, check=False,
        )
        self.assertEqual(result.returncode, 0, result.stderr)

    def test_rejects_unsorted_product_api(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(1)
ACL_API_STUB(aclZero, ZERO)
ACL_API_STUB(aclNull, NULLPTR)
""")
        with self.assertRaisesRegex(ValueError, "must be sorted"):
            GENERATOR.parse_product_def(product)

    def test_rejects_duplicate_product_api(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(2)
ACL_API_STUB(aclZero, ZERO)
ACL_API_STUB(aclZero, ZERO)
""")
        with self.assertRaisesRegex(ValueError, "duplicate stub APIs"):
            GENERATOR.parse_product_def(product)

    def test_rejects_unknown_product_api(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(2)
ACL_API_STUB(aclUnknown, RT_FEATURE_NOT_SUPPORT)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("unknown ACL APIs", result.stderr)

    def test_rejects_incompatible_return_policy(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(2)
ACL_API_STUB(aclZero, RT_FEATURE_NOT_SUPPORT)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("requires aclError return type", result.stderr)

    def test_rejects_invalid_exception_info_for_non_uint32_return_type(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(3)
ACL_API_STUB(aclNull, INVALID_EXCEPTION_INFO)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("requires uint32_t return type", result.stderr)

    def test_rejects_count_one_for_non_count_signature(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(4)
ACL_API_STUB(aclUnsupported, COUNT_ONE)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("requires an int32_t/uint32_t count out-parameter", result.stderr)

    def test_rejects_count_one_for_non_acl_error_return_type(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(4)
ACL_API_STUB(aclZero, COUNT_ONE)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("COUNT_ONE requires aclError return type", result.stderr)

    def test_rejects_run_mode_device_for_non_run_mode_signature(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(4)
ACL_API_STUB(aclCountOne, RUN_MODE_DEVICE)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("RUN_MODE_DEVICE requires one aclrtRunMode out-parameter", result.stderr)

    def test_rejects_run_mode_device_for_non_acl_error_return_type(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(4)
ACL_API_STUB(aclZero, RUN_MODE_DEVICE)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("RUN_MODE_DEVICE requires aclError return type", result.stderr)

    def test_delegates_malloc_with_cfg_to_malloc_flow(self):
        self.wrapper_path.write_text(
            """\
#define ACL_FUNC_MAP(_) \\
    _(aclError, aclrtMalloc, (void** devPtr, size_t size, aclrtMemMallocPolicy policy), (devPtr, size, policy)) \\
    _(aclError, aclrtMallocWithCfg, \\
      (void** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig* cfg), \\
      (devPtr, size, policy, cfg))
#define ACL_RT_FUNC_MAP(_)
#define ACL_RT_ALLOCATOR_FUNC_MAP(_)
#define ACL_MDLRI_FUNC_MAP(_)
#define ACL_MDL_FUNC_MAP(_)
""",
            encoding="utf-8",
        )
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(1)
ACL_API_STUB(aclrtMallocWithCfg, DELEGATE_ACLRT_MALLOC)
""")
        result = self.run_generator(product)

        self.assertEqual(result.returncode, 0, result.stderr)
        source = (self.root / "generated.cc").read_text(encoding="utf-8")
        self.assertIn(
            "aclError aclrtMallocWithCfgImpl"
            "(void** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig* cfg)",
            source,
        )
        self.assertIn("(void)cfg;", source)
        self.assertIn("return aclrtMallocImpl(devPtr, size, policy);", source)
        with (self.root / "provider.csv").open(encoding="utf-8", newline="") as report:
            providers = {row["acl_api"]: row["provider"] for row in csv.DictReader(report)}
        self.assertEqual(providers["aclrtMallocWithCfg"], "strong_stub")
        self.assertEqual(providers["aclrtMalloc"], "weak_real")

    def test_rejects_delegation_when_target_is_stubbed(self):
        self.wrapper_path.write_text(
            """\
#define ACL_FUNC_MAP(_) \\
    _(aclError, aclrtMalloc, (void** devPtr, size_t size, aclrtMemMallocPolicy policy), (devPtr, size, policy)) \\
    _(aclError, aclrtMallocWithCfg, \\
      (void** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocConfig* cfg), \\
      (devPtr, size, policy, cfg))
#define ACL_RT_FUNC_MAP(_)
#define ACL_RT_ALLOCATOR_FUNC_MAP(_)
#define ACL_MDLRI_FUNC_MAP(_)
#define ACL_MDL_FUNC_MAP(_)
""",
            encoding="utf-8",
        )
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(0)
ACL_API_STUB(aclrtMalloc, RT_FEATURE_NOT_SUPPORT)
ACL_API_STUB(aclrtMallocWithCfg, DELEGATE_ACLRT_MALLOC)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("DELEGATE_ACLRT_MALLOC requires aclrtMalloc to stay a weak real provider", result.stderr)

    def test_rejects_delegation_signature_mismatch(self):
        self.wrapper_path.write_text(
            """\
#define ACL_FUNC_MAP(_) \\
    _(aclError, aclrtMalloc, (void** devPtr, size_t size, aclrtMemMallocPolicy policy), (devPtr, size, policy)) \\
    _(aclError, aclrtMallocWithCfg, \\
      (void** devPtr, size_t size, aclrtMemMallocPolicy policy, aclrtMallocPolicy extra), \\
      (devPtr, size, policy, extra))
#define ACL_RT_FUNC_MAP(_)
#define ACL_RT_ALLOCATOR_FUNC_MAP(_)
#define ACL_MDLRI_FUNC_MAP(_)
#define ACL_MDL_FUNC_MAP(_)
""",
            encoding="utf-8",
        )
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(1)
ACL_API_STUB(aclrtMallocWithCfg, DELEGATE_ACLRT_MALLOC)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn(
            "DELEGATE_ACLRT_MALLOC requires the aclrtMalloc signature plus one trailing"
            " aclrtMallocConfig* parameter",
            result.stderr,
        )

    def test_rejects_unknown_policy(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(2)
ACL_API_STUB(aclZero, UNKNOWN)
""")
        with self.assertRaisesRegex(ValueError, "unsupported policy"):
            GENERATOR.parse_product_def(product)

    def test_rejects_new_api_without_product_stub(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(0)
ACL_API_STUB(aclNull, NULLPTR)
ACL_API_STUB(aclUnsupported, RT_FEATURE_NOT_SUPPORT)
""")
        result = self.run_generator(product)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("new ACL APIs default to unsupported", result.stderr)


if __name__ == "__main__":
    unittest.main()
