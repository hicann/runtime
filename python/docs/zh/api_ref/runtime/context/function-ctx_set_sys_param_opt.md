# 函数：ctx\_set\_sys\_param\_opt

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

设置当前Context中的系统参数值。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtCtxSetSysParamOpt(aclSysParamOpt opt, int64_t value)
    ```

- **python函数**

    ```python
    ret = acl.rt.ctx_set_sys_param_opt(opt, value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| opt | int，系统参数，参考[aclSysParamOpt](../datatypes/aclSysParamOpt.md)。 |
| value | int，系统参数值。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

多次调用本接口，以最后一次设置的值为准。
