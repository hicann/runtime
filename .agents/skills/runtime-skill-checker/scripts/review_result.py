# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

"""审查结果的 prepare / finalize 命令入口。"""

from __future__ import annotations

import argparse
import os
import sys
from pathlib import Path

from review_result_lib import (
    ReviewResultError,
    atomic_write_text,
    dump_yaml_subset,
    load_guideline,
    load_yaml_subset,
    new_review_result,
    render_review_report,
    validate_review_result,
)


DEFAULT_OUTPUT_DIRNAME = "skill-review-report"


def default_report_dir(target: Path) -> Path:
    requested = Path(os.path.abspath(target))
    workspace_root = requested.parent
    platform = "other"
    if requested.parent.name == "skills":
        platform_dir = requested.parent.parent
        if platform_dir.name.startswith(".") and len(platform_dir.name) > 1:
            workspace_root = platform_dir.parent
            platform = platform_dir.name[1:]
        else:
            workspace_root = platform_dir
    return workspace_root / DEFAULT_OUTPUT_DIRNAME / platform / requested.name


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Prepare or finalize a Skill review result.")
    commands = parser.add_subparsers(dest="command", required=True)
    prepare = commands.add_parser("prepare", help="create the initial YAML result")
    prepare.add_argument("target_skill", type=Path)
    prepare.add_argument("--report-dir", type=Path)
    prepare.add_argument("--overwrite", action="store_true")
    finalize = commands.add_parser("finalize", help="validate YAML and render Markdown")
    finalize.add_argument("result", type=Path)
    return parser.parse_args(argv)


def _prepare(args: argparse.Namespace) -> int:
    requested_target = Path(os.path.abspath(args.target_skill))
    target = requested_target.resolve(strict=True)
    if not target.is_dir() or not (target / "SKILL.md").is_file():
        raise ReviewResultError("target_skill must be a directory containing SKILL.md")
    report_dir = (args.report_dir or default_report_dir(requested_target)).resolve()
    if report_dir == target or target in report_dir.parents:
        raise ReviewResultError("report directory must be outside the target Skill")
    result_path = report_dir / "review-result.yaml"
    report_path = report_dir / "review-report.md"
    existing = [path.name for path in (result_path, report_path) if path.exists()]
    if existing and not args.overwrite:
        raise ReviewResultError(
            "result already exists; use --overwrite only when replacement is intended: "
            + ", ".join(existing)
        )
    payload = new_review_result(requested_target, load_guideline(target))
    atomic_write_text(result_path, dump_yaml_subset(payload))
    if args.overwrite:
        report_path.unlink(missing_ok=True)
    print(result_path)
    return 0


def _finalize(args: argparse.Namespace) -> int:
    result_path = args.result.resolve(strict=True)
    if result_path.name != "review-result.yaml":
        raise ReviewResultError("result file must be named review-result.yaml")
    payload = load_yaml_subset(result_path)
    target = payload.get("target") if isinstance(payload, dict) else None
    if not isinstance(target, str) or not target.strip():
        raise ReviewResultError("target must be a non-empty string")
    rules = load_guideline(Path(target))
    errors, _ = validate_review_result(payload, rules, result_path, final=True)
    if errors:
        print("error: result validation failed:\n- " + "\n- ".join(errors), file=sys.stderr)
        return 1
    report_path = result_path.with_name("review-report.md")
    atomic_write_text(report_path, render_review_report(payload, rules))
    print(report_path)
    return 0


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    try:
        return _prepare(args) if args.command == "prepare" else _finalize(args)
    except (OSError, ReviewResultError) as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
