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
获取 GitCode PR 的文件列表和 diff 元信息，并输出规范化结果。

环境变量：
- GITCODE_API_TOKEN

用法：
  python fetch_pr_files.py --owner cann --repo runtime --pr 123
"""

import argparse
import json
import os
import sys

import requests


API_ROOT = "https://api.gitcode.com/api/v5"


def fetch_pr_files(owner: str, repo: str, pr_number: int, token: str) -> dict:
    url = f"{API_ROOT}/repos/{owner}/{repo}/pulls/{pr_number}/files.json"
    response = requests.get(url, params={"access_token": token}, timeout=30)
    response.raise_for_status()
    return response.json()


def normalize_pr_files(payload: dict) -> dict:
    diffs = payload.get("diffs", []) or []
    diff_refs = payload.get("diff_refs", {}) or {}

    files = []
    file_paths = []

    for diff in diffs:
        statistic = diff.get("statistic", {}) or {}
        new_path = statistic.get("new_path")
        old_path = statistic.get("old_path")
        path = new_path or old_path
        if path:
            file_paths.append(path)
        files.append(
            {
                "path": path,
                "new_path": new_path,
                "old_path": old_path,
                "added_lines": diff.get("added_lines"),
                "removed_lines": diff.get("remove_lines"),
                "raw": diff,
            }
        )

    return {
        "count": payload.get("count", len(files)),
        "diff_refs": {
            "base_sha": diff_refs.get("base_sha"),
            "start_sha": diff_refs.get("start_sha"),
            "head_sha": diff_refs.get("head_sha"),
        },
        "file_paths": file_paths,
        "files": files,
        "raw": payload,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Fetch GitCode PR file list")
    parser.add_argument("--owner", required=True)
    parser.add_argument("--repo", required=True)
    parser.add_argument("--pr", required=True, type=int)
    args = parser.parse_args()

    token = os.environ.get("GITCODE_API_TOKEN")
    if not token:
        print("GITCODE_API_TOKEN is required", file=sys.stderr)
        return 1

    try:
        payload = fetch_pr_files(args.owner, args.repo, args.pr, token)
    except requests.exceptions.RequestException as exc:
        print(f"Failed to fetch PR files: {exc}", file=sys.stderr)
        return 1
    normalized = normalize_pr_files(payload)
    print(json.dumps(normalized, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
