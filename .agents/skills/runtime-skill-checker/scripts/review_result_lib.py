# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

"""Shared schema, YAML-subset, validation, and rendering logic."""

from __future__ import annotations

import json
import re
from collections import Counter
from dataclasses import dataclass
from pathlib import Path
from typing import Any


RULE_HEADING = re.compile(r"^####\s+(G\.[A-Z]{3}\.\d{2})\s+(.+?)\s*$")
RULE_LEVEL = re.compile(r"^\*\*【级别】\*\*\s*(要求|建议)\s*$")
KEY_PATTERN = re.compile(r"^[A-Za-z_][A-Za-z0-9_-]*$")
INLINE_MAPPING_ITEM = re.compile(r"^([A-Za-z_][A-Za-z0-9_-]*):(?:\s+(.*))?$")
ISSUE_ID = re.compile(r"^(Fail|Suggest)-(\d{3,})$")
SUGGESTED_CHANGE_HUNK = re.compile(r"^@@ ([^:]+):([1-9]\d*)$")
RULE_WEIGHTS = {"required": 5, "suggested": 1}
SKILL_ROOT = Path(__file__).resolve().parents[1]
CANONICAL_STANDARD = Path("docs/zh/guidelines/agent-skill-guidelines.md")
CANONICAL_STANDARD_URL = (
    "https://gitcode.com/cann/runtime/blob/master/" + CANONICAL_STANDARD.as_posix()
)
RULE_FINAL_STATUSES = {
    "pass",
    "fail",
}
RULE_WORKING_STATUSES = RULE_FINAL_STATUSES | {"pending"}
RESOLUTION_STATUSES = {"fixed", "failed", "rejected", "blocked"}


class ReviewResultError(ValueError):
    """Raised when an input or result violates the checker contract."""


@dataclass(frozen=True)
class GuidelineRule:
    rule_id: str
    title: str
    level: str
    source_line: int


def reviewable_rules(rules: list[GuidelineRule]) -> list[GuidelineRule]:
    """Return rules that belong in the default static Skill review."""
    return [rule for rule in rules if _is_reviewable_rule_id(rule.rule_id)]


def _is_reviewable_rule_id(rule_id: str) -> bool:
    _, category, _ = rule_id.split(".")
    return category not in {"CRE", "EVL", "REL", "MNT"}


def load_guideline(target: Path) -> list[GuidelineRule]:
    """从目标 Skill 和检查器的上级目录查找并读取正式规范。"""
    candidates = (
        root / CANONICAL_STANDARD
        for anchor in (target.resolve(), SKILL_ROOT)
        for root in anchor.parents
    )
    return parse_guideline(next(path for path in candidates if path.is_file()))


def parse_guideline(path: Path) -> list[GuidelineRule]:
    """解析正式规范文件，返回运行时使用的规则元数据。"""
    try:
        text = path.read_text(encoding="utf-8")
    except OSError as exc:
        raise ReviewResultError(f"cannot read guideline: {exc}") from exc
    except UnicodeDecodeError as exc:
        raise ReviewResultError("guideline is not valid UTF-8") from exc

    lines = text.splitlines()
    headings: list[tuple[int, str, str]] = []
    for index, line in enumerate(lines):
        match = RULE_HEADING.match(line)
        if match:
            headings.append((index, match.group(1), match.group(2).strip()))
    if not headings:
        raise ReviewResultError("guideline contains no G.<CATEGORY>.<NN> rules")

    rules: list[GuidelineRule] = []
    seen: set[str] = set()
    for position, (index, rule_id, title) in enumerate(headings):
        if rule_id in seen:
            raise ReviewResultError(f"duplicate guideline rule: {rule_id}")
        seen.add(rule_id)
        end = headings[position + 1][0] if position + 1 < len(headings) else len(lines)
        level_matches = [RULE_LEVEL.match(line) for line in lines[index + 1 : end]]
        levels = [match.group(1) for match in level_matches if match]
        if len(levels) != 1:
            raise ReviewResultError(
                f"{rule_id} must contain exactly one level marker; found {len(levels)}"
            )
        rules.append(
            GuidelineRule(
                rule_id=rule_id,
                title=title,
                level="required" if levels[0] == "要求" else "suggested",
                source_line=index + 1,
            )
        )
    return rules

def load_yaml_subset(path: Path) -> Any:
    try:
        text = path.read_text(encoding="utf-8")
    except OSError as exc:
        raise ReviewResultError(f"cannot read YAML: {exc}") from exc
    return parse_yaml_subset(text)


def parse_yaml_subset(text: str) -> Any:
    tokens: list[tuple[int, int, str]] = []
    for line_number, raw_line in enumerate(text.splitlines(), start=1):
        if "\t" in raw_line[: len(raw_line) - len(raw_line.lstrip())]:
            raise ReviewResultError(f"line {line_number}: tabs are not allowed for indentation")
        stripped = raw_line.strip()
        if not stripped or stripped.startswith("#"):
            continue
        indent = len(raw_line) - len(raw_line.lstrip(" "))
        if indent % 2:
            raise ReviewResultError(f"line {line_number}: indentation must use two spaces")
        if stripped in {"---", "..."}:
            raise ReviewResultError("multi-document YAML markers are not supported")
        tokens.append((line_number, indent, raw_line[indent:]))
    if not tokens:
        raise ReviewResultError("YAML document is empty")
    value, index = _parse_block(tokens, 0, tokens[0][1])
    if tokens[0][1] != 0:
        raise ReviewResultError("top-level YAML must not be indented")
    if index != len(tokens):
        line_number = tokens[index][0]
        raise ReviewResultError(f"line {line_number}: unexpected content")
    return value


def _parse_block(
    tokens: list[tuple[int, int, str]], index: int, indent: int
) -> tuple[Any, int]:
    if index >= len(tokens) or tokens[index][1] != indent:
        raise ReviewResultError("invalid nested YAML block")
    if tokens[index][2] == "-" or tokens[index][2].startswith("- "):
        result: list[Any] = []
        while index < len(tokens):
            line_number, current_indent, content = tokens[index]
            if current_indent < indent:
                break
            if current_indent != indent or not (content == "-" or content.startswith("- ")):
                break
            rest = content[1:].strip()
            index += 1
            if rest:
                if INLINE_MAPPING_ITEM.fullmatch(rest):
                    inline_tokens = [(line_number, indent + 2, rest), *tokens[index:]]
                    value, consumed = _parse_block(inline_tokens, 0, indent + 2)
                    result.append(value)
                    index += consumed - 1
                else:
                    result.append(_parse_scalar(rest, line_number))
            else:
                if index >= len(tokens) or tokens[index][1] <= indent:
                    raise ReviewResultError(f"line {line_number}: list item requires a value")
                value, index = _parse_block(tokens, index, indent + 2)
                result.append(value)
        return result, index

    result_map: dict[str, Any] = {}
    while index < len(tokens):
        line_number, current_indent, content = tokens[index]
        if current_indent < indent:
            break
        if current_indent != indent or content == "-" or content.startswith("- "):
            break
        if ":" not in content:
            raise ReviewResultError(f"line {line_number}: expected key: value")
        key, rest = content.split(":", 1)
        key = key.strip()
        if not KEY_PATTERN.fullmatch(key):
            raise ReviewResultError(f"line {line_number}: unsupported key {key!r}")
        if key in result_map:
            raise ReviewResultError(f"line {line_number}: duplicate key {key!r}")
        rest = rest.strip()
        index += 1
        if rest:
            result_map[key] = _parse_scalar(rest, line_number)
        elif index < len(tokens) and tokens[index][1] > indent:
            value, index = _parse_block(tokens, index, indent + 2)
            result_map[key] = value
        else:
            result_map[key] = None
    return result_map, index


def _parse_scalar(value: str, line_number: int) -> Any:
    if value.startswith(("&", "*", "!", "|", ">")):
        raise ReviewResultError(f"line {line_number}: unsupported YAML scalar feature")
    if value.startswith(("[", "{", '"')) or value in {"null", "true", "false"}:
        try:
            return json.loads(value)
        except json.JSONDecodeError as exc:
            raise ReviewResultError(f"line {line_number}: invalid scalar: {exc.msg}") from exc
    if re.fullmatch(r"-?(?:0|[1-9]\d*)", value):
        return int(value)
    if re.fullmatch(r"-?(?:0|[1-9]\d*)\.\d+", value):
        return float(value)
    if " #" in value:
        value = value.split(" #", 1)[0].rstrip()
    return value


def dump_yaml_subset(value: Any) -> str:
    lines: list[str] = []
    _emit_yaml(value, 0, lines)
    return "\n".join(lines) + "\n"


def _emit_yaml(value: Any, indent: int, lines: list[str]) -> None:
    prefix = " " * indent
    if isinstance(value, dict):
        for key, item in value.items():
            if not KEY_PATTERN.fullmatch(str(key)):
                raise ReviewResultError(f"unsupported YAML key: {key!r}")
            if isinstance(item, (dict, list)) and item:
                lines.append(f"{prefix}{key}:")
                _emit_yaml(item, indent + 2, lines)
            else:
                lines.append(f"{prefix}{key}: {_format_scalar(item)}")
    elif isinstance(value, list):
        for item in value:
            if isinstance(item, (dict, list)):
                if not item:
                    lines.append(f"{prefix}- {_format_scalar(item)}")
                else:
                    lines.append(f"{prefix}-")
                    _emit_yaml(item, indent + 2, lines)
            else:
                lines.append(f"{prefix}- {_format_scalar(item)}")
    else:
        lines.append(f"{prefix}{_format_scalar(value)}")


def _format_scalar(value: Any) -> str:
    if value is None:
        return "null"
    if value is True:
        return "true"
    if value is False:
        return "false"
    if isinstance(value, (int, float)):
        return str(value)
    if isinstance(value, list) and not value:
        return "[]"
    if isinstance(value, dict) and not value:
        return "{}"
    return json.dumps(str(value), ensure_ascii=False)


def new_review_result(target: Path, rules: list[GuidelineRule]) -> dict[str, Any]:
    """创建只保存审查事实的初始结果。"""
    return {
        "phase": "review",
        "target": target.as_posix(),
        "review": {
            "status": "in-progress",
            "blocking_reason": "",
        },
        "rules": [
            {
                "id": rule.rule_id,
                "status": "pending",
                "assessment": "",
                "evidence": [],
            }
            for rule in reviewable_rules(rules)
        ],
        "failures": [],
        "optimization": {
            "status": "not-started",
            "requested_failure_ids": [],
            "blocking_reason": "",
        },
    }

def validate_review_result(
    payload: Any,
    guideline_rules: list[GuidelineRule],
    result_path: Path,
    final: bool = True,
) -> tuple[list[str], dict[str, Any]]:
    """按正式规范校验结果，并返回动态派生的数据。"""
    errors: list[str] = []
    if not isinstance(payload, dict):
        return ["top-level result must be a mapping"], {}
    _require_exact_keys(
        payload,
        {"phase", "target", "review", "rules", "failures", "optimization"},
        "$",
        errors,
    )
    phase = payload.get("phase")
    if phase not in {"review", "optimize"}:
        errors.append("phase must be review or optimize")

    target = payload.get("target")
    _validate_target(target, result_path, errors)

    rule_entries = payload.get("rules")
    failures = payload.get("failures")
    if not isinstance(rule_entries, list):
        errors.append("rules must be a list")
        rule_entries = []
    if not isinstance(failures, list):
        errors.append("failures must be a list")
        failures = []

    all_rules = {rule.rule_id: rule for rule in guideline_rules}
    expected = {rule.rule_id: rule for rule in reviewable_rules(guideline_rules)}
    actual: dict[str, dict[str, Any]] = {}
    for index, entry in enumerate(rule_entries):
        entry_path = f"rules[{index}]"
        if not isinstance(entry, dict):
            errors.append(f"{entry_path} must be a mapping")
            continue
        _require_exact_keys(
            entry,
            {"id", "status", "assessment", "evidence"},
            entry_path,
            errors,
        )
        rule_id = entry.get("id")
        if not isinstance(rule_id, str) or not rule_id.strip():
            errors.append(f"{entry_path}.id must be a non-empty string")
            continue
        if rule_id in actual:
            errors.append(f"duplicate rule entry: {rule_id}")
            continue
        actual[rule_id] = entry
        if rule_id not in expected:
            if rule_id in all_rules:
                errors.append(f"rule entry is excluded from default Skill review: {rule_id}")
            else:
                errors.append(f"unknown rule entry: {rule_id}")
            continue
        _validate_rule_entry(entry, entry_path, final, errors)

    failure_map = _validate_failures(failures, expected, errors)
    _validate_rule_failure_links(actual, failure_map, errors)
    summary = _rule_summary(rule_entries)
    _validate_review(payload.get("review"), final, errors)
    _validate_optimization(payload.get("optimization"), phase, failure_map, target, final, errors)
    earned, available, percentage = _calculate_score(rule_entries, expected)
    return errors, {
        "summary": summary,
        "rule_count": len(actual),
        "overall": _overall_result(payload) if not errors else None,
        "score": {
            "earned": earned,
            "available": available,
            "percentage": round(percentage, 2) if percentage is not None else None,
        },
    }

def _require_exact_keys(value: dict[str, Any], expected: set[str], path: str, errors: list[str]) -> None:
    missing = sorted(expected - set(value))
    extra = sorted(set(value) - expected)
    if missing:
        errors.append(f"{path} missing fields: {', '.join(missing)}")
    if extra:
        errors.append(f"{path} contains unsupported fields: {', '.join(extra)}")


def _validate_target(target: Any, result_path: Path, errors: list[str]) -> None:
    """校验目标路径，并确保结果文件不写入目标 Skill。"""
    if not isinstance(target, str) or not target.strip():
        errors.append("target must be a non-empty string")
        return
    try:
        target_root = Path(target).resolve()
        if not target_root.is_dir() or not (target_root / "SKILL.md").is_file():
            errors.append("target must be a directory containing SKILL.md")
        if _is_within(result_path.resolve(), target_root):
            errors.append("review result must be stored outside the target Skill")
    except OSError:
        errors.append("target cannot be resolved")

def _validate_rule_entry(entry: dict[str, Any], path: str, final: bool, errors: list[str]) -> None:
    status = entry.get("status")
    if status not in RULE_WORKING_STATUSES:
        errors.append(f"{path}.status is invalid")
    if final and status == "pending":
        errors.append(f"{path}.status cannot be pending in a completed result")
    assessment = entry.get("assessment")
    if not isinstance(assessment, str):
        errors.append(f"{path}.assessment must be a string")
        assessment = ""
    evidence = entry.get("evidence")
    if not isinstance(evidence, list):
        errors.append(f"{path}.evidence must be a list")
        evidence = []
    for evidence_index, item in enumerate(evidence):
        item_path = f"{path}.evidence[{evidence_index}]"
        if not isinstance(item, dict):
            errors.append(f"{item_path} must be a mapping")
            continue
        _require_exact_keys(item, {"location", "observation"}, item_path, errors)
        for field in ("location", "observation"):
            if not isinstance(item.get(field), str) or not item.get(field, "").strip():
                errors.append(f"{item_path}.{field} must be a non-empty string")
    if status in {"pass", "fail"} and not evidence:
        errors.append(f"{path} requires evidence for status {status}")
    if status in RULE_FINAL_STATUSES and not assessment.strip():
        errors.append(f"{path}.assessment is required for status {status}")


def _validate_failures(
    failures: list[Any], expected_rules: dict[str, GuidelineRule], errors: list[str]
) -> dict[str, dict[str, Any]]:
    result: dict[str, dict[str, Any]] = {}
    numbers: dict[str, set[int]] = {"Fail": set(), "Suggest": set()}
    base_fields = {
        "id", "rule_ids", "severity", "location", "evidence", "problem", "impact",
        "recommendation", "suggested_change",
    }
    for index, failure in enumerate(failures):
        path = f"failures[{index}]"
        if not isinstance(failure, dict):
            errors.append(f"{path} must be a mapping")
            continue
        allowed = base_fields | {"resolution"}
        missing = sorted(base_fields - set(failure))
        extra = sorted(set(failure) - allowed)
        if missing:
            errors.append(f"{path} missing fields: {', '.join(missing)}")
        if extra:
            errors.append(f"{path} contains unsupported fields: {', '.join(extra)}")
        failure_id = failure.get("id")
        id_match = ISSUE_ID.fullmatch(failure_id) if isinstance(failure_id, str) else None
        if not id_match:
            errors.append(f"{path}.id must match Fail-NNN or Suggest-NNN")
            continue
        if failure_id in result:
            errors.append(f"duplicate failure id: {failure_id}")
            continue
        result[failure_id] = failure
        numbers[id_match.group(1)].add(int(id_match.group(2)))
        rule_ids = failure.get("rule_ids")
        _validate_string_list(rule_ids, f"{path}.rule_ids", errors, non_empty=True)
        if isinstance(rule_ids, list):
            for rule_id in rule_ids:
                if rule_id not in expected_rules:
                    errors.append(f"{path}.rule_ids contains unknown rule {rule_id}")
            levels = {
                expected_rules[rule_id].level
                for rule_id in rule_ids
                if rule_id in expected_rules
            }
            if len(levels) > 1:
                errors.append(f"{path} cannot combine required and suggested rules")
        if failure.get("severity") not in {"high", "medium", "low"}:
            errors.append(f"{path}.severity is invalid")
        for field in ("location", "evidence", "problem", "impact", "recommendation"):
            if not isinstance(failure.get(field), str) or not failure.get(field, "").strip():
                errors.append(f"{path}.{field} must be a non-empty string")
        _validate_string_list(
            failure.get("suggested_change"),
            f"{path}.suggested_change",
            errors,
        )
        _validate_suggested_change(
            failure.get("suggested_change"),
            f"{path}.suggested_change",
            errors,
        )
        if "resolution" in failure:
            _validate_resolution(failure["resolution"], path, errors)
    for kind, actual_numbers in numbers.items():
        expected_numbers = set(range(1, len(actual_numbers) + 1))
        if actual_numbers != expected_numbers:
            errors.append(f"{kind}-NNN identifiers must be continuous from 001")
    return result


def _validate_resolution(
    resolution: Any, path: str, errors: list[str]
) -> None:
    resolution_path = f"{path}.resolution"
    if not isinstance(resolution, dict):
        errors.append(f"{resolution_path} must be a mapping")
        return
    _require_exact_keys(
        resolution,
        {"status", "changed_files", "verification_results", "residual_risk", "reason"},
        resolution_path,
        errors,
    )
    status = resolution.get("status")
    if status not in RESOLUTION_STATUSES:
        errors.append(f"{resolution_path}.status is invalid")
    changed_files = resolution.get("changed_files")
    _validate_string_list(changed_files, f"{resolution_path}.changed_files", errors)
    results = resolution.get("verification_results")
    if not isinstance(results, list):
        errors.append(f"{resolution_path}.verification_results must be a list")
        results = []
    for index, item in enumerate(results):
        item_path = f"{resolution_path}.verification_results[{index}]"
        if not isinstance(item, dict):
            errors.append(f"{item_path} must be a mapping")
            continue
        _require_exact_keys(item, {"check", "result", "detail"}, item_path, errors)
        if item.get("result") not in {"passed", "failed", "not-run"}:
            errors.append(f"{item_path}.result is invalid")
        for field in ("check", "detail"):
            if not isinstance(item.get(field), str) or not item.get(field, "").strip():
                errors.append(f"{item_path}.{field} must be a non-empty string")
    for field in ("residual_risk", "reason"):
        if not isinstance(resolution.get(field), str):
            errors.append(f"{resolution_path}.{field} must be a string")
    if status == "fixed":
        if not changed_files:
            errors.append(f"{resolution_path}.changed_files is required for fixed")
        if not results or any(item.get("result") != "passed" for item in results if isinstance(item, dict)):
            errors.append(f"{resolution_path} requires passed verification for fixed")
    if status == "failed":
        if not results:
            errors.append(f"{resolution_path}.verification_results is required for failed")
        if not str(resolution.get("residual_risk", "")).strip():
            errors.append(f"{resolution_path}.residual_risk is required for failed")
        if not str(resolution.get("reason", "")).strip():
            errors.append(f"{resolution_path}.reason is required for failed")
    if status in {"rejected", "blocked"}:
        if status == "rejected" and changed_files:
            errors.append(f"{resolution_path}.changed_files must be empty for {status}")
        if not str(resolution.get("reason", "")).strip():
            errors.append(f"{resolution_path}.reason is required for {status}")
    for changed_file in changed_files if isinstance(changed_files, list) else []:
        if Path(changed_file).is_absolute() or ".." in Path(changed_file).parts:
            errors.append(f"{resolution_path}.changed_files must use target-relative paths")


def _validate_rule_failure_links(
    rules: dict[str, dict[str, Any]],
    failures: dict[str, dict[str, Any]],
    errors: list[str],
) -> None:
    failure_rule_ids: set[str] = set()
    for failure_id, failure in failures.items():
        for rule_id in failure.get("rule_ids") or []:
            rule = rules.get(rule_id)
            failure_rule_ids.add(rule_id)
            if rule is None:
                errors.append(f"{failure_id} references excluded rule {rule_id}")
            elif rule.get("status") != "fail":
                errors.append(f"{failure_id} references rule {rule_id} whose status is not fail")

    for rule_id, rule in rules.items():
        status = rule.get("status")
        if status == "fail" and rule_id not in failure_rule_ids:
            errors.append(f"{rule_id} has status fail but no failure item references it")
        if status != "fail" and rule_id in failure_rule_ids:
            errors.append(f"{rule_id} is referenced by a failure item but status is not fail")


def _validate_review(review: Any, final: bool, errors: list[str]) -> None:
    """校验审查生命周期；汇总信息由规则状态动态计算。"""
    if not isinstance(review, dict):
        errors.append("review must be a mapping")
        return
    _require_exact_keys(review, {"status", "blocking_reason"}, "review", errors)
    if review.get("status") not in {"in-progress", "completed", "blocked"}:
        errors.append("review.status is invalid")
    if final and review.get("status") != "completed":
        errors.append("review.status must be completed for final validation")
    if not isinstance(review.get("blocking_reason"), str):
        errors.append("review.blocking_reason must be a string")

def _validate_optimization(
    optimization: Any,
    phase: Any,
    failures: dict[str, dict[str, Any]],
    target: Any,
    final: bool,
    errors: list[str],
) -> None:
    if not isinstance(optimization, dict):
        errors.append("optimization must be a mapping")
        return
    _require_exact_keys(
        optimization,
        {"status", "requested_failure_ids", "blocking_reason"},
        "optimization",
        errors,
    )
    status = optimization.get("status")
    if status not in {"not-started", "awaiting-confirmation", "in-progress", "completed", "blocked"}:
        errors.append("optimization.status is invalid")
    requested = optimization.get("requested_failure_ids")
    _validate_string_list(requested, "optimization.requested_failure_ids", errors)
    for index, failure_id in enumerate(requested if isinstance(requested, list) else []):
        if not isinstance(failure_id, str) or not ISSUE_ID.fullmatch(failure_id):
            errors.append(f"optimization.requested_failure_ids[{index}] has invalid failure id")
    if not isinstance(optimization.get("blocking_reason"), str):
        errors.append("optimization.blocking_reason must be a string")
    if phase == "review" and final:
        if failures:
            if status != "awaiting-confirmation":
                errors.append("a completed review with failures must await confirmation")
        elif status != "not-started":
            errors.append("optimization.status must be not-started when review has no failures")
        if requested:
            errors.append("review mode must not preselect requested_failure_ids")
    if phase == "optimize" and final:
        if status != "completed":
            errors.append("optimization.status must be completed for final optimize validation")
        if not requested:
            errors.append("optimization.requested_failure_ids must not be empty")
        for failure_id in requested if isinstance(requested, list) else []:
            failure = failures.get(failure_id)
            if not failure:
                errors.append(f"optimization requests missing failure {failure_id}")
            elif "resolution" not in failure:
                errors.append(f"optimization failure {failure_id} has no resolution")
    target_root = Path(target) if isinstance(target, str) and target.strip() else None
    if target_root:
        for failure_id in requested if isinstance(requested, list) else []:
            failure = failures.get(failure_id)
            if not failure or not isinstance(failure.get("resolution"), dict):
                continue
            changed_files = failure["resolution"].get("changed_files")
            for relative in changed_files if isinstance(changed_files, list) else []:
                candidate = (target_root / relative).resolve()
                if not _is_within(candidate, target_root.resolve()):
                    errors.append(f"{failure_id} changed file escapes the target Skill: {relative}")


def _validate_string_list(
    value: Any, path: str, errors: list[str], non_empty: bool = False
) -> None:
    if not isinstance(value, list):
        errors.append(f"{path} must be a list")
        return
    if non_empty and not value:
        errors.append(f"{path} must not be empty")
    for index, item in enumerate(value):
        if not isinstance(item, str) or not item.strip():
            errors.append(f"{path}[{index}] must be a non-empty string")


def _validate_suggested_change(value: Any, path: str, errors: list[str]) -> None:
    """校验建议修改块的路径、行号、修改行和上下文结构。"""
    if not isinstance(value, list) or not value:
        return
    if any(not isinstance(item, str) or not item.strip() for item in value):
        return

    headers = [index for index, line in enumerate(value) if line.startswith("@@")]
    if not headers or headers[0] != 0:
        errors.append(f"{path} must start with @@ <relative-path>:<line>")
        return

    for hunk_index, start in enumerate(headers):
        header_path = f"{path}[{start}]"
        match = SUGGESTED_CHANGE_HUNK.fullmatch(value[start])
        if not match:
            errors.append(f"{header_path} must match @@ <relative-path>:<line>")
        else:
            relative = match.group(1)
            parts = relative.split("/")
            if (
                "\\" in relative
                or relative.startswith("/")
                or any(part in {"", ".", ".."} for part in parts)
            ):
                errors.append(f"{header_path} must use a safe target-relative path")

        end = headers[hunk_index + 1] if hunk_index + 1 < len(headers) else len(value)
        body = value[start + 1 : end]
        if not body:
            errors.append(f"{header_path} must contain at least one change line")
            continue
        invalid = [line for line in body if not line.startswith((" ", "+", "-"))]
        if invalid:
            errors.append(f"{header_path} contains a line without diff prefix")
        change_indexes = [
            index for index, line in enumerate(body) if line.startswith(("+", "-"))
        ]
        if not change_indexes:
            errors.append(f"{header_path} must contain at least one + or - line")
            continue
        first_change = change_indexes[0]
        last_change = change_indexes[-1]
        if any(line.startswith(" ") for line in body[first_change : last_change + 1]):
            errors.append(f"{header_path} must contain one contiguous change block")


def _rule_summary(entries: list[Any]) -> dict[str, int]:
    counts = Counter(
        entry.get("status", "invalid") if isinstance(entry, dict) else "invalid"
        for entry in entries
    )
    ordered = {
        status: counts[status]
        for status in ("pass", "fail", "pending", "invalid")
        if counts[status]
    }
    ordered["total"] = len(entries)
    return ordered


def _calculate_score(
    entries: list[Any], definitions: dict[str, GuidelineRule]
) -> tuple[int, int, float | None]:
    """使用当前规范中的规则级别计算分数。"""
    earned = 0
    available = 0
    for entry in entries:
        if not isinstance(entry, dict):
            continue
        definition = definitions.get(entry.get("id"))
        if definition is None:
            continue
        weight = RULE_WEIGHTS[definition.level]
        available += weight
        if entry.get("status") == "pass":
            earned += weight
    score = earned / available * 100 if available else None
    return earned, available, score

def _overall_result(payload: dict[str, Any]) -> str | None:
    """Only a completed review can receive an overall conclusion."""
    if payload.get("review", {}).get("status") != "completed":
        return None
    if any(
        isinstance(item, dict) and str(item.get("id", "")).startswith("Fail-")
        for item in payload.get("failures", [])
    ):
        return "fail"
    return "pass"


def render_review_report(
    payload: dict[str, Any], guideline_rules: list[GuidelineRule]
) -> str:
    target = payload.get("target", "")
    review = payload.get("review", {})
    rules = payload.get("rules", [])
    failures = payload.get("failures", [])
    definitions = {rule.rule_id: rule for rule in guideline_rules}
    skill_name = Path(target).name if isinstance(target, str) and target else "Unknown Skill"
    lines = [
        f"# {skill_name} 审查报告",
        "",
        f"- 目标：`{target}`",
        f"- 正式规范：[{CANONICAL_STANDARD.as_posix()}]({CANONICAL_STANDARD_URL})",
        f"- 状态：{_review_status_text(review)}",
        "",
        "## 汇总",
        "",
    ]
    summary = _rule_summary(rules)
    earned, available, score = _calculate_score(rules, definitions)
    if score is None:
        lines.append("原审查评分：不计分（没有适用规则）")
    else:
        lines.append(
            f"原审查评分：{score:.2f} %（ 加权得分 = {earned} / {available} ）"
        )
        lines.append("")
    overall = _overall_result(payload)
    if overall is not None:
        lines.extend(["", f"原审查结论：{'不通过' if overall == 'fail' else '通过'}", ""])
    lines.append(
        "，".join(f"{_label(RULE_STATUS_LABELS, key)}={value}" for key, value in summary.items())
        if isinstance(summary, dict) else "结果汇总不可用"
    )
    if review.get("blocking_reason"):
        lines.extend(["", f"阻塞原因：{review['blocking_reason']}"])

    required_failures = [
        item for item in failures
        if isinstance(item, dict) and str(item.get("id", "")).startswith("Fail-")
    ]
    suggested_failures = [
        item for item in failures
        if isinstance(item, dict) and str(item.get("id", "")).startswith("Suggest-")
    ]
    issue_sections = (
        ("必须整改", required_failures, "整改意见"),
        ("建议改进", suggested_failures, "改进建议"),
    )
    if not failures:
        lines.extend(["", "## 审查问题", "", "没有需要整改或建议改进的问题。", ""])
    for section_title, section_items, recommendation_label in issue_sections:
        if not section_items:
            continue
        lines.extend(["", f"## {section_title}", ""])
        for failure in section_items:
            problem_summary = "；".join(
                str(failure.get(field, "")).strip().rstrip("。.!！；;")
                for field in ("evidence", "problem", "impact")
                if str(failure.get(field, "")).strip()
            )
            lines.extend([
                f"### {failure.get('id', '')}｜{_label(SEVERITY_LABELS, failure.get('severity', ''))}｜{' '.join(str(failure.get('problem', '')).split()).rstrip('。.!！')}",
                "",
                f"- 规则 ID：{', '.join(failure.get('rule_ids', []))}",
                f"- 文件路径：`{failure.get('location', '')}`",
                f"- 问题说明：{problem_summary}。",
                f"- {recommendation_label}：{failure.get('recommendation', '')}",
            ])
            suggested_change = failure.get("suggested_change", [])
            if suggested_change:
                lines.extend([
                    "",
                    "- 建议修改为：",
                    "",
                    "```diff",
                    *suggested_change,
                    "```",
                ])
            resolution = failure.get("resolution")
            if isinstance(resolution, dict):
                lines.extend([
                    "",
                    f"优化结果：{_label(RESOLUTION_LABELS, resolution.get('status', ''))}",
                    "",
                    f"- 修改文件：{', '.join(resolution.get('changed_files', [])) or '无'}",
                    f"- 剩余风险：{resolution.get('residual_risk', '') or '无'}",
                    f"- 说明：{resolution.get('reason', '') or '无'}",
                ])
                for item in resolution.get("verification_results", []):
                    if isinstance(item, dict):
                        lines.append(
                            f"- 验证{_label(VERIFICATION_LABELS, item.get('result', ''))}：{item.get('check', '')}；{item.get('detail', '')}"
                        )
            lines.append("")

    lines.extend([
        "## 逐规则判定",
        "",
        "| 规则 ID | 规则级别 | 状态 | 判定 | 证据位置 | 问题编号 |",
        "| --- | --- | --- | --- | --- | --- |",
    ])
    for rule in rules:
        if not isinstance(rule, dict):
            continue
        definition = definitions.get(rule.get("id"))
        evidence_locations = "; ".join(
            item.get("location", "") for item in rule.get("evidence", [])
            if isinstance(item, dict)
        )
        item_ids = [
            item.get("id", "") for item in failures
            if isinstance(item, dict) and rule.get("id") in (item.get("rule_ids") or [])
        ]
        lines.append(
            "| " + " | ".join(
                _table_cell(value) for value in (
                    rule.get("id", ""),
                    _label(LEVEL_LABELS, definition.level if definition else ""),
                    ", ".join(item_ids) if rule.get("status") == "fail" else rule.get("status", ""),
                    rule.get("assessment", ""),
                    evidence_locations,
                    ", ".join(item_ids),
                )
            ) + " |"
        )
    lines.append("")

    optimization = payload.get("optimization", {})
    if (
        payload.get("phase") == "review"
        and failures
        and optimization.get("status") == "awaiting-confirmation"
    ):
        lines.extend([
            "## 后续优化",
            "",
            "审查已完成。请用户明确选择要处理的 `Fail-*` 或 `Suggest-*` 编号，或暂不优化。",
            "",
        ])
    if payload.get("phase") == "optimize":
        lines.extend([
            "## 优化阶段",
            "",
            f"- 状态：{_label(OPTIMIZATION_STATUS_LABELS, optimization.get('status', ''))}",
            f"- 授权问题项：{', '.join(optimization.get('requested_failure_ids', [])) or '无'}",
            f"- 阻塞原因：{optimization.get('blocking_reason', '') or '无'}",
            "",
        ])
    return "\n".join(lines).rstrip() + "\n"


RULE_STATUS_LABELS = {
    "pass": "通过", "fail": "问题规则",
    "pending": "待判定", "invalid": "无效", "total": "总计",
}
LEVEL_LABELS = {"required": "要求", "suggested": "建议"}
SEVERITY_LABELS = {"high": "高风险", "medium": "中风险", "low": "低风险"}
RESOLUTION_LABELS = {"fixed": "已修复", "failed": "失败", "rejected": "已驳回", "blocked": "已阻塞"}
VERIFICATION_LABELS = {"passed": "通过", "failed": "失败", "not-run": "未运行"}
OPTIMIZATION_STATUS_LABELS = {
    "not-started": "未开始", "awaiting-confirmation": "等待确认", "in-progress": "进行中",
    "completed": "已完成", "blocked": "已阻塞",
}


def _review_status_text(review: dict[str, Any]) -> str:
    status = review.get("status")
    if status == "completed":
        return "审查已完成"
    if status == "blocked":
        return "审查受阻，尚未完成"
    return "审查进行中"


def _label(labels: dict[str, str], value: Any) -> str:
    return labels.get(str(value), str(value))


def _table_cell(value: Any) -> str:
    return str(value).replace("|", "\\|").replace("\r", " ").replace("\n", " ")


def _is_within(path: Path, root: Path) -> bool:
    try:
        path.relative_to(root)
        return True
    except ValueError:
        return False


def atomic_write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(path.name + ".tmp")
    temporary.write_text(text, encoding="utf-8", newline="\n")
    temporary.replace(path)
