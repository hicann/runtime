# 函数：set\_sys\_param\_opt

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

设置当前进程中的运行时参数值。调用本接口设置运行时参数值后，若需获取参数值，需调用[acl.rt.get\_sys\_param\_opt](function-get_sys_param_opt.md)接口。

本接口与[acl.rt.ctx\_set\_sys\_param\_opt](../context/function-ctx_set_sys_param_opt.md)接口的差别是，本接口作用域是进程，acl.rt.ctx\_set\_sys\_param\_opt接口作用域是Context。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtSetSysParamOpt(aclrtSysParamOpt opt, int64_t value)
    ```

- **python函数**

    ```python
    ret = acl.rt.set_sys_param_opt(opt, value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| opt | int，运行时系统参数，参考[aclSysParamOpt](../datatypes/aclSysParamOpt.md)。 |
| value | int，运行时参数值。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回[其他值](../datatypes/aclError.md)表示失败。 |

## 约束说明

多次调用本接口，以最后一次设置的值为准。
