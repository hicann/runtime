set(CMAKE_CXX_STANDARD 11)

# compile for st
set(SLOG_STUB_FILES
        ${CMAKE_CURRENT_LIST_DIR}/../depends/slog/slog_stub.cc)

file(GLOB_RECURSE PROTO_LIST RELATIVE ${CMAKE_CURRENT_LIST_DIR}
    ${TOP_DIR}/ace/npuruntime/runtime/platform/proto/platform_infos.proto)

set_legacy_protobuf()

protobuf_generate(platform_infos_proto PROTO_SRCS PROTO_HDRS ${PROTO_LIST} TARGET)

set (PLATFORM_SRC_FILES
        ${TOP_DIR}/ace/npuruntime/runtime/platform/platform_info.cpp
        ${TOP_DIR}/ace/npuruntime/runtime/platform/platform_infos_def.cpp
        ${TOP_DIR}/ace/npuruntime/runtime/platform/platform_infos_impl.cpp
        ${TOP_DIR}/ace/npuruntime/runtime/platform/platform_infos_utils.cpp)

set(PLATFORM_ST_FILES
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_instance_stest.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_ge_instance_stest.cpp)

add_executable(platform_st
        ${SLOG_STUB_FILES}
        ${PLATFORM_SRC_FILES}
        ${PLATFORM_ST_FILES}
        ${PROTO_SRCS})


target_include_directories(platform_st PRIVATE
        ${TOP_DIR}/ace/npuruntime/runtime/platform
        ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
        ${TOP_DIR}/ace/npuruntime/runtime/platform/inc/platform
        ${TOP_DIR}/abl/slog/inc
        ${TOP_DIR}/metadef/inc/external
        ${TOP_DIR}/metadef/inc/external/platform
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto/
        )

target_compile_definitions(platform_st PRIVATE
    google=ascend_private
)

target_compile_options(platform_st PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++11>
        -Werror)

target_link_libraries(platform_st PRIVATE
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:slog_headers>
        -Wl,--no-as-needed
        GTest::gtest
        GTest::gtest_main
        GTest::gmock
        GTest::gmock_main
        -lrt
        -ldl
        ascend_protobuf)

add_custom_target(
        platform_config_files
        COMMAND
        echo "-- Copy platform ini files start" &&
        mkdir -p "${CMAKE_CURRENT_BINARY_DIR}/../data/platform_config" &&
        cp -rf ${TOP_DIR}/ace/npuruntime/runtime/platform/platform_config/*.ini ${CMAKE_CURRENT_BINARY_DIR}/../data/platform_config/ &&
        echo "-- Copy platform ini files end"
)

add_dependencies(platform_st platform_config_files)
add_dependencies(platform_st platform_infos_proto)

run_llt_test(
        TARGET platform_st
        TASK_NUM 1
)

add_executable(platform_stub_st
        ${SLOG_STUB_FILES}
        ${TOP_DIR}/ace/npuruntime/runtime/platform/stub/platform_info_stub.cpp
        ${TOP_DIR}/ace/npuruntime/runtime/platform/stub/platform_infos_def_stub.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_ge_instance_stest_stub.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_instance_stest_stub.cpp
        ${PROTO_SRCS})


target_include_directories(platform_stub_st PRIVATE
        ${TOP_DIR}/ace/npuruntime/runtime/platform
        ${TOP_DIR}/ace/npuruntime/runtime/platform/inc
        ${TOP_DIR}/ace/npuruntime/runtime/platform/inc/platform
        ${TOP_DIR}/abl/slog/inc
        ${TOP_DIR}/metadef/inc/external
        ${TOP_DIR}/metadef/inc/external/platform
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto/
        )

target_compile_definitions(platform_stub_st PRIVATE
    google=ascend_private
)

target_compile_options(platform_stub_st PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++11>
        -Werror)

target_link_libraries(platform_stub_st PRIVATE
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:slog_headers>
        -Wl,--no-as-needed
        GTest::gtest
        GTest::gtest_main
        GTest::gmock
        GTest::gmock_main
        -lrt
        -ldl
        ascend_protobuf)

add_dependencies(platform_stub_st platform_config_files)
add_dependencies(platform_stub_st platform_infos_proto)

run_llt_test(
        TARGET platform_stub_st
        TASK_NUM 1
)
