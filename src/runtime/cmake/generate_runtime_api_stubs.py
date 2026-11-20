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
from typing import Dict, List, Mapping, Optional, Sequence, Tuple


CATALOG_VERSION_MACRO = "RUNTIME_API_CATALOG_VERSION"
CATALOG_ENTRY_MACRO = "RUNTIME_API"
PRODUCT_VERSION_MACRO = "RUNTIME_API_CATALOG_VERSION"
PRODUCT_STUB_MACRO = "RUNTIME_API_STUB"
PRODUCT_STUB_VISIBILITY_MACRO = "RUNTIME_API_STUB_VISIBILITY"
SUPPORTED_POLICIES = {"FEATURE_NOT_SUPPORT", "MEMORY_RESERVED", "SUCCESS_NOOP", "VOID_NOOP"}
SUPPORTED_VISIBILITIES = {"EXPORT", "HIDDEN"}
SUPPORTED_PRODUCT_STUB_VISIBILITIES = {"CATALOG", "HIDDEN"}


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


def parse_product_def(path: Path) -> Tuple[int, List[str], str, Dict[str, str]]:
    content = strip_comments(path.read_text(encoding="utf-8"))
    version = parse_single_version(content, path)
    names = []
    visibility_overrides = {}
    for invocation in extract_invocations(content, PRODUCT_STUB_MACRO):
        fields = split_top_level(invocation)
        if len(fields) not in {1, 2}:
            raise ValueError(
                f"{path}: {PRODUCT_STUB_MACRO} expects 1 or 2 fields, got {len(fields)}"
            )
        name = fields[0]
        if not name.isidentifier():
            raise ValueError(f"{path}: invalid API name {name}")
        names.append(name)
        if len(fields) == 2:
            visibility = fields[1]
            if visibility not in SUPPORTED_VISIBILITIES:
                raise ValueError(f"{path}: unsupported stub visibility {visibility} for {name}")
            visibility_overrides[name] = visibility
    duplicates = sorted({name for name in names if names.count(name) > 1})
    if duplicates:
        raise ValueError(f"{path}: duplicate stub APIs: {', '.join(duplicates)}")
    visibility_values = extract_invocations(content, PRODUCT_STUB_VISIBILITY_MACRO)
    if len(visibility_values) > 1:
        raise ValueError(f"{path}: at most one {PRODUCT_STUB_VISIBILITY_MACRO} is allowed")
    stub_visibility = visibility_values[0].strip() if visibility_values else "CATALOG"
    if stub_visibility not in SUPPORTED_PRODUCT_STUB_VISIBILITIES:
        raise ValueError(f"{path}: unsupported product stub visibility {stub_visibility}")
    return version, names, stub_visibility, visibility_overrides


def argument_names(arguments: str) -> Sequence[str]:
    if arguments in {"", "void"}:
        return []
    return split_top_level(arguments)


def resolve_stub_visibility(
    entry: ApiEntry,
    product_stub_visibility: str = "CATALOG",
    visibility_override: Optional[str] = None,
) -> str:
    if entry.visibility == "HIDDEN" and visibility_override == "EXPORT":
        raise ValueError(f"cannot export catalog-hidden API {entry.name}")
    if visibility_override is not None:
        return visibility_override
    if product_stub_visibility == "HIDDEN":
        return "HIDDEN"
    return entry.visibility


def render_stub(
    entry: ApiEntry,
    product_stub_visibility: str = "CATALOG",
    visibility_override: Optional[str] = None,
) -> str:
    lines = []
    if resolve_stub_visibility(entry, product_stub_visibility, visibility_override) == "EXPORT":
        lines.append("VISIBILITY_DEFAULT")
    lines.extend([f"{entry.return_type} {entry.name}({entry.signature})", "{"])
    for argument in argument_names(entry.arguments):
        lines.append(f"    UNUSED({argument});")
    if entry.policy == "FEATURE_NOT_SUPPORT":
        lines.append("    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;")
    elif entry.policy == "MEMORY_RESERVED":
        lines.append("    return RT_MEMORY_RESERVED;")
    elif entry.policy == "SUCCESS_NOOP":
        lines.append("    return ACL_RT_SUCCESS;")
    lines.append("}")
    return "\n".join(lines)


def render_source(
    product: str,
    entries: Sequence[ApiEntry],
    product_stub_visibility: str = "CATALOG",
    visibility_overrides: Optional[Mapping[str, str]] = None,
) -> str:
    overrides = visibility_overrides or {}
    body = "\n\n".join(
        render_stub(entry, product_stub_visibility, overrides.get(entry.name)) for entry in entries
    )
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
#include "rt_external.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "api.hpp"

using namespace cce::runtime;

extern "C" {{
{body}}} // extern "C"
'''


def render_test_case(entry: ApiEntry) -> str:
    invoke = f"InvokeWithDefaultArguments(&{entry.name})"
    if entry.policy == "FEATURE_NOT_SUPPORT":
        assertion = f"EXPECT_EQ({invoke}, ACL_ERROR_RT_FEATURE_NOT_SUPPORT);"
    elif entry.policy == "MEMORY_RESERVED":
        assertion = f"EXPECT_EQ({invoke}, RT_MEMORY_RESERVED);"
    elif entry.policy == "SUCCESS_NOOP":
        assertion = f"EXPECT_EQ({invoke}, ACL_RT_SUCCESS);"
    else:
        assertion = f"{invoke};"
    return f'''TEST(Arch5162RuntimeApiStubTest, {entry.name})
{{
    {assertion}
}}'''


def render_test_source(product: str, entries: Sequence[ApiEntry]) -> str:
    declarations = "\n".join(f"{entry.return_type} {entry.name}({entry.signature});" for entry in entries)
    tests = "\n\n".join(render_test_case(entry) for entry in entries)
    if tests:
        tests += "\n"
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
#include <type_traits>

#include "gtest/gtest.h"
#define RTS_WEAK
#include "rt_external.h"
#include "runtime/rt.h"
#include "runtime/rts/rts.h"
#include "api.hpp"

using namespace cce::runtime;

extern "C" {{
{declarations}
}} // extern "C"

namespace {{
template <typename T>
typename std::enable_if<!std::is_reference<T>::value, T>::type DefaultArgument()
{{
    return T{{}};
}}

template <typename T>
typename std::enable_if<std::is_lvalue_reference<T>::value, T>::type DefaultArgument()
{{
    static typename std::remove_reference<T>::type value{{}};
    return value;
}}

template <typename ReturnType, typename... Args>
ReturnType InvokeWithDefaultArguments(ReturnType (*api)(Args...))
{{
    return api(DefaultArgument<Args>()...);
}}
}} // namespace

{tests}'''


def write_if_changed(path: Path, content: str) -> None:
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return
    path.write_text(content, encoding="utf-8")


def write_report(
    path: Path,
    product: str,
    catalog: Dict[str, ApiEntry],
    stub_names: Sequence[str],
    product_stub_visibility: str = "CATALOG",
    visibility_overrides: Optional[Mapping[str, str]] = None,
) -> None:
    stub_set = set(stub_names)
    overrides = visibility_overrides or {}
    rows = []
    for name, entry in sorted(catalog.items()):
        provider = "strong_stub" if name in stub_set else "weak_real"
        visibility = ""
        if provider == "strong_stub":
            visibility = resolve_stub_visibility(entry, product_stub_visibility, overrides.get(name))
        rows.append((name, entry.module, visibility, provider))
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
    parser.add_argument("--test-output", type=Path)
    args = parser.parse_args()

    catalog_version, catalog = parse_catalog(args.catalog)
    product_version, stub_names, product_stub_visibility, visibility_overrides = parse_product_def(args.product_def)
    if product_version != catalog_version:
        raise ValueError(
            f"catalog version mismatch: catalog={catalog_version}, product={product_version}")
    unknown_names = sorted(set(stub_names) - set(catalog))
    if unknown_names:
        raise ValueError(f"unknown APIs in {args.product_def}: {', '.join(unknown_names)}")

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.report.parent.mkdir(parents=True, exist_ok=True)
    selected_entries = [catalog[name] for name in stub_names]
    write_if_changed(
        args.output,
        render_source(args.product, selected_entries, product_stub_visibility, visibility_overrides),
    )
    if args.test_output is not None:
        args.test_output.parent.mkdir(parents=True, exist_ok=True)
        write_if_changed(args.test_output, render_test_source(args.product, selected_entries))
    write_report(
        args.report,
        args.product,
        catalog,
        stub_names,
        product_stub_visibility,
        visibility_overrides,
    )


if __name__ == "__main__":
    main()
