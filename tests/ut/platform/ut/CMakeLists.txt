set(CMAKE_CXX_STANDARD 14)
include_directories(${OPEN_SOURCE_DIR}/boost)
# compile for ut
set(SLOG_STUB_FILES
        ${CMAKE_CURRENT_LIST_DIR}/../depends/slog/slog_stub.cc)

set (PLATFORM_SRC_FILES
        ${TOP_DIR}/src/platform/platform_info.cpp
        ${TOP_DIR}/src/platform/platform_infos_def.cpp
        ${TOP_DIR}/src/platform/platform_infos_impl.cpp
        ${TOP_DIR}/src/platform/platform_infos_utils.cpp
        ${TOP_DIR}/src/platform/platform_manager_v2.cpp
        )

set(PLATFORM_UT_FILES
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_instance_utest.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_ge_instance_utest.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_v2_instance_utest.cpp)

add_executable(platform_utest
        ${SLOG_STUB_FILES}
        ${PLATFORM_UT_FILES}
        ${PLATFORM_SRC_FILES} 
#        ${PROTO_SRCS}
        )

add_executable(platform_stub_ut
        ${SLOG_STUB_FILES}
        ${TOP_DIR}/src/platform/stub/platform_info_stub.cpp
        ${TOP_DIR}/src/platform/stub/platform_infos_def_stub.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_instance_stub_utest.cpp
        ${CMAKE_CURRENT_LIST_DIR}/testcase/platform_manager_ge_instance_stub_utest.cpp
#        ${PROTO_SRCS}
        )

target_include_directories(platform_utest PRIVATE
        ${TOP_DIR}/src/platform
        ${TOP_DIR}/src/platform/inc
        ${TOP_DIR}/src/platform/inc/platform
        ${TOP_DIR}/pkg_inc
        ${TOP_DIR}/pkg_inc/platform
        ${TOP_DIR}/abl/slog/inc
        ${TOP_DIR}/metadef/inc/external
        ${TOP_DIR}/metadef/inc/external/platform
        ${TOP_DIR}/include/dfx/base
        ${CMAKE_CURRENT_LIST_DIR}/../depends/
        ${CMAKE_CURRENT_LIST_DIR}/../depends/proto
        ${TOP_DIR}/src/platform/proto/platform_infos_proto/
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto/
        )

target_include_directories(platform_stub_ut PRIVATE
        ${TOP_DIR}/src/platform
        ${TOP_DIR}/src/platform/inc
        ${TOP_DIR}/src/platform/inc/platform
        ${TOP_DIR}/src/
        ${TOP_DIR}/pkg_inc
        ${TOP_DIR}/pkg_inc/platform
        ${TOP_DIR}/abl/slog/inc
        ${TOP_DIR}/metadef/inc/external
        ${TOP_DIR}/metadef/inc/external/platform
        ${TOP_DIR}/include/dfx/base
        ${CMAKE_CURRENT_LIST_DIR}/../depends/
        ${CMAKE_CURRENT_LIST_DIR}/../depends/proto
        ${TOP_DIR}/src/platform/proto/platform_infos_proto/
        ${CMAKE_BINARY_DIR}/proto/platform_infos_proto/
        )

target_compile_definitions(platform_utest PRIVATE
    _OPEN_SOURCE_LLT_
    google=ascend_private
)

target_compile_definitions(platform_stub_ut PRIVATE
    _OPEN_SOURCE_LLT_
    google=ascend_private
)

target_compile_options(platform_utest PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++14>
        -Werror)

target_compile_options(platform_stub_ut PRIVATE
        $<$<COMPILE_LANGUAGE:CXX>:-std=c++14>
        -Werror)

target_link_libraries(platform_utest PRIVATE
        -Wl,--no-as-needed
        GTest::gtest
        GTest::gtest_main
        GTest::gmock
        GTest::gmock_main
        -lrt
        -ldl
        -lgcov
        ascend_protobuf
        $<BUILD_INTERFACE:intf_ut_pub>
        $<BUILD_INTERFACE:slog_headers>
)

target_link_libraries(platform_stub_ut PRIVATE
        -Wl,--no-as-needed
        GTest::gtest
        GTest::gtest_main
        GTest::gmock
        GTest::gmock_main
        -lrt
        -ldl
        -lgcov
        ascend_protobuf
        $<BUILD_INTERFACE:intf_ut_pub>
        $<BUILD_INTERFACE:slog_headers>
)

add_custom_target(
        platform_config_files
        COMMAND
        echo "-- Copy platform ini files start" && mkdir -p "${CMAKE_CURRENT_BINARY_DIR}/../data/platform_config" &&
        cp -rf ${TOP_DIR}/src/platform/platform_config/*.ini ${CMAKE_CURRENT_BINARY_DIR}/../data/platform_config/ &&
        echo "-- Copy platform ini files end"
)

add_dependencies(platform_utest platform_config_files)
#add_dependencies(platform_utest platform_infos_proto_ut)

add_dependencies(platform_stub_ut platform_config_files)
#add_dependencies(platform_stub_ut platform_infos_proto_ut)
set(RUNTIME_TARGET
    platform_utest
    platform_stub_ut
)
add_custom_target(platform_ut DEPENDS ${RUNTIME_TARGET})
include_directories(${OPEN_SOURCE_DIR}/mockcpp_src/include)
# message(STATUS "OPEN_SOURCE_DIR is ${OPEN_SOURCE_DIR}")
# include_directories(/home/jenkins/opensource/mockcpp_src/include)