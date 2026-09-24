# 函数：set\_stream\_overflow\_switch

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
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

对接上层训练框架时（例如：PyTorch），针对指定Stream，打开或关闭溢出检测开关，关闭后无法通过溢出检测算子获取任务是否溢出。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetStreamOverflowSwitch(aclrtStream stream, uint32_t flag)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_stream_overflow_switch(stream, flag)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| stream | int，指定Stream的指针地址，若传入0，则操作默认Stream。 |
| flag | int，溢出检测开关，取值范围如下。<br>0：关闭<br>1：打开 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

调用该接口打开或关闭溢出检测开关后，仅对后续新下发的任务生效，已下发的任务仍维持原样。
