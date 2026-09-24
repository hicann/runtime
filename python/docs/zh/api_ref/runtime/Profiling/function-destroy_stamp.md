# 函数：destroy\_stamp

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

释放msproftx事件标记。

## 函数原型

- **C函数原型**

    ```c
    void aclprofDestroyStamp(void *stamp)
    ```

- **python函数**

    ```python
    acl.prof.destroy_stamp(stamp)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stamp | int，Stamp指针地址，指代msproftx事件标记。指定[函数：create_stamp](function-create_stamp.md)接口的指针地址。 |

## 返回值说明

无

## 约束说明

与[函数：create\_stamp](function-create_stamp.md)接口配对使用，在[函数：stop](function-stop.md)接口前调用。
