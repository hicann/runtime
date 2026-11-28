#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

"""Check private log tables against independent, ordinary enum declarations.

This deliberately checks source symbols, not integer ranges or metadata-derived
expectations: sparse members, aliases and declarations in every #if branch must
be reviewed when the enum changes. It never evaluates C++ initializers. The owner
registry contains locations, not a second copy of the enum member lists.
"""

import re
from collections import Counter
from pathlib import Path


class SyncError(ValueError):
    """A log table no longer agrees with its enum declaration."""


_LEX = re.compile(
    r'//[^\n]*|/\*.*?\*/|'
    r'(?:u8|u|U|L)?R"(?P<delimiter>[^\s()\\]{0,16})\(.*?\)(?P=delimiter)"|'
    r'(?:u8|u|U|L)?"(?:\\.|[^"\\])*"|'
    r"(?:u8|u|U|L)?'(?:\\.|[^'\\])*'|"
    r'[A-Za-z_]\w*|[0-9][\w.]*|::|[^\s]',
    re.DOTALL,
)
_IDENTIFIER = re.compile(r"[A-Za-z_]\w*\Z")
_META = re.compile(r"^[ \t]*#[ \t]*define[ \t]+([A-Za-z_]\w*_META)\b([^\n]*)$", re.MULTILINE)
_CLOSE = {"(": ")", "[": "]", "{": "}"}


def _source_without_comments(source):
    # C/C++ line splicing precedes comment removal, including // continuations.
    source = re.sub(r"\\\r?\n", "", source)
    return _LEX.sub(
        lambda match: "\n" * match[0].count("\n") + " "
        if match[0].startswith(("//", "/*")) else match[0], source
    )


def _token_text(source):
    return [match[0] for match in _LEX.finditer(source)]


def _closing(tokens, start):
    stack = []
    for index in range(start, len(tokens)):
        token = tokens[index]
        if token in _CLOSE:
            stack.append(_CLOSE[token])
        elif token in _CLOSE.values():
            if not stack or stack.pop() != token:
                raise SyncError("unbalanced declaration or metadata row")
            if not stack:
                return index
    raise SyncError("unterminated declaration or metadata row")


def _split_items(tokens):
    items = []
    start = 0
    index = 0
    while index < len(tokens):
        if tokens[index] in _CLOSE:
            index = _closing(tokens, index)
        elif tokens[index] == ",":
            items.append(tokens[start:index])
            start = index + 1
        index += 1
    if start < len(tokens):
        items.append(tokens[start:])
    return items


def _enum_items(source, anchor):
    """Return member tokens from the full enum containing anchor.

    Preprocessor directives are removed but both branches remain visible. A
    structural change that cannot be parsed fails, rather than skipping checks.
    """
    source = _source_without_comments(source)
    source = re.sub(r"^\s*#[^\n]*", "", source, flags=re.MULTILINE)
    tokens = _token_text(source)
    candidates = []
    index = 0
    while index < len(tokens):
        if tokens[index] != "enum":
            index += 1
            continue
        body = index + 1
        while body < len(tokens) and tokens[body] not in ("{", ";", "}"):
            body += 1
        if body == len(tokens) or tokens[body] != "{":
            index = body + 1
            continue
        end = _closing(tokens, body)
        items = _split_items(tokens[body + 1:end])
        if not any(item and item[0] == anchor for item in items):
            index = end + 1
            continue
        for item in items:
            if (not item or not _IDENTIFIER.fullmatch(item[0])
                    or (len(item) > 1 and (item[1] != "=" or len(item) == 2))):
                raise SyncError("unsupported enum member near " + " ".join(item[:4]))
        candidates.append(items)
        index = end + 1
    if len(candidates) != 1:
        raise SyncError(f"expected one enum containing {anchor}; found {len(candidates)}")
    duplicates = [name for name, count in Counter(item[0] for item in candidates[0]).items() if count > 1]
    if duplicates:
        raise SyncError(f"duplicate enum members near {anchor}: {', '.join(duplicates)}")
    return candidates[0]


def enum_members(source, anchor):
    """Include every named member, even aliases and UNKNOWN-valued sentinels."""
    return [item[0] for item in _enum_items(source, anchor)]


def _check_direction_alias(source):
    # This pre-existing exclusion must not hide a newly distinct value.
    # Review any expression change explicitly instead of evaluating arbitrary C++.
    items = _enum_items(source, "RT_MEMCPY_DIR_H2H")
    initializers = {item[0]: item[1:] for item in items}
    for symbol in ("RT_MEMCPY_DIR_H2H", "RT_MEMCPY_DIR_H2D"):
        if initializers.get(symbol) != ["=", "0"]:
            raise SyncError(
                "RT_MEMCPY_DIRECTION_META: alias exception needs re-review: "
                + symbol + " must remain explicitly zero"
            )


def _check_prof_task_begin_alias(source):
    # The begin marker shares the first task's value and cannot have a separate case.
    items = _enum_items(source, "PROF_TASK_TYPE_KERNEL_SIMT")
    initializers = {item[0]: item[1:] for item in items}
    if initializers["PROF_TASK_TYPE_KERNEL_SIMT"] != ["=", "PROF_TASK_TYPE_BEGIN"]:
        raise SyncError(
            "RT_PROF_TASK_TYPE_META: alias exception needs re-review: "
            "PROF_TASK_TYPE_KERNEL_SIMT must remain initialized from PROF_TASK_TYPE_BEGIN"
        )


def metadata_tables(source):
    """Return table symbols; diagnostic text remains implementation data."""
    source = _source_without_comments(source)
    # Do not interpret apparent directives inside string literals as metadata.
    source = _LEX.sub(
        lambda match: '"literal"' + "\n" * match[0].count("\n")
        if re.match(r'''(?:u8|u|U|L)?R?["']''', match[0]) else match[0], source
    )
    tables = {}
    for match in _META.finditer(source):
        name, definition = match.groups()
        signature = re.fullmatch(r"\s*\(([^)]*)\)(.*)", definition)
        if signature is None or not _IDENTIFIER.fullmatch(signature[1].strip()):
            raise SyncError(f"{name}: expected one metadata parameter")
        parameter, body = signature[1].strip(), signature[2]
        if name in tables:
            raise SyncError(f"duplicate metadata table: {name}")
        tokens = _token_text(body)
        symbols = []
        index = 0
        while index < len(tokens):
            if tokens[index:index + 2] != [parameter, "("]:
                raise SyncError(f"{name}: unsupported metadata row near {' '.join(tokens[index:index + 4])}")
            end = _closing(tokens, index + 1)
            columns = _split_items(tokens[index + 2:end])
            if (len(columns) != 2 or any(not column for column in columns)
                    or len(columns[0]) != 1 or not _IDENTIFIER.fullmatch(columns[0][0])):
                raise SyncError(f"{name}: expected X(symbol, text)")
            symbols.append(columns[0][0])
            index = end + 1
        if not symbols:
            raise SyncError(f"{name}: empty metadata table")
        tables[name] = symbols
    return tables


def check_members(table, expected, actual, ignored=()):
    """Compare symbols, allowing only explicitly documented existing exclusions."""
    expected_set, actual_set, ignored_set = set(expected), set(actual), set(ignored)
    duplicates = [name for name, count in Counter(actual).items() if count > 1]
    if duplicates:
        raise SyncError(f"{table}: duplicate metadata symbols: {', '.join(sorted(duplicates))}")
    invalid = ignored_set - expected_set
    overlap = ignored_set & actual_set
    if invalid or overlap:
        raise SyncError(f"{table}: stale exclusions: {', '.join(sorted(invalid | overlap))}")
    missing = expected_set - ignored_set - actual_set
    stale = actual_set - expected_set
    if missing or stale:
        raise SyncError(
            f"{table}: missing: {', '.join(sorted(missing)) or '(none)'}; "
            f"stale: {', '.join(sorted(stale)) or '(none)'}. "
            "Synchronize the enum declaration and its private X-MACRO table."
        )


# Each entry is (owner header, a unique enum locator, explicitly excluded symbols).
# Exclusions must be exact names with a reason; never exclude by suffix or value.
# H2H and H2D are the same existing zero-valued task direction; the switch
# uses H2D, as verified by TaskEnumLogTest.DirectionAliasesAndHolesPreserveCarrierWidth.
# PROF_TASK_TYPE_BEGIN shares the value of PROF_TASK_TYPE_KERNEL_SIMT.
# Only these exact aliases are excluded; new aliases still need review.
DOMAINS = {
    "RT_FUSION_SCHEM_MODE_META": ("pkg_inc/runtime/rt_external_base.h", "RT_SCHEM_MODE_NORMAL", ()),
    "RT_EXCEPTION_EXPAND_TYPE_META": ("pkg_inc/runtime/rt_external_base.h", "RT_EXCEPTION_INVALID", ()),
    "RT_DEVICE_MESSAGE_TYPE_META": ("pkg_inc/runtime/rt_external_device.h", "RT_GET_DEV_ERROR_MSG", ()),
    "RT_DQS_ZERO_COPY_TYPE_META": ("pkg_inc/runtime/rt_external_dqs.h", "RT_DQS_ZERO_COPY_INPUT", ()),
    "RT_FUSION_SUB_KERNEL_TYPE_META": ("pkg_inc/runtime/rt_external_kernel.h", "RT_FUSION_HCOM_CPU", ()),
    "RT_BIN_BUFFER_TYPE_META": ("pkg_inc/runtime/rt_external_kernel.h", "RT_BIN_HOST_ADDR", ()),
    "RT_BUFFER_GET_COMMAND_META": ("pkg_inc/runtime/rt_external_mem.h", "RT_BUFF_GET_MBUF_TIMEOUT_INFO", ()),
    "RT_MALLOC_ADVICE_META": ("pkg_inc/runtime/rt_external_mem.h", "RT_MEM_ADVISE_NONE", ()),
    "RT_QUEUE_QUERY_COMMAND_META": ("pkg_inc/runtime/rt_external_mem.h", "RT_MQ_QUERY_QUE_ATTR_OF_CUR_PROC", ()),
    "RT_MEMCPY_OR_REDUCE_KIND_META": ("pkg_inc/runtime/rt_external_mem.h", "RT_MEMCPY_HOST_TO_HOST", ()),
    "RT_MODEL_QUEUE_FLAG_META": ("pkg_inc/runtime/rt_external_model.h", "RT_MODEL_INPUT_QUEUE", ()),
    "RT_TASK_BUFFER_TYPE_META": ("pkg_inc/runtime/rt_external_preload.h", "HWTS_STATIC_TASK_DESC", ()),
    "RT_PRELOAD_TASK_TYPE_META": ("pkg_inc/runtime/rt_external_preload.h", "RT_TASK_TYPE_KERNEL_AICORE", ()),
    "RT_UTILIZATION_TYPE_META": ("pkg_inc/runtime/runtime/base.h", "RT_UTIL_TYPE_AICORE", ()),
    "RT_DEVICE_CALLBACK_DIRECTION_META": ("pkg_inc/runtime/runtime/base.h", "DEV_CB_POS_FRONT", ()),
    "RT_DEVICE_CAPABILITY_META": ("pkg_inc/runtime/runtime/config.h", "RT_SCHEDULE_SOFTWARE", ()),
    "RT_TASK_TIMEOUT_TYPE_META": ("pkg_inc/runtime/runtime/config.h", "RT_TIMEOUT_TYPE_OP_WAIT", ()),
    "RT_RUN_MODE_META": ("pkg_inc/runtime/runtime/dev.h", "RT_RUN_MODE_OFFLINE", ()),
    "RT_HDC_SERVICE_TYPE_META": ("pkg_inc/runtime/runtime/dev.h", "RT_HDC_SERVICE_TYPE_DMP", ()),
    "RT_EVENT_STATUS_META": ("pkg_inc/runtime/runtime/event.h", "RT_EVENT_INIT", ()),
    "RT_LAUNCH_KERNEL_TYPE_META": ("pkg_inc/runtime/runtime/kernel.h", "KERNEL_TYPE_CCE", ()),
    "RT_POINTER_MEMORY_TYPE_META": ("pkg_inc/runtime/runtime/mem.h", "RT_MEMORY_TYPE_HOST", ()),
    "RT_ADVISE_MEMORY_TYPE_META": ("pkg_inc/runtime/runtime/mem.h", "RT_ADVISE_PERSISTENT", ()),
    "RT_POINTER_LOCATION_META": ("pkg_inc/runtime/runtime/mem_base.h", "RT_MEMORY_LOC_HOST", ()),
    "RT_REDUCE_KIND_META": ("pkg_inc/runtime/runtime/mem_base.h", "RT_MEMCPY_SDMA_AUTOMATIC_ADD", ()),
    "RT_KERNEL_ARGS_TYPE_META": ("src/runtime/core/inc/args/args_inner.h", "RT_ARGS_NON_CPU_EX", ()),
    "RT_DEVICE_FAULT_TYPE_META": ("src/runtime/core/inc/common/internal_error_define.hpp", "L2_BUFFER_ERROR", ()),
    "RT_PROFILE_RECORD_TYPE_META": (
        "src/runtime/core/inc/common/profiler_struct.hpp", "PROFILE_RECORD_TYPE_SRART", (),
    ),
    "RT_MANAGED_MEMORY_FLAG_META": ("src/runtime/core/inc/drv/driver.hpp", "MANAGED_MEM_RW", ()),
    "RT_DAVID_EVENT_STATE_META": ("src/runtime/core/inc/event/event_david.hpp", "EVT_NOT_RECORDED", ()),
    "RT_KERNEL_RATIO_META": ("src/runtime/core/inc/kernel/elf.hpp", "RATION_TYPE_ONE_RATIO_TWO", ()),
    "RT_KERNEL_FUNCTION_ENTRY_TYPE_META": ("src/runtime/core/inc/kernel/elf.hpp", "KERNEL_TYPE_TILING_KEY", ()),
    "RT_KERNEL_REGISTER_TYPE_META": ("src/runtime/core/inc/kernel/kernel.hpp", "RT_KERNEL_REG_TYPE_CPU", ()),
    "RT_PRINT_DUMP_TYPE_META": ("src/runtime/core/inc/printf.hpp", "DUMP_DEFAULT", ()),
    "RT_KERNEL_MIX_TYPE_META": ("src/runtime/core/inc/runtime.hpp", "NO_MIX", ()),
    "RT_TASK_TIME_UNIT_META": ("src/runtime/core/inc/runtime.hpp", "RT_TIME_UNIT_TYPE_S", ()),
    "RT_STARS_INTERRUPT_DIRECTION_META": ("src/runtime/core/inc/stars/stars_base.hpp", "RT_STARS_SQE_INT_DIR_NO", ()),
    "RT_AICPU_TOPIC_TYPE_META": ("src/runtime/core/inc/stars/stars_base.hpp", "TOPIC_TYPE_DEVICE_AICPU_ONLY", ()),
    "RT_MODEL_EXECUTOR_TYPE_META": ("src/runtime/core/inc/stars/stars_base.hpp", "MODEL_EXECUTOR_TS", ()),
    "RT_MEMCPY_DIRECTION_META": (
        "src/runtime/core/inc/task/task_base.hpp", "RT_MEMCPY_DIR_H2H", ("RT_MEMCPY_DIR_H2H",),
    ),
    "RT_REPORT_PACKAGE_TYPE_META": ("src/runtime/core/inc/task/task_base.hpp", "RT_PACKAGE_TYPE_TASK_REPORT", ()),
    "RT_MODEL_MAINTENANCE_TYPE_META": ("src/runtime/core/inc/task/task_base.hpp", "MMT_STREAM_ADD", ()),
    "RT_MODEL_AICPU_KERNEL_TYPE_META": ("src/runtime/core/inc/task/task_base.hpp", "TS_AICPU_KERNEL_CCE", ()),
    "RT_ASYNC_CPY_METHOD_META": ("src/runtime/core/inc/task/task_info_base.hpp", "RT_ASYNC_CPY", ()),
    "RT_RUNTIME_FEATURE_META": ("src/runtime/core/inc/utils/capability.hpp", "RT_FEATURE_STARS_COMPATIBILITY", ()),
    "RT_QOS_MASTER_TYPE_META": ("src/runtime/core/inc/utils/qos.hpp", "MASTER_DVPP_ALL", ()),
    "RT_EVENT_STATE_PERIOD_META": (
        "src/runtime/core/src/event/event_state_callback_manager.hpp", "EVENT_STATE_PERIOD_RECORD", (),
    ),
    "RT_H2D_COPY_POLICY_META": ("src/runtime/core/src/pool/h2d_copy_mgr.hpp", "COPY_POLICY_DEFAULT", ()),
    "RT_H2H_COPY_POLICY_META": ("src/runtime/core/src/pool/h2h_copy_mgr.hpp", "H2H_POLICY_DEFAULT", ()),
    "RT_STREAM_STATE_CALLBACK_TYPE_META": ("src/runtime/core/src/stream/stream.hpp", "RT_STREAM_STATE_CALLBACK", ()),
    "RT_STREAM_SUBSCRIBE_FLAG_META": ("src/runtime/core/src/stream/stream.hpp", "SUBSCRIBE_NONE", ()),
    "RT_SOMA_REUSE_FLAG_META": ("src/runtime/feature/soma/stream_mem_pool.hpp", "REUSE_FLAG_STANDARD", ()),
    "RT_TASK_FAIL_CALLBACK_TYPE_META": ("src/runtime/core/src/device/device.hpp", "RT_SET_TASK_FAIL_CALLBACK", ()),
    "RT_DEVICE_SPLIT_MODE_META": ("src/runtime/core/src/device/device.hpp", "RT_NO_SPLIT_MODE", ()),
    "RT_DEVICE_STATE_CALLBACK_TYPE_META": ("src/runtime/core/src/device/device.hpp", "RT_DEVICE_STATE_CALLBACK", ()),
    "RT_NOTIFY_WAIT_MODE_META": ("pkg_inc/runtime/runtime/rts/rts_event.h", "WAIT_LESS_MODE", ()),
    "RT_COND_TASK_TYPE_META": ("src/inc/runtime/rt_inner_model.h", "RT_COND_TASK_TYPE_IF", ()),
    "RT_KERNEL_FUNCTION_TYPE_META": ("src/runtime/core/inc/kernel/elf.hpp", "KERNEL_FUNCTION_TYPE_INVALID", ()),
    "RT_STREAM_SWITCH_DATA_TYPE_META": ("pkg_inc/runtime/runtime/base.h", "RT_SWITCH_INT32", ()),
    "RT_TS_AICPU_MODEL_CMD_META": ("pkg_inc/runtime/runtime/rt_model.h", "TS_AICPU_MODEL_LOAD", ()),
    "RT_CC_TASK_QUEUE_STATUS_META": (
        "src/runtime/feature/cc_manager/task_queue/task_queue_abi.h", "TASK_QUEUE_STATUS_WAITING", (),
    ),
    "RT_PROF_CTRL_TYPE_META": ("pkg_inc/runtime/runtime/base.h", "RT_PROF_CTRL_SWITCH", ()),
    "RT_PROF_DRV_OP_META": ("src/runtime/core/inc/common/profiler_struct.hpp", "RT_PROF_DRV_API_DrvMemcpy", ()),
    "RT_PROF_TASK_TYPE_META": (
        "src/runtime/core/inc/task/task_base.hpp", "PROF_TASK_TYPE_KERNEL_SIMT", ("PROF_TASK_TYPE_BEGIN",),
    ),
    "RT_OPERATION_TYPE_META": ("src/runtime/core/inc/runtime_tsch_defines.h", "OP_ABORT_APP", ()),
    "RT_SNAPSHOT_OP_META": ("src/runtime/feature/snapshot/snapshot_socket.hpp", "GET_RESTORE_THREAD_ID", ()),
    "RT_SQ_ADDR_MEM_ORDER_TYPE_META": (
        "src/runtime/core/src/device/sq_addr_memory_pool.hpp", "SQ_ADDR_MEM_ORDER_TYPE_32K", (),
    ),
    "RT_STREAM_FAILURE_MODE_META": ("src/runtime/core/src/stream/stream.hpp", "CONTINUE_ON_FAILURE", ()),
    "RT_STREAM_REPORT_STATUS_META": (
        "src/runtime/core/inc/common/profiler_struct.hpp", "STREAM_STATUS_CREATE", (),
    ),
    "RT_TASK_WR_CQE_FLAG_META": ("src/runtime/core/inc/task/task_base.hpp", "TASK_WR_CQE_DEFAULT", ()),
}


# Scan the former source-local mapping location to catch accidental reintroduction.
LOCAL_METADATA_SOURCES = (
    "src/runtime/core/src/task/task_info/cond_op/cond_op_stream_task_base.cc",
)


def metadata_sources(root):
    root = Path(root)
    sources = {
        path.relative_to(root).as_posix()
        for path in (root / "src/runtime/core/src/common").glob("*enum_log.cc")
    }
    sources.update(path for path in LOCAL_METADATA_SOURCES if (root / path).is_file())
    return sorted(sources)


def check_repository(root, overrides=None):
    """Read current repository sources; overrides support isolated mutation tests."""
    root = Path(root)
    overrides = {} if overrides is None else overrides
    sources = {}

    def read(path):
        if path not in sources:
            sources[path] = overrides[path] if path in overrides else (root / path).read_text(encoding="utf-8")
        return sources[path]

    tables = {}
    for path in metadata_sources(root):
        for table, symbols in metadata_tables(read(path)).items():
            if table in tables:
                raise SyncError(f"duplicate metadata table across sources: {table}")
            tables[table] = symbols
    if set(tables) != set(DOMAINS):
        raise SyncError(
            "metadata owner registry mismatch; unregistered: "
            + ", ".join(sorted(set(tables) - set(DOMAINS)))
            + "; missing tables: " + ", ".join(sorted(set(DOMAINS) - set(tables)))
        )
    for table, (path, anchor, ignored) in DOMAINS.items():
        try:
            if table == "RT_MEMCPY_DIRECTION_META":
                _check_direction_alias(read(path))
            elif table == "RT_PROF_TASK_TYPE_META":
                _check_prof_task_begin_alias(read(path))
            check_members(table, enum_members(read(path), anchor), tables[table], ignored)
        except SyncError as error:
            raise SyncError(f"{path}: {error}") from error
    return {"tables": len(tables), "symbols": sum(len(symbols) for symbols in tables.values())}
