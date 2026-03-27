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

# 打印路径
message(STATUS "CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX}")

if (ENABLE_OPEN_SRC)
    set(INSTALL_DIR runtime/lib)
    set(SCHED_TARGETS dgw_client tsdclient)
else()
    set(INSTALL_DIR lib)
    set(SCHED_TARGETS dgw_client tsdclient)
endif()

set(script_prefix ${RUNTIME_DIR}/scripts/package/runtime/scripts)
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
    COMPONENT npu-runtime
)
set(SCRIPTS_FILES
    ${RUNTIME_DIR}/scripts/package/common/sh/check_version_required.awk
    ${RUNTIME_DIR}/scripts/package/common/sh/common_func.inc
    ${RUNTIME_DIR}/scripts/package/common/sh/common_interface.sh
    ${RUNTIME_DIR}/scripts/package/common/sh/common_interface.csh
    ${RUNTIME_DIR}/scripts/package/common/sh/common_interface.fish
    ${RUNTIME_DIR}/scripts/package/common/sh/version_compatiable.inc
)

install(FILES ${SCRIPTS_FILES}
    DESTINATION share/info/runtime/script
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
set(COMMON_FILES
    ${RUNTIME_DIR}/scripts/package/common/sh/install_common_parser.sh
    ${RUNTIME_DIR}/scripts/package/common/sh/common_func_v2.inc
    ${RUNTIME_DIR}/scripts/package/common/sh/common_installer.inc
    ${RUNTIME_DIR}/scripts/package/common/sh/script_operator.inc
    ${RUNTIME_DIR}/scripts/package/common/sh/version_cfg.inc
)

set(PACKAGE_FILES
    ${COMMON_FILES}
    ${RUNTIME_DIR}/scripts/package/common/sh/multi_version.inc
)
set(CONF_FILES
    ${RUNTIME_DIR}/scripts/package/common/cfg/path.cfg
    ${RUNTIME_DIR}/scripts/package/common/cfg/ascend_package_load.ini
    ${RUNTIME_DIR}/scripts/package/common/cfg/RuntimeConfig.ini
)

install(FILES ${CMAKE_BINARY_DIR}/version.npu-runtime.info
    DESTINATION share/info/runtime
    RENAME version.info
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES ${CONF_FILES}
    DESTINATION runtime/conf
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
install(FILES ${PACKAGE_FILES}
    DESTINATION share/info/runtime/script
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
install(FILES ${RUNTIME_DIR}/src/acl/config/swFeatureList.json
    DESTINATION runtime/data/ascendcl_config
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
install(FILES ${RUNTIME_DIR}/src/dfx/error_manager/error_code.json
    DESTINATION runtime/conf/error_manager
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
set(BIN_FILES
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/prereq_check.bash
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/prereq_check.csh
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/prereq_check.fish
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/setenv.bash
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/setenv.csh
    ${RUNTIME_DIR}/scripts/package/runtime/scripts/setenv.fish
    ${INSTALL_OPTIONAL}
)
install(FILES ${BIN_FILES}
    DESTINATION share/info/runtime/bin
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES ${RUNTIME_DIR}/scripts/package/runtime/set_env.sh
    DESTINATION runtime
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(DIRECTORY ${RUNTIME_DIR}/include
    DESTINATION runtime
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${LIBC_SEC_HEADER}/securec.h
    ${LIBC_SEC_HEADER}/securectype.h
    DESTINATION runtime/include
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/dump/adx_datadump_server.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_api.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_pub.h
    ${RUNTIME_DIR}/pkg_inc/dump/adump_device_pub.h
    DESTINATION runtime/pkg_inc/dump
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
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
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
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
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
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
    ${RUNTIME_DIR}/pkg_inc/runtime/runtime/rts/rts_snapshot.h
    DESTINATION runtime/pkg_inc/runtime/runtime/rts
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(DIRECTORY ${RUNTIME_DIR}/include/driver
    DESTINATION runtime/pkg_inc
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/profiling/aprof_pub.h
    ${RUNTIME_DIR}/pkg_inc/profiling/devprof_pub.h
    ${RUNTIME_DIR}/pkg_inc/profiling/prof_api.h
    ${RUNTIME_DIR}/pkg_inc/profiling/prof_common.h
    DESTINATION runtime/pkg_inc/profiling
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/toolchain/prof_api.h
    DESTINATION runtime/pkg_inc/toolchain
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/trace/atrace_pub.h
    ${RUNTIME_DIR}/pkg_inc/trace/atrace_types.h
    DESTINATION runtime/pkg_inc/trace
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/watchdog/awatchdog_types.h
    ${RUNTIME_DIR}/pkg_inc/watchdog/awatchdog.h
    DESTINATION runtime/pkg_inc/watchdog
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/mmpa/mmpa_api.h
    DESTINATION runtime/pkg_inc/mmpa
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/mmpa/sub_inc/mmpa_linux.h
    ${RUNTIME_DIR}/pkg_inc/mmpa/sub_inc/mmpa_typedef_linux.h
    ${RUNTIME_DIR}/pkg_inc/mmpa/sub_inc/mmpa_env_define.h
    DESTINATION runtime/pkg_inc/mmpa/sub_inc
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(DIRECTORY
    ${RUNTIME_DIR}/pkg_inc/aicpu_sched
    ${RUNTIME_DIR}/pkg_inc/queue_schedule
    ${RUNTIME_DIR}/pkg_inc/tsd
    DESTINATION runtime/pkg_inc
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/pkg_inc/base/err_mgr.h
    ${RUNTIME_DIR}/pkg_inc/base/dlog_pub.h
    ${RUNTIME_DIR}/pkg_inc/base/log_types.h
    ${RUNTIME_DIR}/pkg_inc/base/plog.h
    DESTINATION runtime/pkg_inc/base
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(FILES
    ${RUNTIME_DIR}/src/dfx/log/inc/toolchain/alog_pub.h
    ${RUNTIME_DIR}/src/dfx/log/inc/toolchain/log_types.h
    DESTINATION runtime/include/dfx/base
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
 
install(FILES
    ${RUNTIME_DIR}/src/dfx/error_manager/error_manager.h
    DESTINATION runtime/include/experiment/metadef/common/util/error_manager
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(DIRECTORY ${RUNTIME_DIR}/pkg_inc/platform
    DESTINATION runtime/include
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(DIRECTORY ${RUNTIME_DIR}/src/platform/platform_config
    DESTINATION runtime/data
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
install(FILES
    ${PROTOBUF_HOST_STATIC_FINAL_PATH}
    DESTINATION ${INSTALL_DIR}
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

# TODO: ge so packed temporarily for debugging, this need be reverted after ge code has been moved to ge repository.
install(TARGETS acl_rt acl_rt_impl acl_tdt_queue acl_tdt_channel runtime xpu_tprt runtime_common runtime_v100 runtime_v201
        mmpa static_mmpa error_manager platform awatchdog_share runtime_v200
        LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
        ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

if(TARGET shared_c_sec)
    install(TARGETS shared_c_sec
            LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
            ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    )
endif()

install(TARGETS platform
        LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
        ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(TARGETS platform stub_acl_rt stub_acl_tdt_channel stub_acl_tdt_queue stub_acl_prof stub_error_manager ascend_hal_stub
        LIBRARY DESTINATION runtime/devlib/linux/${TARGET_ARCH} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
        ARCHIVE DESTINATION runtime/devlib/linux/${TARGET_ARCH} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(FILES
    ${CMAKE_BINARY_DIR}/lib_acl/stub/linux/${TARGET_ARCH}/libascendcl.so
    DESTINATION runtime/devlib/linux/${TARGET_ARCH}
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

# cpu scheduler targets 
install(TARGETS ${SCHED_TARGETS}
    LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(TARGETS alog unified_dlog
    LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(TARGETS adcore ascend_dump adump_server ascend_dump_static
    LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(TARGETS profapi_share msprofiler_fwk_share profimpl_fwk_share
    LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(TARGETS atrace_share
    LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(TARGETS asc_dumper
    RUNTIME DESTINATION runtime/bin
    ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)

install(FILES
    ${PROTOBUF_SHARED_LIB_DIR}/libascend_protobuf.so.3.13.0.0
    DESTINATION ${INSTALL_DIR}
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)
install(CODE
    "execute_process(
        COMMAND ${CMAKE_COMMAND} -E create_symlink 
        libascend_protobuf.so.3.13.0.0 
        libascend_protobuf.so
        WORKING_DIRECTORY \"\${CMAKE_INSTALL_PREFIX}/${INSTALL_DIR}\"
    )"
    COMPONENT npu-runtime
)

install(DIRECTORY
    ${CMAKE_BINARY_DIR}/lib_acl/
    DESTINATION ${INSTALL_DIR}
    ${INSTALL_OPTIONAL}
    COMPONENT npu-runtime
)

install(TARGETS queue_schedule_so
    LIBRARY DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
    ARCHIVE DESTINATION ${INSTALL_DIR} ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)
 
install(TARGETS queue_schedule
    RUNTIME DESTINATION runtime/bin
    ${INSTALL_OPTIONAL} COMPONENT npu-runtime
)
