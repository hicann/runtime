#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


def find_generator():
    for parent in Path(__file__).resolve().parents:
        candidate = parent / "cmake/stub/h2c.py"
        if candidate.is_file():
            return candidate
    raise RuntimeError("h2c.py not found")


class EmptyHeaderGuardTest(unittest.TestCase):
    def test_empty_and_nonempty_guards(self):
        cases = (
            ("#ifndef __ASCEND_HAL_H__\n#define __ASCEND_HAL_H__\n#endif\n", False),
            ("#ifndef __ASCEND_HAL_H__\n#define __ASCEND_HAL_H__\n#if FLAG\n#endif\n#endif\n", False),
            ("#ifndef __ASCEND_HAL_H__\n#define __ASCEND_HAL_H__\n#if FLAG\nint drvExample(void);\n#endif\n#endif\n", True),
        )
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            for index, (header, has_function) in enumerate(cases):
                with self.subTest(case=index):
                    src, dst = root / f"case{index}.h", root / f"case{index}.c"
                    src.write_text(header, encoding="utf-8")
                    result = subprocess.run([sys.executable, str(find_generator()), "-i", str(src), "-o", str(dst)],
                                            text=True, capture_output=True, check=False)
                    self.assertEqual(result.returncode, 0, result.stderr)
                    self.assertEqual("drvExample" in dst.read_text(encoding="utf-8"), has_function)
                    if has_function:
                        self.assertIn("#if FLAG", dst.read_text(encoding="utf-8"))


if __name__ == "__main__":
    unittest.main()
