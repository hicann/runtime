# 函数：create\_exec\_config\_handle

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

创建aclmdlExecConfigHandle类型的数据，表示一个模型执行的配置对象的指针地址。

如需销毁aclmdlExecConfigHandle类型的数据，请参见[函数：destroy\_exec\_config\_handle](function-destroy_exec_config_handle.md)。

## 函数原型

- **C函数原型**

    ```c
    aclmdlExecConfigHandle *aclmdlCreateExecConfigHandle()
    ```

- **python函数**

    ```python
    handle = acl.mdl.create_exec_config_handle()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| handle | int，返回aclmdlExecConfigHandle类型的指针地址。<br> 返回非0表示成功。<br> 返回0表示失败。 |
