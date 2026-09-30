# 函数：unload

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

系统完成模型推理后，可调用该接口卸载模型，释放资源。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlUnload(uint32_t modelId)
    ```

- **python函数**

    ```python
    ret = acl.mdl.unload(model_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，指定需卸载的模型的ID。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

- 在调用acl.mdl.unload接口卸载指定模型时，需确保该模型当前未被其他接口使用。
- 模型加载、模型执行、模型卸载的操作必须在同一个Context下（关于Context的创建请参见`acl.rt.set\_device`、acl.rt.create\_context）。

## 资源参考

接口调用流程，参见[接口调用流程](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0005.html)。
