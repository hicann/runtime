# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

# CMake 最低版本号要求
cmake_minimum_required (VERSION 3.13.5)

#项目名称
project(acl)

#全局变量
set(ACL_LIB "${PROJECT_SOURCE_DIR}/dependency/lib64")
set(CMAKE_VERBOSE_MAKEFILE ON)

# 安全规范编译命令
add_compile_options(-fvisibility=hidden)
add_compile_options("-fPIE")
add_compile_options("-std=c++11")
add_compile_options("-fPIC")
add_compile_options("-fstack-protector-all")
add_compile_options("-Wall")
add_compile_options("-Wextra")
add_compile_options("-Wfloat-equal")
add_compile_options("-fno-common")
add_compile_options("-D_FORTIFY_SOURCE=2")
add_compile_options("-fno-strict-aliasing")
add_compile_options("-O2")
add_compile_options("-Weffc++")
add_compile_options("-Wtrampolines")
add_compile_options("-Wformat=2")
add_compile_options("-Wdate-time")
add_compile_options("-Wswitch-default")
add_compile_options("-Wshadow")
add_compile_options("-Wconversion")
add_compile_options("-Wcast-qual")
add_compile_options("-Wcast-align")
add_compile_options("-Wvla")
add_compile_options("-Wunused")
add_compile_options("-Wundef")
add_compile_options("-fstrong-eval-order")
add_compile_options("-pipe")

add_link_options("-Wl,-z,now")
add_link_options("-Wl,-z,relro")
add_link_options("-Wl,-z,noexecstack")
add_link_options("-pie")
add_link_options("-s")
set(CMAKE_SKIP_RPATH TRUE)
set(CMAKE_CXX_FLAGS "-Wno-builtin-macro-redefined -U__FILE__ -D__FILE__='\"$(notdir $(abspath $<))\"'")

#依赖编译选项
add_definitions(-DENABLE_DVPP_INTERFACE)
add_definitions(-DASCEND_CI_LIMITED_PY37)

set(OS_TYPE $ENV{ARCH})

#头文件目录包含
#include_directories(${PROJECT_SOURCE_DIR}/opensource/python/python3/include/python3.8/)
if (OS_TYPE MATCHES "sw_64")
    include_directories(/usr/include/python3.7m)
    include_directories(/usr/include/python3.7m/numpy)
else()
    include_directories(/usr/local/include/)
    include_directories(/lib/python3.9/site-packages/numpy/core/include/)
    include_directories(/opt/buildtools/python-3.9.11/lib/python3.9/site-packages/numpy/core/include/)
    include_directories(/lib/python3.10/site-packages/numpy/core/include/)
    include_directories(/opt/buildtools/python-3.10.2/lib/python3.10/site-packages/numpy/core/include/)
    include_directories(/opt/buildtools/python-3.11.4/include/python3.11/)
    include_directories(/opt/buildtools/python-3.11.4/lib/python3.11/site-packages/numpy/core/include)
endif()

include_directories(${PROJECT_SOURCE_DIR}/dependency/include/)
include_directories(${PROJECT_SOURCE_DIR}/dependency/include/acl/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/rt/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/mdl/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/media/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/op/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/blas/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/util/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/prof/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/himpi/)
include_directories(${PROJECT_SOURCE_DIR}/pyACL/fv/)
# 动态链接库
link_directories(${ACL_LIB})

#添加src子目录
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/rt/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/mdl/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/media/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/op/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/blas/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/util/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/prof/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/himpi/ APP_SOURCES)
aux_source_directory(${PROJECT_SOURCE_DIR}/pyACL/fv/ APP_SOURCES)

#将源文件排序，从而保证BEP一致
list(SORT APP_SOURCES)

# 生成动态库或共享库
add_library(acl SHARED ${APP_SOURCES}) 

#去掉lib前缀，指定链接库
set_target_properties(acl PROPERTIES PREFIX  "")
target_link_libraries(acl ascendcl acl_dvpp acl_cblas acl_dvpp_mpi acl_retr)
