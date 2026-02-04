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
message(STATUS "CMAKE_CURRENT_SOURCE_DIR = ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")

if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG)
    include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/makeself-fetch.cmake)
    set(INSTALL_DIR runtime/lib)
    set(SCHED_TARGETS dgw_client tsdclient)
else()
    set(INSTALL_DIR lib)
    set(SCHED_TARGETS tsdclient)
endif()

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
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/check_version_required.awk
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_func.inc
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_interface.sh
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_interface.csh
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_interface.fish
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/version_compatiable.inc
)

install(FILES ${SCRIPTS_FILES}
    DESTINATION share/info/runtime/script
    OPTIONAL
)
set(COMMON_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/install_common_parser.sh
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_func_v2.inc
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_installer.inc
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/script_operator.inc
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/version_cfg.inc
)

set(PACKAGE_FILES
    ${COMMON_FILES}
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/multi_version.inc
)
set(LATEST_MANGER_FILES
    ${COMMON_FILES}
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/common_func.inc
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/version_compatiable.inc
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/sh/check_version_required.awk
)
set(CONF_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/cfg/path.cfg
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/cfg/ascend_package_load.ini
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/common/cfg/RuntimeConfig.ini
)

install(FILES ${RUNTIME_VERSION_FILE}
    DESTINATION share/info/runtime
    OPTIONAL
)

install(FILES ${CONF_FILES}
    DESTINATION runtime/conf
    OPTIONAL
)
install(FILES ${PACKAGE_FILES}
    DESTINATION share/info/runtime/script
    OPTIONAL
)
install(FILES ${LATEST_MANGER_FILES}
    DESTINATION latest_manager
    OPTIONAL
)
install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/latest_manager/scripts/
    DESTINATION latest_manager
    OPTIONAL
)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/acl/config/swFeatureList.json
    DESTINATION runtime/data/ascendcl_config
    OPTIONAL
)
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/src/dfx/error_manager/error_code.json
    DESTINATION runtime/conf/error_manager
    OPTIONAL
)
set(BIN_FILES
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts/prereq_check.bash
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts/prereq_check.csh
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts/prereq_check.fish
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts/setenv.bash
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts/setenv.csh
    ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/scripts/setenv.fish
    OPTIONAL
)
install(FILES ${BIN_FILES}
    DESTINATION share/info/runtime/bin
    OPTIONAL
)

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/scripts/package/runtime/set_env.sh
    DESTINATION runtime
    OPTIONAL
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
    DESTINATION runtime
    OPTIONAL
)

install(FILES
    ${LIBC_SEC_HEADER}/securec.h
    ${LIBC_SEC_HEADER}/securectype.h
    DESTINATION runtime/include
    OPTIONAL
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/dump/adx_datadump_server.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_api.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_pub.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_device_pub.h
    DESTINATION runtime/pkg_inc/dump
    OPTIONAL
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
    ${RUNTIME_DIR}/pkg_inc/runtime/rt_external_dqs.h
    DESTINATION runtime/pkg_inc/runtime
    OPTIONAL
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
    OPTIONAL
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
    OPTIONAL
)

install(DIRECTORY ${RUNTIME_DIR}/include/driver
    DESTINATION runtime/pkg_inc
)

install(FILES
    pkg_inc/profiling/aprof_pub.h
    pkg_inc/profiling/devprof_pub.h
    pkg_inc/profiling/prof_api.h
    pkg_inc/profiling/prof_common.h
    DESTINATION runtime/pkg_inc/profiling
    OPTIONAL
)

install(FILES
    pkg_inc/toolchain/prof_api.h
    DESTINATION runtime/pkg_inc/toolchain
    OPTIONAL
)

install(FILES
    pkg_inc/trace/atrace_pub.h
    pkg_inc/trace/atrace_types.h
    DESTINATION runtime/pkg_inc/trace
    OPTIONAL
)

install(FILES
    pkg_inc/watchdog/awatchdog_types.h
    pkg_inc/watchdog/awatchdog.h
    DESTINATION runtime/pkg_inc/watchdog
    OPTIONAL
)

install(FILES
    pkg_inc/mmpa/mmpa_api.h
    DESTINATION runtime/pkg_inc/mmpa
    OPTIONAL
)

install(FILES
    pkg_inc/mmpa/sub_inc/mmpa_linux.h
    pkg_inc/mmpa/sub_inc/mmpa_typedef_linux.h
    pkg_inc/mmpa/sub_inc/mmpa_env_define.h
    DESTINATION runtime/pkg_inc/mmpa/sub_inc
    OPTIONAL
)

install(DIRECTORY
    pkg_inc/aicpu_sched
    pkg_inc/queue_schedule
    pkg_inc/tsd
    DESTINATION runtime/pkg_inc
    OPTIONAL
)

install(FILES
    pkg_inc/base/err_mgr.h
    pkg_inc/base/dlog_pub.h
    pkg_inc/base/log_types.h
    pkg_inc/base/plog.h
    DESTINATION runtime/pkg_inc/base
    OPTIONAL
)

install(FILES
    src/dfx/log/inc/toolchain/alog_pub.h
    src/dfx/log/inc/toolchain/log_types.h
    DESTINATION runtime/include/dfx/base
    OPTIONAL
)
 
install(FILES
    src/dfx/error_manager/error_manager.h
    DESTINATION runtime/include/experiment/metadef/common/util/error_manager
    OPTIONAL
)

install(DIRECTORY pkg_inc/platform
    DESTINATION runtime/include
    OPTIONAL
)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/src/platform/platform_config
    DESTINATION runtime/data
    OPTIONAL
)

# TODO: ge so packed temporarily for debugging, this need be reverted after ge code has been moved to ge repository.
install(TARGETS acl_rt acl_rt_impl acl_tdt_queue acl_tdt_channel runtime xpu_tprt runtime_common runtime_v100 runtime_v201
        mmpa static_mmpa error_manager platform awatchdog_share runtime_v200
        LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
        ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

if(TARGET shared_c_sec)
    install(TARGETS shared_c_sec
            LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
            ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
    )
endif()

install(TARGETS platform
        LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
        ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

install(TARGETS platform stub_acl_rt stub_acl_tdt_channel stub_acl_tdt_queue stub_acl_prof stub_error_manager ascend_hal_stub
        LIBRARY DESTINATION runtime/devlib/linux/${ARCH} OPTIONAL
        ARCHIVE DESTINATION runtime/devlib/linux/${ARCH} OPTIONAL
)

install(FILES
    ${CMAKE_BINARY_DIR}/lib_acl/stub/linux/${ARCH}/libascendcl.so
    DESTINATION runtime/devlib/linux/${ARCH}
    OPTIONAL
)

# cpu scheduler targets 
install(TARGETS ${SCHED_TARGETS}
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

install(TARGETS slog alog unified_dlog
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

install(TARGETS adcore ascend_dump adump_server ascend_dump_static
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

install(TARGETS profapi_share msprofiler_fwk_share profimpl_fwk_share
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

install(TARGETS atrace_share
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)

install(TARGETS asc_dumper
    RUNTIME DESTINATION runtime/bin
    OPTIONAL
)

install(CODE "execute_process(COMMAND cd ${PROTOBUF_SHARED_PKG_DIR}/lib && ln -sf libascend_protobuf.so.3.13.0.0 libascend_protobuf.so)")

install(FILES
    ${PROTOBUF_SHARED_PKG_DIR}/lib/libascend_protobuf.so.3.13.0.0
    ${PROTOBUF_SHARED_PKG_DIR}/lib/libascend_protobuf.so
    DESTINATION ${INSTALL_DIR}
    OPTIONAL
)

install(DIRECTORY
    ${CMAKE_BINARY_DIR}/lib_acl/
    DESTINATION ${INSTALL_DIR}
    OPTIONAL
)

install(TARGETS queue_schedule_so
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
)
 
install(TARGETS queue_schedule
    RUNTIME DESTINATION runtime/bin
    OPTIONAL
)

install(TARGETS host_aicpu_scheduler_so
    LIBRARY DESTINATION ${INSTALL_DIR} OPTIONAL
    ARCHIVE DESTINATION ${INSTALL_DIR} OPTIONAL
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
        DESTINATION ${INSTALL_DIR}/device
        OPTIONAL
    )

    install(FILES
        ${CHILD_INSTALL_DIR}/runtime/cann-tsch-compat.tar.gz
        DESTINATION runtime
        OPTIONAL
    )
endif()


if (BUILD_WITH_INSTALLED_DEPENDENCY_CANN_PKG)
    # ============= CPack =============
    # acl-compat do not need pack
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
endif()