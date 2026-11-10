#!/usr/bin/env python3
# -*- coding: UTF-8 -*-
# ----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# ----------------------------------------------------------------------------------------------------------

"""Host CLI checks for compressed-log corruption exit status and output."""

import gzip
import subprocess
import sys
import tempfile
import unittest
import zlib
from pathlib import Path

def find_unzip_tool():
    for parent in Path(__file__).resolve().parents:
        candidate = parent / "src/dfx/log/syslog/scripts/unzip_tool.py"
        if candidate.is_file():
            return candidate
    raise RuntimeError("cannot locate unzip_tool.py")


SCRIPT = find_unzip_tool()
FAILURE_MARKER = b"gzip failed.\n"


def compressed_log(payload):
    # Match SoftwareCompressBuffer: gzip framing, default compression, memLevel 9.
    compressor = zlib.compressobj(zlib.Z_DEFAULT_COMPRESSION, zlib.DEFLATED, 31, 9)
    result = bytearray(compressor.compress(payload) + compressor.flush())
    # The deployed Linux log writer uses gzip's UNIX OS identifier (3).
    # Normalize host metadata only; compressed data and CRC remain untouched.
    result[9] = 3
    assert result[:10] == b"\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\x03"
    return bytes(result)


def corrupt_member(member, kind):
    if kind == "truncated":
        return member[:-4]
    damaged = bytearray(member)
    if kind == "crc":
        damaged[-8] ^= 1
    else:
        # Reserved DEFLATE block type 3 is an actual decode failure.
        damaged[10] = (damaged[10] & ~6) | 6
    return bytes(damaged)


class TestLogDecompressionExitStatus(unittest.TestCase):
    def run_tool(self, compressed):
        with tempfile.TemporaryDirectory(prefix="cann-unzip-exit-") as directory:
            source = Path(directory) / "log.txt.gz"
            destination = source.with_suffix("")
            source.write_bytes(compressed)
            result = subprocess.run(
                [sys.executable, str(SCRIPT), str(source)],
                capture_output=True,
                text=True,
                check=False,
            )
            self.assertEqual(source.read_bytes(), compressed)
            output = destination.read_bytes() if destination.exists() else None
            return result, output

    def test_corrupt_members_report_failure_and_keep_fallback_output(self):
        first = b"[INFO] first event\n"
        last = b"[INFO] last event\n"
        member = compressed_log(b"[INFO] interrupted event\n")
        for kind in ("crc", "truncated", "deflate"):
            damaged = corrupt_member(member, kind)
            with self.assertRaises((OSError, EOFError, zlib.error)):
                gzip.decompress(damaged)
            for position in ("only", "first", "middle", "last"):
                with self.subTest(kind=kind, position=position):
                    chunks = [(damaged, FAILURE_MARKER)]
                    if position != "only":
                        chunks = [
                            (compressed_log(first), first),
                            (compressed_log(last), last),
                        ]
                        index = {"first": 0, "middle": 1, "last": 2}[position]
                        chunks.insert(index, (damaged, FAILURE_MARKER))
                    result, output = self.run_tool(b"".join(item[0] for item in chunks))
                    self.assertEqual(result.returncode, 1, result.stderr)
                    self.assertIn("gzip decompression failed", result.stderr)
                    self.assertEqual(output, b"".join(item[1] for item in chunks))

    def test_nonempty_unrecognized_data_reports_failure(self):
        member = compressed_log(b"[INFO] event\n")
        damaged_header = b"\x00" + member[1:]
        for data in (b"not a compressed log", damaged_header):
            with self.subTest(data=data[:10]):
                result, output = self.run_tool(data)
                self.assertEqual(result.returncode, 1, result.stderr)
                self.assertIn("gzip decompression failed", result.stderr)
                self.assertEqual(output, b"")

    def test_nonempty_prefix_before_healthy_members_reports_failure(self):
        first = compressed_log(b"[INFO] lost first event\n")
        damaged_header = b"\x00" + first[1:]
        last = b"[INFO] preserved later event\n"
        for prefix in (b"unrecognized prefix", damaged_header):
            with self.subTest(prefix=prefix[:10]):
                result, output = self.run_tool(prefix + compressed_log(last))
                self.assertEqual(result.returncode, 1, result.stderr)
                self.assertIn("gzip decompression failed", result.stderr)
                self.assertEqual(output, last)

    def assert_diagnostic_context(self, result):
        self.assertIn(str(result.args[-1]), result.stderr)
        self.assertRegex(
            result.stderr,
            r"^\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2},\d{3}\] \[\d+\] ERROR: ",
        )
        self.assertEqual(result.stdout, "")

    def test_corrupt_member_diagnostics_include_path_position_and_exception(self):
        healthy = compressed_log(b"healthy\n")
        member = compressed_log(b"damaged\n")
        for kind in ("crc", "truncated", "deflate"):
            damaged = corrupt_member(member, kind)
            try:
                gzip.decompress(damaged)
            except (OSError, EOFError, zlib.error) as error:
                reason = "{}: {}".format(type(error).__name__, error)
            else:
                self.fail("negative control must be a real decode failure")
            for index in range(3):
                with self.subTest(kind=kind, member=index + 1):
                    chunks = [healthy, healthy]
                    chunks.insert(index, damaged)
                    result, output = self.run_tool(b"".join(chunks))
                    self.assertEqual(result.returncode, 1, result.stderr)
                    self.assert_diagnostic_context(result)
                    self.assertIn("member={}".format(index + 1), result.stderr)
                    self.assertIn(reason, result.stderr)
                    expected = [b"healthy\n", b"healthy\n"]
                    expected.insert(index, FAILURE_MARKER)
                    self.assertEqual(output, b"".join(expected))

    def test_nonempty_prefix_diagnostics_distinguish_recovered_members(self):
        result, output = self.run_tool(b"unrecognized prefix" + compressed_log(b"recovered\n"))
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assert_diagnostic_context(result)
        self.assertIn("member=0 (prefix)", result.stderr)
        self.assertIn("nonempty unrecognized prefix", result.stderr)
        self.assertNotIn("no recognized gzip members", result.stderr)
        self.assertEqual(output, b"recovered\n")

    def test_no_member_diagnostics_identify_unrecognized_input(self):
        result, output = self.run_tool(b"not a compressed log")
        self.assertEqual(result.returncode, 1, result.stderr)
        self.assert_diagnostic_context(result)
        self.assertIn("member=none", result.stderr)
        self.assertIn("no recognized gzip members", result.stderr)
        self.assertNotIn("later members will still be decoded", result.stderr)
        self.assertEqual(output, b"")

    def test_healthy_and_empty_input_controls(self):
        cases = [
            ([b"[INFO] event\n"], b"[INFO] event\n"),
            ([b"first\n", b"second\n", b"third\n"], b"first\nsecond\nthird\n"),
            ([b""], b""),
            (["CANN 日志\n".encode("utf-8")], "CANN 日志\n".encode("utf-8")),
        ]
        for payloads, expected in cases:
            with self.subTest(payloads=payloads):
                compressed = b"".join(compressed_log(data) for data in payloads)
                self.assertEqual(gzip.decompress(compressed), expected)
                result, output = self.run_tool(compressed)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stderr, "")
                self.assertEqual(output, expected)
        result, output = self.run_tool(b"")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(result.stderr, "")
        self.assertIsNone(output)


if __name__ == "__main__":
    unittest.main(verbosity=2)
