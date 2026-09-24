# 函数：create\_step\_info

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

创建aclprofStepInfo对象，用于描述迭代信息。

## 函数原型

- **C函数原型**

    ```c
    aclprofStepInfo* aclprofCreateStepInfo(void)
    ```

- **python函数**

    ```python
    info = acl.prof.create_step_info()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| info | int，aclprofStepInfo类型指针地址。<br>返回aclprofStepInfo类型，表示成功。<br>返回None，表示失败。 |

## 约束说明

- 使用acl.prof.destroy\_step\_info接口销毁aclprofStepInfo类型的数据，如不销毁会导致内存未被释放。
- 与[acl.prof.destroy\_step\_info](function-destroy_step_info.md)接口配对使用，先调用acl.prof.create\_step\_info接口再调用acl.prof.destroy\_step\_info接口。
- 同一个aclprofStepInfo对象、同一个tag只能设置一次，否则Profiling解析会出错。
