get_target_property(DLOG_MULTI_SOURCES iam_slog_utest SOURCES)
get_target_property(DLOG_MULTI_INCLUDES iam_slog_utest INCLUDE_DIRECTORIES)
list(FILTER DLOG_MULTI_SOURCES EXCLUDE REGEX "(main\\.cc|iam_slog_coverage_utest\\.cc)$")

foreach(variant IN ITEMS slog alog app driver)
    set(variant_sources ${DLOG_MULTI_SOURCES})
    if(variant STREQUAL "alog" OR variant STREQUAL "app")
        list(REMOVE_ITEM variant_sources ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_iam.c)
        list(APPEND variant_sources ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_env.c)
    endif()
    add_library(dlog_multi_${variant} SHARED ${variant_sources})
    target_include_directories(dlog_multi_${variant} PRIVATE ${DLOG_MULTI_INCLUDES})
    target_compile_definitions(dlog_multi_${variant} PRIVATE
        _LOG_UT_ IAM IAM_SHARED_TIMER WRITE_TO_SYSLOG OS_TYPE_DEF=0
        LOGOUT_IAM_SERVICE_PATH="/tmp/dlog_multi_${variant}/iam"
        HM_DRV_CHAR_DEV_USER_PATH="/tmp/dlog_multi_${variant}/himem"
    )
    if(variant STREQUAL "alog")
        target_compile_definitions(dlog_multi_${variant} PRIVATE LOG_CPP)
    elseif(variant STREQUAL "app")
        target_compile_definitions(dlog_multi_${variant} PRIVATE APP_LOG)
    elseif(variant STREQUAL "driver")
        target_compile_definitions(dlog_multi_${variant} PRIVATE UNIFIED_DLOG)
    endif()
    target_link_libraries(dlog_multi_${variant} PRIVATE
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        mmpa c_sec dl
    )
    target_link_options(dlog_multi_${variant} PRIVATE -Wl,-Bsymbolic)
    target_compile_options(dlog_multi_${variant} PRIVATE -Werror)
endforeach()

foreach(variant IN ITEMS slog app driver)
    set(variant_sources ${DLOG_MULTI_SOURCES})
    list(APPEND variant_sources
        ${LOG_SOURCE_PATH}/liblog/slog/slog_api.cpp
        ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_env.c
    )
    if(variant STREQUAL "app")
        list(REMOVE_ITEM variant_sources ${LOG_SOURCE_PATH}/liblog/slog/dlog_level_iam.c)
    endif()
    add_library(dlog_autoload_${variant} SHARED ${variant_sources})
    target_include_directories(dlog_autoload_${variant} PRIVATE ${DLOG_MULTI_INCLUDES})
    target_compile_definitions(dlog_autoload_${variant} PRIVATE
        IAM IAM_SHARED_TIMER IAM_PUBLIC_API IAM_AUTO_READY WRITE_TO_SYSLOG OS_TYPE_DEF=0
        LOGOUT_IAM_SERVICE_PATH="/tmp/dlog_autoload_${variant}/iam"
        HM_DRV_CHAR_DEV_USER_PATH="/tmp/dlog_autoload_${variant}/himem"
    )
    if(variant STREQUAL "app")
        target_compile_definitions(dlog_autoload_${variant} PRIVATE APP_LOG)
    elseif(variant STREQUAL "driver")
        target_compile_definitions(dlog_autoload_${variant} PRIVATE UNIFIED_DLOG)
    endif()
    target_link_libraries(dlog_autoload_${variant} PRIVATE
        $<BUILD_INTERFACE:intf_llt_pub>
        $<BUILD_INTERFACE:slog_headers>
        $<BUILD_INTERFACE:mmpa_headers>
        mmpa c_sec dl
    )
    target_compile_options(dlog_autoload_${variant} PRIVATE -Werror -fvisibility=hidden)
    target_link_options(dlog_autoload_${variant} PRIVATE -Wl,-Bsymbolic)
    if(variant STREQUAL "slog")
        set(library_name slog)
    else()
        set(library_name unified_dlog)
    endif()
    set_target_properties(dlog_autoload_${variant} PROPERTIES
        OUTPUT_NAME ${library_name}
        LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/autoload/${variant}
    )
endforeach()

add_executable(dlog_multi_library_utest
    ${UT_SOURCE_PATH}/slog/testcase/main.cc
    ${CMAKE_CURRENT_LIST_DIR}/dlog_multi_library_utest.cc
)
target_include_directories(dlog_multi_library_utest PRIVATE ${DLOG_MULTI_INCLUDES})
target_compile_definitions(dlog_multi_library_utest PRIVATE
    DLOG_MULTI_SLOG_PATH="$<TARGET_FILE:dlog_multi_slog>"
    DLOG_MULTI_ALOG_PATH="$<TARGET_FILE:dlog_multi_alog>"
    DLOG_MULTI_APP_PATH="$<TARGET_FILE:dlog_multi_app>"
    DLOG_MULTI_DRIVER_PATH="$<TARGET_FILE:dlog_multi_driver>"
    DLOG_AUTOLOAD_APP_PATH="$<TARGET_FILE:dlog_autoload_app>"
    DLOG_AUTOLOAD_DRIVER_PATH="$<TARGET_FILE:dlog_autoload_driver>"
    DLOG_AUTOLOAD_SLOG_PATH="$<TARGET_FILE:dlog_autoload_slog>"
    OS_TYPE_DEF=0
)
target_link_libraries(dlog_multi_library_utest PRIVATE
    $<BUILD_INTERFACE:intf_llt_pub>
    $<BUILD_INTERFACE:slog_headers>
    $<BUILD_INTERFACE:mmpa_headers>
    c_sec dl
)
set_target_properties(dlog_multi_library_utest PROPERTIES
    ENABLE_EXPORTS ON OUTPUT_NAME toolchain_dlog_multi_library_utest
)
set_property(TARGET dlog_multi_library_utest APPEND PROPERTY BUILD_RPATH "$<TARGET_FILE_DIR:dlog_autoload_slog>")
add_dependencies(dlog_multi_library_utest dlog_multi_slog dlog_multi_alog dlog_multi_app dlog_multi_driver)
add_dependencies(dlog_multi_library_utest dlog_autoload_slog dlog_autoload_app dlog_autoload_driver)
