#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

import argparse
import csv
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List, Sequence, Tuple


CATALOG_VERSION_MACRO = "RUNTIME_API_CATALOG_VERSION"
CATALOG_ENTRY_MACRO = "RUNTIME_API"
PRODUCT_VERSION_MACRO = "RUNTIME_API_CATALOG_VERSION"
PRODUCT_STUB_MACRO = "RUNTIME_API_STUB"
SUPPORTED_POLICIES = {"FEATURE_NOT_SUPPORT", "SUCCESS_NOOP", "VOID_NOOP"}
SUPPORTED_VISIBILITIES = {"EXPORT", "HIDDEN"}


@dataclass(frozen=True)
class ApiEntry:
    module: str
    return_type: str
    name: str
    signature: str
    arguments: str
    policy: str
    visibility: str


def strip_comments(content: str) -> str:
    content = re.sub(r"/\*.*?\*/", "", content, flags=re.DOTALL)
    return re.sub(r"//.*", "", content)


def extract_invocations(content: str, macro: str) -> List[str]:
    invocations: List[str] = []
    pattern = re.compile(rf"\b{re.escape(macro)}\s*\(")
    position = 0
    while True:
        match = pattern.search(content, position)
        if match is None:
            return invocations
        start = match.end()
        depth = 1
        index = start
        while index < len(content) and depth > 0:
            if content[index] == "(":
                depth += 1
            elif content[index] == ")":
                depth -= 1
            index += 1
        if depth != 0:
            raise ValueError(f"unterminated {macro} invocation")
        invocations.append(content[start:index - 1].strip())
        position = index


def split_top_level(content: str) -> List[str]:
    fields: List[str] = []
    depth = 0
    start = 0
    for index, character in enumerate(content):
        if character == "(":
            depth += 1
        elif character == ")":
            depth -= 1
            if depth < 0:
                raise ValueError("unbalanced closing parenthesis")
        elif character == "," and depth == 0:
            fields.append(content[start:index].strip())
            start = index + 1
    if depth != 0:
        raise ValueError("unbalanced opening parenthesis")
    fields.append(content[start:].strip())
    return fields


def unwrap_parentheses(value: str, field_name: str) -> str:
    value = value.strip()
    if not value.startswith("(") or not value.endswith(")"):
        raise ValueError(f"{field_name} must be enclosed in parentheses: {value}")
    return value[1:-1].strip()


def parse_single_version(content: str, source: Path) -> int:
    versions = extract_invocations(content, CATALOG_VERSION_MACRO)
    if len(versions) != 1 or not versions[0].isdigit():
        raise ValueError(f"{source}: exactly one numeric {CATALOG_VERSION_MACRO} is required")
    return int(versions[0])


def parse_catalog(path: Path) -> Tuple[int, Dict[str, ApiEntry]]:
    content = strip_comments(path.read_text(encoding="utf-8"))
    version = parse_single_version(content, path)
    entries: Dict[str, ApiEntry] = {}
    for invocation in extract_invocations(content, CATALOG_ENTRY_MACRO):
        fields = split_top_level(invocation)
        if len(fields) != 7:
            raise ValueError(f"{path}: {CATALOG_ENTRY_MACRO} expects 7 fields, got {len(fields)}")
        module, return_type, name, signature, arguments, policy, visibility = fields
        if name in entries:
            raise ValueError(f"{path}: duplicate API {name}")
        if policy not in SUPPORTED_POLICIES:
            raise ValueError(f"{path}: unsupported policy {policy} for {name}")
        if visibility not in SUPPORTED_VISIBILITIES:
            raise ValueError(f"{path}: unsupported visibility {visibility} for {name}")
        entries[name] = ApiEntry(
            module=module,
            return_type=return_type,
            name=name,
            signature=unwrap_parentheses(signature, "signature"),
            arguments=unwrap_parentheses(arguments, "arguments"),
            policy=policy,
            visibility=visibility,
        )
    return version, entries


def parse_product_def(path: Path) -> Tuple[int, List[str]]:
    content = strip_comments(path.read_text(encoding="utf-8"))
    version = parse_single_version(content, path)
    names = [name.strip() for name in extract_invocations(content, PRODUCT_STUB_MACRO)]
    duplicates = sorted({name for name in names if names.count(name) > 1})
    if duplicates:
        raise ValueError(f"{path}: duplicate stub APIs: {', '.join(duplicates)}")
    return version, names


def argument_names(arguments: str) -> Sequence[str]:
    if arguments in {"", "void"}:
        return []
    return split_top_level(arguments)


def render_stub(entry: ApiEntry) -> str:
    lines = []
    if entry.visibility == "EXPORT":
        lines.append("VISIBILITY_DEFAULT")
    lines.extend([f"{entry.return_type} {entry.name}({entry.signature})", "{"])
    for argument in argument_names(entry.arguments):
        lines.append(f"    UNUSED({argument});")
    if entry.policy == "FEATURE_NOT_SUPPORT":
        lines.append("    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;")
    elif entry.policy == "SUCCESS_NOOP":
        lines.append("    return ACL_RT_SUCCESS;")
    lines.append("}")
    return "\n".join(lines)


def render_source(product: str, entries: Sequence[ApiEntry]) -> str:
    body = "\n\n".join(render_stub(entry) for entry in entries)
    if body:
        body += "\n"
    return f'''/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

// Generated for {product}. Do not edit this file directly.
#define RTS_WEAK
#include "api.hpp"

using namespace cce::runtime;

extern "C" {{
{body}}} // extern "C"
'''


def write_if_changed(path: Path, content: str) -> None:
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return
    path.write_text(content, encoding="utf-8")


def write_report(path: Path, product: str, catalog: Dict[str, ApiEntry], stub_names: Sequence[str]) -> None:
    stub_set = set(stub_names)
    rows = [(name, entry.module, entry.visibility, "strong_stub" if name in stub_set else "weak_real")
            for name, entry in sorted(catalog.items())]
    with path.open("w", encoding="utf-8", newline="") as report:
        writer = csv.writer(report)
        writer.writerow(["product", "api", "module", "stub_visibility", "provider"])
        writer.writerows((product, name, module, visibility, provider)
                         for name, module, visibility, provider in rows)


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate strong Runtime API stubs from a product capability list")
    parser.add_argument("--catalog", required=True, type=Path)
    parser.add_argument("--product-def", required=True, type=Path)
    parser.add_argument("--product", required=True)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    args = parser.parse_args()

    catalog_version, catalog = parse_catalog(args.catalog)
    product_version, stub_names = parse_product_def(args.product_def)
    if product_version != catalog_version:
        raise ValueError(
            f"catalog version mismatch: catalog={catalog_version}, product={product_version}")
    unknown_names = sorted(set(stub_names) - set(catalog))
    if unknown_names:
        raise ValueError(f"unknown APIs in {args.product_def}: {', '.join(unknown_names)}")

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.report.parent.mkdir(parents=True, exist_ok=True)
    selected_entries = [catalog[name] for name in stub_names]
    write_if_changed(args.output, render_source(args.product, selected_entries))
    write_report(args.report, args.product, catalog, stub_names)


if __name__ == "__main__":
    main()
