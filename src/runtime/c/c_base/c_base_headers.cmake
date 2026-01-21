include_guard(GLOBAL)

add_library(c_base_headers INTERFACE)
target_include_directories(c_base_headers INTERFACE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/..>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/inc>
    $<INSTALL_INTERFACE:include>
    $<INSTALL_INTERFACE:include/c_base>
)
target_compile_definitions(c_base_headers INTERFACE
  $<IF:$<STREQUAL:${TARGET_SYSTEM_NAME},LiteOS>,NANO_OS_TYPE=1,NANO_OS_TYPE=0>
)