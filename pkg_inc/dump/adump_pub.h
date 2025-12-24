/**
  * Copyright (c) 2025 Huawei Technologies Co., Ltd.
  * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
  * CANN Open Software License Agreement Version 2.0 (the "License").
  * Please refer to the License for details. You may not use this file except in compliance with the License.
  * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
  * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
  * See LICENSE in the root of the software repository for the full text of the License.
  */

/*!
 * \file adump_pub.h
 * \brief 算子dump接口头文件
*/

/* * @defgroup dump dump接口 */
#ifndef ADUMP_PUB_H
#define ADUMP_PUB_H
#include <cstdint>
#include <string>
#include <map>
#include <vector>
#include "acl/acl_base.h"
#include "exe_graph/runtime/tensor.h"

#if (defined(_WIN32) || defined(_WIN64) || defined(_MSC_VER))
#define ADX_API __declspec(dllexport)
#else
#define ADX_API __attribute__((visibility("default")))
#endif
namespace Adx {
constexpr int32_t ADUMP_SUCCESS = 0;
constexpr int32_t ADUMP_FAILED = -1;
constexpr int32_t ADUMP_INPUT_FAILED = -2;
constexpr uint32_t ADUMP_ARGS_EXCEPTION_HEAD = 2;

// AdumpGetDFXInfoAddr chunk size parameter
extern uint64_t *g_dynamicChunk;
extern uint64_t *g_staticChunk;
constexpr uint32_t DYNAMIC_RING_CHUNK_SIZE = 393216;  // 393216 * 8 = 3M
constexpr uint32_t STATIC_RING_CHUNK_SIZE = 131072;  // 131072 * 8 = 1M
constexpr uint32_t DFX_MAX_TENSOR_NUM = 4000;
constexpr uint16_t RESERVE_SPACE = 2;

enum class DumpType : int32_t {
    OPERATOR = 0x01,
    EXCEPTION = 0x02,
    ARGS_EXCEPTION = 0x03,
    OP_OVERFLOW = 0x04,
    AIC_ERR_DETAIL_DUMP = 0x05 // COREDUMP mode
};

// dumpSwitch bitmap
constexpr uint64_t OPERATOR_OP_DUMP = 1U << 0;
constexpr uint64_t OPERATOR_KERNEL_DUMP = 1U << 1;

constexpr uint64_t OP_INFO_RECORD_DUMP = 1ULL << 32;

/**
 * @ingroup dump
 * @par 描述: dump 开关状态查询
 *
 * @attention  无
 * @param[in]  dumpType dump 类型（operator, exception）
 * @retval     #0 dump开关未开启
 * @retval     #1 dump开关开启；当dumpType=OPERATOR时，开关开启且dump switch为op
 * @retval     #2 当dumpType=OPERATOR时，开关开启且dump switch为kernel
 * @retval     #3 当dumpType=OPERATOR时，开关开启且dump switch为all
 * @see        无
 * @since
 */
ADX_API uint64_t AdumpGetDumpSwitch(const DumpType dumpType);

/**
 * @ingroup dump
 * @par 描述: 根据配置文件设置dump功能
 *
 * @attention  无
 * @param[in]  configPath  config文件配置路径
 * @retval     #0 dump     开关设置成功
 * @retval     #!0 dump    开关设置失败
 * @see        无
 * @since
 */
ADX_API int32_t AdumpSetDump(const char *dumpConfigData, size_t dumpConfigSize);

/**
 * @ingroup dump
 * @par 描述: 关闭dump功能
 *
 * @attention  无
 * @param      无
 * @retval     #0 dump 关闭成功
 * @retval     #!0 dump 关闭失败
 * @see        无
 * @since
 */
ADX_API int32_t AdumpUnSetDump();

enum class TensorType : int32_t {
    INPUT,
    OUTPUT,
    WORKSPACE
};

enum class AddressType : int32_t {
    TRADITIONAL,
    NOTILING,
    RAW
};

enum TensorPlacement : int32_t {
    kOnDeviceHbm,  ///< Tensor位于Device上的HBM内存
    kOnHost,       ///< Tensor位于Host
    kFollowing,    ///< Tensor位于Host，且数据紧跟在结构体后面
    kOnDeviceP2p,  ///< Tensor位于Device上的P2p内存
    kTensorPlacementEnd
}; 

struct TensorInfo {
    gert::Tensor *tensor;
    TensorType type;
    AddressType addrType;
    uint32_t argsOffSet;
};

struct TensorInfoV2 {
    TensorType type;       // tensor类型
    size_t tensorSize;     // tensor内存大小  
    int32_t format;      
    int32_t dataType;     
    int64_t *tensorAddr;   // tensor数据地址
    AddressType addrType;  // 地址的类型
    int32_t placement;
    uint32_t argsOffSet;   // tensor数据地址在args里的偏移 
    std::vector<int64_t> shape;  //shape
    std::vector<int64_t> originShape; //originShape
};

/**
 * @ingroup dump
 * @par 描述: dump tensor
 *
 * @attention  无
 * @param[in]  opType  算子类型
 * @param[in]  opName  算子名称
 * @param[in]  tensors  算子tensor信息
 * @param[in]  stream  算子处理流句柄
 * @retval     #0 dump tensor成功
 * @retval     #!0 dump tensor失败
 * @see        无
 * @since
 */
ADX_API int32_t AdumpDumpTensor(const std::string &opType, const std::string &opName,
    const std::vector<TensorInfo> &tensors, aclrtStream stream);

/**
 * @ingroup dump
 * @par 描述: dump tensor
 *
 * @attention  无
 * @param[in]  opType  算子类型
 * @param[in]  opName  算子名称
 * @param[in]  tensors  算子tensor信息
 * @param[in]  stream  算子处理流句柄
 * @retval     #0 dump tensor成功
 * @retval     #!0 dump tensor失败
 * @see        无
 * @since
 */
ADX_API int32_t AdumpDumpTensorV2(const std::string &opType, const std::string &opName,
    const std::vector<TensorInfoV2> &tensors, aclrtStream stream);

constexpr char DUMP_ADDITIONAL_BLOCK_DIM[] = "block_dim";
constexpr char DUMP_ADDITIONAL_TILING_KEY[] = "tiling_key";
constexpr char DUMP_ADDITIONAL_TILING_DATA[] = "tiling_data";
constexpr char DUMP_ADDITIONAL_IMPLY_TYPE[] = "imply_type";
constexpr char DUMP_ADDITIONAL_ALL_ATTRS[] = "all_attrs";
constexpr char DUMP_ADDITIONAL_IS_MEM_LOG[] = "is_mem_log";
constexpr char DUMP_ADDITIONAL_IS_HOST_ARGS[] = "is_host_args";
constexpr char DUMP_ADDITIONAL_NODE_INFO[] = "node_info";
constexpr char DUMP_ADDITIONAL_DEV_FUNC[] = "dev_func";
constexpr char DUMP_ADDITIONAL_TVM_MAGIC[] = "tvm_magic";
constexpr char DUMP_ADDITIONAL_OP_FILE_PATH[] = "op_file_path";
constexpr char DUMP_ADDITIONAL_KERNEL_INFO[] = "kernel_info";
constexpr char DUMP_ADDITIONAL_WORKSPACE_BYTES[] = "workspace_bytes";
constexpr char DUMP_ADDITIONAL_WORKSPACE_ADDRS[] = "workspace_addrs";

constexpr char DEVICE_INFO_NAME_ARGS[] = "args before execute";

struct DeviceInfo {
    std::string name;
    void *addr;
    uint64_t length;
};

struct OperatorInfo {
    bool agingFlag{ true };
    uint32_t taskId{ 0U };
    uint32_t streamId{ 0U };
    uint32_t deviceId{ 0U };
    uint32_t contextId{ UINT32_MAX };
    std::string opType;
    std::string opName;
    std::vector<TensorInfo> tensorInfos;
    std::vector<DeviceInfo> deviceInfos;
    std::map<std::string, std::string> additionalInfo;
};

struct OperatorInfoV2 {
    bool agingFlag{ true };
    uint32_t taskId{ 0U };
    uint32_t streamId{ 0U };
    uint32_t deviceId{ 0U };
    uint32_t contextId{ UINT32_MAX };
    std::string opType;
    std::string opName;
    std::vector<TensorInfoV2> tensorInfos;
    std::vector<DeviceInfo> deviceInfos;
    std::map<std::string, std::string> additionalInfo;
};

/**
 * @ingroup dump
 * @par 描述: 保存异常需要Dump的算子信息。
 *
 * @attention  无
 * @param[in]  OperatorInfo 算子信息
 * @retval     #0 保存成功
 * @retval     #!0 保存失败
 * @see 无
 * @since
 */
extern "C" ADX_API int32_t AdumpAddExceptionOperatorInfo(const OperatorInfo &opInfo);

/**
 * @ingroup dump
 * @par 描述: 保存异常需要Dump的算子信息。
 *
 * @attention  无
 * @param[in]  OperatorInfo 算子信息
 * @retval     #0 保存成功
 * @retval     #!0 保存失败
 * @see 无
 * @since
 */
extern "C" ADX_API int32_t AdumpAddExceptionOperatorInfoV2(const OperatorInfoV2 &opInfo);

/**
 * @ingroup dump
 * @par 描述: 模型卸载时，删除异常需要Dump的算子信息。
 *
 * @attention  无
 * @param[in]  deviceId 设备逻辑id
 * @param[in]  streamId 执行流id
 * @retval     #0 保存成功
 * @retval     #!0 保存失败
 * @see        无
 * @since
 */
extern "C" ADX_API int32_t AdumpDelExceptionOperatorInfo(uint32_t deviceId, uint32_t streamId);

/**
 * @ingroup dump
 * @par 描述: 获取动态shape异常算子需要Dump的size信息空间。
 *
 * @attention   无
 * @param[in]   uint32_t space 待获取space大小
 * @param[out]  uint64_t &atomicIndex 返回获取space地址的index参数
 * @retval      #nullptr 地址信息获取失败
 * @retval      #!nullptr 地址信息获取成功
 * @see         无
 * @since
 */
extern "C" ADX_API void *AdumpGetDFXInfoAddrForDynamic(uint32_t space, uint64_t &atomicIndex);

/**
 * @ingroup dump
 * @par 描述: 获取静态shape异常算子需要Dump的size信息空间。
 *
 * @attention   无
 * @param[in]   uint32_t space 待获取space大小
 * @param[out]  uint64_t &atomicIndex 返回获取space地址的index参数
 * @retval      #nullptr 地址信息获取失败
 * @retval      #!nullptr 地址信息获取成功
 * @see         无
 * @since
 */
extern "C" ADX_API void *AdumpGetDFXInfoAddrForStatic(uint32_t space, uint64_t &atomicIndex);

using AdumpCallback = int32_t (*)(uint64_t dumpSwitch, const char *dumpConfig, int32_t size);

/**
 * @ingroup dump
 * @par 描述: 注册dump回调函数。
 *
 * @attention   无
 * @param[in]   moduleId 模块id
 * @param[in]   func 注册回调的函数指针
 * @retval      #0 注册成功
 * @retval      #!0 注册失败
 * @see         无
 * @since
 */
ADX_API int32_t AdumpRegisterCallback(uint32_t moduleId, AdumpCallback enableFunc, AdumpCallback disableFunc);

enum class SaveType : int32_t {
    APPEND,
    OVERWRITE
};

ADX_API int32_t AdumpSaveToFile(const char *data, size_t dataLen, const char *filename, SaveType type);

} // namespace Adx
#endif
