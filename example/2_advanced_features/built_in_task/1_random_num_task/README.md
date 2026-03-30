# Launch Random Number Sample

## 概述

本示例展示了如何使用 CANN Runtime 的 `aclrtRandomNumAsync` API 生成随机数。支持多种随机数分布类型和数据类型，用于满足不同场景下的随机数生成需求。

## 产品支持情况

本样例在以下产品上的支持情况如下：

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 编译运行
环境安装详情以及运行详情请见example目录下的[README](../../../README.md)。


运行步骤如下：

```bash
# ${install_root} 替换为 CANN 安装根目录，默认安装在`/usr/local/Ascend`目录
source ${install_root}/cann/set_env.sh
export ASCEND_INSTALL_PATH=${install_root}/cann

# 编译运行
bash run.sh
```

## CANN RUNTIME API

在该Sample中，涉及的关键功能点及其关键接口，如下所示：
- 初始化
    - 调用aclInit接口初始化AscendCL配置。
    - 调用aclFinalize接口实现AscendCL去初始化。
- Device管理
    - 调用aclrtSetDevice接口指定用于运算的Device。
    - 调用aclrtResetDeviceForce接口强制复位当前运算的Device，回收Device上的资源。
- Stream管理
    - 调用aclrtCreateStream接口创建Stream。
    - 调用aclrtSynchronizeStream接口阻塞等待Stream上任务执行完成。
- 内存管理
    - 调用aclrtMalloc接口申请Device上的输出缓冲区和随机数计数器缓冲区。
    - 调用aclrtFree接口释放Device上的内存。
- 数据传输
    - 调用aclrtMemcpy接口将生成的随机数拷贝回Host侧进行检查。
- 随机数任务执行
    - 调用aclrtRandomNumAsync接口异步下发随机数任务，生成uniform、normal等分布结果以及 dropout bitmask。

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
