# 函数：bundle\_unload

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

系统完成模型推理后，可调用该接口卸载通过[acl.mdl.bundle\_load\_from\_file](function-bundle_load_from_file.md)接口或[acl.mdl.bundle\_load\_from\_mem](function-bundle_load_from_mem.md)接口加载的模型，释放资源。

**本接口需与以下其它接口配合使用**，以便实现动态更新变量的目的，请参见[acl.mdl.bundle\_load\_from\_file](function-bundle_load_from_file.md)处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlBundleUnload(uint32_t bundleId)
    ```

- **python函数**

    ```python
    ret = acl.mdl.bundle_unload(bundle_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| bundle_id | int，通过[acl.mdl.bundle_load_from_file](function-bundle_load_from_file.md)接口或[acl.mdl.bundle_load_from_mem](function-bundle_load_from_mem.md)接口加载模型成功后返回的bundle_id。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程及示例代码请参见[权重更新](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0158.html)。
