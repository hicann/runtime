# 函数：set\_stream\_failure\_mode

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

当一个Stream上下发了多个任务时，可通过本接口指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetStreamFailureMode(aclrtStream stream, uint64_t mode)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_stream_failure_mode(stream, mode)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，待操作Stream的指针地址。 |
| mode | int，当一个Stream上下发了多个任务时，可通过本参数指定任务调度模式，以便控制某个任务失败后是否继续执行下一个任务。<br>取值范围如下：<br>**ACL_CONTINUE_ON_FAILURE = 0**：默认值，某个任务失败后，继续执行下一个任务。<br>**ACL_STOP_ON_FAILURE = 1**：某个任务失败后，停止执行后续的任务。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 针对指定Stream只能调用一次本接口设置任务调度模式。
- 当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。
<!-- npu="950,A3,910b" id7 -->
- 对于Ascend 950PR&950DT系列产品、Atlas A3系列产品、Atlas A2系列产品，支持指定默认Stream（即stream参数传入0）。
<!-- end id7 -->
<!-- npu="910,310p,310b" id8 -->
- 对于Atlas 200I/500 A2推理产品、Atlas推理系列产品、Atlas训练系列产品，不支持指定默认Stream（即stream参数传入0）。
<!-- end id8 -->
