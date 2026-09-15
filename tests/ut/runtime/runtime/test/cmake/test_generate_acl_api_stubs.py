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
    _(aclError, aclUnsupported, (int32_t value), (value)) \\
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

        self.assertEqual(len(entries), 403)
        self.assertEqual(
            sum(entry.return_type == "aclError" for entry in entries.values()), 386
        )
        self.assertEqual(
            sum(entry.return_type != "aclError" for entry in entries.values()), 17
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

    def test_generates_stubs_and_report(self):
        product = self.write_product("""\
ACL_API_CATALOG_VERSION(1)
ACL_API_REAL_PROVIDER_COUNT(0)
ACL_API_STUB(aclNull, NULLPTR)
ACL_API_STUB(aclUnsupported, RT_FEATURE_NOT_SUPPORT)
ACL_API_STUB(aclZero, ZERO)
""")
        result = self.run_generator(product)

        self.assertEqual(result.returncode, 0, result.stderr)
        source = (self.root / "generated.cc").read_text(encoding="utf-8")
        self.assertIn("const char* aclNullImpl()", source)
        self.assertIn("return nullptr;", source)
        self.assertIn("return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;", source)
        self.assertIn("return {};", source)

        with (self.root / "provider.csv").open(encoding="utf-8", newline="") as report:
            rows = list(csv.DictReader(report))
        self.assertEqual(len(rows), 3)
        self.assertEqual(
            {row["acl_api"]: row["provider"] for row in rows},
            {
                "aclNull": "strong_stub",
                "aclUnsupported": "strong_stub",
                "aclZero": "strong_stub",
            },
        )

    def test_arch5162_product_matches_confirmed_acl_support(self):
        product = REPO_ROOT / "src/runtime/cmake/arch5162_unsupported_acl_api.def"
        wrapper = GENERATOR.parse_wrapper(
            REPO_ROOT / "src/acl/aclrt_impl/acl_rt_wrapper.h"
        )
        version, real_provider_count, product_entries = GENERATOR.parse_product_def(product)
        entries = GENERATOR.select_entries(wrapper, product_entries)

        self.assertEqual(version, 1)
        self.assertEqual(real_provider_count, 94)
        self.assertEqual(len(entries), 309)
        self.assertEqual(
            sum(entry.policy == "RT_FEATURE_NOT_SUPPORT" for entry in entries), 294
        )
        self.assertEqual(sum(entry.policy == "NULLPTR" for entry in entries), 5)
        self.assertEqual(sum(entry.policy == "ZERO" for entry in entries), 10)
        unsupported_names = {entry.public_name for entry in entries}
        for name in (
            "aclFloat16ToFloat",
            "aclrtCreateBinary",
            "aclrtGetRunMode",
            "aclrtMallocAlign32",
            "aclrtNonBlockingLaunchBegin",
            "aclrtNonBlockingLaunchEnd",
            "aclrtRecordEventWithFlag",
            "aclrtSetExceptionInfoCallback",
            "aclrtTaskUpdateAsync",
        ):
            self.assertIn(name, unsupported_names)
        for name in (
            "aclFinalize",
            "aclGetRecentErrMsg",
            "aclInit",
            "aclmdlInitDump",
            "aclrtGetDevice",
            "aclrtGetOpExecuteTimeout",
            "aclrtGetOpTimeOutInterval",
            "aclrtGetSocName",
            "aclrtRecordEvent",
        ):
            self.assertNotIn(name, unsupported_names)

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
