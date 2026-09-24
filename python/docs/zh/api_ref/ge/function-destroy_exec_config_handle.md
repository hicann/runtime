# 函数：destroy\_exec\_config\_handle

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

销毁通过[acl.mdl.create\_exec\_config\_handle](function-create_exec_config_handle.md)接口创建的aclmdlExecConfigHandle类型数据。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlDestroyExecConfigHandle(const aclmdlExecConfigHandle *handle)
    ```

- **python函数**

    ```python
    ret = acl.mdl.destroy_exec_config_handle(handle)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| handle | int，待销毁的aclmdlExecConfigHandle数据类型的指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |
