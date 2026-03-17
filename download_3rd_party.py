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

import os
import re
import urllib.request
import ssl
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)


def download_file(url, target_dir):
    filename = url.split('/')[-1]
    target_path = os.path.join(target_dir, filename)
    if os.path.exists(target_path):
        logging.info(f"[{filename}] already exists, skipping.")
        return
    logging.info(f"Downloading [{filename}] from {url} ...")
    try:
        # Avoid SSL certificate verification issues
        context = ssl.create_default_context()
        context.check_hostname = False
        context.verify_mode = ssl.CERT_NONE
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
        with urllib.request.urlopen(req, context=context, timeout=60) as response, open(target_path, 'wb') as out_file:
            data = response.read()
            out_file.write(data)
        logging.info(f"Successfully downloaded [{filename}].")
    except Exception as e:
        logging.error(f"Failed to download [{filename}]: {e}")


def parse_readme_for_urls(content):
    urls = []
    link_pattern = re.compile(r'\]\((https?://[^\)]+)\)')
    in_table = False
    for line in content.split('\n'):
        if "| 开源软件" in line:
            in_table = True
        elif in_table and line.strip() == "":
            in_table = False
            
        if in_table and '|' in line and '](' in line:
            m = link_pattern.search(line)
            if m and m.group(1) not in urls:
                urls.append(m.group(1))
    return urls


def extract_urls(readme_path):
    if not os.path.exists(readme_path):
        return []
    with open(readme_path, "r", encoding="utf-8") as f:
        return parse_readme_for_urls(f.read())


def main():
    target_dir = "third_party"
    if not os.path.exists(target_dir):
        os.makedirs(target_dir)
        logging.info(f"Created directory: {target_dir}")

    urls = extract_urls("README.md")

    if not urls:
        logging.warning("No URLs found to download.")
        return

    logging.info(f"Found {len(urls)} files to download.")
    for url in urls:
        download_file(url, target_dir)
        
    logging.info(f"All downloads finished. Files are saved in '{target_dir}'.")

if __name__ == "__main__":
    main()
