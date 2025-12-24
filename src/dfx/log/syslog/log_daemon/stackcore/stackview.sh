#!/bin/bash
# This script provides function of parsing stackcore file.
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# get specified corefile from user input.
fn_set_corefile()
{
  if [ -n "$1" ]
  then
    if [ ! -r "$1" ]
    then
      echo "error: specified stackcore file does not exist or is not permitted to read."
      exit 1
    fi
    corefile=$1
  else
    echo "error: no corefile specified."
    exit 1
  fi
}

# get specified exefile path from user input.
fn_set_exepath()
{
  if [ -n "$1" ]
  then
    if [ ! -x "$1" ] || [ ! -r "$1" ]
    then
      echo "error: specified exe file path does not exist or is not permitted to read or execute."
      exit 1
    fi
    exe_input_path=$1
  else
    echo "error: no exefile path specified."
    exit 1
  fi
}

# check if the command is callable.
fn_check_command()
{
  if [ ! -x "$(command -v $1)" ]
  then
    echo "error: $1 is not callable, please check if $1 is permitted to execute"\
      "and the according path is included in \$PATH."
    exit 1
  fi
}

# read and parse stackcore file and do addr2line for each line.
# [stack]
# #0 0x0000000000400b74 0x40000 /user/xxx/a.out
fn_parse_file()
{
  local find_key=false
  local line_num=""
  local addr=""
  local binary_name=""
  local exe_file_path=""
  local addr2line_addr=""
  local addr2line_output=""

  fn_check_command "readelf"
  fn_check_command "addr2line"

  while read -r line
  do
    if [[ "${line}" == "[stack]" ]]
    then
      find_key=true
      continue
    fi
    if $find_key
    then
      line_num=$(echo $line | awk '{print $1}')
      stack_addr=$(echo $line | awk '{print $2}')
      delta_addr=$(echo $line | awk '{print $3}')
      binary_path=$(echo $line | awk '{print $4}')
      if [ -z "$line_num" ] || [ -z "$stack_addr" ] || [ -z "$delta_addr" ] || [ -z "$binary_path" ]
      then
        echo "warning: failed to parse \""$line"\" by [line_num] [stack_addr] [delta_addr] [binary_path], skip"
        continue
      else
        exe_full_path=$exe_input_path"/"${binary_path##*/}
        if [ ! -r "$exe_full_path" ]
        then
          echo "warning: "$exe_full_path" does not exist or is not permitted to read, print ? at ??:?"
          addr2line_output=${addr2line_output}"\n"${line_num}" ? at ??:?"
          continue
        fi

        elf_type_str_exec=$(readelf -h $exe_full_path | grep EXEC)
        elf_type_str_dyn=$(readelf -h $exe_full_path | grep DYN)
        if [ ! -z "$elf_type_str_exec" ]
        then
          # do addr2line command processing with stack_addr
          addr2line_addr=$stack_addr
        elif [ ! -z "$elf_type_str_dyn" ]
        then
          # do addr2line command processing with stack_addr - delta_addr
          addr2line_addr="0x"$(printf "%x" $((${stack_addr}-${delta_addr})))
        else
          echo "warning: neither EXEC nor DYN elf type, skip"
          continue
        fi

        addr2line_line_output=$(addr2line $addr2line_addr -e $exe_full_path -f -C -s)
        # the last column is [file_name:line_num], remaining is [function_name]
        function_name=$(echo $addr2line_line_output | awk '{$NF=""; print $0}')
        file_line_num=$(echo $addr2line_line_output | awk '{print $NF}')
        if [ -z "$function_name" ] || [ -z "$file_line_num" ]
        then
          echo "warning: failed to parse output: \""$addr2line_line_output"\" by [function_name] [file_line_num], skip"
          continue
        fi
        addr2line_output=${addr2line_output}"\n"${line_num}" "${function_name}" at "${file_line_num}" from "${binary_path##*/}
      fi
    fi
  done < $corefile
  if [ "$find_key" = false ]
  then
    echo "error: failed to find [stack] info in specified stackcore file, please check"\
      "if the specified stackcore file is correct."
    exit 1
  fi
  echo -e ${addr2line_output:2}
}

# print supported option combos.
fn_print_help()
{
  cat <<- EOF
  Desc: The script is used to parse stackcore file
  Usage: bash stackview.sh -c(--core) {stackcore file path including filename} -p(--path) {executable and dynamic so file path}
  Supported inputs：
               -c(--core)       specify stackcore file path including filename.
               -p(--path)       specify executable and according dynamic so file path.
    [optional] -h(--help)       check and process input arguments before -h and print this message.
EOF
  exit 0
}

# get user input and do check work
while [ -n "$1" ];do
  case "$1" in
  -c|--core)
    fn_set_corefile $2
    shift 2
    ;;
  -p|--path)
    fn_set_exepath $2
    shift 2
    ;;
  -h|--help)
    fn_print_help
    ;;
  --)
    shift
    break
    ;;
  -*)
    echo "error: no such option $1."
    fn_print_help
    exit 1
    ;;
  *)
    break
    ;;
  esac
done

# do file parseing
if [ -n "$corefile" ] && [ -n "$exe_input_path" ]
then
  fn_parse_file
else
  echo "error: please specify both corefile path and exe file path:"
  fn_print_help
  exit 1
fi
