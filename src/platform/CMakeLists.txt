project(platform)

add_library(platform_headers INTERFACE)
message(STATUS "PRODUCT  ${PRODUCT}")

set(STATICPLATFORMFILE
    ${CMAKE_CURRENT_LIST_DIR}/platform_info.cpp
    ${CMAKE_CURRENT_LIST_DIR}/platform_infos_def.cpp
    ${CMAKE_CURRENT_LIST_DIR}/platform_infos_impl.cpp
    ${CMAKE_CURRENT_LIST_DIR}/platform_infos_utils.cpp
    ${CMAKE_CURRENT_LIST_DIR}/platform_manager_v2.cpp
)

set(RUNTIME_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../..)

file(GLOB_RECURSE PROTO_LIST RELATIVE ${CMAKE_CURRENT_LIST_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/proto/platform_infos.proto)

protobuf_generate(platform_infos_proto PROTO_SRCS PROTO_HDRS ${PROTO_LIST} TARGET)

if((DEFINED PRODUCT) AND (PRODUCT STREQUAL "ascend031"))
        set(PLATFORMFILE
        "stub/platform_info_stub.cpp"
        "stub/platform_infos_def_stub.cpp")
else()
        set(PLATFORMFILE
        "platform_info.cpp"
        "platform_infos_def.cpp"
        "platform_infos_impl.cpp"
        "platform_infos_utils.cpp"
        "platform_manager_v2.cpp")
endif()



target_include_directories(platform_headers INTERFACE
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/pkg_inc/platform>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/../runtime>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/proto/google>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/proto/google/protobuf/stubs>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/src/dfx/error_manager>
    $<BUILD_INTERFACE:${RUNTIME_DIR}/include/dfx/base>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/platform>
    $<INSTALL_INTERFACE:include/platform/platform>
)

add_dependencies(platform_headers platform_infos_proto)


file(GLOB FE_SRC_CPP_1 RELATIVE ${CMAKE_CURRENT_LIST_DIR}
    ${PLATFORMFILE}
    )

add_library(platform SHARED
        ${FE_SRC_CPP_1}
        ${PROTO_SRCS}
        ${RUNTIME_DIR}/src/dfx/error_manager
        ${RUNTIME_DIR}/include/dfx/base)


add_dependencies(platform platform_infos_proto)
target_include_directories(platform PRIVATE
        # ${CMAKE_CURRENT_LIST_DIR}/../dfx/include/log/toolchain
        ${CMAKE_CURRENT_LIST_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/proto/google
        ${RUNTIME_DIR}/pkg_inc
        ${RUNTIME_DIR}/src/dfx/error_manager
        ${RUNTIME_DIR}/include/dfx/base
        $<INSTALL_INTERFACE:include>
        $<INSTALL_INTERFACE:include/platform>
        $<INSTALL_INTERFACE:include/platform/platform>
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto)

target_compile_options(platform PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
        -Werror
        -fno-common
        -fno-strict-aliasing
        $<$<STREQUAL:${PRODUCT_SIDE},host>:-fexceptions>)

target_compile_definitions(platform PRIVATE
    google=ascend_private
)

ADD_LIBRARY(platform_static STATIC
        ${STATICPLATFORMFILE}
        ${PROTO_SRCS}
        ${RUNTIME_DIR}/src/dfx/error_manager
        ${RUNTIME_DIR}/include/dfx/base)
add_dependencies(platform_static platform_infos_proto)
target_include_directories(platform_static PRIVATE
        # ${CMAKE_CURRENT_LIST_DIR}/../dfx/include/log/toolchain
        ${CMAKE_CURRENT_LIST_DIR}
        ${CMAKE_CURRENT_LIST_DIR}/inc
        ${RUNTIME_DIR}/src/dfx/error_manager
        ${RUNTIME_DIR}/include/dfx/base
        $<INSTALL_INTERFACE:include>
        $<INSTALL_INTERFACE:include/platform>
        $<INSTALL_INTERFACE:include/platform/platform>
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto/)

target_compile_options(platform_static PRIVATE
        $<$<STREQUAL:${PRODUCT_SIDE},device>:-fPIC>
        $<$<STREQUAL:${PRODUCT_SIDE},device>:-fstack-protector-strong>
        $<$<STREQUAL:${PRODUCT_SIDE},device>:-fstack-protector-all>
        $<$<STREQUAL:${PRODUCT_SIDE},device>:-std=c++17>
        $<$<STREQUAL:${PRODUCT_SIDE},device>:-fvisibility-inlines-hidden>
        $<$<STREQUAL:${PRODUCT_SIDE},device>:-fvisibility=hidden>
)

target_compile_definitions(platform_static PRIVATE
        google=ascend_private
        $<$<STREQUAL:${PRODUCT_SIDE},device>:ASCENDC_DEVICE_REG_STATIC>
        -DCOMPILE_PLATFORM_STATIC="True"
)

target_link_libraries(platform_static
        PRIVATE
                $<BUILD_INTERFACE:intf_pub>
                -Wl,--no-as-needed
                c_sec
                -Wl,--as-needed
                -ldl
                ascend_protobuf_static
        PUBLIC
                platform_headers
        )

target_link_libraries(platform
        PRIVATE
                intf_pub
                unified_dlog
                -Wl,--no-as-needed
                c_sec
                -Wl,--as-needed
                -ldl
                ascend_protobuf
        PUBLIC
                platform_headers
        )

install_package(
    PACKAGE platform
    TARGETS platform platform_headers platform_static
    FILES   ${RUNTIME_DIR}/pkg_inc/platform/platform_info.h
            ${RUNTIME_DIR}/pkg_inc/platform/platform_info_def.h
            ${RUNTIME_DIR}/pkg_inc/platform/platform_infos_def.h
            ${RUNTIME_DIR}/pkg_inc/platform/soc_spec.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/platform/platform
)

install(TARGETS platform OPTIONAL
    LIBRARY DESTINATION ${INSTALL_LIBRARY_DIR}/${CMAKE_SYSTEM_PROCESSOR}/stub
)
