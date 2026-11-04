#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
import importlib.util
import tempfile
import unittest
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parents[6]
SPEC = importlib.util.spec_from_file_location("verify_float16", ROOT / "example/common/verify_float16.py")
VERIFY = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(VERIFY)


class VerifyFloat16ByteLengthTest(unittest.TestCase):
    def test_rejects_partial_float16_element_in_either_input(self):
        valid = np.asarray([1.0], dtype=np.float16).tobytes()
        cases = ((valid + b"\xff", valid), (valid, valid + b"\xff"),
                 (valid + b"\xff", valid + b"\xff"))
        with tempfile.TemporaryDirectory() as tmp:
            out, golden = Path(tmp) / "out.bin", Path(tmp) / "golden.bin"
            for out_data, golden_data in cases:
                with self.subTest(out_len=len(out_data), golden_len=len(golden_data)):
                    out.write_bytes(out_data)
                    golden.write_bytes(golden_data)
                    self.assertFalse(VERIFY.verify_result(str(out), str(golden)))

    def test_accepts_matching_complete_elements(self):
        valid = np.asarray([1.0, -2.0], dtype=np.float16).tobytes()
        with tempfile.TemporaryDirectory() as tmp:
            out, golden = Path(tmp) / "out.bin", Path(tmp) / "golden.bin"
            out.write_bytes(valid)
            golden.write_bytes(valid)
            self.assertTrue(VERIFY.verify_result(str(out), str(golden)))


if __name__ == "__main__":
    unittest.main()
