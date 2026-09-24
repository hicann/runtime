# 函数：use\_stream\_res\_in\_current\_thread

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

在当前线程中使用指定Stream上的Device资源限制。如果多次调用本接口设置Stream，将以最后一次设置为准。

需先调用[acl.rt.set\_stream\_res\_limit](function-set_stream_res_limit.md)接口设置该Stream上的Device资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtUseStreamResInCurrentThread(aclrtStream stream)
    ```

- **python函数**

    ```python
    ret = acl.rt.use_stream_res_in_current_thread(stream)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定stream, 若传入0，则表示默认Stream。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回其他值表示失败。 |
