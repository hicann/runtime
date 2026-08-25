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
根据结构化审查结果渲染 PR summary markdown。

输入 JSON 格式建议：
{
  "change_summary": "...",
  "problem_stats": {
    "must_fix": 0,
    "suggested": 0,
    "reference": 0
  },
  "overall_assessment": "...",
  "findings": [
    {
      "file": "src/foo.cc",
      "severity": "[必须修改]",
      "dimension": "功能正确性",
      "line": 123,
      "summary": "问题摘要"
    }
  ]
}
"""

import argparse
import json
from pathlib import Path


def render_summary(payload: dict) -> str:
    lines = ["## 代码审查", ""]

    findings = payload.get("findings", []) or []
    if not findings:
        lines.extend(
            [
                "未发现问题。已按 Runtime Review 规则检查功能正确性、规范合规性和测试代码约束。",
                "",
            ]
        )
    else:
        lines.extend(["发现以下问题：", ""])
        for item in findings:
            line_suffix = f":{item.get('line')}" if item.get("line") else ""
            lines.append(
                f"- **{item.get('severity', '[建议修改]')}** "
                f"{item.get('file', 'unknown file')}"
                f"{line_suffix} "
                f"| {item.get('dimension', '未分类')} | {item.get('summary', '')}"
            )
        lines.append("")

    lines.append("### 审查总结")
    lines.append("")
    lines.append(f"1. 变更概要：{payload.get('change_summary', '未提供')}")

    stats = payload.get("problem_stats", {}) or {}
    must_fix = stats.get("must_fix", 0)
    suggested = stats.get("suggested", 0)
    reference = stats.get("reference", 0)
    lines.append(
        "2. 问题统计："
        f"[必须修改] {must_fix}，"
        f"[建议修改] {suggested}，"
        f"[仅供参考] {reference}"
    )
    lines.append(f"3. 总体评价：{payload.get('overall_assessment', '未提供')}")
    lines.append("")
    return "\n".join(lines)


def main() -> int:
    parser = argparse.ArgumentParser(description="Render PR review summary markdown")
    parser.add_argument("--input", required=True, help="Structured review result JSON")
    parser.add_argument("--output", help="Optional output markdown file")
    args = parser.parse_args()

    payload = json.loads(Path(args.input).read_text(encoding="utf-8"))
    text = render_summary(payload)

    if args.output:
        Path(args.output).write_text(text, encoding="utf-8")
    else:
        print(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
