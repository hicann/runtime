/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "runtime/rt.h"
#include "runtime/rts/rts_mem.h"

#define private public
#include "runtime.hpp"
#undef private

#include "api_vmm.hpp"

using namespace cce::runtime;
using namespace testing;

namespace {
void* const kVirAddr = reinterpret_cast<void*>(0x1000U);
void* const kVirAddrOut = reinterpret_cast<void*>(0x2000U);
rtDrvMemHandle const kHandle = reinterpret_cast<rtDrvMemHandle>(0x3000U);
constexpr uint64_t kShareableHandle = 0x12345678ULL;
constexpr size_t kGranularity = 4096U;

class ApiVmmRouteStub : public ApiVmm {
public:
    rtError_t ReserveMemAddress(void** devPtr, size_t size, size_t alignment, void* devAddr, uint64_t flags) override
    {
        ++reserveCount_;
        reserveSize_ = size;
        reserveAlignment_ = alignment;
        reserveAddr_ = devAddr;
        reserveFlags_ = flags;
        if (devPtr != nullptr) {
            *devPtr = kVirAddrOut;
        }
        return result_;
    }

    rtError_t ReleaseMemAddress(void* devPtr) override
    {
        ++releaseCount_;
        releasePtr_ = devPtr;
        return result_;
    }

    rtError_t MallocPhysical(rtDrvMemHandle* handle, size_t size, rtDrvMemProp_t* prop, uint64_t flags) override
    {
        ++mallocPhysicalCount_;
        mallocPhysicalSize_ = size;
        mallocPhysicalProp_ = prop;
        mallocPhysicalFlags_ = flags;
        if (handle != nullptr) {
            *handle = kHandle;
        }
        return result_;
    }

    rtError_t FreePhysical(rtDrvMemHandle handle) override
    {
        ++freePhysicalCount_;
        freePhysicalHandle_ = handle;
        return result_;
    }

    rtError_t MapMem(void* devPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) override
    {
        ++mapCount_;
        mapPtr_ = devPtr;
        mapSize_ = size;
        mapOffset_ = offset;
        mapHandle_ = handle;
        mapFlags_ = flags;
        return result_;
    }

    rtError_t UnmapMem(void* devPtr) override
    {
        ++unmapCount_;
        unmapPtr_ = devPtr;
        return result_;
    }

    rtError_t MemMapNoAccess(void* virPtr, size_t size, size_t offset, rtDrvMemHandle handle, uint64_t flags) override
    {
        ++mapNoAccessCount_;
        mapNoAccessPtr_ = virPtr;
        mapNoAccessSize_ = size;
        mapNoAccessOffset_ = offset;
        mapNoAccessHandle_ = handle;
        mapNoAccessFlags_ = flags;
        return result_;
    }

    rtError_t MemSetAccess(void* virPtr, size_t size, rtMemAccessDesc* desc, size_t count) override
    {
        ++setAccessCount_;
        setAccessPtr_ = virPtr;
        setAccessSize_ = size;
        setAccessDesc_ = desc;
        setAccessDescCount_ = count;
        return result_;
    }

    rtError_t MemGetAccess(void* virPtr, rtMemLocation* location, uint64_t* flags) override
    {
        ++getAccessCount_;
        getAccessPtr_ = virPtr;
        if (location != nullptr) {
            location->id = 1U;
            location->type = RT_MEMORY_LOC_DEVICE;
        }
        if (flags != nullptr) {
            *flags = RT_MEM_ACCESS_FLAGS_READWRITE;
        }
        return result_;
    }

    rtError_t ExportToShareableHandle(
        rtDrvMemHandle handle, rtDrvMemHandleType handleType, uint64_t flags, uint64_t* shareableHandle) override
    {
        ++exportCount_;
        exportHandle_ = handle;
        exportHandleType_ = handleType;
        exportFlags_ = flags;
        if (shareableHandle != nullptr) {
            *shareableHandle = kShareableHandle;
        }
        return result_;
    }

    rtError_t ExportToShareableHandleV2(
        rtDrvMemHandle handle, rtMemSharedHandleType handleType, uint64_t flags, void* shareableHandle) override
    {
        ++exportV2Count_;
        exportV2Handle_ = handle;
        exportV2HandleType_ = handleType;
        exportV2Flags_ = flags;
        exportV2ShareableHandle_ = shareableHandle;
        return result_;
    }

    rtError_t ImportFromShareableHandle(uint64_t shareableHandle, int32_t devId, rtDrvMemHandle* handle) override
    {
        ++importCount_;
        importShareableHandle_ = shareableHandle;
        importDevId_ = devId;
        if (handle != nullptr) {
            *handle = kHandle;
        }
        return result_;
    }

    rtError_t ImportFromShareableHandleV2(
        const void* shareableHandle, rtMemSharedHandleType handleType, uint64_t flags, int32_t devId,
        rtDrvMemHandle* handle) override
    {
        ++importV2Count_;
        importV2ShareableHandle_ = shareableHandle;
        importV2HandleType_ = handleType;
        importV2Flags_ = flags;
        importV2DevId_ = devId;
        if (handle != nullptr) {
            *handle = kHandle;
        }
        return result_;
    }

    rtError_t SetPidToShareableHandle(uint64_t shareableHandle, int32_t pid[], uint32_t pidNum) override
    {
        ++setPidCount_;
        setPidShareableHandle_ = shareableHandle;
        setPid_ = pid;
        setPidNum_ = pidNum;
        return result_;
    }

    rtError_t SetPidToShareableHandleV2(
        const void* shareableHandle, rtMemSharedHandleType handleType, int32_t pid[], uint32_t pidNum) override
    {
        ++setPidV2Count_;
        setPidV2ShareableHandle_ = shareableHandle;
        setPidV2HandleType_ = handleType;
        setPidV2_ = pid;
        setPidV2Num_ = pidNum;
        return result_;
    }

    rtError_t GetAllocationGranularity(
        rtDrvMemProp_t* prop, rtDrvMemGranularityOptions option, size_t* granularity) override
    {
        ++granularityCount_;
        granularityProp_ = prop;
        granularityOption_ = option;
        if (granularity != nullptr) {
            *granularity = kGranularity;
        }
        return result_;
    }

    rtError_t MemReserveAddress(
        void** virPtr, size_t size, rtMallocPolicy policy, void* expectAddr, rtMallocConfig_t* cfg) override
    {
        ++memReserveCount_;
        memReserveSize_ = size;
        memReservePolicy_ = policy;
        memReserveExpectAddr_ = expectAddr;
        memReserveCfg_ = cfg;
        if (virPtr != nullptr) {
            *virPtr = kVirAddrOut;
        }
        return result_;
    }

    rtError_t MemMallocPhysical(rtMemHandle* handle, size_t size, rtMallocPolicy policy, rtMallocConfig_t* cfg) override
    {
        ++memMallocPhysicalCount_;
        memMallocPhysicalSize_ = size;
        memMallocPhysicalPolicy_ = policy;
        memMallocPhysicalCfg_ = cfg;
        if (handle != nullptr) {
            *handle = kHandle;
        }
        return result_;
    }

    rtError_t MemRetainAllocationHandle(void* virPtr, rtDrvMemHandle* handle) override
    {
        ++retainCount_;
        retainPtr_ = virPtr;
        if (handle != nullptr) {
            *handle = kHandle;
        }
        return result_;
    }

    rtError_t MemGetAllocationPropertiesFromHandle(rtDrvMemHandle handle, rtDrvMemProp_t* prop) override
    {
        ++propertiesCount_;
        propertiesHandle_ = handle;
        propertiesProp_ = prop;
        return result_;
    }

    rtError_t MemGetAddressRange(void* ptr, void** pbase, size_t* psize) override
    {
        ++addressRangeCount_;
        addressRangePtr_ = ptr;
        if (pbase != nullptr) {
            *pbase = kVirAddrOut;
        }
        if (psize != nullptr) {
            *psize = kGranularity;
        }
        return result_;
    }

    rtError_t MemMapSelectedLink(void* virPtrDst, size_t size, void* virPtrSrc, uint32_t linkIdx) override
    {
        ++selectedLinkCount_;
        selectedLinkDst_ = virPtrDst;
        selectedLinkSize_ = size;
        selectedLinkSrc_ = virPtrSrc;
        selectedLinkIdx_ = linkIdx;
        return result_;
    }

    rtError_t MemMapSetLink(rtDrvMemHandle handle, rtMemLinkType adviceLink) override
    {
        ++setLinkCount_;
        setLinkHandle_ = handle;
        setLinkAdvice_ = adviceLink;
        return result_;
    }

    rtError_t result_ = RT_ERROR_NONE;
    uint32_t reserveCount_ = 0U;
    uint32_t releaseCount_ = 0U;
    uint32_t mallocPhysicalCount_ = 0U;
    uint32_t freePhysicalCount_ = 0U;
    uint32_t mapCount_ = 0U;
    uint32_t unmapCount_ = 0U;
    uint32_t mapNoAccessCount_ = 0U;
    uint32_t setAccessCount_ = 0U;
    uint32_t getAccessCount_ = 0U;
    uint32_t exportCount_ = 0U;
    uint32_t exportV2Count_ = 0U;
    uint32_t importCount_ = 0U;
    uint32_t importV2Count_ = 0U;
    uint32_t setPidCount_ = 0U;
    uint32_t setPidV2Count_ = 0U;
    uint32_t granularityCount_ = 0U;
    uint32_t memReserveCount_ = 0U;
    uint32_t memMallocPhysicalCount_ = 0U;
    uint32_t retainCount_ = 0U;
    uint32_t propertiesCount_ = 0U;
    uint32_t addressRangeCount_ = 0U;
    uint32_t selectedLinkCount_ = 0U;
    uint32_t setLinkCount_ = 0U;
    size_t reserveSize_ = 0U;
    size_t reserveAlignment_ = 0U;
    void* reserveAddr_ = nullptr;
    uint64_t reserveFlags_ = 0U;
    void* releasePtr_ = nullptr;
    size_t mallocPhysicalSize_ = 0U;
    rtDrvMemProp_t* mallocPhysicalProp_ = nullptr;
    uint64_t mallocPhysicalFlags_ = 0U;
    rtDrvMemHandle freePhysicalHandle_ = nullptr;
    void* mapPtr_ = nullptr;
    size_t mapSize_ = 0U;
    size_t mapOffset_ = 0U;
    rtDrvMemHandle mapHandle_ = nullptr;
    uint64_t mapFlags_ = 0U;
    void* unmapPtr_ = nullptr;
    void* mapNoAccessPtr_ = nullptr;
    size_t mapNoAccessSize_ = 0U;
    size_t mapNoAccessOffset_ = 0U;
    rtDrvMemHandle mapNoAccessHandle_ = nullptr;
    uint64_t mapNoAccessFlags_ = 0U;
    void* setAccessPtr_ = nullptr;
    size_t setAccessSize_ = 0U;
    rtMemAccessDesc* setAccessDesc_ = nullptr;
    size_t setAccessDescCount_ = 0U;
    void* getAccessPtr_ = nullptr;
    rtDrvMemHandle exportHandle_ = nullptr;
    rtDrvMemHandleType exportHandleType_ = RT_MEM_HANDLE_TYPE_NONE;
    uint64_t exportFlags_ = 0U;
    rtDrvMemHandle exportV2Handle_ = nullptr;
    rtMemSharedHandleType exportV2HandleType_ = RT_MEM_SHARE_HANDLE_TYPE_DEFAULT;
    uint64_t exportV2Flags_ = 0U;
    void* exportV2ShareableHandle_ = nullptr;
    uint64_t importShareableHandle_ = 0U;
    int32_t importDevId_ = 0;
    const void* importV2ShareableHandle_ = nullptr;
    rtMemSharedHandleType importV2HandleType_ = RT_MEM_SHARE_HANDLE_TYPE_DEFAULT;
    uint64_t importV2Flags_ = 0U;
    int32_t importV2DevId_ = 0;
    uint64_t setPidShareableHandle_ = 0U;
    int32_t* setPid_ = nullptr;
    uint32_t setPidNum_ = 0U;
    const void* setPidV2ShareableHandle_ = nullptr;
    rtMemSharedHandleType setPidV2HandleType_ = RT_MEM_SHARE_HANDLE_TYPE_DEFAULT;
    int32_t* setPidV2_ = nullptr;
    uint32_t setPidV2Num_ = 0U;
    rtDrvMemProp_t* granularityProp_ = nullptr;
    rtDrvMemGranularityOptions granularityOption_ = RT_MEM_ALLOC_GRANULARITY_INVALID;
    size_t memReserveSize_ = 0U;
    rtMallocPolicy memReservePolicy_ = RT_MEM_MALLOC_HUGE_FIRST;
    void* memReserveExpectAddr_ = nullptr;
    rtMallocConfig_t* memReserveCfg_ = nullptr;
    size_t memMallocPhysicalSize_ = 0U;
    rtMallocPolicy memMallocPhysicalPolicy_ = RT_MEM_MALLOC_HUGE_FIRST;
    rtMallocConfig_t* memMallocPhysicalCfg_ = nullptr;
    void* retainPtr_ = nullptr;
    rtDrvMemHandle propertiesHandle_ = nullptr;
    rtDrvMemProp_t* propertiesProp_ = nullptr;
    void* addressRangePtr_ = nullptr;
    void* selectedLinkDst_ = nullptr;
    size_t selectedLinkSize_ = 0U;
    void* selectedLinkSrc_ = nullptr;
    uint32_t selectedLinkIdx_ = 0U;
    rtDrvMemHandle setLinkHandle_ = nullptr;
    rtMemLinkType setLinkAdvice_ = RT_MEM_ACCESS_LINK_SIO;
};

class ApiVmmRouteTest : public Test {
protected:
    void SetUp() override
    {
        runtime_ = Runtime::Instance();
        ASSERT_NE(runtime_, nullptr);
        oldApi_ = runtime_->api_;
        oldApiVmm_ = runtime_->apiVmm_;
        runtime_->api_ = nullptr;
        runtime_->apiVmm_ = &apiVmm_;
    }

    void TearDown() override
    {
        runtime_->api_ = oldApi_;
        runtime_->apiVmm_ = oldApiVmm_;
    }

    Runtime* runtime_ = nullptr;
    Api* oldApi_ = nullptr;
    ApiVmm* oldApiVmm_ = nullptr;
    ApiVmmRouteStub apiVmm_;
};
} // namespace

TEST_F(ApiVmmRouteTest, RoutesLegacyVmmApisToApiVmm)
{
    void* devPtr = nullptr;
    rtDrvMemHandle handle = nullptr;
    rtDrvMemProp_t prop = {};
    uint64_t shareableHandle = 0U;
    int32_t pid = 1;
    size_t granularity = 0U;

    EXPECT_EQ(rtReserveMemAddress(&devPtr, 64U, 16U, kVirAddr, 1U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtReleaseMemAddress(kVirAddr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMallocPhysical(&handle, 128U, &prop, 2U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtFreePhysical(kHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMapMem(kVirAddr, 256U, 8U, kHandle, 3U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtUnmapMem(kVirAddr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemMapNoAccess(kVirAddr, 512U, 4U, kHandle, 5U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemExportToShareableHandle(kHandle, RT_MEM_HANDLE_TYPE_POSIX, 1U, &shareableHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemImportFromShareableHandle(kShareableHandle, 7, &handle), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemSetPidToShareableHandle(kShareableHandle, &pid, 1U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_MINIMUM, &granularity), ACL_RT_SUCCESS);

    EXPECT_EQ(devPtr, kVirAddrOut);
    EXPECT_EQ(handle, kHandle);
    EXPECT_EQ(shareableHandle, kShareableHandle);
    EXPECT_EQ(granularity, kGranularity);
    EXPECT_EQ(apiVmm_.reserveCount_, 1U);
    EXPECT_EQ(apiVmm_.releaseCount_, 1U);
    EXPECT_EQ(apiVmm_.mallocPhysicalCount_, 1U);
    EXPECT_EQ(apiVmm_.freePhysicalCount_, 1U);
    EXPECT_EQ(apiVmm_.mapCount_, 1U);
    EXPECT_EQ(apiVmm_.unmapCount_, 1U);
    EXPECT_EQ(apiVmm_.mapNoAccessCount_, 1U);
    EXPECT_EQ(apiVmm_.exportCount_, 1U);
    EXPECT_EQ(apiVmm_.importCount_, 1U);
    EXPECT_EQ(apiVmm_.setPidCount_, 1U);
    EXPECT_EQ(apiVmm_.granularityCount_, 1U);
    EXPECT_EQ(apiVmm_.reserveSize_, 64U);
    EXPECT_EQ(apiVmm_.reserveAlignment_, 16U);
    EXPECT_EQ(apiVmm_.reserveAddr_, kVirAddr);
    EXPECT_EQ(apiVmm_.mapHandle_, kHandle);
    EXPECT_EQ(apiVmm_.mapOffset_, 8U);
    EXPECT_EQ(apiVmm_.importDevId_, 7);
    EXPECT_EQ(apiVmm_.setPid_, &pid);
}

TEST_F(ApiVmmRouteTest, RoutesRtsAndV2VmmApisToApiVmm)
{
    void* virPtr = nullptr;
    rtMemHandle memHandle = nullptr;
    rtDrvMemHandle drvHandle = nullptr;
    rtDrvMemProp_t prop = {};
    rtMemAccessDesc accessDesc = {};
    rtMemLocation location = {};
    uint64_t flags = 0U;
    uint64_t shareableHandle = 0U;
    rtDrvMemFabricHandle fabricHandle = {};
    int32_t pid = 2;
    size_t granularity = 0U;
    void* base = nullptr;
    size_t baseSize = 0U;

    EXPECT_EQ(rtsMemExportToShareableHandle(kHandle, RT_MEM_HANDLE_TYPE_POSIX, 0U, &shareableHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemSetPidToShareableHandle(kShareableHandle, &pid, 1U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemImportFromShareableHandle(kShareableHandle, 1, &drvHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(
        rtMemExportToShareableHandleV2(kHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 1U, &fabricHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(
        rtMemImportFromShareableHandleV2(&fabricHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, 0U, 2, &drvHandle),
        ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemSetPidToShareableHandleV2(&fabricHandle, RT_MEM_SHARE_HANDLE_TYPE_FABRIC, &pid, 1U), ACL_RT_SUCCESS);
    EXPECT_EQ(
        rtsMemGetAllocationGranularity(&prop, RT_MEM_ALLOC_GRANULARITY_RECOMMENDED, &granularity), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemReserveAddress(&virPtr, 4096U, RT_MEM_MALLOC_HUGE_ONLY, nullptr, nullptr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemFreeAddress(&virPtr), ACL_RT_SUCCESS);
    EXPECT_EQ(
        rtsMemMallocPhysical(
            &memHandle, 8192U, static_cast<rtMallocPolicy>(RT_MEM_MALLOC_HUGE_ONLY | RT_MEM_TYPE_HIGH_BAND_WIDTH),
            nullptr),
        ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemFreePhysical(&memHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemMap(kVirAddr, 1024U, 0U, memHandle, 0U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtsMemUnmap(kVirAddr), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemSetAccess(kVirAddr, 2048U, &accessDesc, 1U), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemGetAccess(kVirAddr, &location, &flags), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemRetainAllocationHandle(kVirAddr, &drvHandle), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemGetAllocationPropertiesFromHandle(kHandle, &prop), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemGetAddressRange(kVirAddr, &base, &baseSize), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemMapSelectedLink(kVirAddrOut, 4096U, kVirAddr, RT_MEM_LINK_IDX_1), ACL_RT_SUCCESS);
    EXPECT_EQ(rtMemMapSetLink(kHandle, RT_MEM_ACCESS_LINK_HCCS), ACL_RT_SUCCESS);

    EXPECT_EQ(apiVmm_.exportCount_, 1U);
    EXPECT_EQ(apiVmm_.setPidCount_, 1U);
    EXPECT_EQ(apiVmm_.importCount_, 1U);
    EXPECT_EQ(apiVmm_.exportV2Count_, 1U);
    EXPECT_EQ(apiVmm_.importV2Count_, 1U);
    EXPECT_EQ(apiVmm_.setPidV2Count_, 1U);
    EXPECT_EQ(apiVmm_.granularityCount_, 1U);
    EXPECT_EQ(apiVmm_.memReserveCount_, 1U);
    EXPECT_EQ(apiVmm_.releaseCount_, 1U);
    EXPECT_EQ(apiVmm_.memMallocPhysicalCount_, 1U);
    EXPECT_EQ(apiVmm_.freePhysicalCount_, 1U);
    EXPECT_EQ(apiVmm_.mapCount_, 1U);
    EXPECT_EQ(apiVmm_.unmapCount_, 1U);
    EXPECT_EQ(apiVmm_.setAccessCount_, 1U);
    EXPECT_EQ(apiVmm_.getAccessCount_, 1U);
    EXPECT_EQ(apiVmm_.retainCount_, 1U);
    EXPECT_EQ(apiVmm_.propertiesCount_, 1U);
    EXPECT_EQ(apiVmm_.addressRangeCount_, 1U);
    EXPECT_EQ(apiVmm_.selectedLinkCount_, 1U);
    EXPECT_EQ(apiVmm_.setLinkCount_, 1U);
    EXPECT_EQ(location.id, 1U);
    EXPECT_EQ(location.type, RT_MEMORY_LOC_DEVICE);
    EXPECT_EQ(flags, RT_MEM_ACCESS_FLAGS_READWRITE);
    EXPECT_EQ(base, kVirAddrOut);
    EXPECT_EQ(baseSize, kGranularity);
    EXPECT_EQ(apiVmm_.setLinkAdvice_, RT_MEM_ACCESS_LINK_HCCS);
}

TEST_F(ApiVmmRouteTest, ConvertsVmmSpecialErrors)
{
    apiVmm_.result_ = RT_ERROR_FEATURE_NOT_SUPPORT;
    EXPECT_EQ(rtMapMem(kVirAddr, 256U, 0U, kHandle, 0U), ACL_ERROR_RT_FEATURE_NOT_SUPPORT);
    EXPECT_EQ(apiVmm_.mapCount_, 1U);

    apiVmm_.result_ = RT_ERROR_DRV_LINK_TYPE_NOT_SUPPORTED;
    EXPECT_EQ(rtMemMapSetLink(kHandle, RT_MEM_ACCESS_LINK_HCCS), ACL_ERROR_RT_LINK_TYPE_NOT_SUPPORTED);
    EXPECT_EQ(apiVmm_.setLinkCount_, 1U);
}
