/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>
#include "driver/ascend_hal.h"
#include "driver_mem.h"
#include <gtest/gtest.h>
#include "model/model_api.h"
#include "mockcpp/mockcpp.hpp"

//extern "C" int open(const char *pathname, int flags);
extern "C" void drvResetMgmtHead(void);
extern "C" void drvResetMgmtTail(void);

using namespace testing;

class DrvMemTest : public testing::Test {
 protected:
  static void SetUpTestCase() {
    std::cout << "DrvApiTest SetUP" << std::endl;
  }
  static void TearDownTestCase() {
    std::cout << "DrvApiTest TearDown" << std::endl;
  }
  // Some expensive resource shared by all tests.
  virtual void SetUp()
  {
    GlobalMockObject::verify();
    std::cout << "a test SetUP" << std::endl;
  }
  virtual void TearDown()
  {
    drvResetMgmtHead();
    drvResetMgmtTail();
    GlobalMockObject::verify();
    std::cout << "a test TearDown" << std::endl;
  }
};

extern "C" drvError_t drvMemMgmtInit();
extern "C" drvError_t drvMemAllocHost(void **pp, size_t bytesize);
extern "C" drvError_t drvMemFreeHost(void *pp);
extern "C" drvError_t drvMergeDeviceHBM(drvMemNode_t *drvNewMemMgmt, int32_t deviceId);
extern "C" drvError_t drvFreeDeviceHBM(void *dptr, int32_t deviceId);
extern "C" drvError_t drvMemAllocDeviceHBM(void **dptr, uint64_t requestSize, int32_t deviceId);
extern "C" drvError_t drvMemMgmtQueueFree(int32_t deviceId);
extern "C" DVresult drvMemAddressTranslate(DVdeviceptr vptr, UINT64 *pptr);
extern "C" drvError_t drvMemSmmuQuery(uint32_t device, uint32_t *SSID);
extern "C" DVresult drvMemAllocL2buffAddr(DVdevice device, void **l2buff, UINT64 *pte);
extern "C" drvError_t drvMemReleaseL2buffAddr(uint32_t device, void *l2buff);
extern "C" DVresult drvMemAllocHugePageManaged(DVdeviceptr *pp, size_t bytesize);
extern "C" DVresult drvMemFreeHugePageManaged(DVdeviceptr addr);
extern "C" DVresult drvMemAllocManaged(DVdeviceptr *addr, size_t bytesize);
extern "C" DVresult drvMemFreeManaged(DVdeviceptr addr);
extern "C" drvError_t drvMemDestroyAddr(struct DMA_ADDR *ptr);
extern "C" DVresult drvMemPrefetchToDevice(DVdeviceptr devPtr, size_t len, DVdevice device);
extern "C" DVresult drvMemAdvise(DVdeviceptr devPtr, size_t count, DVmem_advise advise, DVdevice device);
extern "C" DVresult drvMemConvertAddr(DVdeviceptr pSrc, DVdeviceptr pDst, UINT32 len, struct DMA_ADDR *dmaAddr);
extern "C" int drvMemDeviceOpen(unsigned int devid, int devfd);
extern "C" int drvMemDeviceClose(unsigned int devid);
extern "C" DVresult drvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t ByteCount);
extern "C" DVresult drvMemsetD8(DVdeviceptr dst, size_t destMax, UINT8 value, size_t num);
extern "C" DVresult drvMemLock(DVdeviceptr devPtr, unsigned int lockType, DVdevice device);
extern "C" DVresult drvMemUnLock(DVdeviceptr devPtr);
extern "C" DVresult drvMemGetAttribute(DVdeviceptr vptr, struct DVattribute *attr);
extern "C" DVresult halShmemCreateHandle(DVdeviceptr vptr, size_t byte_count, char *name, unsigned int name_len);
extern "C" drvError_t halShmemDestroyHandle(const char *name);
extern "C" DVresult halShmemOpenHandle(const char *name, DVdeviceptr *vptr);
extern "C" DVresult halShmemOpenHandleByDevId(DVdevice devId, const char *name, DVdeviceptr *vptr);
extern "C" DVresult halShmemCloseHandle(DVdeviceptr vptr);
extern "C" drvError_t halShmemSetPidHandle(const char *name, pid_t pid[], int num);
extern "C" drvError_t drvLoadProgram(uint32_t deviceId, void *program, unsigned int offset, size_t ByteCount, void **vPtr);
extern "C" drvError_t drvDeviceGetPhyIdByIndex(uint32_t devIndex, uint32_t *phyId);
extern "C" drvError_t drvDeviceGetIndexByPhyId(uint32_t phyId, uint32_t *devIndex);
extern "C" DVresult cmodelDrvMemcpy(DVdeviceptr dst, size_t destMax, DVdeviceptr src, size_t size, drvMemcpyKind_t kind);
extern "C" drvError_t cmodelDrvFreeHost(void *pp);
TEST_F(DrvMemTest, mem_init_test)
{
	drvError_t error;
	void *hbmOffsetPoint;
	int32_t nodeId=0;
    int32_t deviceId = nodeId;
	uint64_t size=64;   //size of L1

	error=drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    drvFlushCache((uint64_t)hbmOffsetPoint, (uint32_t)size);
    error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_allocAPI_test)
{
	drvError_t error;
    void *hbmOffsetPoint;
	int32_t nodeId=0;
    int32_t deviceId = nodeId;
	uint64_t size=64;

	drvMemMgmtInit();

    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = drvMemAlloc(&hbmOffsetPoint, MAX_ALLOC, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemAlloc(&hbmOffsetPoint, 0x40000000UL - 0x10000000, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_OUT_OF_MEMORY);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = drvMemAlloc(&hbmOffsetPoint, 0, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

	error=drvMemAlloc(NULL,size,DRV_MEMORY_HBM,nodeId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvMemAlloc(&hbmOffsetPoint, -1, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_OUT_OF_MEMORY);
    error = drvMemAlloc(&hbmOffsetPoint, 0x40000000UL - 0x10000000 + 1, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_OUT_OF_MEMORY);
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_DDR, nodeId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_MALLOC_TYPE);
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, -1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, 1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvMemTest, mem_freeAPI_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

	drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
	error=drvMemFree(NULL,deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvMemFree(hbmOffsetPoint, -1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = drvMemFree(hbmOffsetPoint, 1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);


    error = drvModelMemset(0, 0, 0, 8);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    uint64_t dst;
    size_t destMax;

    dst = 0x20000000;
    destMax = 256;
    error = drvModelMemset(dst, destMax, 0, size);
    EXPECT_EQ(error, DRV_ERROR_NONE);


}

TEST_F(DrvMemTest, mem_hostAPI_test)
{
    drvError_t error;
    void *hostDDRPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

    drvMemMgmtInit();
    error = halMemAlloc(&hostDDRPoint, size, MEM_SET_ALIGN_SIZE(20) | MEM_HOST);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = cmodelDrvFreeHost(hostDDRPoint);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halMemAlloc(NULL, size, MEM_SET_ALIGN_SIZE(20) | MEM_HOST);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);

    void *mem;
    error = halMemAlloc(&mem, size, MEM_SET_ALIGN_SIZE(20) | MEM_DEV);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = halMemFree(mem);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halMemAlloc(&hostDDRPoint, size, MEM_SET_ALIGN_SIZE(20) | MEM_HOST);
    error = cmodelDrvFreeHost(NULL);
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = cmodelDrvFreeHost(hostDDRPoint);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}



TEST_F(DrvMemTest, drv_memaddr_translate)
{
    DVresult rst;
    UINT64 ptr;
    DVdeviceptr vptr;

    rst = drvMemAddressTranslate(vptr, NULL);
    EXPECT_EQ(rst, DRV_ERROR_INVALID_HANDLE);

    rst = drvMemAddressTranslate(0, &ptr);
    EXPECT_EQ(rst, DRV_ERROR_INVALID_VALUE);

    rst = drvMemAddressTranslate(1, &ptr);
    EXPECT_EQ(rst, DRV_ERROR_NONE);
}

/*TEST_F(DrvMemTest, mem_drvMemsetD8_test)
{
    drvError_t error;
    char* a = (char*)malloc(MEMSET_SIZE_MAX + 1);

    MOCKER(drvModelMemset).stubs().will(returnValue(DRV_ERROR_NONE));
    error = drvMemsetD8((uint64_t)a, MEMSET_SIZE_MAX + 1, 0, MEMSET_SIZE_MAX + 1);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    free(a);
}*/

TEST_F(DrvMemTest, mem_drvMemConvertAddr)
{
	drvError_t error;
	DVresult result;
	size_t ByteCount = (size_t)32;
	DVdeviceptr dstDev = 0;
	DVdeviceptr srcDev = 0;
	void *srcHost = 0;
	void *dstHost = 0;
	uint32_t len = 0;
	struct DMA_ADDR dmaAddr;

	error = drvMemConvertAddr(srcDev, dstDev, len, &dmaAddr);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}


#if 0
TEST_F(DrvMemTest, mem_alloc_test)
{
    drvError_t error;
    void *hbmOffsetPoint1;
    void *hbmOffsetPoint2;
    void *hbmOffsetPoint3;
	void *hbmOffsetPoint4;
	void *hbmOffsetPoint5;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

    drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint1, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAlloc(&hbmOffsetPoint2, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAlloc(&hbmOffsetPoint3, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemAlloc(&hbmOffsetPoint4, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemAlloc(&hbmOffsetPoint5, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

    error = drvMemFree(hbmOffsetPoint4, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint3, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

	error = drvMemFree(hbmOffsetPoint5, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint2, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint1, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);

}

TEST_F(DrvMemTest, memcpy_syncH2D_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

	drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemcpy((uint64_t)hbmOffsetPoint, sizeof(str), (uint64_t)str, sizeof(str));
	EXPECT_EQ(error, DRV_ERROR_NONE);
	memset(str,0,size);
    error = drvMemcpy((uint64_t)str,  sizeof(str), (uint64_t)hbmOffsetPoint, sizeof(str));
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_syncH2D_writeFail1_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

    MOCKER(busDirectWrite).stubs().will(returnValue(MODEL_RW_ERROR_LEN));
    drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hbmOffsetPoint, sizeof(str), str, sizeof(str), DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);

    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_syncH2D2_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

    drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hbmOffsetPoint, sizeof(str), str, sizeof(str), DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    memset(str, 0, size);
    error = drvModelMemcpy(str, sizeof(str), hbmOffsetPoint, sizeof(str), DRV_MEMCPY_DEVICE_TO_HOST, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_syncH2D_writeFail2_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

    MOCKER(busDirectWrite).stubs().will(returnValue(MODEL_RW_ERROR_ADDRESS));

    drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hbmOffsetPoint, sizeof(str), str, sizeof(str), DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_syncH2D_readFail1_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

    MOCKER(busDirectRead).stubs().will(returnValue(MODEL_RW_ERROR_ADDRESS));

    drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hbmOffsetPoint, size, str, size, DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    memset(str, 0, size);
    error = drvModelMemcpy(str, size, hbmOffsetPoint, size, DRV_MEMCPY_DEVICE_TO_HOST, deviceId);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_syncH2D_readFail2_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

    MOCKER(busDirectRead).stubs().will(returnValue(MODEL_RW_ERROR_LEN));

    drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hbmOffsetPoint, sizeof(str), str, sizeof(str), DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    memset(str, 0, size);
    error = drvModelMemcpy(str, sizeof(str), hbmOffsetPoint, sizeof(str), DRV_MEMCPY_DEVICE_TO_HOST, deviceId);
    EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_syncAPI_H2D_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

	drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
	error=drvModelMemcpy(NULL, size, str, size, DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvModelMemcpy(hbmOffsetPoint, size, NULL, size, DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
    error = drvModelMemcpy(hbmOffsetPoint, 0x40000000 - 0x2000000 + 1, str, 0x40000000 - 0x2000000 + 1, DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = drvModelMemcpy(hbmOffsetPoint, size, str, size, DRV_MEMCPY_HOST_TO_DEVICE, -1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = drvModelMemcpy(hbmOffsetPoint, size, str, size, DRV_MEMCPY_HOST_TO_DEVICE, 1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = drvModelMemcpy(hbmOffsetPoint, size, str, size, DRV_MEMCPY_DEVICE_TO_DEVICE, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
    error = drvModelMemcpy(hbmOffsetPoint, size, str, size, DRV_MEMCPY_HOST_TO_DEVICE, deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_D2D_test)
{
	drvError_t error;
    void *hbmSrc, *hbmDst;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

    drvMemMgmtInit();
    error = drvMemAlloc(&hbmSrc, size, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAlloc(&hbmDst, size, DRV_MEMORY_HBM, nodeId);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemcpy((uint64_t)hbmDst, size, (uint64_t)hbmSrc, size);
	EXPECT_NE(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmSrc, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmDst, deviceId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, memcpy_H2H_test)
{
	drvError_t error;
    void *hostDDRSrc, *hostDDRtDst;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

    error = drvMemAllocHost(&hostDDRSrc, size);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemAllocHost(&hostDDRtDst, size);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hostDDRSrc, size, str, size, DRV_MEMCPY_HOST_TO_HOST, 0);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvModelMemcpy(hostDDRtDst, size, hostDDRSrc, size, DRV_MEMCPY_HOST_TO_HOST, 0);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFreeHost(hostDDRSrc);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFreeHost(hostDDRtDst);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}


TEST_F(DrvMemTest, mem_freeHBM_test)
{
	drvError_t error;
	void *dptr=(void *)0x10000001;
	int32_t nodeId = 0;
        int32_t deviceId = nodeId;
	drvMemMgmtInit();
	error=drvFreeDeviceHBM(NULL,deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
	error=drvFreeDeviceHBM(dptr,-1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvFreeDeviceHBM(dptr,deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

TEST_F(DrvMemTest, mem_freeHBM_test2)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
	MOCKER(drvMergeDeviceHBM).stubs().will(returnValue(DRV_ERROR_INVALID_HANDLE));
	drvMemMgmtInit();
	MOCKER(drvMemAllocDeviceHBM).stubs().will(returnValue(DRV_ERROR_INVALID_HANDLE));
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
    error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

TEST_F(DrvMemTest, mem_mgmtFreeApi_test)
{
    drvError_t error;
	 int32_t nodeId = 0;
    int32_t deviceId = nodeId;
	error=drvMemMgmtQueueFree(1);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
	error=drvMemMgmtQueueFree(0);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_mgmtInitApi_test)
{
    drvError_t error;
	int32_t nodeId = 0;
    int32_t deviceId = nodeId;

	MOCKER(drvMemMgmtQueueFree).stubs().will(returnValue(DRV_ERROR_INVALID_VALUE));
	error=drvMemMgmtInit();
	EXPECT_EQ(error, DRV_ERROR_NONE);
	error=drvMemMgmtInit();
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvMemTest, mem_mergeApi_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
	int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

	error=drvMergeDeviceHBM(NULL,deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

TEST_F(DrvMemTest, mem_allocHBM_test_null)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

	drvMemMgmtInit();

    MOCKER(malloc).stubs().will(returnValue(DRV_ERROR_NONE));

	error=drvMemAllocDeviceHBM(&hbmOffsetPoint,size,2);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvMemTest, mem_mergeApi_test_null)
{
    drvError_t error;
    void *hbmOffsetPoint;
	int32_t nodeId = 0;
    int32_t deviceId = 2;
	drvMemNode_t *drvNewMemMgmt = NULL;
    uint64_t size = 64;
	//drvNewMemMgmt->drvMemMgmtData.status = DRV_MEM_FREE;

	error=drvMergeDeviceHBM(drvNewMemMgmt, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

TEST_F(DrvMemTest, mem_freeHBM_default_test2)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
	MOCKER(drvMergeDeviceHBM).stubs().will(returnValue(DRV_ERROR_INVALID_HANDLE));
	drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, (drvMemType_t)4, nodeId);
    error = drvMemFree(hbmOffsetPoint, deviceId);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);
}

TEST_F(DrvMemTest, mem_drvMemAllocHost)
{
    drvError_t error;
    void *hbmOffsetPoint;
	int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

	uint64_t tmp_uiPhy = 0;
	uint64_t vptr=0;
	size_t bytesize = (size_t)32;
	void **pp = NULL;

	error = drvMemAllocHost(pp, bytesize);
	EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}


TEST_F(DrvMemTest, mem_memAddress_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
	int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;

	uint64_t tmp_uiPhy = 0;
	uint64_t vptr=1;

	error = drvMemAddressTranslate(vptr, (UINT64 *)&tmp_uiPhy);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, hal_mem_test)
{
    drvError_t error;
	void *vptr;

	drvMemMgmtInit();

	error = halMemAlloc(&vptr, MAX_ALLOC, 0);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halMemFree(vptr);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}


TEST_F(DrvMemTest, mem_MemSmmuQuery)
{
	drvError_t error;
	DVdevice device = 99;
	uint32_t *SSID = 0;
	DVresult result;

	result = drvMemSmmuQuery(device, SSID);
	EXPECT_EQ(result, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_MemAllocL2buffAddr)
{
	drvError_t error;
	DVdevice device = 99;
	DVresult result;
	void **l2buff = (void **)99;
	uint64_t *pte = (uint64_t *)1;

	error = drvMemAllocL2buffAddr(device, l2buff, (UINT64 *)pte);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_MemReleaseL2buffAddr1)
{
	drvError_t error;
	DVresult result;
	DVdevice device = 99;
	void **l2buff = (void **)99;

	result = drvMemReleaseL2buffAddr(device, l2buff);
	EXPECT_EQ(result, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_MemAllocHugePageManaged)
{
	drvError_t error;
	DVresult result;
	DVdevice device = 99;
	void **l2buff = (void **)99;
	DVdeviceptr pp = NULL;
	size_t bytesize = (size_t)32;

    drvMemMgmtInit();
    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
	result = drvMemAllocHugePageManaged(&pp, bytesize);
	EXPECT_EQ(result, DRV_ERROR_OUT_OF_MEMORY);
}

TEST_F(DrvMemTest, mem_MemFreeHugePageManaged1)
{
	drvError_t error;
	DVresult result;
	DVdevice device = 99;
	void **l2buff = (void **)99;
	DVdeviceptr pp = 0;
	size_t bytesize = (size_t)32;

	result = drvMemFreeHugePageManaged(pp);
	EXPECT_EQ(result, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_MemAllocManaged)
{
	drvError_t error;
	DVdeviceptr deviceptr = 1;
	DVdeviceptr *pp = &deviceptr;
	size_t bytesize = (size_t)64;

    drvMemMgmtInit();
	error = drvMemAllocManaged(pp, bytesize);
	EXPECT_EQ(error, DRV_ERROR_NONE);
	error = drvMemFreeManaged(deviceptr);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

#if 0
TEST_F(DrvMemTest, mem_MemAllocDevice)
{
    drvError_t error;
    DVdeviceptr deviceptr = 1;
    DVdeviceptr *pp = &deviceptr;
    size_t bytesize = (size_t)64;
    DVdevice device = 99;
    DVmem_advise advise = 0;

    drvMemMgmtInit();
    error = halMemAllocDevice(pp, bytesize, advise, device);
    EXPECT_EQ(error, DRV_ERROR_NONE);
    error = halMemFreeDevice(deviceptr);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}
#endif

TEST_F(DrvMemTest, mem_drvMemDestroyAddr)
{
	drvError_t error;
	DVresult result;
	size_t ByteCount = (size_t)32;
	DVdeviceptr dstDev = 0;
	DVdeviceptr srcDev = 0;
	void *srcHost = 0;
	void *dstHost = 0;
	uint32_t len = 0;
	struct DMA_ADDR *dmaAddr = NULL;

	error = drvMemDestroyAddr(dmaAddr);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

#if 0
TEST_F(DrvMemTest, mem_drvMemAdvise)
{
	drvError_t error;
	DVresult result;
	size_t count = (size_t)32;
	DVdeviceptr devPtr = 0;
	DVdeviceptr srcDev = 0;
	void *srcHost = 0;
	void *dstHost = 0;
	uint32_t len = 0;
	struct DMA_ADDR *dmaAddr = NULL;
	DVdevice device = 99;
	DVmem_advise advise = 0;

	error = drvMemAdvise(devPtr, count, advise, device);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}
#endif

TEST_F(DrvMemTest, mem_drvMemPrefetchToDevice)
{
	drvError_t error;
	DVresult result;
	size_t count = (size_t)32;
	DVdeviceptr devPtr = 0;
	DVdeviceptr srcDev = 0;
	void *srcHost = 0;
	void *dstHost = 0;
	size_t len = 0;
	struct DMA_ADDR *dmaAddr = NULL;
	DVdevice device = 99;
	DVmem_advise advise = 0;

	error = drvMemPrefetchToDevice(devPtr, len, device);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_drvMemsetD8_host)
{
	drvError_t error;
    char* a = (char*)malloc(MEMSET_SIZE_MAX + 1);

	error = drvMemsetD8((uint64_t)a, MEMSET_SIZE_MAX + 1, 0, MEMSET_SIZE_MAX + 1);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    free(a);
}

TEST_F(DrvMemTest, mem_drvMemsetD8_fail)
{
	drvError_t error;
    char* a = (char*)malloc(MEMSET_SIZE_MAX + 1);

	error = drvMemsetD8((uint64_t)a, MEMSET_SIZE_MAX, 0, MEMSET_SIZE_MAX + 1);
	EXPECT_NE(error, DRV_ERROR_NONE);
    free(a);

}

TEST_F(DrvMemTest, mem_drvMemsetD8_dev)
{
	drvError_t error;
    uint64_t addr;
    drvMemMgmtInit();
    drvMemAllocManaged((DVdeviceptr *)&addr, 10);

	error = drvMemsetD8(addr, 10, 0, 10);
	EXPECT_EQ(error, DRV_ERROR_NONE);
    drvMemFreeManaged(addr);
}

TEST_F(DrvMemTest, drvMemDeviceOpen)
{
    int result;

    result = drvMemDeviceOpen(0, 0);
    EXPECT_EQ(result, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, drvMemDeviceClose)
{
    int result;

    result = drvMemDeviceClose(0);
    EXPECT_EQ(result, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_drvMemlock)
{
	drvError_t error;
	DVdeviceptr dstDev = 1;
	DVdevice device = 99;

	error = drvMemLock(dstDev, 0, device);
	EXPECT_EQ(error, DRV_ERROR_NONE);

	error = drvMemUnLock(dstDev);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}
#endif

TEST_F(DrvMemTest, mem_GetAttribute)
{
	drvError_t error;
	DVdeviceptr dstDev = 1;
    DVattribute attr;

	error = drvMemGetAttribute(dstDev, &attr);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    dstDev = 0x20000000;
    error = drvMemGetAttribute(dstDev, &attr);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_ipc)
{
	drvError_t error;
	DVdeviceptr dstDev = 1;
    pid_t pid[2];
    DVattribute attr;

    pid[0] = fork();
    pid[1] = pid[0];

	error = halShmemCreateHandle(dstDev, 4, "st", 4);
	EXPECT_EQ(error, DRV_ERROR_NONE);

	error = halShmemOpenHandle("test", &dstDev);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halShmemOpenHandleByDevId(0, "test", &dstDev);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halShmemCloseHandle(dstDev);
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halShmemDestroyHandle("test");
	EXPECT_EQ(error, DRV_ERROR_NONE);

    error = halShmemSetPidHandle("test", pid, 0);
}

TEST_F(DrvMemTest, mem_LoadProgram)
{
	drvError_t error;
	void *srcHost = (void*)1;
	void *dstHost;
    DVattribute attr;
	DVdevice device = 99;

	error = drvLoadProgram(device, srcHost, 0, 100, &dstHost);
	EXPECT_EQ(error, DRV_ERROR_INVALID_MALLOC_TYPE);
}

TEST_F(DrvMemTest, mem_init_test_001)
{
    printf("1111--6 \n");

    MOCKER(malloc).stubs().will(returnValue((void *)NULL));
    printf("1111--7 \n");
    MOCKER(drvMemMgmtQueueFree).stubs().will(returnValue(DRV_ERROR_NONE));
    printf("1111--8 \n");
    MOCKER(drvResetMgmtHead).stubs();
    printf("1111--9 \n");
    MOCKER(drvResetMgmtTail).stubs();
    printf("1111--99 \n");
    drvError_t error = drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_INVALID_VALUE);
}

TEST_F(DrvMemTest, mem_init_test_002)
{
    drvError_t error;
    error = drvMemMgmtInit();
    EXPECT_EQ(error, DRV_ERROR_NONE);
    drvResetMgmtHead();
    drvResetMgmtTail();
}

TEST_F(DrvMemTest, mem_getChipCapability)
{
    drvError_t error;
    halCapabilityInfo info;
    error = halGetChipCapability(0, &info);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_GetPhyIdByIndex)
{
    drvError_t error;
    uint32_t phyId;
    error = drvDeviceGetPhyIdByIndex(1, &phyId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_GetIndexByPhyId)
{
    drvError_t error;
    uint32_t indexId;
    error = drvDeviceGetIndexByPhyId(1, &indexId);
    EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, cmodelMemcpy_syncH2D_test)
{
    drvError_t error;
    void *hbmOffsetPoint;
    int32_t nodeId = 0;
    int32_t deviceId = nodeId;
    uint64_t size = 64;
    char str[64] = "HelloWorld";

        drvMemMgmtInit();
    error = drvMemAlloc(&hbmOffsetPoint, size, DRV_MEMORY_HBM, nodeId);
        EXPECT_EQ(error, DRV_ERROR_NONE);
    error = cmodelDrvMemcpy((uint64_t)hbmOffsetPoint, sizeof(str), (uint64_t)str, sizeof(str), DRV_MEMCPY_HOST_TO_DEVICE);
        EXPECT_EQ(error, DRV_ERROR_NONE);
        memset(str,0,size);
    error = drvMemcpy((uint64_t)str,  sizeof(str), (uint64_t)hbmOffsetPoint, sizeof(str));
        EXPECT_EQ(error, DRV_ERROR_NONE);
    error = drvMemFree(hbmOffsetPoint, deviceId);
        EXPECT_EQ(error, DRV_ERROR_NONE);
}

TEST_F(DrvMemTest, mem_drvMemcpy)
{
	drvError_t error;
	DVresult result;
	DVdevice device = 99;
	void **l2buff = (void **)99;
	DVdeviceptr pp = 0;
	size_t bytesize = (size_t)32;
	DVdeviceptr dst = 0;
	DVdeviceptr src = 0;

    error = drvMemcpy(0x20000000, bytesize, src, bytesize);
	EXPECT_EQ(error, DRV_ERROR_INVALID_HANDLE);

    error = drvMemcpy(0x22000000, bytesize, 0x20000000, bytesize);
	EXPECT_NE(error, DRV_ERROR_NONE);

    MOCKER(memcpy_s).stubs().will(returnValue(0));
	error = drvMemcpy(0x41000000, bytesize, 0x44000000, bytesize);
	EXPECT_EQ(error, DRV_ERROR_NONE);
}


