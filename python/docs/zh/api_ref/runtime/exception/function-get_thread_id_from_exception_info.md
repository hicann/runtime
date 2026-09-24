# 函数：get\_thread\_id\_from\_exception\_info

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

获取异常信息中的线程ID。该接口与[acl.rt.set\_exception\_info\_callback](function-set_exception_info_callback.md)接口配合使用。

## 函数原型

- **C函数原型**

    ```c
    uint32_t aclrtGetThreadIdFromExceptionInfo(const aclrtExceptionInfo *info)
    ```

- **python函数**

    ```python
    thread_id = acl.rt.get_thread_id_from_exception_info(info)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| info | int，表示异常信息aclrtExceptionInfo的指针地址。<br>在执行任务之前调用[acl.rt.set_exception_info_callback](function-set_exception_info_callback.md)接口，系统会将产生异常的任务ID、Stream ID、线程ID、Device ID存放在aclExceptionInfo中。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| thread_id | int，返回异常信息中的线程ID，返回值为“0xFFFFFFFF”（以十六进制为例）时表示异常信息为空。 |
