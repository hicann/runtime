# 函数：get\_aipp\_type

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

获取指定模型的指定输入所支持的AIPP类型（动态AIPP或静态AIPP）及动态AIPP输入对应的index值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetAippType(uint32_t modelId, size_t index, aclmdlInputAippType *type, size_t *dynamicAttachedDataIndex)
    ```

- **python函数**

    ```python
    type, dynamic_attached_data_index, ret = acl.mdl.get_aipp_type(model_id, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，指定模型的ID。调用模型加载接口（例如[acl.mdl.load_from_file](function-load_from_file.md)接口、[acl.mdl.load_from_mem](function-load_from_mem.md)等）成功后，会返回模型ID，该ID作为本接口的输入。 |
| index | int，模型中输入的index。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| type | int，表示指定模型输入的AIPP类型，具体请参见[aclmdlInputAippType](aclmdlInputAippType.md)。 |
| dynamic_attached_data_index | int，返回信息。<br> 当type不为ACL_DATA_WITH_DYNAMIC_AIPP时，该值返回0xFFFFFFFF，表示无效。<br> 当type为ACL_DATA_WITH_DYNAMIC_AIPP时，该值返回动态AIPP输入（用于配置动态AIPP参数）的index。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用示例，参见[动态AIPP（多个动态AIPP输入）](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0040.html)。
