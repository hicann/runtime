# 函数：bundle\_get\_model\_num

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

根据bundle\_id获取实际可执行的模型数。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlBundleGetModelNum(uint32_t bundleId, size_t modelNum)
    ```

- **python函数**

    ```python
    model_num, ret = acl.mdl.bundle_get_model_num(bundle_id)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| bundle_id | int，通过[acl.mdl.bundle_load_from_file](function-bundle_load_from_file.md)接口或[acl.mdl.bundle_load_from_mem](function-bundle_load_from_mem.md)接口加载模型成功后返回的bundle_id。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| model_num | int，实际可执行的模型数。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
