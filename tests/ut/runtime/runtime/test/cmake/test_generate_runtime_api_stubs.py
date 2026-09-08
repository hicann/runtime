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
        generator_path = parent / "src/runtime/cmake/generate_runtime_api_stubs.py"
        if generator_path.is_file():
            return generator_path
    raise RuntimeError("cannot locate src/runtime/cmake/generate_runtime_api_stubs.py")


GENERATOR_PATH = find_generator_path()
REPO_ROOT = GENERATOR_PATH.parents[3]
SPEC = importlib.util.spec_from_file_location("generate_runtime_api_stubs", GENERATOR_PATH)
GENERATOR = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(GENERATOR)


CATALOG = """\
RUNTIME_API_CATALOG_VERSION(1)
RUNTIME_API(module_a, rtError_t, rtUnsupported, (int32_t value), (value), FEATURE_NOT_SUPPORT, EXPORT)
RUNTIME_API(module_a, rtError_t, rtNoop, (void), (), SUCCESS_NOOP, EXPORT)
RUNTIME_API(module_b, void, rtVoidNoop, (void* value), (value), VOID_NOOP, HIDDEN)
RUNTIME_API(module_b, uint32_t, rtMemoryReserved, (void), (), MEMORY_RESERVED, EXPORT)
"""


class GenerateRuntimeApiStubsTest(unittest.TestCase):
    def setUp(self):
        self.temp_dir = tempfile.TemporaryDirectory()
        self.root = Path(self.temp_dir.name)
        self.catalog_path = self.root / "catalog.def"
        self.catalog_path.write_text(CATALOG, encoding="utf-8")

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
                "--catalog",
                str(self.catalog_path),
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

    def test_generates_selected_strong_stubs_and_report(self):
        product_path = self.write_product("""\
RUNTIME_API_CATALOG_VERSION(1)
RUNTIME_API_STUB(rtUnsupported)
RUNTIME_API_STUB(rtNoop)
""")
        version, catalog = GENERATOR.parse_catalog(self.catalog_path)
        product_version, names = GENERATOR.parse_product_def(product_path)

        self.assertEqual(version, product_version)
        source = GENERATOR.render_source("test", [catalog[name] for name in names])
        self.assertIn("return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;", source)
        self.assertIn("return ACL_RT_SUCCESS;", source)
        hidden_stub = GENERATOR.render_stub(catalog["rtVoidNoop"])
        self.assertIn("void rtVoidNoop(void* value)", hidden_stub)
        self.assertNotIn("VISIBILITY_DEFAULT", hidden_stub)
        reserved_stub = GENERATOR.render_stub(catalog["rtMemoryReserved"])
        self.assertIn("return RT_MEMORY_RESERVED;", reserved_stub)
        self.assertNotIn("RUNTIME_API_WEAK", source)

        test_source = GENERATOR.render_test_source(
            "test", [catalog["rtUnsupported"], catalog["rtNoop"]]
        )
        self.assertIn(
            "EXPECT_EQ(InvokeWithDefaultArguments(&rtUnsupported), "
            "ACL_ERROR_RT_FEATURE_NOT_SUPPORT);",
            test_source,
        )
        self.assertIn(
            "EXPECT_EQ(InvokeWithDefaultArguments(&rtNoop), ACL_RT_SUCCESS);",
            test_source,
        )
        self.assertEqual(test_source.count("TEST(Arch5162RuntimeApiStubTest,"), 2)

        report_path = self.root / "provider.csv"
        GENERATOR.write_report(report_path, "test", catalog, names)
        with report_path.open(encoding="utf-8", newline="") as report:
            rows = list(csv.DictReader(report))
        self.assertEqual(
            rows[0].keys(), {"product", "api", "module", "stub_visibility", "provider"}
        )
        self.assertEqual(
            {row["api"]: row["provider"] for row in rows},
            {
                "rtMemoryReserved": "weak_real",
                "rtNoop": "strong_stub",
                "rtUnsupported": "strong_stub",
                "rtVoidNoop": "weak_real",
            },
        )

    def test_arch5162_product_matches_confirmed_api_support(self):
        catalog_path = REPO_ROOT / "src/runtime/api/runtime_api_stub_catalog.def"
        product_path = REPO_ROOT / "src/runtime/cmake/arch5162_unsupported_runtime_api.def"
        catalog_version, catalog = GENERATOR.parse_catalog(catalog_path)
        product_version, names = GENERATOR.parse_product_def(product_path)

        self.assertEqual(catalog_version, product_version)
        self.assertFalse(set(names) - set(catalog))
        self.assertEqual(names, sorted(names))
        self.assertEqual(len(catalog), 786)
        self.assertEqual(len(names), 654)
        self.assertEqual(len(set(catalog) - set(names)), 132)
        self.assertEqual(
            sum(catalog[name].policy == "FEATURE_NOT_SUPPORT" for name in names),
            650,
        )
        self.assertEqual(
            sum(catalog[name].policy == "SUCCESS_NOOP" for name in names), 3
        )
        self.assertEqual(
            sum(catalog[name].policy == "VOID_NOOP" for name in names), 1
        )
        generated_tests = GENERATOR.render_test_source(
            "arch5162", [catalog[name] for name in names]
        )
        self.assertEqual(
            generated_tests.count("TEST(Arch5162RuntimeApiStubTest,"), len(names)
        )
        for api in (
            "rtCtxGetCurrentDefaultStream",
            "rtDatadumpInfoLoadWithFlag",
            "rtDeviceGetStreamPriorityRange",
            "rtEventRecord",
            "rtGetAvailEventNum",
            "rtGetDeviceInfo",
            "rtGetEventID",
            "rtGetNotifyID",
            "rtGetOpExecuteTimeoutV2",
            "rtGetOpTimeOutInterval",
            "rtGetSocVersion",
            "rtGetSocSpec",
            "rtGetStreamId",
            "rtGetTsMemType",
            "rtLabelDestroy",
            "rtLabelSet",
            "rtLabelSwitchByIndex",
            "rtMalloc",
            "rtMemcpy",
            "rtMemcpyAsync",
            "rtModelCreate",
            "rtModelLoadComplete",
            "rtModelUnbindStream",
            "rtNotifyDestroy",
            "rtNotifyRecord",
            "rtNotifyWait",
            "rtNotifyWaitWithTimeOut",
            "rtNpuClearFloatDebugStatus",
            "rtNpuGetFloatDebugStatus",
            "rtSetDevice",
            "rtSetModelName",
            "rtStarsTaskLaunch",
            "rtStarsTaskLaunchWithFlag",
            "rtStreamActive",
            "rtStreamSwitchEx",
            "rtStreamWaitEventWithTimeout",
            "rtsFree",
            "rtsPointerGetAttributes",
        ):
            self.assertIn(api, catalog)
            self.assertNotIn(api, names)
        for api in (
            "rtBinaryLoadWithoutTilingKey",
            "rtDeviceGetHostAtomicCapabilities",
            "rtDeviceGetLimit",
            "rtDeviceGetP2PAtomicCapabilities",
            "rtEventRecordWithFlag",
            "rtGetDevMsg",
            "rtMemGetAddressRange",
            "rtMemMapSelectedLink",
            "rtModelGetId",
            "rtRegTaskFailCallbackByModule",
            "rtStreamWaitEventWithFlag",
            "rtsMalloc",
            "rtsLaunchUpdateTask",
            "rtsModelAbort",
        ):
            self.assertIn(api, names)
        self.assertNotIn("rtDeinit", names)
        self.assertNotIn("rtGetDevice", names)
        self.assertEqual(catalog["rtDeinit"].policy, "VOID_NOOP")

    def test_arch5162_acl_tests_reference_product_stubs(self):
        product_path = REPO_ROOT / "src/runtime/cmake/arch5162_unsupported_runtime_api.def"
        _, runtime_stub_names = GENERATOR.parse_product_def(product_path)
        runtime_stub_set = set(runtime_stub_names)

        acl_def_path = (
            REPO_ROOT
            / "tests/ut/runtime/runtime/test/platform/arch5162/arch5162_unsupported_acl_api.def"
        )
        content = GENERATOR.strip_comments(acl_def_path.read_text(encoding="utf-8"))
        macros = (
            "ARCH5162_UNSUPPORTED_ACL_API",
            "ARCH5162_UNSUPPORTED_ACL_API_WITH_ARGS",
            "ARCH5162_UNSUPPORTED_ACL_API_WITH_EXPECTED",
            "ARCH5162_UNSUPPORTED_ACL_API_WITH_ARGS_AND_EXPECTED",
            "ARCH5162_UNSUPPORTED_ACL_POINTER_API_WITH_ARGS",
        )
        mappings = []
        for macro in macros:
            for invocation in GENERATOR.extract_invocations(content, macro):
                fields = GENERATOR.split_top_level(invocation)
                mappings.append((fields[0], fields[1]))

        acl_names = [acl_name for acl_name, _ in mappings]
        self.assertEqual(len(acl_names), 265)
        self.assertFalse(any(name.startswith("acltdt") for name in acl_names))
        self.assertEqual(len(acl_names), len(set(acl_names)))
        self.assertFalse(
            {runtime_name for _, runtime_name in mappings} - runtime_stub_set
        )

    def test_rejects_duplicate_product_api(self):
        product_path = self.write_product("""\
RUNTIME_API_CATALOG_VERSION(1)
RUNTIME_API_STUB(rtUnsupported)
RUNTIME_API_STUB(rtUnsupported)
""")
        with self.assertRaisesRegex(ValueError, "duplicate stub APIs"):
            GENERATOR.parse_product_def(product_path)

    def test_rejects_unknown_policy(self):
        self.catalog_path.write_text(
            "RUNTIME_API_CATALOG_VERSION(1)\n"
            "RUNTIME_API(module, rtError_t, rtApi, (void), (), UNKNOWN, EXPORT)\n",
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "unsupported policy"):
            GENERATOR.parse_catalog(self.catalog_path)

    def test_rejects_unknown_visibility(self):
        self.catalog_path.write_text(
            "RUNTIME_API_CATALOG_VERSION(1)\n"
            "RUNTIME_API(module, rtError_t, rtApi, (void), (), FEATURE_NOT_SUPPORT, UNKNOWN)\n",
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "unsupported visibility"):
            GENERATOR.parse_catalog(self.catalog_path)

    def test_rejects_unbalanced_signature(self):
        self.catalog_path.write_text(
            "RUNTIME_API_CATALOG_VERSION(1)\n"
            "RUNTIME_API(module, rtError_t, rtApi, (void, (), FEATURE_NOT_SUPPORT)\n",
            encoding="utf-8",
        )
        with self.assertRaisesRegex(ValueError, "unterminated RUNTIME_API invocation"):
            GENERATOR.parse_catalog(self.catalog_path)

    def test_rejects_unknown_product_api(self):
        product_path = self.write_product("""\
RUNTIME_API_CATALOG_VERSION(1)
RUNTIME_API_STUB(rtUnknown)
""")
        result = self.run_generator(product_path)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("unknown APIs", result.stderr)

    def test_rejects_catalog_version_mismatch(self):
        product_path = self.write_product("""\
RUNTIME_API_CATALOG_VERSION(2)
RUNTIME_API_STUB(rtUnsupported)
""")
        result = self.run_generator(product_path)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("catalog version mismatch", result.stderr)


if __name__ == "__main__":
    unittest.main()
