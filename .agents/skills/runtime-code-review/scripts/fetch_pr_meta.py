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
获取 GitCode PR 元信息。

环境变量：
- GITCODE_API_TOKEN

用法：
  python fetch_pr_meta.py --owner cann --repo runtime --pr 123
"""

import argparse
import json
import os
import sys

import requests


API_ROOT = "https://api.gitcode.com/api/v5"


def fetch_pr_meta(owner: str, repo: str, pr_number: int, token: str) -> dict:
    url = f"{API_ROOT}/repos/{owner}/{repo}/pulls/{pr_number}"
    response = requests.get(url, params={"access_token": token}, timeout=30)
    response.raise_for_status()
    return response.json()


def normalize_pr_meta(payload: dict) -> dict:
    base = payload.get("base", {}) or {}
    head = payload.get("head", {}) or {}

    return {
        "number": payload.get("number"),
        "title": payload.get("title"),
        "body": payload.get("body"),
        "state": payload.get("state"),
        "draft": payload.get("draft", False),
        "html_url": payload.get("html_url") or payload.get("web_url"),
        "base": {
            "label": base.get("label"),
            "ref": base.get("ref"),
            "sha": base.get("sha"),
        },
        "head": {
            "label": head.get("label"),
            "ref": head.get("ref"),
            "sha": head.get("sha"),
        },
        "raw": payload,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description="Fetch GitCode PR metadata")
    parser.add_argument("--owner", required=True)
    parser.add_argument("--repo", required=True)
    parser.add_argument("--pr", required=True, type=int)
    args = parser.parse_args()

    token = os.environ.get("GITCODE_API_TOKEN")
    if not token:
        print("GITCODE_API_TOKEN is required", file=sys.stderr)
        return 1

    try:
        payload = fetch_pr_meta(args.owner, args.repo, args.pr, token)
    except requests.exceptions.RequestException as exc:
        print(f"Failed to fetch PR metadata: {exc}", file=sys.stderr)
        return 1
    normalized = normalize_pr_meta(payload)
    print(json.dumps(normalized, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
