# 函数：destroy\_tensor\_desc

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

销毁aclTensorDesc类型的数据。

## 函数原型

- **C函数原型**

    ```c
    void aclDestroyTensorDesc(const aclTensorDesc *desc)
    ```

- **python函数**

    ```python
    acl.destroy_tensor_desc(desc)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| desc | int，待销毁的aclTensorDesc类型的指针地址。 |

## 返回值说明

无
