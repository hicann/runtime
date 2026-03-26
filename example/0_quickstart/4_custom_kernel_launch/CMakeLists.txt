cmake_minimum_required(VERSION 3.16.0)

project(Custom_Kernel_Launch_Sample)

set(SOC_VERSION $ENV{SOC_VERSION})
set(ASCENDC_CMAKE_DIR $ENV{ASCENDC_CMAKE_DIR})
set(RUN_MODE "npu" CACHE STRING "run mode: npu")
set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "Build type Release/Debug (default Debug)" FORCE)

include(${ASCENDC_CMAKE_DIR}/ascendc.cmake)

include_directories(${ASCEND_CANN_PACKAGE_PATH}/include)
link_directories(${ASCEND_CANN_PACKAGE_PATH}/lib64)

ascendc_library(custom_kernel STATIC vector_add_kernel.cpp)

add_executable(main main.cpp)

target_compile_options(main PRIVATE
    -O2 -std=c++17 -D_GLIBCXX_USE_CXX11_ABI=0 -Wall -Werror
)

target_link_libraries(main PRIVATE
    custom_kernel
)
