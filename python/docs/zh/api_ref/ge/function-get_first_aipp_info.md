# 函数：get\_first\_aipp\_info

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：不支持
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

获取模型AIPP（包括静态AIPP和动态AIPP）的配置信息。

AIPP支持的几种操作的计算方式及其计算顺序如下：抠图-\>色域转换-\>减均值/归一化-\>padding。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlGetFirstAippInfo(uint32_t modelId, size_t index, aclAippInfo *aippInfo)
    ```

- **python函数**

    ```python
    aipp_info, ret = acl.mdl.get_first_aipp_info(model_id, index)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，模型ID。可在以下接口成功加载模型后获取到模型ID。<br> [acl.mdl.load_from_file](function-load_from_file.md)<br> [acl.mdl.load_from_mem](function-load_from_mem.md)<br> [acl.mdl.load_from_file_with_mem](function-load_from_file_with_mem.md)<br> [acl.mdl.load_from_mem_with_mem](function-load_from_mem_with_mem.md) |
| index | int，指定模型的第几个输入。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| aipp_info | dict，获取指定输入上静态AIPP的配置信息，具体请参见[aclAippInfo](aclAippInfo.md)。详细说明及参数解释，请参考[《ATC离线模型编译工具》](https://hiascend.com/document/redirect/cannCommunityATC)。 |
| ret | int，错误码。<br> 返回0表示成功。<br> 返回[其它值](aclError.md)表示失败。 |

## 约束说明

如果使用本接口获取模型中动态AIPP的信息，只能获取aipp\_info中如下参数的值：srcFormat、srcDatatype、srcDimNum、shapeCount、outDims，其它参数值无效。
