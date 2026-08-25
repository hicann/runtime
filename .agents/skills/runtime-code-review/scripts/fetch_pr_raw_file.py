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
获取 GitCode PR 指定 commit 下的 raw 文件内容。

用法：
  python fetch_pr_raw_file.py --owner cann --repo runtime --sha <head_sha> --path src/foo.cc
"""

import argparse
import sys

import requests


def fetch_raw_file(owner: str, repo: str, sha: str, path: str) -> str:
    url = f"https://raw.gitcode.com/{owner}/{repo}/raw/{sha}/{path}"
    response = requests.get(url, timeout=30)
    response.raise_for_status()
    return response.text


def main() -> int:
    parser = argparse.ArgumentParser(description="Fetch GitCode raw file")
    parser.add_argument("--owner", required=True)
    parser.add_argument("--repo", required=True)
    parser.add_argument("--sha", required=True)
    parser.add_argument("--path", required=True)
    args = parser.parse_args()

    try:
        content = fetch_raw_file(args.owner, args.repo, args.sha, args.path)
    except requests.exceptions.RequestException as exc:
        print(f"Failed to fetch raw file: {exc}", file=sys.stderr)
        return 1
    sys.stdout.write(content)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
