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
"""Select, run, measure, and report Runtime LLT for changed code."""

from __future__ import annotations

import argparse
import contextlib
import datetime as dt
import fnmatch
import json
import logging
import os
import re
import shlex
import shutil
import subprocess
import sys
import time
import xml.etree.ElementTree as ET
from collections.abc import Iterator
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable

import collect_llt_scope as scope


CODE_SUFFIXES = {
    ".c",
    ".cc",
    ".cpp",
    ".cxx",
    ".h",
    ".hh",
    ".hpp",
    ".hxx",
    ".inc",
    ".inl",
}

RUNTIME_LLT_ROOTS = (
    "include/",
    "src/runtime/",
    "tests/ut/runtime/",
)

NON_LLT_ROOTS = (
    ".arts/",
    ".claude/",
    ".codex/",
    ".git/",
    ".opencode/",
    "cmake/",
    "doc/",
    "docs/",
    "example/",
    "examples/",
)

TEST_RE = scope.TEST_RE
INCLUDE_RE = re.compile(r"^\s*#\s*include\s*[<\"]([^>\"]+)[>\"]", re.MULTILINE)
HUNK_RE = re.compile(r"@@\s+-\d+(?:,\d+)?\s+\+(\d+)(?:,(\d+))?")

LOCAL_DEFAULT_BUILD_TARGETS = (
    "runtime_utest",
    "runtime_utest_api",
    "runtime_utest_api_ext_others",
    "runtime_utest_api_others",
    "runtime_utest_dfx",
    "runtime_utest_engine",
    "runtime_utest_dc",
)

LOW_SIGNAL_TEST_SYMBOLS = {
    "args",
    "argsSize",
    "buffer",
    "can",
    "cce",
    "char_t",
    "endif",
    "eventId",
    "extern",
    "file",
    "free",
    "full",
    "handle",
    "int32_t",
    "int64_t",
    "kernel",
    "normal",
    "not",
    "num",
    "only",
    "program",
    "runtime",
    "size_t",
    "timeout",
    "uint8_t",
    "uint16_t",
    "vector",
    "with",
}

HIGH_SIGNAL_TEST_SYMBOLS = {
    "GetValidatedObjectImpl",
    "InitEmbeddedInnerHandle",
    "ParaDetail",
    "ResetEmbeddedInnerHandle",
    "RtArgsHandle",
    "ValidateArgsHandleForApi",
    "ValidateLaunchArgsHandleForApi",
    "rtInnerObject",
    "rtLaunchArgs_t",
    "runtime_handle_guard",
}

LOGGER = logging.getLogger(__name__)
GIT_EXECUTABLE = shutil.which("git") or "/usr/bin/git"


@dataclass
class CommandResult:
    name: str
    command: list[str]
    returncode: int
    elapsed_seconds: float
    timed_out: bool = False
    stdout: str = ""
    stderr: str = ""

    def to_json(self) -> dict[str, object]:
        return {
            "name": self.name,
            "command": shlex.join(self.command),
            "returncode": self.returncode,
            "elapsed_seconds": round(self.elapsed_seconds, 3),
            "timed_out": self.timed_out,
            "stdout_tail": tail(self.stdout),
            "stderr_tail": tail(self.stderr),
        }


@dataclass
class TestRun:
    executable: str
    xml: str
    result: CommandResult
    tests: int = 0
    executed_tests: list[str] = field(default_factory=list)
    failures: list[str] = field(default_factory=list)
    skipped: int = 0
    reruns: list[CommandResult] = field(default_factory=list)

    def to_json(self) -> dict[str, object]:
        return {
            "executable": self.executable,
            "xml": self.xml,
            "tests": self.tests,
            "executed_tests": self.executed_tests,
            "failures": self.failures,
            "skipped": self.skipped,
            "result": self.result.to_json(),
            "reruns": [item.to_json() for item in self.reruns],
        }


@dataclass
class AvailableGtestFilterContext:
    repo: Path
    args: argparse.Namespace
    build_targets: list[str]
    scope_data: dict[str, object]
    out_dir: Path


@dataclass
class RerunContext:
    repo: Path
    args: argparse.Namespace
    executable: Path
    env: dict[str, str]


@dataclass
class ReportContext:
    repo: Path
    out_dir: Path
    conclusion: str
    conclusion_reason: str
    scope_data: dict[str, object]
    build_results: list[CommandResult]
    executables: list[str]
    runs: list[TestRun]
    test_summary: dict[str, object] | None
    coverage: dict[str, object] | None
    coverage_commands: list[CommandResult]


def tail(text: str, limit: int = 4000) -> str:
    if len(text) <= limit:
        return text
    return text[-limit:]


def compact_text(text: object, limit: int = 1200) -> str:
    value = str(text)
    if len(value) <= limit:
        return value
    return value[:limit] + f"... <truncated {len(value) - limit} chars>"


@contextlib.contextmanager
def pushd(path: Path) -> Iterator[None]:
    old = Path.cwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(old)


def run_command(
    name: str,
    command: list[str],
    cwd: Path,
    timeout: int | None = None,
    env: dict[str, str] | None = None,
) -> CommandResult:
    started = time.monotonic()
    try:
        proc = subprocess.run(
            command,
            cwd=str(cwd),
            env=env,
            text=True,
            capture_output=True,
            timeout=timeout,
            check=False,
        )
        return CommandResult(
            name=name,
            command=command,
            returncode=proc.returncode,
            elapsed_seconds=time.monotonic() - started,
            stdout=proc.stdout,
            stderr=proc.stderr,
        )
    except subprocess.TimeoutExpired as exc:
        stdout = exc.stdout or ""
        stderr = exc.stderr or ""
        return CommandResult(
            name=name,
            command=command,
            returncode=124,
            elapsed_seconds=time.monotonic() - started,
            timed_out=True,
            stdout=stdout if isinstance(stdout, str) else stdout.decode(errors="ignore"),
            stderr=stderr if isinstance(stderr, str) else stderr.decode(errors="ignore"),
        )


def git(repo: Path, args: list[str], check: bool = True) -> str:
    proc = subprocess.run(
        [GIT_EXECUTABLE, *args],
        cwd=str(repo),
        text=True,
        capture_output=True,
        check=False,
    )
    if check and proc.returncode != 0:
        raise RuntimeError(proc.stderr.strip() or f"git {' '.join(args)} failed")
    return proc.stdout


def rel(path: str | Path, repo: Path) -> str:
    try:
        return str(Path(path).resolve().relative_to(repo))
    except (OSError, ValueError):
        return str(path)


def default_base(repo: Path) -> str:
    with pushd(repo):
        return scope.default_base()


def detect_scope(
    repo: Path,
    base: str,
    test_root: str,
    max_symbols: int,
    include_worktree: bool,
) -> dict[str, object]:
    with pushd(repo):
        files = scope.changed_files(base, include_worktree)
        relevant_files = [path for path in files if is_llt_relevant(path)]
        symbol_files = [path for path in relevant_files if not is_test_path(path)]
        primary_symbols, added_lines = scope.collect_diff_material(
            base, symbol_files or relevant_files, include_worktree
        )
        symbols = scope.symbols_from(primary_symbols, added_lines, symbol_files or relevant_files, max_symbols)

    changed_lines, deleted_lines = collect_changed_line_sets(repo, base, relevant_files, include_worktree)
    tests = collect_candidate_tests(repo, Path(test_root), relevant_files, symbols) if relevant_files else []
    exact_filter = ":".join(test["name"] for test in tests)

    return {
        "base": base,
        "head": git(repo, ["rev-parse", "HEAD"]).strip(),
        "branch": git(repo, ["branch", "--show-current"], check=False).strip(),
        "include_worktree": include_worktree,
        "worktree_status": git(repo, ["status", "--short"], check=False).splitlines(),
        "changed_files": files,
        "llt_relevant_files": relevant_files,
        "changed_lines": {path: sorted(lines) for path, lines in changed_lines.items()},
        "deleted_changed_lines": {path: sorted(lines) for path, lines in deleted_lines.items()},
        "primary_symbols": primary_symbols,
        "symbols": symbols,
        "test_root": test_root,
        "tests": tests,
        "exact_gtest_filter": exact_filter,
    }


def is_llt_relevant(path: str) -> bool:
    normalized = path.replace("\\", "/")
    if normalized.startswith(NON_LLT_ROOTS):
        return False
    if Path(path).suffix not in CODE_SUFFIXES:
        return False
    return normalized.startswith(RUNTIME_LLT_ROOTS)


def is_test_path(path: str) -> bool:
    normalized = path.replace("\\", "/")
    return normalized.startswith("tests/") or "/test/" in normalized or "/testcase/" in normalized


def collect_changed_line_sets(
    repo: Path,
    base: str,
    files: Iterable[str],
    include_worktree: bool,
) -> tuple[dict[str, set[int]], dict[str, set[int]]]:
    added: dict[str, set[int]] = {path: set() for path in files}
    deleted: dict[str, set[int]] = {path: set() for path in files}
    for path in files:
        diff_texts: list[str] = []
        for rev in (f"{base}...HEAD", f"{base}..HEAD"):
            out = git(repo, ["diff", "-U0", rev, "--", path], check=False)
            if out:
                diff_texts.append(out)
                break
        if include_worktree:
            for args in (
                ["diff", "-U0", "--", path],
                ["diff", "--cached", "-U0", "--", path],
            ):
                out = git(repo, args, check=False)
                if out:
                    diff_texts.append(out)

        if not diff_texts and include_worktree and (repo / path).is_file():
            try:
                line_count = len((repo / path).read_text(errors="ignore").splitlines())
            except OSError:
                line_count = 0
            added[path].update(range(1, line_count + 1))
            continue

        for text in diff_texts:
            add_lines, del_lines = parse_changed_lines(text)
            added[path].update(add_lines)
            deleted[path].update(del_lines)
    return (
        {path: lines for path, lines in added.items() if lines},
        {path: lines for path, lines in deleted.items() if lines},
    )


def parse_added_lines(diff_text: str) -> set[int]:
    return parse_changed_lines(diff_text)[0]


def parse_changed_lines(diff_text: str) -> tuple[set[int], set[int]]:
    added: set[int] = set()
    deleted: set[int] = set()
    old_line: int | None = None
    new_line: int | None = None
    for line in diff_text.splitlines():
        match = HUNK_RE.match(line)
        if match:
            old_match = re.match(r"@@\s+-(\d+)", line)
            old_line = int(old_match.group(1)) if old_match else None
            new_line = int(match.group(1))
            continue
        if old_line is None or new_line is None:
            continue
        if line.startswith("+") and not line.startswith("+++"):
            added.add(new_line)
            new_line += 1
        elif line.startswith("-") and not line.startswith("---"):
            deleted.add(old_line)
            old_line += 1
        elif line.startswith("\\"):
            continue
        else:
            old_line += 1
            new_line += 1
    return added, deleted


def collect_candidate_tests(
    repo: Path,
    test_root: Path,
    changed_files: list[str],
    symbols: list[str],
    history_map: dict[str, object] | None = None,
) -> list[dict[str, object]]:
    root = repo / test_root
    tests: dict[str, dict[str, object]] = {}
    if not root.exists():
        return tests_from_history(changed_files, symbols, history_map)

    symbol_patterns = {
        symbol: re.compile(rf"\b{re.escape(symbol)}\b") for symbol in symbols
    }
    stems = changed_file_stems(changed_files)
    basenames = {Path(path).name for path in changed_files if is_llt_relevant(path)}

    for path in sorted(root.rglob("*")):
        if path.suffix not in {".cc", ".cpp", ".cxx"}:
            continue
        try:
            text = path.read_text(errors="ignore")
        except OSError:
            continue

        matches = list(TEST_RE.finditer(text))
        if not matches:
            continue
        starts = scope.line_starts(text)
        include_hits = include_reasons(text, basenames, stems)
        path_hits = path_reasons(path, stems)

        for index, match in enumerate(matches):
            begin = match.start()
            end = matches[index + 1].start() if index + 1 < len(matches) else len(text)
            body = text[begin:end]
            suite, case = match.group(1), match.group(2)
            name = f"{suite}.{case}"

            direct_reasons: list[str] = []
            hit_symbols = [
                symbol
                for symbol, pattern in symbol_patterns.items()
                if pattern.search(body)
            ]
            if hit_symbols:
                hit_symbols = sorted(
                    hit_symbols,
                    key=lambda symbol: (-test_symbol_weight(symbol), symbol),
                )
                direct_reasons.append("symbol:" + ",".join(hit_symbols[:8]))
            body_stems = sorted(
                stem for stem in stems if re.search(rf"\b{re.escape(stem)}\b", body)
            )
            if body_stems:
                direct_reasons.append("body-stem:" + ",".join(body_stems[:8]))
            if path_hits:
                direct_reasons.extend(path_hits)
            if str(path.relative_to(repo)).replace("\\", "/") in changed_files:
                direct_reasons.append("modified-test-file")
            if not direct_reasons:
                continue
            reasons = direct_reasons + include_hits

            merge_test(
                tests,
                {
                    "name": name,
                    "file": str(path.relative_to(repo)),
                    "line": scope.byte_to_line(starts, match.start()),
                    "symbols": hit_symbols[:20],
                    "reasons": reasons,
                },
            )

    for item in tests_from_history(changed_files, symbols, history_map):
        merge_test(tests, item)
    return sorted(
        tests.values(),
        key=lambda item: (-int(item["score"]), str(item["name"])),
    )


def changed_file_stems(changed_files: list[str]) -> set[str]:
    stems: set[str] = set()
    for path in changed_files:
        stem = Path(path).stem
        if len(stem) < 4 or not is_llt_relevant(path):
            continue
        if scope.is_low_signal(stem):
            continue
        stems.add(stem)
    return stems


def include_reasons(text: str, basenames: set[str], stems: set[str]) -> list[str]:
    includes = INCLUDE_RE.findall(text)
    reasons: list[str] = []
    for include in includes:
        include_name = Path(include).name
        include_stem = Path(include).stem
        if include_name in basenames:
            reasons.append(f"include:{include_name}")
        elif include_stem in stems:
            reasons.append(f"include-stem:{include_stem}")
    return sorted(set(reasons))


def path_reasons(path: Path, stems: set[str]) -> list[str]:
    normalized = str(path).replace("\\", "/").lower()
    return [f"path-stem:{stem}" for stem in sorted(stems) if stem.lower() in normalized]


def merge_test(tests: dict[str, dict[str, object]], item: dict[str, object]) -> None:
    name = str(item["name"])
    existing = tests.get(name)
    reasons = sorted(set(str(reason) for reason in item.get("reasons", [])))
    symbols = sorted(set(str(symbol) for symbol in item.get("symbols", [])))
    score = score_reasons(reasons)
    if existing is None:
        payload = dict(item)
        payload["reasons"] = reasons
        payload["symbols"] = symbols
        payload["score"] = score
        tests[name] = payload
        return
    existing["reasons"] = sorted(set(existing.get("reasons", [])) | set(reasons))
    existing["symbols"] = sorted(set(existing.get("symbols", [])) | set(symbols))
    existing["score"] = int(existing.get("score", 0)) + score
    if test_location_score(str(item.get("file", ""))) < test_location_score(str(existing.get("file", ""))):
        existing["file"] = item.get("file", existing.get("file", ""))
        existing["line"] = item.get("line", existing.get("line", 0))


def score_reasons(reasons: list[str]) -> int:
    score = 0
    for reason in reasons:
        if reason.startswith("symbol:"):
            score += score_symbol_reason(reason)
        elif reason.startswith("include"):
            score += score_include_reason(reason)
        elif reason.startswith("modified-test-file"):
            score += 4
        elif reason.startswith("body-stem"):
            score += score_body_stem_reason(reason)
        elif reason.startswith("history"):
            score += 5
        else:
            score += 1
    return score


def score_symbol_reason(reason: str) -> int:
    symbols = [item for item in reason.removeprefix("symbol:").split(",") if item]
    if not symbols:
        return 0
    return min(24, sum(test_symbol_weight(symbol) for symbol in symbols))


def test_symbol_weight(symbol: str) -> int:
    if symbol in HIGH_SIGNAL_TEST_SYMBOLS:
        return 12
    if symbol in LOW_SIGNAL_TEST_SYMBOLS or scope.is_low_signal(symbol):
        return 0
    if symbol.startswith(("rt", "Rt", "rts")):
        return 4
    if any(ch.isupper() for ch in symbol):
        return 3
    return 1


def score_include_reason(reason: str) -> int:
    include = reason.split(":", 1)[1] if ":" in reason else ""
    if include in {"runtime_handle_guard.h", "args_inner.h"}:
        return 6
    if include == "base_info.hpp":
        return 1
    return 3


def score_body_stem_reason(reason: str) -> int:
    stem = reason.split(":", 1)[1] if ":" in reason else ""
    if stem in HIGH_SIGNAL_TEST_SYMBOLS:
        return 8
    return 2


def test_location_score(path: str) -> int:
    normalized = path.replace("\\", "/")
    if "/platform/910B/" in normalized:
        return 50
    if "/platform/950/" in normalized:
        return 45
    if "/platform/cloud" in normalized:
        return 35
    if "/platform/" in normalized and "/platform/others/" not in normalized:
        return 25
    if "/platform/others/" in normalized:
        return 5
    return 0


def load_history_map(path: str | None) -> dict[str, object] | None:
    if not path:
        return None
    history_path = Path(path)
    if not history_path.exists():
        raise RuntimeError(f"history coverage map not found: {history_path}")
    return json.loads(history_path.read_text())


def tests_from_history(
    changed_files: list[str],
    symbols: list[str],
    history_map: dict[str, object] | None,
) -> list[dict[str, object]]:
    if not history_map:
        return []
    tests: list[dict[str, object]] = []
    for key, value in history_map.items():
        if not history_key_matches(key, changed_files, symbols):
            continue
        for test_name in normalize_test_names(value):
            tests.append(
                {
                    "name": test_name,
                    "file": "<history-coverage-map>",
                    "line": 0,
                    "symbols": [],
                    "reasons": [f"history:{key}"],
                    "score": 5,
                }
            )
    return tests


def history_key_matches(key: str, changed_files: list[str], symbols: list[str]) -> bool:
    candidates = set(symbols)
    for path in changed_files:
        candidates.add(path)
        candidates.add(Path(path).name)
        candidates.add(Path(path).stem)
    return any(fnmatch.fnmatch(candidate, key) or fnmatch.fnmatch(key, candidate) for candidate in candidates)


def normalize_test_names(value: object) -> list[str]:
    if isinstance(value, str):
        return [item for item in value.split(":") if item]
    if isinstance(value, list):
        return [str(item) for item in value if str(item)]
    return []


def resolve_build_targets(repo: Path, args: argparse.Namespace, tests: list[dict[str, object]]) -> list[str]:
    if args.build_target != "auto":
        return [item for item in re.split(r"[:,]", args.build_target) if item]
    return list(LOCAL_DEFAULT_BUILD_TARGETS) if tests else []


def build_filter(tests: list[dict[str, object]], suite_fallback_threshold: int) -> tuple[str, str]:
    exact = [str(test["name"]) for test in tests]
    if not exact:
        return "", ""
    selected = list(exact)
    if len(exact) <= suite_fallback_threshold:
        for test in exact:
            suite = test.split(".", 1)[0]
            suite_filter = f"{suite}.*"
            if suite_filter not in selected:
                selected.append(suite_filter)
    return ":".join(exact), ":".join(selected)


def configure_and_build(
    repo: Path,
    args: argparse.Namespace,
    build_targets: list[str],
) -> list[CommandResult]:
    build_dir = (repo / args.build_dir).resolve()
    build_dir.mkdir(parents=True, exist_ok=True)
    cmake_args = []
    if not args.no_default_cmake_args:
        cmake_args.extend(
            [
                "-DENABLE_OPEN_SRC=True",
                "-DCMAKE_BUILD_TYPE=Debug",
                f"-DCMAKE_INSTALL_PREFIX={repo / 'output'}",
                f"-DCANN_3RD_LIB_PATH={repo / 'output' / 'third_party'}",
                "-DENABLE_COV=on",
                "-DENABLE_UT=on",
            ]
        )
    cmake_args.extend(args.cmake_arg or [])

    commands = [
        [
            "cmake",
            "-S",
            str(repo),
            "-B",
            str(build_dir),
            *cmake_args,
        ]
    ]
    targets = build_targets or []
    if targets:
        for target in targets:
            commands.append([
                "cmake",
                "--build",
                str(build_dir),
                "--target",
                target,
                "-j",
                str(args.jobs),
            ])
    else:
        commands.append(["cmake", "--build", str(build_dir), "-j", str(args.jobs)])

    results: list[CommandResult] = []
    for index, command in enumerate(commands):
        result = run_command(f"build-{index + 1}", command, repo, timeout=args.build_timeout)
        results.append(result)
        if result.returncode != 0:
            break
    return results


def discover_gtest_executables(
    repo: Path,
    args: argparse.Namespace,
    env: dict[str, str],
    build_targets: list[str],
) -> list[Path]:
    if args.ut_exec:
        return [Path(item).resolve() if Path(item).is_absolute() else (repo / item).resolve() for item in args.ut_exec]

    roots: list[Path] = []
    if args.ut_exec_root:
        roots.append(repo / args.ut_exec_root)
    build_dir = repo / args.build_dir
    roots.extend(
        [
            build_dir / "tests" / "ut" / "runtime" / "runtime",
            build_dir / "tests" / "ut" / "runtime",
        ]
    )
    if args.scan_build_root:
        roots.append(build_dir)

    target_names = set(build_targets)
    candidates: list[Path] = []
    seen: set[Path] = set()
    for root in roots:
        if not root.exists():
            continue
        for path in root.rglob("*"):
            if path in seen or not is_executable_file(path):
                continue
            if target_names and path.name not in target_names:
                continue
            seen.add(path)
            if is_gtest_executable(repo, path, env):
                candidates.append(path)
    return sorted(candidates)


def is_executable_file(path: Path) -> bool:
    normalized = str(path).replace("\\", "/")
    if "/CMakeFiles/" in normalized:
        return False
    if path.suffix in {".so", ".a", ".o", ".gcda", ".gcno", ".xml", ".info"}:
        return False
    if not re.search(r"(utest|gtest|test)", path.name, re.IGNORECASE):
        return False
    return path.is_file() and os.access(path, os.X_OK)


def is_gtest_executable(repo: Path, path: Path, env: dict[str, str]) -> bool:
    result = run_command(
        "gtest-list",
        [str(path), "--gtest_list_tests"],
        repo,
        timeout=15,
        env=env,
    )
    return result.returncode == 0 and bool(re.search(r"^[A-Za-z_].*\.\s*$", result.stdout, re.MULTILINE))


def parse_gtest_list(stdout: str) -> list[str]:
    tests: list[str] = []
    suite = ""
    for line in stdout.splitlines():
        if not line.startswith(" ") and line.strip().endswith("."):
            suite = line.strip()[:-1]
            continue
        if suite and line.startswith("  "):
            case = line.strip().split(" ", 1)[0]
            if case:
                tests.append(f"{suite}.{case}")
    return tests


def filter_tests_by_available_gtests(
    context: AvailableGtestFilterContext,
    tests: list[dict[str, object]],
) -> tuple[list[dict[str, object]], str, str]:
    repo = context.repo
    args = context.args
    scope_data = context.scope_data
    if args.build_target != "auto" or args.skip_run or not tests:
        return (
            tests,
            str(scope_data.get("exact_gtest_filter", "")),
            str(scope_data.get("gtest_filter", "")),
        )

    env = llt_env(repo, args)
    executables = discover_gtest_executables(
        repo,
        args,
        env,
        context.build_targets,
    )
    available: set[str] = set()
    for executable in executables:
        result = run_command(
            f"gtest-list-{executable.name}",
            [str(executable), "--gtest_list_tests"],
            repo,
            timeout=30,
            env=env,
        )
        if result.returncode == 0:
            available.update(parse_gtest_list(result.stdout))

    filtered = [test for test in tests if str(test.get("name", "")) in available]
    filtered_out = [
        str(test.get("name", ""))
        for test in tests
        if str(test.get("name", "")) not in available
    ]
    exact_filter, selected_filter = build_filter(filtered, args.suite_fallback_threshold)
    scope_data["selected_tests_total_before_available_filter"] = len(tests)
    scope_data["selected_tests_total"] = len(filtered)
    scope_data["available_gtest_executables"] = [rel(path, repo) for path in executables]
    scope_data["available_gtest_tests_total"] = len(available)
    scope_data["filtered_unavailable_tests"] = filtered_out
    scope_data["tests"] = filtered
    scope_data["exact_gtest_filter"] = exact_filter
    scope_data["gtest_filter"] = selected_filter
    write_json(context.out_dir / "scope.json", scope_data)
    return filtered, exact_filter, selected_filter


def run_selected_tests(
    repo: Path,
    args: argparse.Namespace,
    gtest_filter: str,
    out_dir: Path,
    build_targets: list[str],
) -> tuple[list[TestRun], list[str]]:
    env = llt_env(repo, args)
    executables = discover_gtest_executables(repo, args, env, build_targets)
    xml_dir = out_dir / "xml"
    xml_dir.mkdir(parents=True, exist_ok=True)

    runs: list[TestRun] = []
    for executable in executables:
        xml_path = xml_dir / f"{executable.name}.xml"
        command = [
            str(executable),
            f"--gtest_filter={gtest_filter}",
            f"--gtest_output=xml:{xml_path}",
        ]
        result = run_command(
            f"run-{executable.name}",
            command,
            repo,
            timeout=args.test_timeout,
            env=env,
        )
        tests, executed_tests, failures, skipped = parse_gtest_xml(xml_path)
        run = TestRun(
            executable=rel(executable, repo),
            xml=rel(xml_path, repo),
            result=result,
            tests=tests,
            executed_tests=executed_tests,
            failures=failures,
            skipped=skipped,
        )
        if args.reruns > 0 and should_rerun(result, failures):
            rerun_context = RerunContext(repo, args, executable, env)
            run.reruns = rerun_failed_tests(
                rerun_context,
                failures,
                gtest_filter,
            )
        runs.append(run)
    return runs, [rel(path, repo) for path in executables]


def should_rerun(result: CommandResult, failures: list[str]) -> bool:
    return bool(failures) or result.returncode != 0 or result.timed_out


def llt_env(repo: Path, args: argparse.Namespace) -> dict[str, str]:
    env = os.environ.copy()
    env.setdefault("ASAN_OPTIONS", "handle_segv=0:detect_leaks=0")
    lib_dirs = [
        repo / args.build_dir / "lib",
        repo / args.build_dir / "lib64",
        repo / args.build_dir / "gtest_shared_build-prefix" / "src" / "gtest_shared_build-build" / "lib",
        repo / args.build_dir / "gtest_shared_build-prefix" / "src" / "gtest_shared_build-build" / "lib64",
        repo / args.build_dir / "libc_sec" / "source" / "lib",
        repo / args.build_dir / "src" / "runtime",
        repo / args.build_dir / "src" / "mmpa",
        repo / "output" / "lib64",
        repo / "output" / "lib",
        repo / "output" / "third_party" / "lib_cache" / "gtest_shared" / "lib",
        repo / "output" / "third_party" / "lib_cache" / "gtest_shared" / "lib64",
        repo / "output" / "third_party" / "lib_cache" / "mockcpp" / "lib",
        repo / "output" / "third_party" / "lib_cache" / "mockcpp" / "lib64",
    ]
    existing = [str(path) for path in lib_dirs if path.exists()]
    if existing:
        old = env.get("LD_LIBRARY_PATH", "")
        env["LD_LIBRARY_PATH"] = ":".join(existing + ([old] if old else []))
    return env


def parse_gtest_xml(xml_path: Path) -> tuple[int, list[str], list[str], int]:
    if not xml_path.exists():
        return 0, [], [], 0
    try:
        root = ET.parse(xml_path).getroot()
    except ET.ParseError:
        return 0, [], [], 0
    tests = 0
    executed_tests: list[str] = []
    failures: list[str] = []
    skipped = 0
    for testcase in root.iter("testcase"):
        tests += 1
        name = testcase.attrib.get("name", "")
        classname = testcase.attrib.get("classname", "")
        full_name = f"{classname}.{name}" if classname else name
        executed_tests.append(full_name)
        if testcase.find("skipped") is not None:
            skipped += 1
        if testcase.find("failure") is not None or testcase.find("error") is not None:
            failures.append(full_name)
    return tests, executed_tests, failures, skipped


def rerun_failed_tests(
    context: RerunContext,
    failures: list[str],
    original_filter: str,
) -> list[CommandResult]:
    filters = failures or [original_filter]
    reruns: list[CommandResult] = []
    for test_filter in filters:
        for index in range(context.args.reruns):
            result = run_command(
                f"rerun-{context.executable.name}-{index + 1}",
                [str(context.executable), f"--gtest_filter={test_filter}"],
                context.repo,
                timeout=context.args.rerun_timeout,
                env=context.env,
            )
            reruns.append(result)
            if result.returncode == 0 and not result.timed_out:
                break
    return reruns


def reset_coverage_counters(repo: Path, args: argparse.Namespace) -> CommandResult | None:
    if shutil.which("lcov") is None:
        return None
    gcov_dir = repo / (args.gcov_dir or args.build_dir)
    if not gcov_dir.exists():
        return None
    return run_command(
        "coverage-zero",
        ["lcov", "--zerocounters", "-d", str(gcov_dir)],
        repo,
        timeout=args.coverage_timeout,
    )


def coverage_requested(args: argparse.Namespace) -> bool:
    return bool(args.coverage and not args.skip_coverage)


def collect_coverage(
    repo: Path,
    args: argparse.Namespace,
    scope_data: dict[str, object],
    out_dir: Path,
) -> tuple[dict[str, object], list[CommandResult]]:
    if shutil.which("lcov") is None:
        return {"status": "blocked", "reason": "lcov not found in PATH"}, []

    tmp_info = out_dir / "tmp.info"
    coverage_info = out_dir / "coverage.info"
    html_dir = out_dir / "coverage_html"
    gcov_dir = repo / (args.gcov_dir or args.build_dir)

    capture = [
        "lcov",
        "-c",
        "-d",
        str(gcov_dir),
        "-o",
        str(tmp_info),
        "--ignore-errors",
        "mismatch,gcov,source,negative",
    ]
    remove = [
        "lcov",
        "-r",
        str(tmp_info),
        "/usr/*",
        str(repo / "output" / "*"),
        str(repo / "tests" / "*"),
        str(repo / "output" / "third_party" / "*"),
        str(repo / args.build_dir / "*"),
        "-o",
        str(coverage_info),
        "--ignore-errors",
        "mismatch,unused",
    ]
    genhtml = [
        "genhtml",
        str(coverage_info),
        "--output-directory",
        str(html_dir),
    ]
    summary = ["lcov", "--summary", str(coverage_info)]

    results: list[CommandResult] = []
    for name, command in (
        ("coverage-capture", capture),
        ("coverage-filter", remove),
        ("coverage-html", genhtml),
        ("coverage-summary", summary),
    ):
        if name == "coverage-html" and shutil.which("genhtml") is None:
            continue
        result = run_command(name, command, repo, timeout=args.coverage_timeout)
        results.append(result)
        if result.returncode != 0:
            return {
                "status": "blocked",
                "reason": f"{name} failed",
                "coverage_info": rel(coverage_info, repo),
            }, results

    coverage = parse_lcov(coverage_info, repo)
    changed_lines = scope_data.get("changed_lines", {})
    deleted_lines = scope_data.get("deleted_changed_lines", {})
    line_gate = evaluate_changed_line_coverage(
        coverage,
        changed_lines if isinstance(changed_lines, dict) else {},
        deleted_lines if isinstance(deleted_lines, dict) else {},
        args.coverage_threshold,
        repo,
    )
    line_gate.update(
        {
            "status": "ok",
            "coverage_info": rel(coverage_info, repo),
            "html": rel(html_dir, repo) if html_dir.exists() else "",
        }
    )
    return line_gate, results


def parse_lcov(path: Path, repo: Path) -> dict[str, dict[str, int]]:
    coverage: dict[str, dict[str, int]] = {}
    if not path.exists():
        return coverage
    current: str | None = None
    current_aliases: list[str] = []
    for raw_line in path.read_text(errors="ignore").splitlines():
        if raw_line.startswith("SF:"):
            current = normalize_source_path(raw_line[3:], repo)
            resolved = resolve_coverage_source(current, repo)
            current_aliases = [current]
            if resolved != current:
                current_aliases.append(resolved)
            for alias in current_aliases:
                coverage.setdefault(alias, {})
        elif raw_line.startswith("DA:") and current:
            body = raw_line[3:]
            parts = body.split(",")
            if len(parts) >= 2 and parts[0].isdigit():
                for alias in current_aliases:
                    coverage[alias][parts[0]] = int(parts[1])
        elif raw_line == "end_of_record":
            current = None
            current_aliases = []
    return coverage


def normalize_source_path(path: str, repo: Path) -> str:
    candidate = Path(path)
    if candidate.is_absolute():
        try:
            return str(candidate.resolve().relative_to(repo))
        except (OSError, ValueError):
            return str(candidate)
    return path


def resolve_coverage_source(path: str, repo: Path) -> str:
    candidate = (repo / path) if not Path(path).is_absolute() else Path(path)
    if candidate.exists():
        return normalize_source_path(str(candidate), repo)
    parts = Path(path).parts
    for index in range(len(parts)):
        suffix = Path(*parts[index:])
        resolved = repo / suffix
        if resolved.exists():
            return str(suffix)
    if parts:
        suffix_matches = sorted(repo.rglob(parts[-1]))
        if len(suffix_matches) == 1:
            return normalize_source_path(str(suffix_matches[0]), repo)
    return path


def evaluate_changed_line_coverage(
    coverage: dict[str, dict[str, int]],
    changed_lines: dict[str, object],
    deleted_changed_lines: dict[str, object],
    threshold: float,
    repo: Path | None = None,
) -> dict[str, object]:
    total = 0
    covered = 0
    uncovered: dict[str, list[int]] = {}
    unknown: dict[str, list[int]] = {}
    non_coverable: dict[str, list[int]] = {}

    for path, raw_lines in changed_lines.items():
        line_counts = coverage.get(path)
        lines = [int(item) for item in raw_lines]
        if line_counts is None:
            non_coverable_lines = non_coverable_changed_lines(repo, path, lines)
            unknown_lines = [line for line in lines if line not in non_coverable_lines]
            if non_coverable_lines:
                non_coverable[path] = non_coverable_lines
            if unknown_lines:
                unknown[path] = unknown_lines
            continue
        file_non_coverable: list[int] = []
        for line in lines:
            key = str(line)
            if key not in line_counts:
                if line in non_coverable_changed_lines(repo, path, [line]):
                    file_non_coverable.append(line)
                continue
            total += 1
            if line_counts[key] > 0:
                covered += 1
            else:
                uncovered.setdefault(path, []).append(line)
        if file_non_coverable:
            non_coverable[path] = file_non_coverable

    deleted_total = sum(len(items) for items in deleted_changed_lines.values())
    percent = 100.0 if total == 0 and not unknown else (covered * 100.0 / total if total else 0.0)
    no_coverable_changed_lines = total == 0 and not unknown and bool(non_coverable)
    deletion_only_change = total == 0 and not unknown and not non_coverable and deleted_total > 0
    passed = (
        total > 0 and percent >= threshold and not uncovered
    ) or no_coverable_changed_lines or deletion_only_change
    note = ""
    if deletion_only_change:
        note = "deletion_only_change"
    elif no_coverable_changed_lines:
        note = "no_coverable_changed_lines"
    return {
        "changed_line_total": total,
        "changed_line_covered": covered,
        "changed_line_percent": round(percent, 2),
        "deleted_changed_line_total": deleted_total,
        "threshold": threshold,
        "passed": passed,
        "note": note,
        "uncovered_lines": uncovered,
        "unknown_changed_lines": unknown,
        "non_coverable_changed_lines": non_coverable,
        "deleted_changed_lines": deleted_changed_lines,
    }


def non_coverable_changed_lines(repo: Path | None, path: str, lines: list[int]) -> list[int]:
    if repo is None:
        return []
    source = repo / path
    if not source.exists():
        return []
    try:
        text_lines = source.read_text(errors="ignore").splitlines()
    except OSError:
        return []
    result: list[int] = []
    for line in lines:
        if line <= 0 or line > len(text_lines):
            continue
        stripped = text_lines[line - 1].strip()
        if is_non_coverable_source_line(stripped):
            result.append(line)
    return result


def is_non_coverable_source_line(stripped: str) -> bool:
    if not stripped:
        return True
    if stripped in {"{", "}", "};", ":", "public:", "private:", "protected:"}:
        return True
    if stripped.startswith(("//", "/*", "*")) or stripped.endswith("*/"):
        return True
    if stripped.startswith(("#include", "#pragma", "#ifdef", "#ifndef", "#if", "#else", "#elif", "#endif", "#define")):
        return True
    if stripped.startswith(("using ", "namespace ", "template <")):
        return True
    if stripped.endswith(("{", "};")):
        return True
    return False


def summarize_test_runs(runs: list[TestRun], expected_tests: list[str]) -> dict[str, object]:
    total = sum(run.tests for run in runs)
    executed = sorted({name for run in runs for name in run.executed_tests})
    failures = [failure for run in runs for failure in run.failures]
    missing = sorted(set(expected_tests) - set(executed))
    timed_out = [run.executable for run in runs if run.result.timed_out]
    nonzero = [
        run.executable
        for run in runs
        if run.result.returncode != 0 and not run.result.timed_out
    ]
    rerun_passed = []
    for run in runs:
        if run.failures and run.reruns and all(item.returncode == 0 for item in run.reruns):
            rerun_passed.append(run.executable)
    return {
        "total_tests": total,
        "executed_tests": executed,
        "expected_tests": expected_tests,
        "missing_tests": missing,
        "failures": failures,
        "timed_out_executables": timed_out,
        "nonzero_executables": nonzero,
        "rerun_passed_executables": rerun_passed,
        "passed": total > 0 and not missing and not failures and not timed_out and not nonzero,
    }


def decide_conclusion(
    scope_data: dict[str, object],
    plan_only: bool,
    build_results: list[CommandResult],
    test_summary: dict[str, object] | None,
    coverage: dict[str, object] | None,
) -> tuple[str, int, str]:
    _ = coverage
    if plan_only:
        return "SKIPPED", 0, "plan_only"
    if not scope_data.get("llt_relevant_files"):
        return "SKIPPED", 0, "non_llt_change"
    if not scope_data.get("gtest_filter"):
        return "FAIL", 2, "no_related_tests"
    if build_results and build_results[-1].returncode != 0:
        return "FAIL", 3, "build_failed"
    if test_summary is None:
        return "FAIL", 3, "test_not_run"
    if test_summary.get("missing_tests"):
        return "FAIL", 3, "selected_tests_missing"
    if not test_summary.get("passed"):
        if test_summary.get("rerun_passed_executables"):
            return "FAIL", 2, "flaky_risk"
        return "FAIL", 2, "tests_failed"
    return "PASS", 0, "tests_passed"


def write_json(path: Path, payload: object) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n")


def zh_bool(value: object) -> str:
    return "是" if bool(value) else "否"


def zh_reason(reason: str) -> str:
    mapping = {
        "plan_only": "仅生成计划，未执行构建和用例",
        "non_llt_change": "非 Runtime LLT 相关变更",
        "no_related_tests": "未找到相关用例",
        "build_failed": "构建失败",
        "test_not_run": "用例未执行",
        "selected_tests_missing": "选中的用例未被实际执行",
        "flaky_risk": "失败用例复跑通过，存在偶发风险",
        "tests_failed": "用例执行失败",
        "tests_passed": "构建和定向用例均通过",
    }
    return mapping.get(reason, reason)


def zh_status(result: CommandResult) -> str | int:
    return "超时" if result.timed_out else result.returncode


def write_report(context: ReportContext) -> Path:
    repo = context.repo
    out_dir = context.out_dir
    conclusion = context.conclusion
    conclusion_reason = context.conclusion_reason
    scope_data = context.scope_data
    build_results = context.build_results
    executables = context.executables
    runs = context.runs
    test_summary = context.test_summary
    coverage = context.coverage
    coverage_commands = context.coverage_commands
    timestamp = dt.datetime.now().strftime("%Y%m%d_%H%M%S")
    report_path = out_dir / f"report_{timestamp}.md"
    lines: list[str] = []
    lines.append("# Runtime LLT 验证报告")
    lines.append("")
    lines.append(f"- 结论: {conclusion}")
    lines.append(f"- 原因: {zh_reason(conclusion_reason)} (`{conclusion_reason}`)")
    lines.append(f"- 生成时间: {dt.datetime.now().isoformat(timespec='seconds')}")
    lines.append(f"- 仓库: {repo}")
    lines.append(f"- 分支: {scope_data.get('branch', '')}")
    lines.append(f"- 基线提交: {scope_data.get('base', '')}")
    lines.append(f"- 待验证提交: {scope_data.get('head', '')}")
    lines.append(f"- 是否包含未提交工作区变更: {zh_bool(scope_data.get('include_worktree', False))}")
    lines.append("")

    lines.append("## 变更范围")
    changed_files = scope_data.get("changed_files", [])
    relevant_files = scope_data.get("llt_relevant_files", [])
    lines.append(f"- 变更文件数: {len(changed_files)}")
    lines.append(f"- Runtime LLT 相关文件数: {len(relevant_files)}")
    changed_line_count = sum(len(items) for items in scope_data.get("changed_lines", {}).values())
    deleted_line_count = sum(len(items) for items in scope_data.get("deleted_changed_lines", {}).values())
    lines.append(f"- 新增或修改的变更行数: {changed_line_count}")
    lines.append(f"- 删除的变更行数: {deleted_line_count}")
    for path in relevant_files[:40]:
        lines.append(f"  - {path}")
    if len(relevant_files) > 40:
        lines.append(f"  - ... 另有 {len(relevant_files) - 40} 个文件")
    lines.append("")

    lines.append("## 候选用例")
    lines.append(f"- 变更符号数量: {len(scope_data.get('symbols', []))}")
    lines.append(f"- 候选用例总数: {scope_data.get('candidate_tests_total', len(scope_data.get('tests', [])))}")
    if scope_data.get("selected_tests_total_before_available_filter") is not None:
        lines.append(f"- 可运行目标过滤前选中用例数: {scope_data.get('selected_tests_total_before_available_filter')}")
    lines.append(f"- 选中用例总数: {scope_data.get('selected_tests_total', len(scope_data.get('tests', [])))}")
    if scope_data.get("filtered_unavailable_tests"):
        lines.append(f"- 因本地目标不可运行而过滤的候选数: {len(scope_data.get('filtered_unavailable_tests', []))}")
    lines.append(f"- 是否因数量上限截断: {zh_bool(scope_data.get('selection_truncated', False))}")
    lines.append(f"- 精确 gtest_filter: `{compact_text(scope_data.get('exact_gtest_filter', ''))}`")
    lines.append(f"- 实际执行 gtest_filter: `{compact_text(scope_data.get('gtest_filter', ''))}`")
    lines.append(f"- 构建目标模式: {scope_data.get('build_target_mode', '')}")
    lines.append(f"- 解析后的构建目标: `{compact_text(':'.join(scope_data.get('resolved_build_targets', [])))}`")
    for test in scope_data.get("tests", [])[:60]:
        reasons = ",".join(test.get("reasons", []))
        lines.append(f"  - {test.get('name')} ({test.get('file')}:{test.get('line')}) [{reasons}]")
    lines.append("")

    lines.append("## 构建")
    if not build_results:
        lines.append("- 未执行")
    for result in build_results:
        lines.append(f"- {result.name}: 返回码={zh_status(result)}, 耗时={result.elapsed_seconds:.1f}s")
        lines.append(f"  - 命令: `{shlex.join(result.command)}`")
    lines.append("")

    lines.append("## 用例执行")
    if test_summary is None:
        lines.append("- 未执行")
    else:
        lines.append(f"- 可执行文件数: {len(executables)}")
        lines.append(f"- 实际执行用例数: {test_summary.get('total_tests', 0)}")
        lines.append(f"- 期望用例数: {len(test_summary.get('expected_tests', []))}")
        lines.append(f"- 缺失用例数: {len(test_summary.get('missing_tests', []))}")
        lines.append(f"- 失败用例数: {len(test_summary.get('failures', []))}")
        lines.append(f"- 超时可执行文件数: {len(test_summary.get('timed_out_executables', []))}")
        lines.append(f"- 非零退出可执行文件数: {len(test_summary.get('nonzero_executables', []))}")
    for run in runs:
        lines.append(f"  - {run.executable}: 返回码={zh_status(run.result)}, 用例数={run.tests}, 失败数={len(run.failures)}")
        if run.failures:
            lines.append(f"    失败用例: `{':'.join(run.failures)}`")
        if run.reruns:
            passed = sum(1 for item in run.reruns if item.returncode == 0 and not item.timed_out)
            lines.append(f"    复跑结果: {passed}/{len(run.reruns)} 通过")
    if test_summary is not None and test_summary.get("missing_tests"):
        lines.append(f"  - 缺失用例: `{compact_text(':'.join(test_summary.get('missing_tests', [])))}`")
    lines.append("")

    if scope_data.get("coverage_requested") or coverage is not None or coverage_commands:
        lines.append("## 增量覆盖率")
        lines.append("- 判定口径: 仅报告，不参与 PASS/FAIL")
        if coverage is None:
            lines.append("- 已请求，但未执行")
        else:
            lines.append(f"- 状态: {coverage.get('status', '')}")
            lines.append(f"- 增量变更行覆盖率: {coverage.get('changed_line_percent', '')}")
            lines.append(f"- 已覆盖变更行数: {coverage.get('changed_line_covered', '')}")
            lines.append(f"- 可统计变更行总数: {coverage.get('changed_line_total', '')}")
            lines.append(f"- 参考阈值: {coverage.get('threshold', '')}")
            if coverage.get("note"):
                lines.append(f"- 说明: {coverage.get('note', '')}")
            lines.append(f"- 覆盖率数据: {coverage.get('coverage_info', '')}")
            lines.append(f"- HTML 报告: {coverage.get('html', '')}")
            if coverage.get("uncovered_lines"):
                lines.append(
                    "- 未覆盖变更行: "
                    f"`{json.dumps(coverage.get('uncovered_lines'), ensure_ascii=False)}`"
                )
            if coverage.get("unknown_changed_lines"):
                lines.append(
                    "- 未识别覆盖率的变更行: "
                    f"`{json.dumps(coverage.get('unknown_changed_lines'), ensure_ascii=False)}`"
                )
            if coverage.get("non_coverable_changed_lines"):
                lines.append(
                    "- 不可统计覆盖率的变更行: "
                    f"`{json.dumps(coverage.get('non_coverable_changed_lines'), ensure_ascii=False)}`"
                )
            if coverage.get("deleted_changed_lines"):
                lines.append(
                    "- 删除的变更行: "
                    f"`{json.dumps(coverage.get('deleted_changed_lines'), ensure_ascii=False)}`"
                )
        for result in coverage_commands:
            lines.append(f"  - {result.name}: 返回码={zh_status(result)}, 耗时={result.elapsed_seconds:.1f}s")
        lines.append("")

    lines.append("## 产物")
    lines.append(f"- 范围文件: {rel(out_dir / 'scope.json', repo)}")
    lines.append(f"- 结果文件: {rel(out_dir / 'result.json', repo)}")
    lines.append(f"- 报告文件: {rel(report_path, repo)}")
    lines.append("")

    report_path.write_text("\n".join(lines) + "\n")
    return report_path


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=__doc__,
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
    )
    parser.add_argument("--repo", default=".", help="Runtime repository root")
    parser.add_argument(
        "--base",
        default=os.environ.get("BASE_REF", "auto"),
        help="diff base ref; use BASE_REF when set, otherwise auto-detect",
    )
    parser.add_argument("--out-dir", default="llt_verify", help="artifact directory")
    parser.add_argument("--test-root", default="tests/ut/runtime/runtime/test", help="runtime UT source root")
    parser.add_argument("--history-map", default=None, help="optional source/symbol to gtest map JSON")
    parser.add_argument("--max-symbols", type=int, default=160, help="maximum changed symbols used for test selection")
    parser.add_argument(
        "--max-tests",
        type=int,
        default=120,
        help="maximum selected candidate tests; 0 means unlimited",
    )
    parser.add_argument(
        "--coverage-threshold",
        type=float,
        default=80.0,
        help="changed-line coverage reference threshold, informational only",
    )
    parser.add_argument(
        "--suite-fallback-threshold",
        type=int,
        default=3,
        help="add suite-level fallback filters when exact candidates are not more than this value",
    )
    parser.add_argument("--committed-only", action="store_true", help="ignore staged and worktree changes")
    parser.add_argument("--plan-only", action="store_true", help="only collect scope and write report")
    parser.add_argument("--skip-build", action="store_true", help="reuse existing build artifacts")
    parser.add_argument("--skip-run", action="store_true", help="skip gtest execution")
    parser.add_argument(
        "--coverage",
        action="store_true",
        help="collect incremental changed-line coverage; disabled by default",
    )
    parser.add_argument("--skip-coverage", action="store_true", help="force skip lcov collection")
    parser.add_argument("--build-dir", default="build_ut", help="CMake build directory")
    parser.add_argument(
        "--build-target",
        default="auto",
        help="CMake target(s) to build, separated by ':' or ','; auto uses a small stable local target set",
    )
    parser.add_argument("--jobs", type=int, default=8, help="parallel build jobs")
    parser.add_argument("--cmake-arg", action="append", default=[], help="extra CMake argument; can be repeated")
    parser.add_argument(
        "--no-default-cmake-args",
        action="store_true",
        help="do not add default Runtime UT CMake arguments",
    )
    parser.add_argument("--ut-exec", action="append", default=[], help="explicit gtest executable")
    parser.add_argument("--ut-exec-root", default=None, help="directory containing gtest executables")
    parser.add_argument(
        "--scan-build-root",
        action="store_true",
        help="scan the entire build directory for gtest executables",
    )
    parser.add_argument("--gcov-dir", default=None, help="directory passed to lcov -d")
    parser.add_argument("--build-timeout", type=int, default=1800, help="build command timeout in seconds")
    parser.add_argument("--test-timeout", type=int, default=300, help="per gtest executable timeout in seconds")
    parser.add_argument("--rerun-timeout", type=int, default=120, help="per flaky-rerun timeout in seconds")
    parser.add_argument("--coverage-timeout", type=int, default=600, help="per coverage command timeout in seconds")
    parser.add_argument("--reruns", type=int, default=1, help="rerun attempts for failed tests")
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    repo = Path(args.repo).resolve()
    if not (repo / ".git").exists():
        raise RuntimeError(f"not a git repository root: {repo}")

    out_dir = (repo / args.out_dir).resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    history_map = load_history_map(args.history_map)
    base = default_base(repo) if args.base in ("", "auto") else args.base
    include_worktree = not args.committed_only
    scope_data = detect_scope(repo, base, args.test_root, args.max_symbols, include_worktree)
    history_tests = []
    if scope_data.get("llt_relevant_files"):
        history_tests = tests_from_history(
            scope_data.get("llt_relevant_files", []),
            scope_data.get("symbols", []),
            history_map,
        )
    merged: dict[str, dict[str, object]] = {
        str(test["name"]): dict(test) for test in scope_data.get("tests", [])
    }
    for item in history_tests:
        merge_test(merged, item)
    all_tests = sorted(merged.values(), key=lambda item: (-int(item["score"]), str(item["name"])))
    tests = all_tests[: args.max_tests] if args.max_tests > 0 else all_tests
    exact_filter, selected_filter = build_filter(tests, args.suite_fallback_threshold)
    scope_data["candidate_tests_total"] = len(all_tests)
    scope_data["selected_tests_total"] = len(tests)
    scope_data["selection_truncated"] = len(tests) < len(all_tests)
    scope_data["max_tests"] = args.max_tests
    scope_data["tests"] = tests
    scope_data["exact_gtest_filter"] = exact_filter
    scope_data["gtest_filter"] = selected_filter
    build_targets = resolve_build_targets(repo, args, tests)
    scope_data["build_target_mode"] = args.build_target
    scope_data["resolved_build_targets"] = build_targets
    scope_data["coverage_requested"] = coverage_requested(args)
    scope_data["coverage_mode"] = "incremental_changed_line" if coverage_requested(args) else "disabled"
    write_json(out_dir / "scope.json", scope_data)

    build_results: list[CommandResult] = []
    runs: list[TestRun] = []
    executables: list[str] = []
    test_summary: dict[str, object] | None = None
    coverage: dict[str, object] | None = None
    coverage_commands: list[CommandResult] = []

    if not args.plan_only and scope_data.get("llt_relevant_files") and selected_filter:
        if not args.skip_build:
            build_results = configure_and_build(repo, args, build_targets)
        if not build_results or build_results[-1].returncode == 0:
            if not args.skip_run:
                filter_context = AvailableGtestFilterContext(
                    repo,
                    args,
                    build_targets,
                    scope_data,
                    out_dir,
                )
                tests, exact_filter, selected_filter = filter_tests_by_available_gtests(
                    filter_context,
                    tests,
                )
                if selected_filter and coverage_requested(args):
                    zero_result = reset_coverage_counters(repo, args)
                    if zero_result is not None:
                        coverage_commands.append(zero_result)
                if selected_filter:
                    runs, executables = run_selected_tests(repo, args, selected_filter, out_dir, build_targets)
                    expected_tests = [str(test["name"]) for test in scope_data.get("tests", [])]
                    test_summary = summarize_test_runs(runs, expected_tests)
            if args.skip_run:
                test_summary = None
            if test_summary and test_summary.get("passed") and coverage_requested(args):
                coverage_zero_failed = (
                    coverage_commands
                    and coverage_commands[-1].name == "coverage-zero"
                    and coverage_commands[-1].returncode != 0
                )
                if coverage_zero_failed:
                    coverage = {"status": "blocked", "reason": "coverage-zero failed"}
                else:
                    coverage, collect_commands = collect_coverage(repo, args, scope_data, out_dir)
                    coverage_commands.extend(collect_commands)

    conclusion, exit_code, conclusion_reason = decide_conclusion(
        scope_data,
        args.plan_only,
        build_results,
        test_summary,
        coverage,
    )
    report_context = ReportContext(
        repo,
        out_dir,
        conclusion,
        conclusion_reason,
        scope_data,
        build_results,
        executables,
        runs,
        test_summary,
        coverage,
        coverage_commands,
    )
    report_path = write_report(report_context)
    result = {
        "conclusion": conclusion,
        "reason": conclusion_reason,
        "exit_code": exit_code,
        "report": rel(report_path, repo),
        "scope": rel(out_dir / "scope.json", repo),
        "test_summary": test_summary,
        "coverage": coverage,
        "build": [item.to_json() for item in build_results],
        "runs": [item.to_json() for item in runs],
        "coverage_commands": [item.to_json() for item in coverage_commands],
    }
    write_json(out_dir / "result.json", result)

    LOGGER.info("conclusion: %s", conclusion)
    LOGGER.info("reason: %s", conclusion_reason)
    LOGGER.info("scope: %s", rel(out_dir / "scope.json", repo))
    LOGGER.info("report: %s", rel(report_path, repo))
    return exit_code


if __name__ == "__main__":
    logging.basicConfig(level=logging.INFO, format="%(message)s")
    try:
        sys.exit(main())
    except RuntimeError as exc:
        LOGGER.error("error: %s", exc)
        sys.exit(3)
