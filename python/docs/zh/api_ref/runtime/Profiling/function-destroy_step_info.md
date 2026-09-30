# 函数：destroy\_step\_info

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

销毁通过[acl.prof.create\_step\_info](function-create_step_info.md)接口创建的aclprofStepInfo类型的数据。

## 函数原型

- **C函数原型**

    ```c
    void aclprofDestroyStepInfo (aclprofStepInfo * stepinfo)
    ```

- **python函数**

    ```python
    acl.prof.destroy_step_info(stepinfo)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stepinfo | int，指定迭代信息，需提前调用[acl.prof.create_step_info](function-create_step_info.md)接口创建aclprofStepInfo类型的数据。 |

## 返回值说明

无

## 约束说明

- 与[acl.prof.create\_step\_info](function-create_step_info.md)接口配对使用，先调用acl.prof.create\_step\_info接口再调用acl.prof.destroy\_step\_info接口。
- 同一aclprofStepInfo数据重复调用acl.prof.destroy\_step\_info接口，会出现重复释放内存的报错。
