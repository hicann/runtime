# Dump产物解读

本文介绍Dump数据落盘后的产物目录、转换方法和常见字段含义。Dump配置接口的调用顺序和参数约束请参见[Dump配置](../api_ref/18_dump_configuration.md)。

## 产物路径

Dump产物目录由Dump类型、配置和环境变量共同决定：

- 模型Dump、单算子Dump和溢出Dump的产物目录优先级为`ASCEND_DUMP_PATH` > `ASCEND_WORK_PATH` > 配置文件`dump_path` > 当前目录`./`。配置了环境变量时，配置文件中的`dump_path`不生效。
- 单算子参数Dump由`aclopStartDumpArgs(uint32_t dumpType, const char *path)`的`path`参数指定，该接口输出算子信息文件，不输出tensor数据文件。
- 可调用`acldumpGetPath(acldumpType dumpType)`查询当前Dump类型的输出路径。
- Exception Dump的根路径为`<dumpPath>/extra-info/data-dump/<deviceId>/`，也可调用`acldumpGetExceptionInfoPath(char *path, size_t maxLen)`查询。

常见Dump类型：

| 类型 | 说明 | 路径定位方式 |
| --- | --- | --- |
| 模型Dump | 导出模型中算子的输入/输出数据。 | `ASCEND_DUMP_PATH`、`ASCEND_WORK_PATH`、配置文件`dump_path`，或`acldumpGetPath(DATA_DUMP)`。 |
| 单算子数据Dump | 导出单算子的输入/输出tensor数据。 | `ASCEND_DUMP_PATH`、`ASCEND_WORK_PATH`、配置文件`dump_path`，或`acldumpGetPath(DATA_DUMP)`。 |
| 单算子参数Dump | 导出算子信息文件，包含算子类型、属性、输入输出format、数据类型和shape等信息。 | `aclopStartDumpArgs`的`path`。 |
| 溢出Dump | 导出溢出算子的输入和输出数据。 | `ASCEND_DUMP_PATH`、`ASCEND_WORK_PATH`或配置文件`dump_path`。 |
| Exception Dump | 导出异常算子的输入输出、workspace、Tiling等信息。 | `ASCEND_DUMP_PATH`、`ASCEND_WORK_PATH`或当前目录`./`下的`<dumpPath>/extra-info/data-dump/<deviceId>/`。 |

## 解析与转换

将tensor Dump文件转换为numpy等便于查看的格式：

```bash
msaccucmp.py convert -d <dump_file> -out <output_dir>
```

`aclopStartDumpArgs`生成的是算子信息文件，不适用于上述tensor Dump转换命令。

转换完成后，可使用Python查看numpy数据：

```python
import numpy as np

data = np.load("<converted_file>.npy")
print(data.shape)
print(data.dtype)
print(data)
```

数据量较大时，建议先查看shape、dtype、最大值、最小值以及是否存在NaN或Inf：

```python
import numpy as np

data = np.load("<converted_file>.npy")
print("shape:", data.shape)
print("dtype:", data.dtype)
print("min:", np.nanmin(data))
print("max:", np.nanmax(data))
print("has_nan:", np.isnan(data).any())
print("has_inf:", np.isinf(data).any())
```

## 回调字段

使用`acldumpRegCallback`注册回调后，回调函数可通过`acldumpChunk`获取分块Dump数据，常用字段如下：

| 字段 | 含义 | 使用建议 |
| --- | --- | --- |
| `fileName` | Dump数据原计划写入的绝对文件名。 | 用于按文件名归并同一个tensor或同一次Dump的数据块。 |
| `bufLen` | `dataBuf`的字节长度。 | 判断本次回调携带的数据大小。 |
| `isLastChunk` | 是否为最后一个数据块，`0`表示否，`1`表示是。 | 只有收到最后一块后，才应认为该文件的数据接收完整。 |
| `offset` | 当前数据块写入文件时的偏移，`-1`表示追加写。 | 用于按偏移还原分块数据。 |
| `flag` | 预留标志位。 | 当前未定义具体标志，通常仅记录。 |
| `dataBuf` | Dump数据内容地址。 | 按`bufLen`读取字节数据，再结合文件名或元信息解析。 |

## Tensor字段

Exception Dump或自定义tensor落盘场景中，`acldumpTensorInfo`的关键字段含义如下。调用[`acldumpSaveExceptionInfo`](../api_ref/18_dump_configuration.md#acldumpSaveExceptionInfo)主动落盘自定义tensor时，`addrType`仅支持`ACL_DUMP_ADDR_RAW`，`placement`仅支持`ACL_DUMP_PLACEMENT_DEVICE`。

| 字段 | 含义 | 使用建议 |
| --- | --- | --- |
| `type` | Tensor类型，区分输入、输出等。 | 判断数据在算子中的角色。 |
| `tensorSize` | Tensor数据大小，单位为字节。 | 与shape和dataType计算结果比对，判断数据是否完整。 |
| `format` | Tensor格式。 | 与算子期望格式比对，排查格式不匹配。 |
| `dataType` | Tensor数据类型。 | 转换或查看数据时需按该类型解释原始字节。 |
| `tensorAddr` | Tensor数据地址。 | 用于落盘时标识待读取的数据地址。 |
| `addrType` | Tensor地址类型。 | 调用`acldumpSaveExceptionInfo`时必须为`ACL_DUMP_ADDR_RAW`，表示`tensorAddr`为Device上的原始数据地址。 |
| `placement` | Tensor数据所在位置。 | 调用`acldumpSaveExceptionInfo`时必须为`ACL_DUMP_PLACEMENT_DEVICE`，表示读取Device侧数据。 |
| `shapeNum` | `shape`的有效维度个数。 | 不得超过`ACL_DUMP_MAX_SHAPE_NUM`，否则接口返回`ACL_ERROR_INVALID_PARAM`；未设置或为0时，落盘文件中当前shape为空。 |
| `originShapeNum` | `originShape`的有效维度个数。 | 不得超过`ACL_DUMP_MAX_SHAPE_NUM`；动态shape或格式转换场景下需与`originShape`中的有效维度保持一致。 |
| `shape` | Tensor当前shape。 | 仅前`shapeNum`个维度有效，与模型或算子输入输出规格比对。 |
| `originShape` | Tensor原始shape。 | 仅前`originShapeNum`个维度有效，动态shape或格式转换场景下用于回溯原始维度。 |

## 分析建议

- 先根据路径优先级、`dump_path`或接口返回路径确认产物是否生成，再选择需要转换和查看的文件。
- 比对精度问题时，优先确认shape、dataType和format是否符合预期，再比较数值差异。
- 对异常Dump，先查看异常算子名称、输入输出、workspace和Tiling信息，再结合Runtime日志或AI Core Error信息定位。
- 对分块回调数据，必须按`fileName`、`offset`和`isLastChunk`还原完整文件后再分析。
