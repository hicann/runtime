
set(INSTALL_LIBRARY_DIR lib)

set(stackcoreSrcList
    ${CMAKE_CURRENT_SOURCE_DIR}/stackcore.c
    ${CMAKE_CURRENT_SOURCE_DIR}/stackcore_common.c
)

set(stackcoreHeaders
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${RUNTIME_DIR}/abl/libc_sec/include
    ${TOOLAHCIN_LOG_DIR}/../../include/log/stackcore
)

add_library(stackcore SHARED
    ${stackcoreSrcList}
)

add_library(stackcore_headers INTERFACE)
target_include_directories(stackcore_headers INTERFACE
    ${stackcoreHeaders}
)

target_link_libraries(stackcore PRIVATE
    $<BUILD_INTERFACE:intf_pub>
    $<BUILD_INTERFACE:stackcore_headers>
    c_sec
)

target_compile_options(stackcore PRIVATE
    -Werror
    -Wfloat-equal -Wextra
    -Wunused
    -Wshadow
    -Wundef
    $<$<CONFIG:Debug>:-g -O0>
    $<$<CONFIG:Release>:-O2 -D_FORTIFY_SOURCE=2>
    -std=c99
    -fno-common
    -fstack-protector-strong
    -fPIC
    -fdata-sections
    -ffunction-sections
)

target_link_options(stackcore PRIVATE
    -Wl,-z,relro,-z,now,-z,noexecstack
    -Wl,--gc-sections
)

target_compile_definitions(stackcore PRIVATE
    $<$<STREQUAL:${PRODUCT},ascend910_95>:LOG_CORETRACE>
    $<$<STREQUAL:${PRODUCT},ascend910_95esl>:LOG_CORETRACE>
    _GNU_SOURCE
)

install(TARGETS stackcore OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}
)

install(PROGRAMS
    ${CMAKE_CURRENT_BINARY_DIR}/coretrace_helper.sh
    DESTINATION ${INSTALL_LIBRARY_DIR} OPTIONAL
)
