#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
"""
# Purpose: support to transform .h to .c)
# Copyright Huawei Technologies Co., Ltd. 2010-2018. All rights reserved.
# Author:
"""


import os
import sys
import argparse
import re

PATTERN_FUNCTION = re.compile(r'.+\w+\([^;]*\);')
PATTERN_FUNCTION_WEAK = re.compile(r'.+\w+\([^;]*\) ASCEND_HAL_WEAK;')
INGORE_LIST = ["#ifndef __ASCEND_HAL_H__", "#ifndef ASCEND_EXTERNAL_H", 
    "#ifndef __ASCEND_INPACKAGE_HAL_H__", "#ifndef TS_API_H", "#ifndef __DRV_INTERNAL_H__",
    "#ifndef ASCEND_HAL_BASE_H"]

def collect_content(file_path):
    """
    功能描述 : 脚本入参解析
    参    数 : 调用脚本的传参
    返  回 值 : 解析后的参数值
    """
    with open(file_path) as file_cnt:
        content = file_cnt.readlines()
        contents = []
        change_line, left, right = 0, 0, 0
        skip = False
        for i in content:
            if i.strip(" ").startswith(r"//") or i.strip(" ").startswith(r"/**"):
                skip = True
            if skip:
                if i.strip(" ").startswith(r"//") or i.strip(" ").startswith(r"*/"):
                    skip = False
                continue
            left += i.count('(')
            right += i.count(')')
            i = i.replace('extern', '').replace('SECUREC_API', '')
            if change_line == 0:
                contents.append(i.strip(" "))
            elif change_line == 1:
                contents[-1] = contents[-1] + i
            if left != right:
                change_line = 1
            if i.strip().endswith(";") or (change_line == 1 and left == right):
                change_line = 0
                left = 0
                right = 0
    return contents

def collect_functions(file_path):
    """
    功能描述 : 脚本入参解析
    参    数 : 调用脚本的传参
    返  回 值 : 解析后的参数值
    """
    signatures = []
    if_num = 0
    endif_num = 0
    for i in collect_content(file_path):
        if "#if" in i and i.strip() not in INGORE_LIST:
            signatures.append(i)
            if_num += 1
        if "#else" in i:
            if "#if" in signatures[-1]:
                continue
            else:
                signatures.append(i)
        if "#endif" in i:
            if "#if" in signatures[-1]:
                signatures.pop()
                if_num -= 1
                continue
            else:
                if endif_num < if_num:
                    signatures.append(i)
                    endif_num += 1

        match = PATTERN_FUNCTION.match(i) or PATTERN_FUNCTION_WEAK.match(i)
        if match:
            signatures.append(i)
    return signatures


def implement_function(func):
    """
    功能描述 : 脚本入参解析
    参    数 : 调用脚本的传参
    返  回 值 : 解析后的参数值
    """
    function_def = func[:len(func) - 1].replace(";", "")
    function_def += '\n'
    function_def += '{\n'
    if not func.startswith("void"):
        if not func.startswith("DLLEXPORT void"):
            function_def += '    return 0;'
    if func.startswith("DLLEXPORT void *"):
        function_def += '    return NULL;'
    if func.startswith("DLLEXPORT void*"):
        function_def += '    return NULL;'
    function_def += '\n'
    function_def += '}'
    return function_def


def generate_stub_file(input_header):
    """
    功能描述 : 脚本入参解析
    参    数 : 调用脚本的传参
    返  回 值 : 解析后的参数值
    """
    content = generate_function(input_header)
    print("content has been generate")
    return content

def generate_function(header_files):
    """
    功能描述 : 脚本入参解析
    参    数 : 调用脚本的传参
    返  回 值 : 解析后的参数值
    """
    content = []
    for header_file in header_files:
        if not header_file.endswith('.h'):
            continue
        include_str = '#include "{}"\n'.format(os.path.basename(header_file))

        content.append(include_str)
        print("include concent build success")
        content.append('\n')
        # generate implement
        if not header_file.endswith('.h'):
            continue
        content.append("// stub for " + os.path.basename(header_file) + "\n")
        functions = collect_functions(header_file)

        print("inc file:{}, functions numbers:{}".format(header_file, len(functions)))
        for func in functions:
            if PATTERN_FUNCTION.match(func):
                content.append(implement_function(func) + "\n")
            elif PATTERN_FUNCTION_WEAK.match(func):
                delete_weak_func = func.replace(" ASCEND_HAL_WEAK", "")
                content.append(implement_function(delete_weak_func) + "\n")
            else:
                content.append(func)
                content.append("\n")

    print("implement concent build success")
    return content

def main(input_header, output_cfile):
    """
    功能描述 : main function
    参    数 :
    返  回 值 :
    """
    content = generate_stub_file(input_header)
    if content:
        print("stub content have been generated")
        if not output_cfile:
            output_cfile = os.path.basename(input_header).replace(".h", ".c")
        with open(output_cfile, mode='w') as output_cnt:
            output_cnt.writelines(content)
        return 0
    return -1

def args_prase():
    """
    功能描述 : 脚本入参解析
    参       数 : 调用脚本的传参
        usage: h2c.py [-h] [-i [input_header]] [-o [output_cfile]]

        This script is for h2c.py processing..

        optional arguments:
        -h, --help            show this help message and exit
        -i [input_header], --inheader [input_header]
                                This parameter define input header for transform.
        -o [output_cfile], --outcfile [output_cfile]
                                This parameter define output file.
    返  回 值 : 解析后的参数值
    """
    parser = argparse.ArgumentParser(
        description='This script is for h2c.py processing.')
    parser.add_argument('-i', '--inheader', metavar='inheader', required=True, \
                        dest='input_header', nargs='*', \
                        help='This parameter define input header for transform.')
    parser.add_argument('-o', '--outcfile', metavar='outcfile', required=False, \
                        dest='output_cfile', nargs='?', const='', default='', \
                        help='This parameter define output file.')
    return parser.parse_args()

if __name__ == "__main__":
    ARGS = args_prase()
    STATUS = main(ARGS.input_header, ARGS.output_cfile)
    sys.exit(STATUS)
