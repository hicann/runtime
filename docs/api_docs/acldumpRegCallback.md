# acldumpRegCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

Dump数据回调函数注册接口。

[aclmdlInitDump](aclmdlInitDump.md)接口、[acldumpRegCallback](acldumpRegCallback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[acldumpUnregCallback](acldumpUnregCallback.md)接口、[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口配合使用，用于通过回调函数获取Dump数据。**场景举例如下：**

-   **执行一个模型，通过回调获取Dump数据：**

    支持以下两种方式：

    -   在aclInit接口处**不启用**模型Dump配置、单算子Dump配置

        [aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

    -   在aclInit接口处**启用**模型Dump配置、单算子Dump配置，在aclInit接口处启用Dump配置时需配置落盘路径，但如果调用了[acldumpRegCallback](acldumpRegCallback.md)接口，则落盘不生效，以回调函数获取的Dump数据为准

        [aclInit](aclInit.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>模型加载--\>模型执行--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

-   **执行两个不同的模型，通过回调获取Dump数据**，该场景下，只要不调用[acldumpUnregCallback](acldumpUnregCallback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的Dump数据：

    [aclInit](aclInit.md)接口--\>[aclmdlInitDump](aclmdlInitDump.md)接口--\>[acldumpRegCallback](acldumpRegCallback.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[acldumpUnregCallback](acldumpUnregCallback.md)接口--\>[aclmdlFinalizeDump](aclmdlFinalizeDump.md)接口--\>模型卸载--\>[aclFinalize](aclFinalize.md)接口

## 函数原型

```
aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t len), int32_t flag)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| messageCallback | 输入 | 回调函数指针，用于接收回调数据的回调。<br><br>  - acldumpChunk结构体的定义如下，在实现messageCallback回调函数时可以获取acldumpChunk结构体中的dataBuf、bufLen等参数值，用于获取Dump数据及其数据长度：typedef struct acldumpChunk  {<br>   char  fileName[ACL_DUMP_MAX_FILE_PATH_LENGTH];  // 待落盘的Dump数据文件名，ACL_DUMP_MAX_FILE_PATH_LENGTH表示文件名最大长度，当前为4096<br>   uint32_t  bufLen;  // dataBuf数据长度，单位Byte<br>   uint32_t  isLastChunk;  // 标识Dump数据是否为最后一个分片，0表示不是最后一个分片，1表示最后一个分片<br>   int64_t  offset;  // Dump数据文件内容的偏移，其中-1表示文件追加内容<br>   int32_t  flag;  // 预留Dump数据标识，当前数据无标识<br>   uint8_t  dataBuf[0];  // Dump数据的内存地址<br>} acldumpChunk;<br>  - len：表示acldumpChunk结构体的长度，单位Byte。 |
| flag | 输入 | 在调用回调接口后是否还落盘dump数据：<br><br>  - 0：不落盘，当前仅支持0 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

