/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef INC_EXTERNAL_ACL_DUMP_H_
#define INC_EXTERNAL_ACL_DUMP_H_

#include <stdint.h>
#include "acl_base.h"

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define ACL_DUMP_API __declspec(dllexport)
#define ACL_DUMP_WEAK
#else
#define ACL_DUMP_API __attribute__((visibility("default")))
#define ACL_DUMP_WEAK __attribute__((weak))
#endif

#ifdef __cplusplus
extern "C" {
#endif

#define ACL_DUMP_MAX_FILE_PATH_LENGTH 4096
typedef struct acldumpChunk {
    char fileName[ACL_DUMP_MAX_FILE_PATH_LENGTH]; // name of the dump data file to be written, absolute path
    uint32_t bufLen;                              // length of dataBuf, in bytes
    uint32_t isLastChunk;                         // whether it is the last chunk. 0: no, 1: yes
    int64_t offset;                               // offset of the content in the dump data file. -1: append write
    int32_t flag;                                 // reserved flag of the dump data, no flag is defined currently
    uint8_t dataBuf[0];                           // memory address of the dump data
} acldumpChunk;

ACL_DUMP_API aclError acldumpRegCallback(int32_t (*const messageCallback)(const acldumpChunk*, int32_t), int32_t flag);
ACL_DUMP_API void acldumpUnregCallback();

#define ACL_OP_DUMP_OP_AICORE_ARGS 0x00000001U

/**
 * @ingroup AscendCL
 * @brief Enable the dump function of the corresponding dump type.
 *
 * @param dumpType [IN]       type of dump
 * @param path     [IN]       dump path
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
ACL_FUNC_VISIBILITY aclError aclopStartDumpArgs(uint32_t dumpType, const char* path);

/**
 * @ingroup AscendCL
 * @brief Disable the dump function of the corresponding dump type.
 *
 * @param dumpType [IN]       type of dump
 *
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure
 */
ACL_FUNC_VISIBILITY aclError aclopStopDumpArgs(uint32_t dumpType);

typedef enum acldumpType {
    AIC_ERR_BRIEF_DUMP = 1,  // lite exception dump
    AIC_ERR_NORM_DUMP = 2,   // normal exception dump, dumps shape/data type/format/attributes additionally
    AIC_ERR_DETAIL_DUMP = 3, // npu coredump dump, dumps AI Core internal memory, registers and call stack additionally
    DATA_DUMP = 4,           // model dump or single operator dump
    OVERFLOW_DUMP = 5        // overflow operator dump
} acldumpType;

/**
 * @ingroup AscendCL
 * @brief Get dump path.
 *
 * @param dumpType [IN]   type of dump path
 *
 * @retval path for success
 * @retval NULL for failed
 */
ACL_FUNC_VISIBILITY const char* acldumpGetPath(acldumpType dumpType);

#define ACL_DUMP_MAX_SHAPE_NUM 25

typedef enum acldumpTensorType {
    ACL_DUMP_TENSOR_INPUT = 0, // input tensor
    ACL_DUMP_TENSOR_OUTPUT,    // output tensor
    ACL_DUMP_TENSOR_WORKSPACE  // workspace tensor
} acldumpTensorType;

typedef enum acldumpTensorAddressType {
    ACL_DUMP_ADDR_PTR = 0, // address is a level-2 address, one dereference is needed for the data address
    ACL_DUMP_ADDR_PTR_PTR, // address is a level-3 address, two dereferences are needed for the data address
    ACL_DUMP_ADDR_RAW      // address is a raw address, it is the data address itself
} acldumpTensorAddressType;

typedef enum acldumpTensorPlacement {
    ACL_DUMP_PLACEMENT_DEVICE = 0, // tensor is placed on device
    ACL_DUMP_PLACEMENT_HOST,       // tensor is placed on host
    ACL_DUMP_PLACEMENT_END         // reserved boundary of this enumeration, not a valid placement
} acldumpTensorPlacement;

typedef struct acldumpTensorInfo {
    acldumpTensorType type;                       // tensor type
    size_t tensorSize;                            // tensor size, in bytes
    int32_t format;                               // tensor format
    int32_t dataType;                             // tensor data type
    int64_t* tensorAddr;                          // tensor address
    acldumpTensorAddressType addrType;            // tensor address type
    acldumpTensorPlacement placement;             // placement of the tensor data
    uint32_t argsOffset;                          // offset of the tensor within the operator args
    uint32_t shapeNum;                            // valid dim count of shape, <= ACL_DUMP_MAX_SHAPE_NUM
    uint32_t originShapeNum;                      // valid dim count of originShape, <= ACL_DUMP_MAX_SHAPE_NUM
    uint64_t shape[ACL_DUMP_MAX_SHAPE_NUM];       // dim array of the tensor shape
    uint64_t originShape[ACL_DUMP_MAX_SHAPE_NUM]; // dim array of the tensor originShape
} acldumpTensorInfo;

/**
 * @ingroup AscendCL
 * @brief Save custom exception information (tensors) to the Exception Dump path.
 * @attention It is implemented only on platforms that support Exception Dump, and Exception Dump must be
 *            enabled before this function is called. A ".custom.{timestamp}" suffix, in which timestamp is
 *            a millisecond-level timestamp, is appended to fileName on disk (e.g. "info" ->
 *            "info.custom.20260721153012345") to avoid overwriting existing files on repeated calls.
 * @param fileName    [IN]  Target file name, a relative path saved under the Exception Dump root path.
 *                          Must not be NULL, must not be empty, and must not contain a ".." path segment.
 * @param userTag     [IN]  User custom tag written into the dump file header. May be NULL.
 * @param tensors     [IN]  Tensors to be saved. Must not be NULL, and must point to an array holding at
 *                          least tensorCount elements. Each element's shapeNum/originShapeNum must not
 *                          exceed ACL_DUMP_MAX_SHAPE_NUM, tensorAddr must be a non-NULL raw device data
 *                          address of the tensor, that is, addrType ACL_DUMP_ADDR_RAW and placement
 *                          ACL_DUMP_PLACEMENT_DEVICE, and tensorSize must be greater than 0.
 * @param tensorCount [IN]  Count of tensors in the tensors array, must be greater than 0. The caller must
 *                          guarantee it matches the actual array length.
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval ACL_ERROR_INVALID_PARAM Invalid fileName/tensors/tensorCount, a tensor with a NULL tensorAddr or a
 *                                 zero tensorSize, or shapeNum/originShapeNum exceeds the limit.
 * @retval OtherValues Failure (e.g. Exception Dump not enabled).
 */
ACL_DUMP_WEAK ACL_FUNC_VISIBILITY aclError acldumpSaveExceptionInfo(
    const char* fileName, const char* userTag, const acldumpTensorInfo* tensors, size_t tensorCount);

/**
 * @ingroup AscendCL
 * @brief Get the Exception Dump root path (i.e. <dumpPath>/extra-info/data-dump/<deviceId>/).
 * @attention It is implemented only on platforms that support Exception Dump, and Exception Dump must be
 *            enabled before this function is called.
 * @param path   [OUT]  Character array to receive the path, allocated by the caller in advance. On success a
 *                     '\0'-terminated path is written into it. ACL_DUMP_MAX_FILE_PATH_LENGTH bytes are
 *                     recommended.
 * @param maxLen [IN]   Memory size of the path parameter, in bytes. Must be greater than 1 and large enough
 *                     to hold the path plus the terminating '\0'.
 * @retval ACL_SUCCESS The function is successfully executed.
 * @retval OtherValues Failure (e.g. Exception Dump not enabled, or buffer too small).
 */
ACL_DUMP_WEAK ACL_FUNC_VISIBILITY aclError acldumpGetExceptionInfoPath(char* path, size_t maxLen);

#ifdef __cplusplus
}
#endif

#endif
