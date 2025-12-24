# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

file(READ "${CSEC_SOURCE_DIR}/Makefile" MAKEFILE_CONTENT)

# 检查是否已打过补丁（避免重复）
if(NOT MAKEFILE_CONTENT MATCHES "libc_sec\\.a")
    set(STATIC_RULE [=[

PROJECT_A = libc_sec.a
AR?=ar
LD?=$(CC)

static: $(OBJECTS)
	mkdir -p lib
	$(AR) rcs lib/$(PROJECT_A) $(patsubst %.o,obj/%.o,$(notdir $(OBJECTS)))
	@echo "finish $(PROJECT_A)"

lib: static $(PROJECT)
]=])

    file(APPEND "${CSEC_SOURCE_DIR}/Makefile" "${STATIC_RULE}")
endif()