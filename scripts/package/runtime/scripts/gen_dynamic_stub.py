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
import os
import re
import sys
import logging
from enum import Enum

ACL_RT_SET = {"acl_rt_impl.h"}
ACL_MODEL_SET = set()
ACL_OP_EXECUTOR_SET = set()
WRAPPER_FILE_NAME = "acl_rt_wrapper.h"
TARGET_WRAPPER_MAPS = (
    "ACL_FUNC_MAP",
    "ACL_RT_FUNC_MAP",
    "ACL_MDLRI_FUNC_MAP",
    "ACL_MDL_FUNC_MAP",
    "ACL_RT_ALLOCATOR_FUNC_MAP",
)


def get_func_infos(func):
    pattern = (r'((?:(?:const|volatile|static)\s+)*\w+(?:\s*\*+\s*)?)'
               r'\s*(\w+)\s*\('
               r'(\s*(?:(?:(?:(?:const|volatile|static)\s+)*\w+(?:\s*(?:\*+\s*)+)?)\s*\w+\s*'
               r'(?:\[[^\]]*?\])*(?:,[\s\.]*)?)*)\)')
    match = re.search(pattern, func)
    if match:
        return_type = match.group(1)
        func_name = match.group(2)
        params = match.group(3)

        if params == "void":
            param_names = []
        else:
            param_pattern = r'\b(\w+)\s*(?:\[[^\]]*?\])*(?:,|$)'
            param_names = re.findall(param_pattern, params)
        return return_type, func_name, param_names
    else:
        logging.warning("No match func: %s", func)
        return None, None, None

PATTERN_FUNCTION = re.compile(r'ACL_FUNC_VISIBILITY\s+\n*(.+\w+\([^();]*\);)')

HANDLE_GET = '\n'                       \
             'std::string GetSoPath(const void *instance, std::string so_name)\n'    \
             '{\n'   \
             '   Dl_info dlInfo;\n' \
             '   std::string realFilePath;\n'   \
             '   if (dladdr(instance, &dlInfo) == 0) {\n'   \
             '       printf("Call dladdr failed.\\n");\n'    \
             '       return realFilePath;\n'    \
             '   }\n'   \
             '   std::string soPath = dlInfo.dli_fname;\n'  \
             '   if (soPath.empty()) {\n'   \
             '       printf("So file path is empty.\\n");\n' \
             '       return realFilePath;\n'    \
             '   }\n'   \
             '   char resolvedPath[PATH_MAX] = {0x00};\n'   \
             '   if (realpath(soPath.c_str(), resolvedPath) == NULL) {\n'   \
             '       printf("Got realpath failed, soPath is %s.\\n", soPath.c_str());\n' \
             '       return realFilePath;\n'    \
             '    }\n'   \
             '    std::string soFilePath = resolvedPath;\n'  \
             '    std::string::size_type pos = soFilePath.rfind(\'/\');\n' \
             '    if (pos == std::string::npos) {\n' \
             '        printf("Invalid path %s, not contain /\\n", soFilePath.c_str());\n' \
             '        return realFilePath;\n'    \
             '    }\n'   \
             '    realFilePath = soFilePath.substr(0, pos + 1);\n'   \
             '    return realFilePath + so_name;\n'  \
             '}\n'   \
             '\n'   \
             '\n'   \
             'void *GetSoHandleAclRt() {\n' \
             '  static void *dl_handle = dlopen(GetSoPath((void *)GetSoHandleAclRt, \
"libruntime.so").c_str(), RTLD_NOW | RTLD_GLOBAL);\n'  \
             '  if (!dl_handle) {\n'    \
             '      printf("Falied to dlopen libruntime.so, please check your install environment.\\n");\n'    \
             '      _exit(-1);\n'   \
             '  }\n'    \
             '  return dl_handle;\n'    \
             '}\n'  \
             '\n'   \
             '\n'   \
             'void *GetSoHandleAclModel() {\n' \
             '  static void *dl_handle = dlopen(GetSoPath((void *)GetSoHandleAclModel, \
"libacl_mdl.so").c_str(), RTLD_NOW | RTLD_GLOBAL);\n'  \
             '  if (!dl_handle) {\n'    \
             '      printf("Falied to dlopen libacl_mdl.so, please check your install environment.\\n");\n'    \
             '      _exit(-1);\n'   \
             '  }\n'    \
             '  return dl_handle;\n'    \
             '}\n'  \
             '\n'   \
             '\n'   \
             'void *GetSoHandleAclOpExecutor() {\n' \
             '  static void *dl_handle = dlopen(GetSoPath((void *)GetSoHandleAclOpExecutor, \
"libacl_op_executor.so").c_str(), RTLD_NOW | RTLD_GLOBAL);\n'  \
             '  if (!dl_handle) {\n'    \
             '      printf("Falied to dlopen libacl_op_executor.so, please check your install environment.\\n");\n'    \
             '      _exit(-1);\n'   \
             '  }\n'    \
             '  return dl_handle;\n'    \
             '}\n'  \
             '\n'   \
             '#define ASSERT_SOHANDLE_VALID(handle)\\\n'    \
             'if (!handle) {\\\n'   \
             '  printf("handle for \'%s\' is null.\\n", __FUNCTION__);\\\n' \
             '  _exit(-1);\\\n' \
             '}\n'


class PathType(Enum):
    RUNTIME_INC = 1
    GE_INC = 2


def collect_header_files(path, path_type):
    """input path,return relevant header files"""
    acl_headers = []
    for root, _, files in os.walk(path):
        files.sort()
        for file in files:
            file_name = file.split("/")[-1]
            if path_type == PathType.RUNTIME_INC and file_name in ACL_RT_SET:
                file_path = os.path.join(root, file)
                file_path = file_path.replace('\\', '/')
                acl_headers.append(file_path)
            elif path_type == PathType.GE_INC and (file_name in ACL_MODEL_SET or file_name in ACL_OP_EXECUTOR_SET):
                file_path = os.path.join(root, file)
                file_path = file_path.replace('\\', '/')
                acl_headers.append(file_path)
    return acl_headers


def collect_functions(file_path):
    file_name = os.path.basename(file_path)
    if file_name in ACL_RT_SET:
        function_entries = []
        seen_symbols = set()
        wrapper_path = os.path.join(os.path.dirname(file_path), WRAPPER_FILE_NAME)
        if os.path.exists(wrapper_path):
            wrapper_entries = collect_functions_from_wrapper(wrapper_path)
            for entry in wrapper_entries:
                symbol_name = entry["symbol"]
                if symbol_name in seen_symbols:
                    continue
                seen_symbols.add(symbol_name)
                function_entries.append(entry)
        else:
            logging.warning("wrapper file not found, fallback to regex parse: %s", wrapper_path)
        visibility_entries = collect_functions_from_visibility(file_path)
        for entry in visibility_entries:
            symbol_name = entry["symbol"]
            if symbol_name in seen_symbols:
                continue
            seen_symbols.add(symbol_name)
            function_entries.append(entry)
        return function_entries
    return collect_functions_from_visibility(file_path)


def collect_functions_from_visibility(file_path):
    function_entries = []
    with open(file_path, encoding='utf-8') as f:
        content = f.read()
        matches = PATTERN_FUNCTION.findall(content)
        for signature in matches:
            return_type, func_name, param_names = get_func_infos(signature)
            if return_type is None or func_name is None:
                continue
            sig_match = re.search(r'\w+\s*(\([^;]*\))\s*;', signature)
            if sig_match is None:
                logging.warning("No signature body match for function: %s", signature)
                continue
            func_signature = sig_match.group(1).strip()
            call_args = "()"
            if len(param_names) > 0:
                call_args = "(" + ", ".join(param_names) + ")"
            function_entries.append({
                "symbol": func_name,
                "return_type": return_type.strip(),
                "signature": func_signature,
                "call_args": call_args
            })
    return function_entries


def split_top_level_commas(text):
    parts = []
    depth = 0
    start = 0
    for i, ch in enumerate(text):
        if ch == '(':
            depth += 1
        elif ch == ')':
            depth -= 1
        elif ch == ',' and depth == 0:
            parts.append(text[start:i].strip())
            start = i + 1
    parts.append(text[start:].strip())
    return parts


def extract_wrapper_macro_body(content, macro_name):
    lines = content.splitlines()
    define_prefix = "#define {}(".format(macro_name)
    collecting = False
    body_lines = []
    for line in lines:
        stripped = line.strip()
        if not collecting:
            if stripped.startswith(define_prefix):
                collecting = True
            continue
        body_lines.append(line)
        if not line.rstrip().endswith("\\"):
            break
    return "\n".join(body_lines)


def parse_wrapper_entries(wrapper_body):
    function_entries = []
    idx = 0
    while True:
        start = wrapper_body.find("_(", idx)
        if start == -1:
            break
        depth = 1
        end = start + 2
        while end < len(wrapper_body) and depth > 0:
            if wrapper_body[end] == '(':
                depth += 1
            elif wrapper_body[end] == ')':
                depth -= 1
            end += 1
        if depth != 0:
            logging.warning("unmatched function tuple when parsing wrapper map, start=%d", start)
            break
        tuple_body = wrapper_body[start + 2:end - 1].strip()
        idx = end

        fields = split_top_level_commas(tuple_body)
        if len(fields) != 4:
            continue

        return_type, func_name, signature, call_args = [field.strip() for field in fields]
        symbol_name = "{}Impl".format(func_name)
        function_entries.append({
            "symbol": symbol_name,
            "return_type": return_type,
            "signature": signature,
            "call_args": call_args
        })
    return function_entries


def collect_functions_from_wrapper(wrapper_path):
    function_entries = []
    seen_symbols = set()
    with open(wrapper_path, encoding='utf-8') as f:
        content = f.read()

    for map_name in TARGET_WRAPPER_MAPS:
        map_body = extract_wrapper_macro_body(content, map_name)
        if map_body == "":
            logging.warning("map not found in wrapper: %s", map_name)
            continue
        parsed_entries = parse_wrapper_entries(map_body)
        logging.info("parsed map %s, functions numbers:%s", map_name, len(parsed_entries))
        for entry in parsed_entries:
            symbol_name = entry["symbol"]
            if symbol_name in seen_symbols:
                continue
            seen_symbols.add(symbol_name)
            function_entries.append(entry)

    return function_entries
    

def process_headers(headers, inc_dir, content):
    total = 0
    for header in headers:
        if not header.endswith('.h'):
            continue
        file_name = os.path.basename(header)
        so_handler = "GetSoHandleAclRt"
        if file_name in ACL_RT_SET:
            so_handler = "GetSoHandleAclRt"
        if file_name in ACL_OP_EXECUTOR_SET:
            so_handler = "GetSoHandleAclOpExecutor"
        if file_name in ACL_MODEL_SET:
            so_handler = "GetSoHandleAclModel"
        content.append("// stub for {}\n".format(header[len(inc_dir):]))
        function_entries = collect_functions(header)
        logging.info("inc file:%s, functions numbers:%s", header, len(function_entries))
        total += len(function_entries)
        for function_entry in function_entries:
            content.append("{}\n".format(implement_function(function_entry, so_handler)))
            content.append("\n")
    return total


def implement_function(function_entry, so_handler):
    symbol_name = function_entry["symbol"].strip()
    return_type = function_entry["return_type"].strip()
    signature = function_entry["signature"].strip()
    call_args = function_entry["call_args"].strip()
    declaration = "{} {}{}".format(return_type, symbol_name, signature)
    func_ptr = "{} (*){}".format(return_type, signature)
    func_prototype = "{} (*temp_func_ptr){}".format(return_type, signature)

    function_def = ""
    function_def += declaration
    function_def += '\n'
    function_def += '{\n'
    function_def += '   static ' + func_prototype + ' ='
    function_def += '\n'
    function_def += '       (' + func_ptr + ')dlsym(' + so_handler + '(), "' + symbol_name + '");\n'
    function_def += '   ASSERT_SOHANDLE_VALID(temp_func_ptr);\n'
    function_def += '   return temp_func_ptr'
    function_def += call_args
    function_def += ';'
    function_def += '\n'
    function_def += '}'
    return function_def


def generate_stub_file(ge_inc_dir, runtime_inc_dir):
    """input inc_dir and return relevant contents"""
    ge_header_files = collect_header_files(ge_inc_dir, PathType.GE_INC)
    runtime_header_files = collect_header_files(runtime_inc_dir, PathType.RUNTIME_INC)
    logging.info("header files has been generated")
    acl_content = generate_function(ge_header_files, runtime_header_files, ge_inc_dir, runtime_inc_dir)
    logging.info("acl_content has been generated")
    return acl_content


def generate_function(ge_header_files, runtime_header_files, ge_inc_dir, runtime_inc_dir):
    includes = []
    includes.append('#include <stdio.h>\n')
    includes.append('#include <dlfcn.h>\n')
    includes.append('#include <unistd.h>\n')
    includes.append('#include <limits.h>\n')
    includes.append('#include <string>\n')
    includes.append('#include <cstdarg>\n')
    # generate includes
    for header in ge_header_files:
        if not header.endswith('.h'):
            continue
        include_str = '#include "acl/{}"\n'.format(header[len(ge_inc_dir):])
        includes.append(include_str)
    for header in runtime_header_files:
        if not header.endswith('.h'):
            continue
        include_str = '#include "{}"\n'.format(header[len(runtime_inc_dir):])
        includes.append(include_str)

    content = includes
    content.append('// LCOV_EXCL_START\n')
    content.append(HANDLE_GET)
    logging.info("include concent build success")
    total = 0
    content.append('\n')
    # generate implement
    total += process_headers(ge_header_files, ge_inc_dir, content)
    total += process_headers(runtime_header_files, runtime_inc_dir, content)
    logging.info("implement concent build success")
    logging.info('total functions number is %s', total)
    content.append('// LCOV_EXCL_STOP\n')
    return content


def gen_code(ge_inc_dir, runtime_inc_dir, stub_path):
    """input inc_dir and relevant cpp files"""
    if not ge_inc_dir.endswith('/'):
        ge_inc_dir += '/'
    if not runtime_inc_dir.endswith('/'):
        runtime_inc_dir += '/'
    acl_content = generate_stub_file(ge_inc_dir, runtime_inc_dir)
    with open(stub_path, mode='w', encoding='utf-8') as f:
        f.writelines(acl_content)

if __name__ == '__main__':
    ge_include_dir = sys.argv[1]
    runtime_include_dir = sys.argv[2]
    stub_file = sys.argv[3]
    ge_inc_dir = os.path.abspath(ge_include_dir)
    runtime_inc_dir = os.path.abspath(runtime_include_dir)
    logging.basicConfig(stream=sys.stdout, level=logging.INFO, format='[%(levelname)s] %(message)s')
    gen_code(ge_inc_dir, runtime_inc_dir, stub_file)
