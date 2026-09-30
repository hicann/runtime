# 函数：destroy\_context

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

销毁一个Context，释放Context的资源。只能销毁通过[acl.rt.create\_context](function-create_context.md)接口创建的Context。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDestroyContext(aclrtContext context)
    ```

- **python函数**

    ```python
    ret = acl.rt.destroy_context(context)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| context | int，指定需要销毁的Context对象指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 资源参考

接口调用流程与示例，请参见《应用开发》Python部分的运行时资源申请与释放、同步等待章节。
