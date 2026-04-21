#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# ----------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------

import os
import re
import datetime
import logging
from collections import defaultdict
from dataclasses import dataclass, field

os.environ.pop('http_proxy', None)
os.environ.pop('https_proxy', None)
os.environ.pop('HTTP_PROXY', None)
os.environ.pop('HTTPS_PROXY', None)


@dataclass
class RegisterProcessorContext:
    file_type: str
    normal_registers: list = field(default_factory=list)
    debug_registers: list = field(default_factory=list)
    seen_normal_addresses: set = field(default_factory=set)
    seen_debug_addresses: set = field(default_factory=set)
    duplicate: dict = field(default_factory=lambda: {'normal': [], 'debug': [], 'file': ''})


def setup_logging(log_file_path):
    try:
        logging.basicConfig(
            level=logging.INFO,
            format='[%(asctime)s] %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S',
            handlers=[
                logging.FileHandler(log_file_path, mode='w', encoding='utf-8'),
                logging.StreamHandler()
            ]
        )
        logging.info("=== Register Code Generator Log ===")
    except Exception as e:
        logging.basicConfig(
            level=logging.INFO,
            format='[%(asctime)s] %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        logging.error(f"Error setting up log file: {e}")


def log_msg(message):
    logging.info(message)


def parse_bit_width(bit_width_str):
    match = re.match(r'(\d+):(\d+)', bit_width_str)
    if match:
        high = int(match.group(1))
        low = int(match.group(2))
        return high - low + 1
    return 32


def get_register_type(file_type='AIC', is_debug=False):
    if is_debug:
        return f'RegisterType::{file_type}_DBG'
    return f'RegisterType::{file_type}_OFFSET'


def merge_consecutive_addresses(registers, address_gap):
    if not registers:
        return {}
    
    sorted_regs = sorted(registers, key=lambda x: x['address'])
    by_type = defaultdict(list)
    
    for reg in sorted_regs:
        by_type[reg['type']].append(reg)
    
    merged_by_type = {}
    
    for reg_type, regs in by_type.items():
        if not regs:
            continue
        
        merged = []
        current_start = regs[0]['address']
        current_count = 1
        current_bit_width = regs[0]['bit_width']
        
        for reg in regs[1:]:
            expected_addr = current_start + current_count * address_gap
            is_consecutive = (reg['address'] == expected_addr and reg['bit_width'] == current_bit_width)
            
            if is_consecutive:
                current_count += 1
            else:
                merged.append({'start': current_start, 'count': current_count, 'bit_width': current_bit_width})
                current_start = reg['address']
                current_count = 1
                current_bit_width = reg['bit_width']
        
        merged.append({'start': current_start, 'count': current_count, 'bit_width': current_bit_width})
        merged_by_type[reg_type] = merged
    
    return merged_by_type


def _read_reginfo_file(input_file):
    try:
        with open(input_file, 'r') as f:
            return f.readlines()
    except FileNotFoundError:
        log_msg(f"Error: File not found: {input_file}")
        return None
    except Exception as e:
        log_msg(f"Error opening file {input_file}: {e}")
        return None


def _should_skip_line(line):
    if not line or line.startswith('#'):
        return True
    parts = line.split()
    if len(parts) < 5:
        return True
    return False


def _should_skip_operation(operation):
    return operation in ['judge', 'end', 'lookup']


def _should_skip_register(reg_name):
    return reg_name in ['SC_SYSCTRL_LOCK', 'SYSCTRL_LOCK']


def _is_debug_register(reg_name):
    return 'SC_DBG' in reg_name


def _process_debug_address_pair(lines, i, parts, context):
    if i + 1 >= len(lines):
        return None
    
    next_line = lines[i + 1].strip()
    next_parts = next_line.split()
    
    if len(next_parts) < 2 or next_parts[1] != 'SC_DBG_ADDR_H':
        return None
    
    try:
        low_value = int(parts[4], 16)
        high_value = int(next_parts[4], 16)
    except ValueError as e:
        log_msg(f"Error parsing hex values at line {i}: {e}")
        return None
    
    debug_addr = (high_value << 32) | low_value
    
    if debug_addr in context.seen_debug_addresses:
        log_msg(f"Warning: Duplicate debug address 0x{debug_addr:x} skipped (line {i+1})")
        context.duplicate['debug'].append({'address': debug_addr, 'line': i + 1})
        return None
    
    context.seen_debug_addresses.add(debug_addr)
    debug_type = get_register_type(context.file_type, is_debug=True)
    
    context.debug_registers.append({
        'name': 'Debug',
        'address': debug_addr,
        'bit_width': parse_bit_width(parts[3]),
        'type': debug_type
    })
    
    return 1


def _process_normal_register(reg_name, reg_addr, bit_width, context, line_num):
    try:
        normal_addr = int(reg_addr, 16)
    except ValueError as e:
        log_msg(f"Error parsing register address at line {line_num}: {e}")
        return False
    
    if normal_addr in context.seen_normal_addresses:
        log_msg(f"Warning: Duplicated normal address 0x{normal_addr:x} ({reg_name}) skipped (line {line_num+1})")
        context.duplicate['normal'].append({'address': normal_addr, 'name': reg_name, 'line': line_num + 1})
        return False
    
    context.seen_normal_addresses.add(normal_addr)
    
    context.normal_registers.append({
        'name': reg_name,
        'address': normal_addr,
        'bit_width': parse_bit_width(bit_width),
        'type': get_register_type(context.file_type, is_debug=False)
    })
    
    return True


def process_reginfo(input_file, file_type='AIC'):
    context = RegisterProcessorContext(file_type=file_type)
    context.duplicate['file'] = os.path.basename(input_file)
    
    lines = _read_reginfo_file(input_file)
    if lines is None:
        return [], [], context.duplicate
    
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        
        if _should_skip_line(line):
            i += 1
            continue
        
        parts = line.split()
        operation = parts[0]
        reg_name = parts[1]
        reg_addr = parts[2]
        bit_width = parts[3]
        value = parts[4]
        
        if _should_skip_operation(operation):
            i += 1
            continue
        
        if _should_skip_register(reg_name):
            i += 1
            continue
        
        if reg_name == 'SC_DBG_ADDR_L':
            skip = _process_debug_address_pair(lines, i, parts, context)
            if skip is not None:
                i += skip + 1
                continue
        
        if _is_debug_register(reg_name):
            i += 1
            continue
        
        _process_normal_register(reg_name, reg_addr, bit_width, context, i)
        i += 1
    
    return context.normal_registers, context.debug_registers, context.duplicate


def generate_cpp_output(all_normal_registers, all_debug_registers, output_file):
    merged_all_normal = {}
    for normal_registers in all_normal_registers:
        merged = merge_consecutive_addresses(normal_registers, 4)
        for reg_type, ranges in merged.items():
            if reg_type not in merged_all_normal:
                merged_all_normal[reg_type] = []
            merged_all_normal[reg_type].extend(ranges)
    
    merged_all_debug = {}
    for debug_registers in all_debug_registers:
        merged = merge_consecutive_addresses(debug_registers, 1)
        for reg_type, ranges in merged.items():
            if reg_type not in merged_all_debug:
                merged_all_debug[reg_type] = []
            merged_all_debug[reg_type].extend(ranges)
    
    total_normal = sum(len(regs) for regs in all_normal_registers)
    total_debug = sum(len(regs) for regs in all_debug_registers)
    
    cpp_lines = []
    cpp_lines.append("// Auto-generated CloudV4Register initialization function")
    cpp_lines.append(f"// Normal registers: {total_normal} registers")
    cpp_lines.append(f"// Debug registers: {total_debug} registers")
    cpp_lines.append("")
    cpp_lines.append("void CloudV4Register() {")
    cpp_lines.append("    registerTableMap_ = {")
    
    for reg_type in sorted(merged_all_normal.keys()):
        ranges = merged_all_normal[reg_type]
        ranges = sorted(ranges, key=lambda x: x['start'])
        
        if ranges:
            cpp_lines.append(f"        {{{reg_type}, {{")
            for reg_range in ranges:
                line = f"            {{0x{reg_range['start']:x}, {reg_range['bit_width']}, {reg_range['count']}}},"
                cpp_lines.append(line)
            cpp_lines.append("        },")
    
    for reg_type in sorted(merged_all_debug.keys()):
        ranges = merged_all_debug[reg_type]
        ranges = sorted(ranges, key=lambda x: x['start'])
        
        if ranges:
            cpp_lines.append(f"        {{{reg_type}, {{")
            for reg_range in ranges:
                line = f"            {{0x{reg_range['start']:x}, {reg_range['bit_width']}, {reg_range['count']}}},"
                cpp_lines.append(line)
            cpp_lines.append("        },")
    
    cpp_lines.append("    };")
    cpp_lines.append("}")
    
    with open(output_file, 'w') as f:
        f.write('\n'.join(cpp_lines))
    
    log_msg(f"Generated {output_file}")
    log_msg(f"Total normal registers: {total_normal}")
    log_msg(f"Total debug registers: {total_debug}")


def main():
    import glob
    
    script_dir = os.path.dirname(os.path.abspath(__file__))
    log_file_path = os.path.join(script_dir, 'generate_register_init.log')
    setup_logging(log_file_path)
    
    output_file = os.path.join(script_dir, 'output.cpp')
    
    pattern = os.path.join(script_dir, 'reginfo*.txt')
    files = glob.glob(pattern)
    
    if len(files) == 0:
        log_msg(f"No reginfo*.txt files found in {script_dir}")
        return
    
    all_normal_registers = []
    all_debug_registers = []
    
    for input_file in files:
        filename = os.path.basename(input_file)
        if 'AIV' in filename:
            file_type = 'AIV'
        elif 'AIC' in filename:
            file_type = 'AIC'
        else:
            file_type = 'AIC'
        
        try:
            log_msg(f"Processing {input_file} (type: {file_type})")
            normal_registers, debug_registers, duplicate_info = process_reginfo(input_file, file_type)
            all_normal_registers.append(normal_registers)
            all_debug_registers.append(debug_registers)
        except Exception as e:
            log_msg(f"Error processing {input_file}: {e}")
    
    generate_cpp_output(all_normal_registers, all_debug_registers, output_file)

if __name__ == '__main__':
    main()
