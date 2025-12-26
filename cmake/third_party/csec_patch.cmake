# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

if(NOT CSEC_SOURCE_DIR)
    message(FATAL_ERROR "CSEC_SOURCE_DIR not set")
endif()

set(MAKEFILE "${CSEC_SOURCE_DIR}/Makefile")

if(NOT EXISTS "${MAKEFILE}")
    message(FATAL_ERROR "Makefile not found: ${MAKEFILE}")
endif()
file(READ "${MAKEFILE}" MAKEFILE_CONTENT)

if("${MAKEFILE_CONTENT}" STREQUAL "")
    message(FATAL_ERROR "Makefile is empty!")
endif()

# --- 2. 修改 PROJECT 行（支持有/无空格）---
# 匹配: PROJECT=xxx 或 PROJECT = xxx
set(PROJECT_LINE_OLD "PROJECT[ \t]*=[ \t]*libboundscheck\\.so")
set(PROJECT_LINE_NEW "PROJECT = libc_sec.so")

if(MAKEFILE_CONTENT MATCHES "${PROJECT_LINE_OLD}")
    string(REGEX REPLACE "${PROJECT_LINE_OLD}" "${PROJECT_LINE_NEW}" MAKEFILE_CONTENT "${MAKEFILE_CONTENT}")
    message(STATUS "Replaced PROJECT line to: ${PROJECT_LINE_NEW}")
else()
    message(WARNING "Expected PROJECT=libboundscheck.so not found in Makefile! Current content:\n${MAKEFILE_CONTENT}")
endif()

# --- 3. 添加 SONAME 到链接命令 ---
# 找到包含 "-shared -o lib/\$@" 的行，并在其 -shared 后插入 soname
set(LINK_PATTERN "\\$\\(CC\\)[ \t]+-shared")
set(LINK_REPLACEMENT "\$(CC) -shared -Wl,-soname,libc_sec.so")

if(MAKEFILE_CONTENT MATCHES "-Wl,-soname,libc_sec\\.so")
    message(STATUS "SONAME already present, skip patching linker command.")
else()
    if(MAKEFILE_CONTENT MATCHES "${LINK_PATTERN}")
        string(REGEX REPLACE "${LINK_PATTERN}" "${LINK_REPLACEMENT}" MAKEFILE_CONTENT "${MAKEFILE_CONTENT}")
        message(STATUS "Patched linker command with SONAME")
    else()
        message(WARNING "Linker command pattern not found! Cannot add SONAME.")
    endif()
endif()

# --- 4. 添加静态库规则（仅当不存在时）---
if(NOT MAKEFILE_CONTENT MATCHES "PROJECT_A[ \t]*=[ \t]*libc_sec\\.a")
    set(STATIC_RULE [=[

# --- patched by CMake ---
PROJECT_A = libc_sec.a
AR?=ar
LD?=$(CC)

static: $(OBJECTS)
	mkdir -p lib
	$(AR) rcs lib/$(PROJECT_A) $(patsubst %.o,obj/%.o,$(notdir $(OBJECTS)))
	@echo "finish $(PROJECT_A)"

lib: static $(PROJECT)
# --- end patch ---
]=])
    set(MAKEFILE_CONTENT "${MAKEFILE_CONTENT}${STATIC_RULE}")
    message(STATUS "Appended static library build rule")
endif()

# --- 5. 写回文件（关键：确保内容非空）---
if("${MAKEFILE_CONTENT}" STREQUAL "")
    message(FATAL_ERROR "BUG: MAKEFILE_CONTENT is empty before writing!")
endif()

file(WRITE "${MAKEFILE}" "${MAKEFILE_CONTENT}")
message(STATUS "Successfully patched Makefile at ${MAKEFILE}")