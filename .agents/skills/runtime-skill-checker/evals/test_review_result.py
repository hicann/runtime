# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

"""统一入口和审查结果主流程测试。"""

from __future__ import annotations

import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


SKILL_ROOT = Path(__file__).resolve().parents[1]
SCRIPTS = SKILL_ROOT / "scripts"
sys.path.insert(0, str(SCRIPTS))

from review_result import DEFAULT_OUTPUT_DIRNAME, default_report_dir  # noqa: E402
from review_result_lib import (  # noqa: E402
    CANONICAL_STANDARD,
    CANONICAL_STANDARD_URL,
    dump_yaml_subset,
    load_guideline,
    load_yaml_subset,
    parse_guideline,
    parse_yaml_subset,
    render_review_report,
    reviewable_rules,
    validate_review_result,
)


class ReviewResultTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.repo = self.root / "runtime"
        self.target = self.repo / ".claude" / "skills" / "demo-skill"
        self.target.mkdir(parents=True)
        (self.target / "SKILL.md").write_text(
            "---\nname: demo-skill\ndescription: Demo.\n---\n\n# Demo\n",
            encoding="utf-8",
        )
        self.standard = self.repo / CANONICAL_STANDARD
        self.standard.parent.mkdir(parents=True)
        self.standard.write_text(
            "# Test guideline\n\n"
            "#### G.STR.02 Non-empty entrypoint\n\n**【级别】** 要求\n\n"
            "#### G.MET.03 Recognizable name\n\n**【级别】** 建议\n",
            encoding="utf-8",
        )
        self.guideline_rules = parse_guideline(self.standard)
        candidates = reviewable_rules(self.guideline_rules)
        self.required_rule = next(rule for rule in candidates if rule.level == "required")
        self.suggested_rule = next(rule for rule in candidates if rule.level == "suggested")
        self.report_dir = self.root / "reports" / "demo-skill"

    def tearDown(self) -> None:
        self.temp.cleanup()

    def run_prepare(self, report_dir: Path | None = None) -> Path:
        report_dir = report_dir or self.report_dir
        completed = subprocess.run(
            [
                sys.executable,
                "-B",
                str(SCRIPTS / "review_result.py"),
                "prepare",
                str(self.target),
                "--report-dir",
                str(report_dir),
            ],
            text=True,
            capture_output=True,
            check=False,
        )
        self.assertEqual(completed.returncode, 0, completed.stderr)
        self.assertEqual([path.name for path in report_dir.iterdir()], ["review-result.yaml"])
        return report_dir / "review-result.yaml"

    def complete_review(self, result_path: Path) -> dict:
        payload = load_yaml_subset(result_path)
        for index, rule in enumerate(payload["rules"]):
            rule.update(
                {
                    "status": "pass",
                    "assessment": f"Rule {index} is satisfied.",
                    "evidence": [{"location": "SKILL.md:5", "observation": "Observed."}],
                }
            )
        payload["review"]["status"] = "completed"
        result_path.write_text(dump_yaml_subset(payload), encoding="utf-8")
        return payload

    def failure_item(self, rule_id: str) -> dict:
        return {
            "id": "Fail-001",
            "rule_ids": [rule_id],
            "severity": "high",
            "location": "SKILL.md:5",
            "evidence": "The recorded evidence does not satisfy the rule.",
            "problem": "The rule is not satisfied.",
            "impact": "The Skill may behave inconsistently.",
            "recommendation": "Update the Skill and rerun the review.",
            "suggested_change": [],
        }

    def test_package_structure(self) -> None:
        text = (SKILL_ROOT / "SKILL.md").read_text(encoding="utf-8")
        frontmatter = parse_yaml_subset(text.split("---", 2)[1])
        self.assertEqual(frontmatter["name"], SKILL_ROOT.name)
        self.assertLessEqual(len(text.splitlines()), 500)
        self.assertEqual(set(frontmatter), {"name", "description", "compatibility"})
        self.assertEqual(
            {path.name for path in SCRIPTS.iterdir() if path.is_file()},
            {"review_result.py", "review_result_lib.py"},
        )

    def test_prepare_uses_default_rules_and_isolated_path(self) -> None:
        result_path = self.run_prepare()
        payload = load_yaml_subset(result_path)
        self.assertEqual(payload["target"], self.target.as_posix())
        self.assertEqual(
            default_report_dir(self.target),
            self.repo / DEFAULT_OUTPUT_DIRNAME / "claude" / self.target.name,
        )
        self.assertEqual(
            {rule["id"] for rule in payload["rules"]},
            {rule.rule_id for rule in reviewable_rules(self.guideline_rules)},
        )

        outside = self.target / "reports"
        completed = subprocess.run(
            [sys.executable, "-B", str(SCRIPTS / "review_result.py"), "prepare", str(self.target), "--report-dir", str(outside)],
            text=True,
            capture_output=True,
            check=False,
        )
        self.assertEqual(completed.returncode, 2)
        self.assertIn("outside the target Skill", completed.stderr)

    def test_guideline_prefers_repository_document(self) -> None:
        self.assertEqual(load_guideline(self.target), self.guideline_rules)

    def test_finalize_only_writes_report_after_success(self) -> None:
        result_path = self.run_prepare()
        report_path = result_path.with_name("review-report.md")
        report_path.write_text("sentinel", encoding="utf-8")
        command = [sys.executable, "-B", str(SCRIPTS / "review_result.py"), "finalize", str(result_path)]

        invalid = subprocess.run(command, text=True, capture_output=True, check=False)
        self.assertEqual(invalid.returncode, 1)
        self.assertEqual(report_path.read_text(encoding="utf-8"), "sentinel")

        self.complete_review(result_path)
        finalized = subprocess.run(command, text=True, capture_output=True, check=False)
        self.assertEqual(finalized.returncode, 0, finalized.stderr)
        report = report_path.read_text(encoding="utf-8")
        self.assertIn("原审查结论：通过", report)
        self.assertIn(CANONICAL_STANDARD_URL, report)

    def test_failures_drive_validation_and_report(self) -> None:
        result_path = self.run_prepare()
        payload = self.complete_review(result_path)
        payload["rules"][0].update({"status": "fail", "assessment": "The rule is not satisfied."})
        payload["failures"] = [self.failure_item(payload["rules"][0]["id"])]
        payload["optimization"]["status"] = "awaiting-confirmation"
        errors, derived = validate_review_result(payload, self.guideline_rules, result_path, final=True)
        self.assertEqual(errors, [])
        self.assertEqual(derived["overall"], "fail")
        self.assertIn("## 必须整改", render_review_report(payload, self.guideline_rules))

    def test_optimize_result_is_validated(self) -> None:
        result_path = self.run_prepare()
        payload = self.complete_review(result_path)
        rule_id = payload["rules"][0]["id"]
        payload["rules"][0].update({"status": "fail", "assessment": "The rule is not satisfied."})
        payload["phase"] = "optimize"
        payload["failures"] = [self.failure_item(rule_id)]
        payload["failures"][0]["resolution"] = {
            "status": "fixed",
            "changed_files": ["SKILL.md"],
            "verification_results": [{"check": "Re-review.", "result": "passed", "detail": "Passed."}],
            "residual_risk": "none-known",
            "reason": "",
        }
        payload["optimization"] = {
            "status": "completed",
            "requested_failure_ids": ["Fail-001"],
            "blocking_reason": "",
        }
        errors, _ = validate_review_result(payload, self.guideline_rules, result_path, final=True)
        self.assertEqual(errors, [])


if __name__ == "__main__":
    unittest.main()
