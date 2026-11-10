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
Exit status 1 reports failed member decoding, a nonempty unrecognized prefix,
or nonempty input without recognized members. Healthy members are still written;
empty input exits successfully without creating an output file.
"""
import gzip
import logging
import sys

GZIP_HEAD = b'\x1f\x8b\x08\x00\x00\x00\x00\x00\x00\x03'


def unzip_file(data_list, file_name, source_name=None):
    """Write decoded members; return True only when a member exists,
    no nonempty unrecognized prefix exists, and every member decodes successfully.
    """
    input_name = source_name if source_name is not None else file_name
    success = True
    has_member = False
    with open(file_name, 'wb') as fou:
        i = 0
        for data in data_list:
            if (i == 0):
                i = 1
                if data:
                    success = False
                    logging.error(
                        "gzip decompression failed: input=%s, member=0 (prefix), "
                        "reason=nonempty unrecognized prefix%s",
                        input_name, "; later members will still be decoded" if len(data_list) > 1 else "")
                continue
            has_member = True
            i += 1
            try:
                ungz_data = gzip.decompress(GZIP_HEAD + data)
            except Exception as error:
                success = False
                logging.error(
                    "gzip decompression failed: input=%s, member=%s, reason=%s: %s",
                    input_name, i - 1, type(error).__name__, error)
                ungz_data = str.encode("gzip failed.\n")
            fou.write(ungz_data)
    if not has_member:
        logging.error("gzip decompression failed: input=%s, member=none, reason=no recognized gzip members",
                      input_name)
    return success and has_member

if __name__ == "__main__":
    logging.basicConfig(format='[%(asctime)s] [%(lineno)s] %(levelname)s: %(message)s',
                        level=logging.INFO)
    with open(sys.argv[1], 'rb') as fin:
        line = fin.read()
    if not line:
        exit()
    else:
        line_list = line.split(GZIP_HEAD)
    out_file = sys.argv[1][:-3]
    success = unzip_file(line_list, out_file, sys.argv[1])
    line_list.clear()
    if not success:
        logging.error("gzip decompression failed: input=%s, output=%s; see member diagnostics",
                      sys.argv[1], out_file)
        sys.exit(1)
