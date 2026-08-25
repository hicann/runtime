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
PR review 单入口总控脚本。

职责：
- 获取 PR 元信息
- 获取 PR 文件列表
- 判断是否建议跳过审查
- 进行文件分类
- 聚合审查上下文
- 可选根据已有 review 结果渲染 summary
- 可选发布 summary comment

说明：
- 该脚本不直接执行模型审查，只负责 orchestration。
- 真正的 review 结果应由外部流程产出，再通过 --review-result 传入。
"""

import argparse
import json
import subprocess
import sys
from pathlib import Path


SCRIPT_DIR = Path(__file__).resolve().parent
ALLOWED_SEVERITIES = {"[必须修改]", "[建议修改]", "[仅供参考]"}


def run_json_command(cmd: list[str], cwd: Path) -> dict:
    completed = subprocess.run(cmd, cwd=cwd, check=True, capture_output=True, text=True)
    return json.loads(completed.stdout)


def run_text_command(cmd: list[str], cwd: Path) -> str:
    completed = subprocess.run(cmd, cwd=cwd, check=True, capture_output=True, text=True)
    return completed.stdout


def write_json(path: Path, payload: dict) -> None:
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")


def validate_review_result(payload: dict) -> None:
    required_top = ["change_summary", "problem_stats", "overall_assessment", "findings"]
    for key in required_top:
        if key not in payload:
            raise ValueError(f"Missing top-level field: {key}")

    stats = payload["problem_stats"]
    for key in ["must_fix", "suggested", "reference"]:
        if key not in stats:
            raise ValueError(f"Missing problem_stats field: {key}")

    findings = payload["findings"]
    if not isinstance(findings, list):
        raise ValueError("findings must be a list")

    for idx, item in enumerate(findings):
        for key in ["file", "severity", "dimension", "summary"]:
            if key not in item:
                raise ValueError(f"Finding #{idx} missing field: {key}")
        if item["severity"] not in ALLOWED_SEVERITIES:
            raise ValueError(f"Finding #{idx} has invalid severity: {item['severity']}")


def build_inline_body(finding: dict) -> str:
    suggestion = finding.get("suggestion")
    body = (
        f"**{finding.get('severity')}** {finding.get('dimension')}："
        f"{finding.get('summary')}"
    )
    if suggestion:
        body += f"\n\n建议：{suggestion}"
    return body


def main() -> int:
    parser = argparse.ArgumentParser(description="Orchestrate Runtime GitCode PR review")
    parser.add_argument("--owner", required=True)
    parser.add_argument("--repo", required=True)
    parser.add_argument("--pr", required=True, type=int)
    parser.add_argument("--workspace", default=".tmp/runtime-code-review", help="Output working directory")
    parser.add_argument("--review-result", help="Optional structured review result JSON")
    parser.add_argument("--comment", action="store_true", help="Post summary comment when review result is provided")
    parser.add_argument(
        "--summary-only",
        action="store_true",
        help="Only render/post summary, do not post inline comments",
    )
    parser.add_argument(
        "--post-inline-comments",
        action="store_true",
        help="Post inline comments for eligible findings",
    )
    args = parser.parse_args()

    if args.summary_only and args.post_inline_comments:
        print("--summary-only and --post-inline-comments cannot be used together", file=sys.stderr)
        return 1

    if args.post_inline_comments and not args.comment:
        print("--post-inline-comments requires --comment", file=sys.stderr)
        return 1

    if (args.comment or args.post_inline_comments or args.summary_only) and not args.review_result:
        print(
            "--review-result is required when using --comment, --summary-only, or --post-inline-comments",
            file=sys.stderr,
        )
        return 1

    cwd = Path.cwd()
    workspace = (cwd / args.workspace).resolve()
    workspace.mkdir(parents=True, exist_ok=True)

    meta_path = workspace / "pr-meta.json"
    files_path = workspace / "pr-files.json"
    classified_path = workspace / "pr-classified.json"
    context_path = workspace / "pr-context.json"
    skip_path = workspace / "pr-skip.json"
    summary_path = workspace / "summary.md"

    meta = run_json_command(
        [
            sys.executable,
            str(SCRIPT_DIR / "fetch_pr_meta.py"),
            "--owner",
            args.owner,
            "--repo",
            args.repo,
            "--pr",
            str(args.pr),
        ],
        cwd,
    )
    write_json(meta_path, meta)

    files = run_json_command(
        [
            sys.executable,
            str(SCRIPT_DIR / "fetch_pr_files.py"),
            "--owner",
            args.owner,
            "--repo",
            args.repo,
            "--pr",
            str(args.pr),
        ],
        cwd,
    )
    write_json(files_path, files)

    skip = run_json_command(
        [
            sys.executable,
            str(SCRIPT_DIR / "should_skip_pr_review.py"),
            "--meta",
            str(meta_path),
        ],
        cwd,
    )
    write_json(skip_path, skip)

    if skip.get("skip"):
        print(
            json.dumps(
                {
                    "skip": True,
                    "reason": skip.get("reason"),
                    "workspace": str(workspace),
                },
                ensure_ascii=False,
                indent=2,
            )
        )
        return 0

    file_list = "\n".join(files.get("file_paths", [])) + ("\n" if files.get("file_paths") else "")
    classified_text = subprocess.run(
        [sys.executable, str(SCRIPT_DIR / "classify_review_files.py")],
        cwd=cwd,
        check=True,
        input=file_list,
        capture_output=True,
        text=True,
    ).stdout
    classified = json.loads(classified_text)
    write_json(classified_path, classified)

    context = run_json_command(
        [
            sys.executable,
            str(SCRIPT_DIR / "prepare_pr_review_context.py"),
            "--meta",
            str(meta_path),
            "--files",
            str(files_path),
            "--classified",
            str(classified_path),
        ],
        cwd,
    )
    write_json(context_path, context)

    output = {
        "skip": False,
        "workspace": str(workspace),
        "meta": str(meta_path),
        "files": str(files_path),
        "classified": str(classified_path),
        "context": str(context_path),
    }

    if args.review_result:
        review_result_path = Path(args.review_result).resolve()
        review_result = json.loads(review_result_path.read_text(encoding="utf-8"))
        validate_review_result(review_result)

        run_text_command(
            [
                sys.executable,
                str(SCRIPT_DIR / "render_pr_review_summary.py"),
                "--input",
                str(review_result_path),
                "--output",
                str(summary_path),
            ],
            cwd,
        )
        output["summary"] = str(summary_path)

        if args.comment:
            result = run_json_command(
                [
                    sys.executable,
                    str(SCRIPT_DIR / "post_pr_summary_comment.py"),
                    "--owner",
                    args.owner,
                    "--repo",
                    args.repo,
                    "--pr",
                    str(args.pr),
                    "--body-file",
                    str(summary_path),
                ],
                cwd,
            )
            output["summary_comment_result"] = result

        if args.post_inline_comments:
            inline_results = []
            for finding in review_result.get("findings", []):
                inline = finding.get("inline_comment")
                if not inline:
                    continue
                path = inline.get("path") or finding.get("file")
                position = inline.get("position") or finding.get("line")
                if path is None or position is None:
                    continue
                cmd = [
                    sys.executable,
                    str(SCRIPT_DIR / "post_pr_inline_comment.py"),
                    "--owner",
                    args.owner,
                    "--repo",
                    args.repo,
                    "--pr",
                    str(args.pr),
                    "--path",
                    str(path),
                    "--position",
                    str(position),
                    "--body",
                    inline.get("body") or build_inline_body(finding),
                ]
                start_position = inline.get("start_position")
                if start_position is not None:
                    cmd.extend(["--start-position", str(start_position)])
                inline_results.append(run_json_command(cmd, cwd))
            output["inline_comment_results"] = inline_results

    print(json.dumps(output, ensure_ascii=False, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
