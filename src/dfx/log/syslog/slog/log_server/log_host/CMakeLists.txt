# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Host Configuration File Targets
# ------------------------------------------------------------------------------
if (PRODUCT)
if (${PRODUCT} STREQUAL "ascend310")
    add_custom_target(slogHostFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/mini/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../../scripts/slogd_daemon_monitor.sh ${CMAKE_CURRENT_BINARY_DIR}
    )

elseif ((${PRODUCT} STREQUAL "ascend310B") OR (${PRODUCT} STREQUAL "ascend310Besl"))
    add_custom_target(slogHostFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
    )

elseif ((${PRODUCT} STREQUAL "ascend310Brc") OR (${PRODUCT} STREQUAL "ascend310Brcesl"))
    add_custom_target(slogHostFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/milan_310rc/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
    )

elseif (${PRODUCT} STREQUAL "ascend910" OR ${PRODUCT} STREQUAL "ascend910B")
    add_custom_target(slogHostFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/cloud/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
    )

endif ()
endif ()

### INTERNAL START ###
if (PRODUCT)
if ((${PRODUCT} STREQUAL "ascend950") OR 
        (${PRODUCT} STREQUAL "ascend950esl") OR 
        (${PRODUCT} STREQUAL "ascend350") OR 
        (${PRODUCT} STREQUAL "ascend910_96") OR 
        (${PRODUCT} STREQUAL "ascend910_96esl"))
    add_custom_target(slogHostFiles
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/slog.conf ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/rsyslog_proc.conf ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../../etc/david_910_95/rsyslog_socket.conf ${CMAKE_CURRENT_BINARY_DIR}
    )
endif ()
endif ()
### INTERNAL END ###

# ------------------------------------------------------------------------------
# Host Installation Configuration
# ------------------------------------------------------------------------------
set(INSTALL_BASE_DIR "")
set(INSTALL_INCLUDE_DIR include)
set(INSTALL_LIBRARY_DIR lib)
set(INSTALL_RUNTIME_DIR bin)
set(INSTALL_CONFIG_DIR lib/cmake)

include(CMakePackageConfigHelpers)

# Install host configuration file
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/slog.conf
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
