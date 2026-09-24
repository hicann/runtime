# 函数：destroy\_event

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

销毁一个Event，支持在Event未完成前调用本接口销毁Event。此时，本接口不会阻塞线程等Event完成，Event相关资源会在Event完成时被自动释放。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDestroyEvent(aclrtEvent event)
    ```

- **python函数**

    ```python
    ret = acl.rt.destroy_event(event)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| event | int，待销毁的Event指针地址。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

在调用acl.rt.destroy\_event接口销毁指定Event时，需确保其它接口没有正在使用该Event。
