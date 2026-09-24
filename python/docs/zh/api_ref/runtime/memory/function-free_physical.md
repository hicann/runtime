# 函数：free\_physical

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

释放通过[acl.rt.malloc\_physical](function-malloc_physical.md)接口申请的物理内存。

若该物理内存与虚拟内存存在映射关系，则此处不会实际释放物理内存，只有在调用[acl.rt.unmap\_mem](function-unmap_mem.md)接口取消该物理内存与虚拟内存的映射之后，物理内存才会被真正释放。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtFreePhysical(aclrtDrvMemHandle handle)
    ```

- **python函数**

    ```python
    ret = acl.rt.free_physical(handle)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| handle | int，待释放的物理地址信息handle。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

<!-- npu="310b" id7 -->
## 约束说明

Atlas 200I/500 A2推理产品上，Ascend RC形态不支持调用本接口。
<!-- end id7 -->
