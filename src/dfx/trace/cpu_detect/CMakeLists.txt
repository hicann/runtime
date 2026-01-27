############################# libcpu_detect.so(linux)   #############################
set(libcpudetectSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_detect.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_detect_core.c
    ${CMAKE_CURRENT_SOURCE_DIR}/cpu_detect_test.c
)

set(milanCpuDetectTestSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdScalar01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdScalar02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdScalar03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector05.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector06.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector07.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressAdvsimdVector08.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressFloat01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressFloat02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressFloat03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressInt01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressInt02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupA/SinglePressInt03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupB/TSRTIntAllOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupB/TSRTIntCompare.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupB/TSRTIntAlu.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupB/TSRTIntCRCAndShiftAndMov.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatAllOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatCompare.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatFixedPointConvertToFloatPoint.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatFloatPointConvertPrecision.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatFloatPointRoundToInteger.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatMinMax.S 
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupC/TSRTFloatMovMadd.S 
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupD/TSRTAdvsimdScalarAllOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupD/TSRTAdvsimdScalarCompare.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupD/TSRTAdvsimdScalarFixedPointConvertToFloatPoint.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupD/TSRTAdvsimdScalarFloatPointConvertToInteger.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupD/TSRTAdvsimdScalarGeneralOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorAllOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorCompare.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorFixedPointConvertToFloatingPoint.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorFloatingPointConvertToInteger.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorFloatingPointOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorGeneralOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorMaxMin.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorSecureHashStandard.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorSignedOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupE/TSRTAdvsimdVectorUnsignedOperation.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadDeprecatedP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadDeprecatedP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadDeprecatedP03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadDeprecatedP04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP05.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP06.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/AdvsimdLoadStoreP07.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/FpsimdLoadStoreP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/FpsimdLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/GeneralLoadStoreP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/GeneralLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/GeneralLoadStoreP03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupF/GeneralLoadStoreP04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupG/BranchInGeneralP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupG/BranchInGeneralP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseAdvsimdScalarP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseAdvsimdVectorP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseAdvsimdVectorP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseAdvsimdVectorP03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseAdvsimdVectorP04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseFloatP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/DataReverseIntP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/EnhanceBranchP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/EnhanceDependencyP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/EnhanceLoadStoreP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/stl_groupH/EnhanceLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanFpComparisonP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanFpMiniMaxiP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanFpMovMaddP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdAddP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdAritheticP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdCompareP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdComplexP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdCryptoP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdElementArithemticP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdFpIntConversionP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdImmP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdMovP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdPairArithmeticP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdPermuteP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdReduceP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdUnaryArithmeticP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanSimdWideNarryArthemticP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntAluP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCcP01.S 
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntMduP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntAluP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntMduP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCacheWriteReadP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCacheWriteReadP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCacheWriteReadP03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCacheWriteReadP04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCacheWriteReadP05.S 
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_milan/Taishan/TaishanIntCacheWriteReadP06.S
)

set(torinoCpuDetectTestSrcFiles
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupA/TSRTIntAlu.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupA/TSRTIntCompare.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupA/TSRTIntCRCAndShiftAndMov.S

    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/GeneralLoadStoreP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/GeneralLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/LCRTGeneralLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/LCRTGeneralLoadStoreP03.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/LCRTGeneralLoadStoreP04.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/GeneralPrefetchP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupE/LCRTGeneralLoadStoreP05.S

    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupF/BranchInGeneralP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupF/BranchInGeneralP02.S

    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/EnhanceBranchP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/EnhanceLoadStoreP02.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/BrAdrLiteral.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/DataCacheInvalidP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/EnhanceLoadStoreP01.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/InstrCacheInvalid.S
    ${CMAKE_CURRENT_SOURCE_DIR}/testcase_torino/stl_groupG/LoadALUDependencyP01.S
)

set(libcpudetecttestSrcFiles ${milanCpuDetectTestSrcFiles})
set(CPU_DETECT_STL_MARCH "-march=armv8.3-a+crc+crypto+fp16")
if(PRODUCT)
    if(${PRODUCT} STREQUAL "ascend910_95")
        set(libcpudetecttestSrcFiles ${torinoCpuDetectTestSrcFiles})
        set(CPU_DETECT_STL_MARCH "-march=armv8.3-a+crc+fp+simd+lse+fp16+crypto")
    endif()
endif()

add_library(cpu_detect_testcase_share
    OBJECT
        ${libcpudetecttestSrcFiles}
)

target_compile_options(cpu_detect_testcase_share 
    PRIVATE
        ${CPU_DETECT_STL_MARCH}
        -Werror
        -ftrapv
        -fPIC
)

set(libcpudetectHeaderDir
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/../inc/cpu_detect
    ${RUNTIME_DIR}/inc/driver
)

add_library(cpu_detect_share
    SHARED
        ${libcpudetectSrcFiles})

target_include_directories(cpu_detect_share
    PRIVATE
        ${RUNTIME_DIR}/abl/libc_sec/include
        ${libcpudetectHeaderDir})

target_compile_definitions(cpu_detect_share
    PRIVATE
    PUBLIC
)

target_compile_options(cpu_detect_share
    PRIVATE
        ${ADIAG_COMMON_COMPILE_OPTIONS}
        -Werror
        -Wall
        -Wfloat-equal
        -Wextra
        -Wunused
        -Wshadow
        -Wundef
        $<$<CONFIG:Debug>:-g -O0>
        $<$<CONFIG:Release>:-Os -D_FORTIFY_SOURCE=2>
        -std=gnu11
        -fPIC
        -fstack-protector-strong
        -fno-common
        -fsigned-char
        -fno-strict-aliasing
        -fdata-sections
        -ffunction-sections
)

target_link_options(cpu_detect_share
    PRIVATE
        -Wl,-z,relro,-z,now,-z,noexecstack
        -Wl,--gc-sections
)

target_link_libraries(cpu_detect_share
    PRIVATE
        $<BUILD_INTERFACE:intf_pub>
        $<BUILD_INTERFACE:slog_headers>
        cpu_detect_testcase_share
        ascend_hal
        ${ATRACE_DIR}/slog.so
        ${ATRACE_DIR}/libc_sec.so
)

target_compile_definitions(cpu_detect_share
    PRIVATE
        OS_TYPE=0
        $<$<STREQUAL:${PRODUCT},ascend910_95>:CPU_DETECT_LINX_CORE>
)
set_target_properties(cpu_detect_share
    PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS TRUE
    OUTPUT_NAME cpu_detect
)

install_package(
    TARGETS cpu_detect_share
    FILES   ${ATRACE_DIR}/../../include/cpu_detect/cpu_detect.h
            ${ATRACE_DIR}/../../include/cpu_detect/cpu_detect_types.h
    DESTINATION ${INSTALL_INCLUDE_DIR}/cpu_detect
)