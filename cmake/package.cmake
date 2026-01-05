# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

#### CPACK to package run #####
message(STATUS "System processor: ${CMAKE_SYSTEM_PROCESSOR}")
if (CMAKE_SYSTEM_PROCESSOR MATCHES "x86_64")
    message(STATUS "Detected architecture: x86_64")
    set(ARCH x86_64)
elseif (CMAKE_SYSTEM_PROCESSOR MATCHES "aarch64|arm64|arm")
    message(STATUS "Detected architecture: ARM64")
    set(ARCH aarch64)
else ()
    message(WARNING "Unknown architecture: ${CMAKE_SYSTEM_PROCESSOR}")
endif ()
# 打印路径
message(STATUS "CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")
message(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
message(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/makeself-fetch.cmake)

set(script_prefix ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts)
install(DIRECTORY ${script_prefix}/
    DESTINATION share/info/runtime/script
    FILE_PERMISSIONS
    OWNER_READ OWNER_WRITE OWNER_EXECUTE  # 文件权限
    GROUP_READ GROUP_EXECUTE
    WORLD_READ WORLD_EXECUTE
    DIRECTORY_PERMISSIONS
    OWNER_READ OWNER_WRITE OWNER_EXECUTE  # 目录权限
    GROUP_READ GROUP_EXECUTE
    WORLD_READ WORLD_EXECUTE
)
set(SCRIPTS_FILES
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/check_version_required.awk
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_func.inc
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_interface.sh
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_interface.csh
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_interface.fish
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/version_compatiable.inc
)

install(FILES ${SCRIPTS_FILES}
    DESTINATION share/info/runtime/script
)
set(COMMON_FILES
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/install_common_parser.sh
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_func_v2.inc
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_installer.inc
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/script_operator.inc
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/version_cfg.inc
)

set(PACKAGE_FILES
    ${COMMON_FILES}
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/multi_version.inc
)
set(LATEST_MANGER_FILES
    ${COMMON_FILES}
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/common_func.inc
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/version_compatiable.inc
    ${CMAKE_SOURCE_DIR}/scripts/package/common/sh/check_version_required.awk
)
set(CONF_FILES
    ${CMAKE_SOURCE_DIR}/scripts/package/common/cfg/path.cfg
    ${CMAKE_SOURCE_DIR}/scripts/package/common/cfg/ascend_package_load.ini
)

install(FILES ${RUNTIME_VERSION_FILE}
    DESTINATION share/info/runtime
)

install(FILES ${CONF_FILES}
    DESTINATION runtime/conf
)
install(FILES ${PACKAGE_FILES}
    DESTINATION share/info/runtime/script
)
install(FILES ${LATEST_MANGER_FILES}
    DESTINATION latest_manager
)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/scripts/package/latest_manager/scripts/
    DESTINATION latest_manager
)
install(FILES ${CMAKE_SOURCE_DIR}/src/acl/config/swFeatureList.json
    DESTINATION runtime/data/ascendcl_config
)
install(FILES ${CMAKE_SOURCE_DIR}/src/dfx/error_manager/error_code.json
    DESTINATION runtime/conf/error_manager
)
set(BIN_FILES
    ${CMAKE_SOURCE_DIR}/scripts/package/runtime/scripts/prereq_check.bash
    ${CMAKE_SOURCE_DIR}/scripts/package/runtime/scripts/prereq_check.csh
    ${CMAKE_SOURCE_DIR}/scripts/package/runtime/scripts/prereq_check.fish
    ${CMAKE_SOURCE_DIR}/scripts/package/runtime/scripts/setenv.bash
    ${CMAKE_SOURCE_DIR}/scripts/package/runtime/scripts/setenv.csh
    ${CMAKE_SOURCE_DIR}/scripts/package/runtime/scripts/setenv.fish
)
install(FILES ${BIN_FILES}
    DESTINATION share/info/runtime/bin
)

install(FILES ${CMAKE_SOURCE_DIR}/scripts/package/runtime/set_env.sh
    DESTINATION runtime
)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/include
    DESTINATION runtime
    FILES_MATCHING
    PATTERN "*.h"
    PATTERN "include/external/acl/acl_rt_impl.h" EXCLUDE
)

install(FILES
    ${LIBC_SEC_HEADER}/securec.h
    ${LIBC_SEC_HEADER}/securectype.h
    DESTINATION runtime/include
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/dump/adx_datadump_server.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_api.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_pub.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_device_pub.h
    DESTINATION runtime/pkg_inc/dump
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_stars.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_base.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_device.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_event.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_ffts_define.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_ffts.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_kernel.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_mem.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_model.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_preload.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_stars_define.h
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_stream.h
    DESTINATION runtime/pkg_inc/runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/__clang_cce_runtime.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/base.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/config.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/context.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/dev.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/elf_base.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/event.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/kernel.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/mem_base.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/mem.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_dfx.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_ffts_plus_define.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_ffts_plus.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_ffts.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_mem_queue.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_model.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_preload_task.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_ras.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_stars_define.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt_stars.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rt.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/stars_interface.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/stream.h
    DESTINATION runtime/pkg_inc/runtime/runtime
)
 
install(FILES
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_context.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_device.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_dfx.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_dqs.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_event.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_ffts.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_kernel.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_mem.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_model.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_stars.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_stream.h
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts.h
    DESTINATION runtime/pkg_inc/runtime/runtime/rts
)

install(FILES
    pkg_inc/profiling/aprof_pub.h
    pkg_inc/profiling/devprof_pub.h
    pkg_inc/profiling/prof_api.h
    pkg_inc/profiling/prof_common.h
    DESTINATION runtime/pkg_inc/profiling
)

install(FILES
    pkg_inc/toolchain/prof_api.h
    DESTINATION runtime/pkg_inc/toolchain
)

install(FILES
    pkg_inc/trace/atrace_pub.h
    pkg_inc/trace/atrace_types.h
    DESTINATION runtime/pkg_inc/trace
)

install(FILES
    pkg_inc/watchdog/awatchdog_types.h
    pkg_inc/watchdog/awatchdog.h
    DESTINATION runtime/pkg_inc/watchdog
)

install(FILES
    src/mmpa/inc/mmpa/mmpa_api.h
    DESTINATION runtime/include/mmpa
)

install(FILES
    src/mmpa/inc/mmpa/sub_inc/mmpa_linux.h
    src/mmpa/inc/mmpa/sub_inc/mmpa_typedef_linux.h
    src/mmpa/inc/mmpa/sub_inc/mmpa_env_define.h
    DESTINATION runtime/include/mmpa/sub_inc
)

install(DIRECTORY pkg_inc/aicpu
    DESTINATION runtime/pkg_inc
)

install(FILES
    pkg_inc/base/err_mgr.h
    pkg_inc/base/dlog_pub.h
    pkg_inc/base/log_types.h
    pkg_inc/base/plog.h
    DESTINATION runtime/pkg_inc/base
)

install(FILES
    src/dfx/log/inc/toolchain/alog_pub.h
    src/dfx/log/inc/toolchain/log_types.h
    DESTINATION runtime/include/dfx/base
)
 
install(FILES
    src/dfx/log/inc/toolchain/slog.h
    src/dfx/log/inc/toolchain/dlog_pub.h
    src/dfx/log/inc/toolchain/log_types.h
    DESTINATION runtime/include/toolchain
)
 
install(FILES
    src/dfx/error_manager/error_manager.h
    DESTINATION runtime/include/experiment/metadef/common/util/error_manager
)

install(DIRECTORY pkg_inc/platform
    DESTINATION runtime/include
)

install(DIRECTORY ${CMAKE_SOURCE_DIR}/src/platform/platform_config
    DESTINATION runtime/data
)

# TODO: ge so packed temporarily for debugging, this need be reverted after ge code has been moved to ge repository.
install(TARGETS acl_rt acl_rt_impl acl_tdt_queue acl_tdt_channel runtime runtime_common runtime_v100
        shared_c_sec mmpa static_mmpa error_manager platform awatchdog_share
        LIBRARY DESTINATION runtime/lib
        ARCHIVE DESTINATION runtime/lib
)

install(TARGETS platform
        LIBRARY DESTINATION runtime/lib
        ARCHIVE DESTINATION runtime/lib
)

install(TARGETS platform stub_acl_rt stub_acl_tdt_channel stub_acl_tdt_queue stub_acl_prof stub_error_manager ascend_hal_stub
        LIBRARY DESTINATION runtime/devlib/linux/${ARCH}
        ARCHIVE DESTINATION runtime/devlib/linux/${ARCH}
)

install(FILES
    ${CMAKE_BINARY_DIR}/lib_acl/stub/linux/${ARCH}/libascendcl.so
    DESTINATION runtime/devlib/linux/${ARCH}
    OPTIONAL
)

install(TARGETS slog alog unified_dlog
    LIBRARY DESTINATION runtime/lib
    ARCHIVE DESTINATION runtime/lib
)

install(TARGETS adcore ascend_dump adump_server ascend_dump_static
    LIBRARY DESTINATION runtime/lib
    ARCHIVE DESTINATION runtime/lib
)

install(TARGETS profapi_share msprofiler_fwk_share profimpl_fwk_share
    LIBRARY DESTINATION runtime/lib
    ARCHIVE DESTINATION runtime/lib
)

install(TARGETS atrace_share
    LIBRARY DESTINATION runtime/lib
    ARCHIVE DESTINATION runtime/lib
)

install(TARGETS asc_dumper
    RUNTIME DESTINATION runtime/bin
)

install(CODE "execute_process(COMMAND cd ${PROTOBUF_SHARED_PKG_DIR}/lib && ln -sf libascend_protobuf.so.3.13.0.0 libascend_protobuf.so)")

install(FILES
    ${PROTOBUF_SHARED_PKG_DIR}/lib/libascend_protobuf.so.3.13.0.0
    ${PROTOBUF_SHARED_PKG_DIR}/lib/libascend_protobuf.so
    DESTINATION runtime/lib
)

install(DIRECTORY
    ${CMAKE_BINARY_DIR}/lib_acl/
    DESTINATION runtime/lib
    OPTIONAL
)

set(AICPU_TAR_DIR ${RUNTIME_DIR}/build/lib_aicpu)
install(FILES
    ${AICPU_TAR_DIR}/host_queue_schedule
    DESTINATION runtime/bin
)
install(FILES
    ${AICPU_TAR_DIR}/libhost_aicpu_scheduler.so
    ${AICPU_TAR_DIR}/libhost_queue_schedule.so
    ${AICPU_TAR_DIR}/libdgw_client.so
    ${AICPU_TAR_DIR}/libtsdclient.so
    DESTINATION runtime/lib
)

if(DEFINED ENV{TOOLCHAIN_DIR} AND NOT BUILD_HOST_ONLY)
    install(FILES 
        ${CHILD_INSTALL_DIR}/lib/libc_sec.so
        ${CHILD_INSTALL_DIR}/lib/libascendalog.so
        ${CHILD_INSTALL_DIR}/lib/libunified_dlog.so
        ${CMAKE_BINARY_DIR}/device_build/protobuf_static/lib/libascend_protobuf.a
        ${CHILD_INSTALL_DIR}/lib/libmmpa.so
        ${CHILD_INSTALL_DIR}/lib/stub/libascend_hal.so
        ${CHILD_INSTALL_DIR}/lib/libplatform_static.a
        ${CHILD_INSTALL_DIR}/lib/libkernel_load_platform.so
        DESTINATION runtime/lib/device
    )

    install(FILES
        ${CHILD_INSTALL_DIR}/runtime/cann-tsch-compat.tar.gz
        DESTINATION runtime
    )
endif()

# ============= CPack =============
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}")
set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CMAKE_SYSTEM_NAME}")

set(CPACK_INSTALL_PREFIX "/")

set(CPACK_CMAKE_SOURCE_DIR "${CMAKE_SOURCE_DIR}")
set(CPACK_CMAKE_BINARY_DIR "${CMAKE_BINARY_DIR}")
set(CPACK_CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")
set(CPACK_CMAKE_CURRENT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
set(CPACK_ARCH "${ARCH}")
set(CPACK_SET_DESTDIR ON)
set(CPACK_GENERATOR External)
set(CPACK_EXTERNAL_PACKAGE_SCRIPT "${CMAKE_SOURCE_DIR}/cmake/makeself.cmake")
set(CPACK_EXTERNAL_ENABLE_STAGING true)
set(CPACK_PACKAGE_DIRECTORY "${CMAKE_BINARY_DIR}")
include(CPack)