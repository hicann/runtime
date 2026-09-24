# 函数：dump\_unreg\_callback

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

Dump数据回调函数取消注册接口。

[函数：init\_dump](function-init_dump.md)接口、[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口（通过该接口注册的回调函数需由用户自行实现，回调函数实现逻辑中包括获取Dump数据及数据长度）、[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口、[函数：finalize\_dump](function-finalize_dump.md)接口配合使用，用于通过回调函数获取Dump数据。场景举例如下：

- 执行一个模型，通过回调获取Dump数据：

    [函数：init](../init/function-init.md)接口--\>[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口--\>[函数：init\_dump](function-init_dump.md)接口--\>模型加载--\>模型执行--\>[函数：finalize\_dump](function-finalize_dump.md)接口--\>[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口--\>模型卸载--\>[函数：finalize](../init/function-finalize.md)接口

- 执行两个不同的模型，通过回调获取Dump数据，该场景下，只要不调用[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口取消注册回调函数，则可通过回调函数获取两个模型的dump数据：

    [函数：init](../init/function-init.md)接口--\>[函数：dump\_reg\_callback](function-dump_reg_callback.md)接口--\>[函数：init\_dump](function-init_dump.md)接口--\>模型1加载--\>模型1执行--\>--\>模型2加载--\>模型2执行--\>[函数：finalize\_dump](function-finalize_dump.md)接口--\>模型卸载--\>[函数：dump\_unreg\_callback](function-dump_unreg_callback.md)接口--\>[函数：finalize](../init/function-finalize.md)接口

## 函数原型

- **C函数原型**

    ```c
    void acldumpUnregCallback()
    ```

- **python函数**

    ```python
    acl.mdl.dump_unreg_callback()
    ```

## 参数说明

无

## 返回值说明

无

## 约束说明

acl.mdl.dump\_unreg\_callback需要和acl.mdl.dump\_reg\_callback配合使用，且必须在acl.mdl.dump\_reg\_callback调用后才有效。
