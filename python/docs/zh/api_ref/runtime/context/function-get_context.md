# 函数：get\_context

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

获取线程的Context。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetCurrentContext(aclrtContext context)
    ```

- **python函数**

    ```python
    context, ret = acl.rt.get_context()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| context | int，表示创建的Context对象指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

如果用户多次调用[acl.rt.set\_context](../context/function-set_context.md)接口设置当前线程的Context，则获取的是最后一次设置的Context。
