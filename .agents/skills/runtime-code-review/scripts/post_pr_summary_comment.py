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
向 GitCode PR 发布 summary comment。

环境变量：
- GITCODE_API_TOKEN

用法：
  python post_pr_summary_comment.py --owner cann --repo runtime --pr 123 --body-file summary.md
"""

import argparse
import json
import os
import sys
from pathlib import Path

import requests


API_ROOT = "https://api.gitcode.com/api/v5"


def post_comment(owner: str, repo: str, pr_number: int, token: str, body: str) -> dict:
    url = f"{API_ROOT}/repos/{owner}/{repo}/pulls/{pr_number}/comments"
    response = requests.post(
        url,
        params={"access_token": token},
        headers={"Content-Type": "application/json", "Accept": "application/json"},
        json={"body": body},
        timeout=30,
    )
    response.raise_for_status()
    return response.json()


def main() -> int:
    parser = argparse.ArgumentParser(description="Post GitCode PR summary comment")
    parser.add_argument("--owner", required=True)
    parser.add_argument("--repo", required=True)
    parser.add_argument("--pr", required=True, type=int)
    parser.add_argument("--body-file", required=True)
    args = parser.parse_args()

    token = os.environ.get("GITCODE_API_TOKEN")
    if not token:
        print("GITCODE_API_TOKEN is required", file=sys.stderr)
        return 1

    body = Path(args.body_file).read_text(encoding="utf-8")
    try:
        result = post_comment(args.owner, args.repo, args.pr, token, body)
    except requests.exceptions.RequestException as exc:
        print(f"Failed to post PR summary comment: {exc}", file=sys.stderr)
        return 1
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
