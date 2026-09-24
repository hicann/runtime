# 函数：create\_notify

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

创建Notify。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCreateNotify(aclrtNotify *notify, uint64_t flag)
    ```

- **python函数**

    ```python
    notify, ret = acl.rt.create_notify(flag)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| flag | int，预留参数。当前固定配置为0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| notify | int，Notify的指针地址。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

不同型号的硬件支持的Notify数量不同：

<!-- npu="950" id7 -->
- 对于Ascend 950PR&950DT系列产品，单个Device支持的Notify最大数为65535。
<!-- end id7 -->
<!-- npu="A3,910b" id8 -->
- 对于Atlas A3系列产品、Atlas A2系列产品，单个Device支持的Notify最大数为8192。
<!-- end id8 -->
<!-- npu="310b" id9 -->
- 对于Atlas 200I/500 A2推理产品，单个Device支持的Notify最大数为2048。
<!-- end id9 -->
<!-- npu="910,310p" id10 -->
- 对于Atlas推理系列产品、Atlas训练系列产品，单个Device支持的Notify最大数为1024。
<!-- end id10 -->
