#!/usr/bin/env python3
"""
CANN Runtime API Coverage Analyzer

Extracts public APIs from CANN header files, scans example source code
for API usage, and calculates coverage metrics.

Usage:
    python analyze_coverage.py [options]

Output formats:
    summary  - Human-readable summary to stdout
    json     - Full structured data as JSON
    markdown - Markdown report (Chinese)
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime
from pathlib import Path

# Visibility macros that mark public API functions
VISIBILITY_MACROS = [
    "ACL_FUNC_VISIBILITY",
    "ACL_BASE_FUNC_VISIBILITY",
    "MSVP_PROF_API",
    "ACL_DUMP_API",
]

# Regex to match a visibility macro at the start of a line
MACRO_PATTERN = re.compile(
    r"^(" + "|".join(re.escape(m) for m in VISIBILITY_MACROS) + r")\s+"
)

# Regex to extract function name: last identifier before '('
FUNC_NAME_PATTERN = re.compile(r"\b(\w+)\s*\(")


def extract_apis_from_header(filepath):
    """Extract all public API function names from a single header file."""
    apis = []
    with open(filepath, "r", encoding="utf-8", errors="ignore") as f:
        lines = f.readlines()

    i = 0
    while i < len(lines):
        line = lines[i].rstrip()
        if MACRO_PATTERN.match(line):
            # Accumulate multi-line declarations until we find '('
            declaration = line
            while "(" not in declaration and i + 1 < len(lines):
                i += 1
                declaration += " " + lines[i].strip()

            # Extract function name: find all identifiers before '(', take the last one
            # This handles return types like "aclError", pointer returns "const char *", etc.
            paren_pos = declaration.find("(")
            if paren_pos > 0:
                before_paren = declaration[:paren_pos].rstrip()
                # Remove pointer stars and qualifiers
                before_paren = before_paren.replace("*", " ")
                tokens = before_paren.split()
                if tokens:
                    func_name = tokens[-1]
                    # Validate it looks like a CANN API name
                    if func_name.startswith(("acl", "Acl")):
                        apis.append({
                            "name": func_name,
                            "header": os.path.basename(filepath),
                            "line": i + 1,
                        })
        i += 1

    return apis


def extract_all_apis(headers_dir):
    """Extract APIs from all header files in the directory."""
    all_apis = []
    header_files = sorted(Path(headers_dir).glob("*.h"))

    for hf in header_files:
        # Skip error code headers and base type headers without API functions
        basename = hf.name
        if basename in ("acl_base.h", "acl_base_mdl.h", "acl_op.h", "acl_mdl.h", "acl.h"):
            continue
        if "error_codes" in str(hf):
            continue

        apis = extract_apis_from_header(str(hf))
        all_apis.extend(apis)

    return all_apis


def load_example_sources(examples_dir):
    """Load all example source files into memory, stripping comments."""
    sources = []
    example_path = Path(examples_dir)

    for ext in ("*.cpp", "*.c", "*.h"):
        for src_file in sorted(example_path.rglob(ext)):
            rel_path = str(src_file.relative_to(example_path)).replace("\\", "/")
            try:
                with open(src_file, "r", encoding="utf-8", errors="ignore") as f:
                    raw_lines = f.readlines()
            except OSError:
                continue

            # Strip comments for more accurate matching
            cleaned_lines = strip_comments(raw_lines)
            sources.append({
                "path": rel_path,
                "abs_path": str(src_file),
                "lines": cleaned_lines,
                "raw_lines": raw_lines,
            })

    return sources


def strip_comments(lines):
    """Remove C/C++ comments from source lines (simple approach)."""
    result = []
    in_block_comment = False

    for line in lines:
        cleaned = ""
        i = 0
        while i < len(line):
            if in_block_comment:
                end_pos = line.find("*/", i)
                if end_pos >= 0:
                    in_block_comment = False
                    i = end_pos + 2
                else:
                    break  # rest of line is comment
            else:
                if line[i:i+2] == "//":
                    break  # rest of line is comment
                elif line[i:i+2] == "/*":
                    in_block_comment = True
                    i += 2
                else:
                    cleaned += line[i]
                    i += 1
        result.append(cleaned)

    return result


def scan_examples_for_apis(apis, sources):
    """Search example sources for API function calls."""
    # Build regex patterns for all APIs
    api_patterns = {}
    for api in apis:
        name = api["name"]
        # Use word boundary + function call pattern
        api_patterns[name] = re.compile(r"\b" + re.escape(name) + r"\s*\(")

    # Scan each source file
    coverage = {}  # api_name -> list of {file, line}

    for src in sources:
        for line_num, line in enumerate(src["lines"], 1):
            for api_name, pattern in api_patterns.items():
                if pattern.search(line):
                    if api_name not in coverage:
                        coverage[api_name] = []
                    coverage[api_name].append({
                        "file": src["path"],
                        "line": line_num,
                    })

    return coverage


def get_example_name(file_path):
    """Extract example name from file path (e.g., 'device/0_device_normal')."""
    parts = file_path.replace("\\", "/").split("/")
    if len(parts) >= 2:
        return "/".join(parts[:2])
    return parts[0]


def load_categories(categories_file):
    """Load API category mapping from JSON file."""
    if not categories_file or not os.path.exists(categories_file):
        return None
    with open(categories_file, "r", encoding="utf-8") as f:
        return json.load(f)


def build_report(apis, coverage, sources, categories_data):
    """Build the full coverage report data structure."""
    # Per-header statistics
    header_stats = {}
    for api in apis:
        h = api["header"]
        if h not in header_stats:
            header_stats[h] = {"total": 0, "covered": 0, "apis": []}
        header_stats[h]["total"] += 1
        is_covered = api["name"] in coverage
        if is_covered:
            header_stats[h]["covered"] += 1
        header_stats[h]["apis"].append({
            "name": api["name"],
            "covered": is_covered,
            "examples": coverage.get(api["name"], []),
        })

    per_header = []
    for h in sorted(header_stats.keys()):
        stats = header_stats[h]
        per_header.append({
            "header": h,
            "total": stats["total"],
            "covered": stats["covered"],
            "coverage_pct": round(stats["covered"] / stats["total"] * 100, 1) if stats["total"] > 0 else 0,
            "apis": stats["apis"],
        })

    # Per-category statistics
    per_category = []
    api_names_set = {a["name"] for a in apis}
    categorized_apis = set()
    if categories_data:
        for cat in categories_data["categories"]:
            cat_apis = [a for a in cat["apis"] if a in api_names_set]
            cat_covered = [a for a in cat_apis if a in coverage]
            cat_uncovered = [a for a in cat_apis if a not in coverage]
            categorized_apis.update(cat_apis)
            total = len(cat_apis)
            covered = len(cat_covered)
            per_category.append({
                "id": cat["id"],
                "name": cat["name"],
                "name_en": cat["name_en"],
                "total": total,
                "covered": covered,
                "coverage_pct": round(covered / total * 100, 1) if total > 0 else 0,
                "covered_apis": cat_covered,
                "uncovered_apis": cat_uncovered,
            })

    # Detect uncategorized APIs (in headers but not in any category)
    uncategorized_apis = []
    if categories_data:
        for api in apis:
            if api["name"] not in categorized_apis:
                uncategorized_apis.append({
                    "name": api["name"],
                    "header": api["header"],
                })

    # Per-example statistics
    example_apis = {}  # example_name -> set of api names
    for api_name, usages in coverage.items():
        for usage in usages:
            ex_name = get_example_name(usage["file"])
            if ex_name not in example_apis:
                example_apis[ex_name] = set()
            example_apis[ex_name].add(api_name)

    per_example = []
    for ex_name in sorted(example_apis.keys()):
        api_list = sorted(example_apis[ex_name])
        per_example.append({
            "path": ex_name,
            "apis_used": api_list,
            "api_count": len(api_list),
        })

    # Uncovered APIs
    all_api_names = [a["name"] for a in apis]
    uncovered = [name for name in all_api_names if name not in coverage]

    # Summary
    total = len(apis)
    covered_count = len([a for a in apis if a["name"] in coverage])

    report = {
        "timestamp": datetime.now().isoformat(),
        "summary": {
            "total_apis": total,
            "covered_apis": covered_count,
            "coverage_pct": round(covered_count / total * 100, 1) if total > 0 else 0,
            "total_examples": len(example_apis),
            "total_example_files": len(sources),
            "total_headers": len(header_stats),
            "uncategorized_count": len(uncategorized_apis),
        },
        "per_header": per_header,
        "per_category": per_category,
        "per_example": per_example,
        "uncovered_apis": uncovered,
        "uncategorized_apis": uncategorized_apis,
    }

    return report


def format_summary(report):
    """Format report as human-readable summary."""
    s = report["summary"]
    lines = [
        "=" * 60,
        "CANN Runtime API Coverage Summary",
        "=" * 60,
        f"Timestamp: {report['timestamp']}",
        f"Total APIs: {s['total_apis']}",
        f"Covered:    {s['covered_apis']} ({s['coverage_pct']}%)",
        f"Uncovered:  {s['total_apis'] - s['covered_apis']}",
        f"Examples:   {s['total_examples']}",
        f"Source files:{s['total_example_files']}",
        "",
        "Per Header:",
        "-" * 50,
    ]

    for h in report["per_header"]:
        lines.append(f"  {h['header']:<25} {h['covered']:>3}/{h['total']:<3} ({h['coverage_pct']}%)")

    if report["per_category"]:
        lines.extend(["", "Per Category:", "-" * 50])
        for c in report["per_category"]:
            lines.append(f"  {c['id']:>2}. {c['name']:<20} {c['covered']:>3}/{c['total']:<3} ({c['coverage_pct']}%)")

    if report.get("uncategorized_apis"):
        lines.extend(["", "WARNING: Uncategorized APIs (not in categories.json):", "-" * 50])
        for api in report["uncategorized_apis"]:
            lines.append(f"  {api['name']:<40} ({api['header']})")
        lines.append(f"  Total: {len(report['uncategorized_apis'])} APIs need categorization")

    lines.extend(["", "=" * 60])
    return "\n".join(lines)


def format_markdown(report):
    """Format report as Markdown (Chinese)."""
    s = report["summary"]
    lines = [
        "# CANN Runtime Example API 覆盖率分析报告",
        "",
        f"> 生成时间: {report['timestamp']}",
        f"> 分析工具: analyze_coverage.py",
        "",
        "## 1. 总体概览",
        "",
        "| 指标 | 数值 |",
        "|---|---|",
        f"| 总 API 数 | {s['total_apis']} |",
        f"| 已覆盖 API 数 | {s['covered_apis']} |",
        f"| 覆盖率 | {s['coverage_pct']}% |",
        f"| Example 程序数 | {s['total_examples']} |",
        f"| 源文件数 | {s['total_example_files']} |",
        "",
        "## 2. 按头文件统计",
        "",
        "| 头文件 | 总 API | 已覆盖 | 覆盖率 |",
        "|---|---|---|---|",
    ]

    for h in report["per_header"]:
        lines.append(f"| {h['header']} | {h['total']} | {h['covered']} | {h['coverage_pct']}% |")

    if report["per_category"]:
        lines.extend([
            "",
            "## 3. 按功能分类统计",
            "",
            "| 序号 | 分类 | 总 API | 已覆盖 | 覆盖率 |",
            "|---|---|---|---|---|",
        ])
        for c in report["per_category"]:
            lines.append(f"| {c['id']} | {c['name']} | {c['total']} | {c['covered']} | {c['coverage_pct']}% |")

    # Per-category detail: uncovered APIs
    lines.extend(["", "## 4. 各分类未覆盖 API 详情", ""])
    for c in report["per_category"]:
        if c["uncovered_apis"]:
            lines.append(f"### 4.{c['id']} {c['name']} (未覆盖 {len(c['uncovered_apis'])} 个)")
            lines.append("")
            for api in c["uncovered_apis"]:
                lines.append(f"- `{api}`")
            lines.append("")

    # Per-example
    lines.extend([
        "## 5. 各 Example 使用 API 统计",
        "",
        "| Example | API 数量 | 使用的 API |",
        "|---|---|---|",
    ])
    for ex in report["per_example"]:
        api_str = ", ".join(f"`{a}`" for a in ex["apis_used"][:10])
        if len(ex["apis_used"]) > 10:
            api_str += f" ... (共{ex['api_count']}个)"
        lines.append(f"| {ex['path']} | {ex['api_count']} | {api_str} |")

    if report.get("uncategorized_apis"):
        lines.extend([
            "",
            "## 6. 未归类 API 警告",
            "",
            f"以下 **{len(report['uncategorized_apis'])}** 个 API 在头文件中检测到，但未在 `categories.json` 中归类。",
            "请更新分类文件以包含这些 API。",
            "",
            "| API 名称 | 所属头文件 |",
            "|---|---|",
        ])
        for api in report["uncategorized_apis"]:
            lines.append(f"| `{api['name']}` | {api['header']} |")

    lines.extend(["", "---", f"*报告由 analyze_coverage.py 自动生成*"])
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description="CANN Runtime API Coverage Analyzer")
    parser.add_argument(
        "--headers-dir",
        default="include/external/acl/",
        help="Directory containing ACL header files (default: include/external/acl/)",
    )
    parser.add_argument(
        "--examples-dir",
        default="example/",
        help="Directory containing example source code (default: example/)",
    )
    parser.add_argument(
        "--categories",
        default=None,
        help="Path to categories.json for functional classification",
    )
    parser.add_argument(
        "--format",
        choices=["json", "summary", "markdown"],
        default="summary",
        help="Output format (default: summary)",
    )
    parser.add_argument(
        "--output",
        default=None,
        help="Output file path (default: stdout)",
    )

    args = parser.parse_args()

    # Auto-detect categories.json location
    if args.categories is None:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        default_categories = os.path.join(script_dir, "categories.json")
        if os.path.exists(default_categories):
            args.categories = default_categories

    # Validate directories
    if not os.path.isdir(args.headers_dir):
        print(f"Error: Headers directory not found: {args.headers_dir}", file=sys.stderr)
        sys.exit(1)
    if not os.path.isdir(args.examples_dir):
        print(f"Error: Examples directory not found: {args.examples_dir}", file=sys.stderr)
        sys.exit(1)

    # Step 1: Extract APIs from headers
    print("Extracting APIs from headers...", file=sys.stderr)
    apis = extract_all_apis(args.headers_dir)
    print(f"  Found {len(apis)} APIs", file=sys.stderr)

    # Step 2: Load example sources
    print("Loading example sources...", file=sys.stderr)
    sources = load_example_sources(args.examples_dir)
    print(f"  Loaded {len(sources)} source files", file=sys.stderr)

    # Step 3: Scan for API usage
    print("Scanning for API usage...", file=sys.stderr)
    coverage = scan_examples_for_apis(apis, sources)
    covered_count = len(coverage)
    print(f"  Found {covered_count} covered APIs", file=sys.stderr)

    # Step 4: Load categories
    categories_data = load_categories(args.categories)

    # Step 5: Build report
    report = build_report(apis, coverage, sources, categories_data)

    # Warn about uncategorized APIs
    if report.get("uncategorized_apis"):
        count = len(report["uncategorized_apis"])
        print(f"  WARNING: {count} APIs not in categories.json:", file=sys.stderr)
        for api in report["uncategorized_apis"]:
            print(f"    - {api['name']} ({api['header']})", file=sys.stderr)

    # Step 6: Format output
    if args.format == "json":
        output = json.dumps(report, ensure_ascii=False, indent=2)
    elif args.format == "markdown":
        output = format_markdown(report)
    else:
        output = format_summary(report)

    # Step 7: Write output
    if args.output:
        os.makedirs(os.path.dirname(args.output) or ".", exist_ok=True)
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(output)
        print(f"Report written to: {args.output}", file=sys.stderr)
    else:
        print(output)


if __name__ == "__main__":
    main()
