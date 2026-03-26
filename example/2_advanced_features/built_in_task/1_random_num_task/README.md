# Launch Random Number Sample

## 概述

本示例展示了如何使用 CANN Runtime 的 `aclrtRandomNumAsync` API 生成随机数。支持多种随机数分布类型和数据类型，用于满足不同场景下的随机数生成需求。

## 支持的产品型号

- Atlas A3 训练系列产品/Atlas A3 推理系列产品
- Atlas A2 训练系列产品/Atlas A2 推理系列产品

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../README.md)。


## 运行前环境变量

运行 `bash run.sh` 前，请先在同一个 shell 中导入以下环境变量：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann
```
## 相关 API

| API | 说明 |
|-----|------|
| `aclInit` | 初始化 ACL |
| `aclrtSetDevice` | 设置设备 |
| `aclrtCreateStream` | 创建 Stream |
| `aclrtMalloc` | 分配 Device 内存 |
| `aclrtRandomNumAsync` | 异步生成随机数 |
| `aclrtSynchronizeStream` | 同步 Stream |
| `aclrtMemcpy` | 内存拷贝 |
| `aclrtFree` | 释放 Device 内存 |
| `aclrtDestroyStream` | 销毁 Stream |
| `aclrtResetDeviceForce` | 重置设备 |
| `aclFinalize` | 释放 ACL 资源 |

## 核心 API

### aclrtRandomNumAsync

```c
aclError aclrtRandomNumAsync(
    const aclrtRandomNumTaskInfo* taskInfo,  // 随机数任务信息
    aclrtStream stream,                      // Stream
    void* reserve                            // 预留字段
);
```

### aclrtRandomNumTaskInfo 结构体

```c
typedef struct { 
    aclDataType dataType; 
    aclrtRandomNumFuncParaInfo randomNumFuncParaInfo;
    void *randomParaAddr;  
    void *randomResultAddr; 
    void *randomCounterAddr;
    aclrtRandomParaInfo randomSeed; 
    aclrtRandomParaInfo randomNum; 
    uint8_t rsv[10]; 
} aclrtRandomNumTaskInfo;
```

## 随机数生成类型

### 1. 均匀分布 (Uniform Distribution)

支持的数据类型：
- **浮点类型**: `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`
- **整数类型**: `ACL_INT32`, `ACL_INT64`, `ACL_UINT32`, `ACL_UINT64`

函数类型标识: `ACL_RT_RANDOM_NUM_FUNC_TYPE_UNIFORM_DIS`

参数说明：
- `min`: 最小值
- `max`: 最大值

### 2. 正态分布 (Normal Distribution)

支持的数据类型：
- `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`

函数类型标识: `ACL_RT_RANDOM_NUM_FUNC_TYPE_NORMAL_DIS`

参数说明：
- `mean`: 均值
- `stddev`: 标准差

### 3. 截断正态分布 (Truncated Normal Distribution)

支持的数据类型：
- `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`

函数类型标识: `ACL_RT_RANDOM_NUM_FUNC_TYPE_TRUNCATED_NORMAL_DIS`

参数说明：
- `mean`: 均值
- `stddev`: 标准差

### 4. Dropout Bitmask 生成

用于生成随机失活（Dropout）的 bit mask，支持按比例生成。

函数类型标识: `ACL_RT_RANDOM_NUM_FUNC_TYPE_DROPOUT_BITMASK`

参数说明:
- `ratio`: dropout比例 （支持数据类型 `ACL_FLOAT`, `ACL_FLOAT16`, `ACL_BF16`）

## 随机数算法

| 算法 | 特性 |
|------|------|
| **Philox4_32_10** | - 支持所有分布类型<br>- Counter 为 128bit，需要 16Byte 存储 |

## 内存要求

1. **Counter 内存**: 固定 16 字节，任意字节对齐地址即可
2. **输出内存**: 根据数据类型和随机数数量动态分配
3. **参数内存**: 均值、标准差、范围等参数可使用立即值或设备内存


## 已知issue

暂无
