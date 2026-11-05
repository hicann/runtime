#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


def repository_root():
    for parent in Path(__file__).resolve().parents:
        if (parent / "cmake/stub/h2c.py").is_file():
            return parent
    raise RuntimeError("cannot locate h2c.py")


ROOT = repository_root()
GENERATOR = ROOT / "cmake/stub/h2c.py"


class H2cCommentTerminationTest(unittest.TestCase):
    def generate(self, headers, output):
        env = os.environ.copy()
        env["PYTHONUTF8"] = "1"
        return subprocess.run(
            [sys.executable, str(GENERATOR), "-i", *(str(h) for h in headers), "-o", str(output)],
            capture_output=True, text=True, env=env,
        )

    def test_comments_do_not_hide_following_declarations(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            header = root / "input.h"
            output = root / "output.c"
            header.write_text(
                "/** inline */\nint after_inline(void);\n"
                "/** multiline\n **/\nint after_multiline(void);\n"
                "/** same line */ int after_same_line(void);\n",
                encoding="utf-8",
            )
            result = self.generate([header], output)
            self.assertEqual(result.returncode, 0, result.stderr)
            content = output.read_text(encoding="utf-8")
            for name in ("after_inline", "after_multiline", "after_same_line"):
                self.assertEqual(content.count(name + "("), 1)

    def test_repository_header_generates_queue_reset(self):
        with tempfile.TemporaryDirectory() as tmp:
            output = Path(tmp) / "ascend_hal.c"
            headers = [ROOT / "pkg_inc/driver" / name for name in
                       ("ascend_hal.h", "ascend_hal_external.h", "ascend_hal_base.h")]
            result = self.generate(headers, output)
            self.assertEqual(result.returncode, 0, result.stderr)
            content = output.read_text(encoding="utf-8")
            for name in ("halQueueInit", "halQueueDestroy", "halQueueReset", "halQueueGetStatus"):
                self.assertEqual(content.count(name + "("), 1)


if __name__ == "__main__":
    unittest.main()
