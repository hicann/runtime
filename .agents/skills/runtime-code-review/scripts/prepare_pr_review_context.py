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
聚合 PR review 所需上下文：
- PR 元信息
- 文件列表与 diff refs
- 文件分类

输入：
- --meta <fetch_pr_meta.py 产物>
- --files <fetch_pr_files.py 产物>
- --classified <classify_review_files.py 产物>

输出：
{
  "pr": {...},
  "diff": {...},
  "classified": {...}
}
"""

import argparse
import json
from pathlib import Path


def load_json(path: str) -> dict:
    return json.loads(Path(path).read_text(encoding="utf-8"))


def main() -> int:
    parser = argparse.ArgumentParser(description="Prepare PR review context")
    parser.add_argument("--meta", required=True)
    parser.add_argument("--files", required=True)
    parser.add_argument("--classified", required=True)
    args = parser.parse_args()

    meta = load_json(args.meta)
    files = load_json(args.files)
    classified = load_json(args.classified)

    payload = {
        "pr": {
            "number": meta.get("number"),
            "title": meta.get("title"),
            "body": meta.get("body"),
            "state": meta.get("state"),
            "draft": meta.get("draft"),
            "html_url": meta.get("html_url"),
            "base": meta.get("base"),
            "head": meta.get("head"),
        },
        "diff": {
            "count": files.get("count"),
            "diff_refs": files.get("diff_refs"),
            "file_paths": files.get("file_paths"),
            "files": files.get("files"),
        },
        "classified": classified,
    }

    print(json.dumps(payload, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
