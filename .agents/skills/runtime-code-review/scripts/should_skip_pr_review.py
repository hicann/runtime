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
根据 PR 元信息判断是否建议跳过审查。

输入：
- 通过 --meta 传入 fetch_pr_meta.py 生成的 JSON 文件

输出：
{
  "skip": true/false,
  "reason": "..."
}
"""

import argparse
import json
from pathlib import Path


def should_skip(meta: dict) -> dict:
    state = meta.get("state")
    draft = meta.get("draft", False)
    title = (meta.get("title") or "").lower()

    if state and state != "open":
        return {"skip": True, "reason": f"PR state is {state}"}

    if draft:
        return {"skip": True, "reason": "PR is draft"}

    if title.startswith(("wip", "[wip]", "draft:")):
        return {"skip": True, "reason": "PR title indicates work in progress"}

    return {"skip": False, "reason": ""}


def main() -> int:
    parser = argparse.ArgumentParser(description="Determine whether PR review should be skipped")
    parser.add_argument("--meta", required=True, help="Path to PR meta JSON")
    args = parser.parse_args()

    payload = json.loads(Path(args.meta).read_text(encoding="utf-8"))
    result = should_skip(payload)
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
