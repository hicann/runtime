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

from gen_dynamic_stub import (
    TARGET_WRAPPER_MAPS,
    extract_wrapper_macro_body,
    parse_wrapper_entries,
    split_top_level_commas,
)


CATALOG_VERSION_MACRO = "ACL_API_CATALOG_VERSION"
REAL_PROVIDER_COUNT_MACRO = "ACL_API_REAL_PROVIDER_COUNT"
PRODUCT_STUB_MACRO = "ACL_API_STUB"
SUPPORTED_POLICIES = {
    "ACL_FEATURE_UNSUPPORTED",
    "NULLPTR",
    "RT_FEATURE_NOT_SUPPORT",
    "VOID_NOOP",
    "ZERO",
}
NULLABLE_HANDLE_TYPES = {"aclrtAllocatorDesc", "aclrtBinary"}


@dataclass(frozen=True)
class AclApiEntry:
    return_type: str
    public_name: str
    impl_name: str
    signature: str
    arguments: str
    wrapper_map: str
    policy: str = ""


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


def normalize_field(value: str) -> str:
    value = re.sub(r"\\\s*\n\s*", " ", value)
    return re.sub(r"\s+", " ", value).strip()


def parse_single_version(content: str, source: Path) -> int:
    versions = extract_invocations(content, CATALOG_VERSION_MACRO)
    if len(versions) != 1 or not versions[0].isdigit():
        raise ValueError(f"{source}: exactly one numeric {CATALOG_VERSION_MACRO} is required")
    return int(versions[0])


def parse_single_numeric_macro(content: str, source: Path, macro: str) -> int:
    values = extract_invocations(content, macro)
    if len(values) != 1 or not values[0].isdigit():
        raise ValueError(f"{source}: exactly one numeric {macro} is required")
    return int(values[0])


def parse_wrapper(path: Path) -> Dict[str, AclApiEntry]:
    content = path.read_text(encoding="utf-8")
    entries: Dict[str, AclApiEntry] = {}
    for map_name in TARGET_WRAPPER_MAPS:
        body = extract_wrapper_macro_body(content, map_name)
        if body == "":
            definition = re.compile(rf"^\s*#define\s+{re.escape(map_name)}\s*\(_\)\s*$", re.MULTILINE)
            if definition.search(content) is None:
                raise ValueError(f"{path}: wrapper map not found: {map_name}")
            continue
        for raw_entry in parse_wrapper_entries(body):
            impl_name = normalize_field(raw_entry["symbol"])
            public_name = impl_name.removesuffix("Impl")
            if public_name in entries:
                raise ValueError(f"{path}: duplicate ACL API {public_name}")
            entries[public_name] = AclApiEntry(
                return_type=normalize_field(raw_entry["return_type"]),
                public_name=public_name,
                impl_name=impl_name,
                signature=normalize_field(raw_entry["signature"]),
                arguments=normalize_field(raw_entry["call_args"]),
                wrapper_map=map_name,
            )
    return entries


def parse_product_def(path: Path) -> Tuple[int, int, List[Tuple[str, str]]]:
    content = strip_comments(path.read_text(encoding="utf-8"))
    version = parse_single_version(content, path)
    real_provider_count = parse_single_numeric_macro(content, path, REAL_PROVIDER_COUNT_MACRO)
    product_entries = []
    for invocation in extract_invocations(content, PRODUCT_STUB_MACRO):
        fields = [normalize_field(field) for field in split_top_level_commas(invocation)]
        if len(fields) != 2:
            raise ValueError(f"{path}: {PRODUCT_STUB_MACRO} expects 2 fields, got {len(fields)}")
        name, policy = fields
        if policy not in SUPPORTED_POLICIES:
            raise ValueError(f"{path}: unsupported policy {policy} for {name}")
        product_entries.append((name, policy))

    names = [name for name, _ in product_entries]
    duplicates = sorted({name for name in names if names.count(name) > 1})
    if duplicates:
        raise ValueError(f"{path}: duplicate stub APIs: {', '.join(duplicates)}")
    if names != sorted(names):
        raise ValueError(f"{path}: ACL stub APIs must be sorted by name")
    return version, real_provider_count, product_entries


def is_nullable_type(return_type: str) -> bool:
    return "*" in return_type or return_type in NULLABLE_HANDLE_TYPES


def validate_policy(entry: AclApiEntry) -> None:
    if entry.policy in {"RT_FEATURE_NOT_SUPPORT", "ACL_FEATURE_UNSUPPORTED"}:
        if entry.return_type != "aclError":
            raise ValueError(f"{entry.public_name}: {entry.policy} requires aclError return type")
    elif entry.policy == "NULLPTR":
        if not is_nullable_type(entry.return_type):
            raise ValueError(f"{entry.public_name}: NULLPTR requires a pointer or nullable handle return type")
    elif entry.policy == "ZERO":
        if entry.return_type in {"aclError", "void"} or is_nullable_type(entry.return_type):
            raise ValueError(f"{entry.public_name}: ZERO requires a non-pointer value return type")
    elif entry.policy == "VOID_NOOP" and entry.return_type != "void":
        raise ValueError(f"{entry.public_name}: VOID_NOOP requires void return type")


def select_entries(
    wrapper_entries: Dict[str, AclApiEntry], product_entries: Sequence[Tuple[str, str]]
) -> List[AclApiEntry]:
    unknown_names = sorted({name for name, _ in product_entries} - set(wrapper_entries))
    if unknown_names:
        raise ValueError(f"unknown ACL APIs in product definition: {', '.join(unknown_names)}")

    selected = []
    for name, policy in product_entries:
        base = wrapper_entries[name]
        entry = AclApiEntry(
            return_type=base.return_type,
            public_name=base.public_name,
            impl_name=base.impl_name,
            signature=base.signature,
            arguments=base.arguments,
            wrapper_map=base.wrapper_map,
            policy=policy,
        )
        validate_policy(entry)
        selected.append(entry)
    return selected


def validate_real_provider_count(
    wrapper_entries: Dict[str, AclApiEntry], selected: Sequence[AclApiEntry], expected_count: int
) -> None:
    actual_count = len(wrapper_entries) - len(selected)
    if actual_count != expected_count:
        raise ValueError(
            "unexpected ACL real-provider count: "
            f"expected {expected_count}, got {actual_count}; new ACL APIs default to unsupported, "
            "add them to the product definition unless product support is explicitly confirmed"
        )


def argument_names(arguments: str) -> Sequence[str]:
    if arguments == "()":
        return []
    if not arguments.startswith("(") or not arguments.endswith(")"):
        raise ValueError(f"arguments must be enclosed in parentheses: {arguments}")
    names = [normalize_field(name) for name in split_top_level_commas(arguments[1:-1])]
    invalid_names = [name for name in names if not name.isidentifier()]
    if invalid_names:
        raise ValueError(f"arguments must be identifiers: {', '.join(invalid_names)}")
    return names


def render_return(policy: str) -> str:
    if policy == "RT_FEATURE_NOT_SUPPORT":
        return "    return ACL_ERROR_RT_FEATURE_NOT_SUPPORT;"
    if policy == "ACL_FEATURE_UNSUPPORTED":
        return "    return ACL_ERROR_FEATURE_UNSUPPORTED;"
    if policy == "NULLPTR":
        return "    return nullptr;"
    if policy == "ZERO":
        return "    return {};"
    return ""


def render_stub(entry: AclApiEntry) -> str:
    lines = ["ACL_FUNC_VISIBILITY", f"{entry.return_type} {entry.impl_name}{entry.signature}", "{"]
    lines.extend(f"    (void){argument};" for argument in argument_names(entry.arguments))
    return_statement = render_return(entry.policy)
    if return_statement:
        lines.append(return_statement)
    lines.append("}")
    return "\n".join(lines)


def render_source(product: str, entries: Sequence[AclApiEntry]) -> str:
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
#include "acl_rt_impl.h"

#ifdef __cplusplus
extern "C" {{
#endif

{body}#ifdef __cplusplus
}}
#endif
'''


def write_if_changed(path: Path, content: str) -> None:
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return
    path.write_text(content, encoding="utf-8")


def write_report(
    path: Path, product: str, wrapper_entries: Dict[str, AclApiEntry], selected: Sequence[AclApiEntry]
) -> None:
    selected_by_name = {entry.public_name: entry.policy for entry in selected}
    with path.open("w", encoding="utf-8", newline="") as report:
        writer = csv.writer(report)
        writer.writerow(["product", "acl_api", "impl_symbol", "return_type", "wrapper_map", "policy", "provider"])
        for name, entry in sorted(wrapper_entries.items()):
            policy = selected_by_name.get(name, "")
            writer.writerow(
                [
                    product,
                    name,
                    entry.impl_name,
                    entry.return_type,
                    entry.wrapper_map,
                    policy,
                    "strong_stub" if policy else "weak_real",
                ]
            )


def main() -> None:
    parser = argparse.ArgumentParser(description="Generate strong ACL Impl stubs from a product capability list")
    parser.add_argument("--wrapper", required=True, type=Path)
    parser.add_argument("--product-def", required=True, type=Path)
    parser.add_argument("--product", required=True)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    args = parser.parse_args()

    wrapper_entries = parse_wrapper(args.wrapper)
    product_version, real_provider_count, product_entries = parse_product_def(args.product_def)
    if product_version != 1:
        raise ValueError(f"unsupported ACL API catalog version: {product_version}")
    selected = select_entries(wrapper_entries, product_entries)
    validate_real_provider_count(wrapper_entries, selected, real_provider_count)

    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.report.parent.mkdir(parents=True, exist_ok=True)
    write_if_changed(args.output, render_source(args.product, selected))
    write_report(args.report, args.product, wrapper_entries, selected)


if __name__ == "__main__":
    main()
