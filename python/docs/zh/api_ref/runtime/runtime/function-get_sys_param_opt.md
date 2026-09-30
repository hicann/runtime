# 函数：get\_sys\_param\_opt

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

获取当前进程中的运行时参数值。

如果不调用[acl.rt.set\_sys\_param\_opt](function-set_sys_param_opt.md)接口设置运行时参数的值，直接调用本接口可获取各参数的默认值0，表示不开启确定性计算或内存访问越界检测；调用[acl.rt.set\_sys\_param\_opt](function-set_sys_param_opt.md)接口设置运行时参数值后，若需获取参数值，需调用[acl.rt.get\_sys\_param\_opt](function-get_sys_param_opt.md)接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetSysParamOpt(aclrtSysParamOpt opt, int64_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.get_sys_param_opt(opt)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| opt | int，运行时系统参数，参考[aclSysParamOpt](../datatypes/aclSysParamOpt.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | int，运行时参数值。 |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
