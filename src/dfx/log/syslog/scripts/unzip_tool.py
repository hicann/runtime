#!/usr/bin/env python
# coding=utf-8
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
"""
Function: unzip file tool by gzip
Copyright Huawei Technologies Co., Ltd. 2023-2023. All rights reserved.
"""
import sys
import os
import gzip

GZIP_HEAD = b'\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\x03'


def unzip_file(data_list, file_name):
    with open(file_name, 'ab+') as fou:
        i = 0
        for data in data_list:
            if (i == 0):
                i = 1
                continue
            try:
                ungz_data = gzip.decompress(GZIP_HEAD + data)
            except Exception as e:
                ungz_data = str.encode("gzip failed.\n")
            fou.write(ungz_data)

if __name__ == "__main__":
    with open(sys.argv[1], 'rb') as fin:
        line = fin.read()
    if not line:
        exit()
    else:
        line_list = line.split(GZIP_HEAD)
    out_file = sys.argv[1][:-3]
    unzip_file(line_list, out_file)
    line_list.clear()
