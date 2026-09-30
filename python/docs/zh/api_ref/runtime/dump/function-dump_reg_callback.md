# 函数：dump\_reg\_callback

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：支持
<!-- end id6 -->

## 功能说明

Dump数据回调函数注册接口。

[函数：init\_dump](function-init_dump.md)接口、[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口、[函数：finalize\_dump](function-finalize_dump.md)接口配合使用，用于通过回调函数获取Dump数据。**场景举例如下：**

- **执行一个模型，通过回调获取Dump数据：**

    支持以下两种方式：

  - 在aclInit接口处**不启用**模型Dump配置、单算子Dump配置

    [函数：init](../init/function-init.md)接口--\>[函数：init\_dump](function-init_dump.md)接口--\>[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口--\>模型加载--\>模型执行--\>[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口--\>[函数：finalize\_dump](function-finalize_dump.md)接口--\>模型卸载--\>[函数：finalize](../init/function-finalize.md)接口

  - 在aclInit接口处**启用**模型Dump配置、单算子Dump配置，在aclInit接口处启用Dump配置时需配置落盘路径，但如果调用了[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口，则落盘不生效，以回调函数获取的Dump数据为准

    [函数：init](../init/function-init.md)接口--\>[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口--\>模型加载--\>模型执行--\>[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口--\>模型卸载--\>[函数：finalize](../init/function-finalize.md)接口

- **执行两个不同的模型，通过回调获取Dump数据**，该场景下，只要不调用[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的dump数据：

    [函数：init](../init/function-init.md)接口--\>[函数：init\_dump](function-init_dump.md)接口--\>[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口--\>[函数：finalize\_dump](function-finalize_dump.md)接口--\>模型卸载--\>[函数：finalize](../init/function-finalize.md)接口

## 函数原型

- **C函数原型**

    ```c
    aclError acldumpRegCallback(int32_t (* const messageCallback)(const acldumpChunk *, int32_t), int32_t flag)
    ```

- **python函数**

    ```python
    ret = acl.mdl.dump_reg_callback(mdl_dump_callback, flag)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| mdl_dump_callback | 用于接收回调数据的回调函数，有如下两个参数：<br>dump_chunk：dict，在实现mdl_dump_callback函数时可以获取dump_chunk中的data_fuf、buf_len等参数值，用于获取Dump数据及其数据长度：<br>{<br>"file_name": file_name, // 待落盘的Dump数据文件名<br>"data_buf": data_buf, // Dump数据的内存地址<br>"buf_len": buf_len, // data_buf数据长度，单位Byte<br>"is_last_chunk": is_last_chunk, // 标识Dump数据是否为最后一个分片，0表示不是最后一个分片，1表示最后一个分片<br>"offset": offset, // Dump数据文件内容的偏移，其中-1表示文件追加内容<br>"flag": flag // 预留Dump数据标识，当前数据无标识<br>} |
| flag | int，在调用回调接口后是否还落盘dump数据。<br>0：不落盘，当前仅支持0 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

无
