#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
"""
按 Runtime review 规则对变更文件进行分类。

输出 JSON，格式：
{
  "source_files": [...],
  "ut_files": [...],
  "doc_files": [...],
  "other_files": [...]
}
"""

import json
import re
import sys
from pathlib import PurePosixPath


UT_PATTERNS = [
    re.compile(r".*_utest\.(cc|cpp|cxx|c)$"),
    re.compile(r".*_unittest\.(cc|cpp|cxx|c)$"),
]


def classify(path_str: str) -> str:
    path = PurePosixPath(path_str)
    path_text = str(path)

    if path_text.startswith("docs/"):
        return "doc_files"

    if path_text.startswith("tests/"):
        return "ut_files"

    if any(pattern.match(path.name) for pattern in UT_PATTERNS):
        return "ut_files"

    if path_text.startswith(("src/", "include/", "pkg_inc/", "cmake/")):
        return "source_files"

    return "other_files"


def main() -> int:
    groups = {
        "source_files": [],
        "ut_files": [],
        "doc_files": [],
        "other_files": [],
    }

    for raw_line in sys.stdin:
        line = raw_line.strip()
        if not line:
            continue
        groups[classify(line)].append(line)

    print(json.dumps(groups, ensure_ascii=False, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
