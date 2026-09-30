# 函数：start

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

下发Profiling请求，使能对应数据的采集。

用户可根据需要，在模型执行过程中按需调用[acl.prof.start](function-start.md)接口，Profiling采集到的数据为调用该接口之后的数据。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofStart(const aclprofConfig *profilerConfig)
    ```

- **python函数**

    ```python
    ret = acl.prof.start(profiler_config)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| profiler_config | int，指定Profiling配置数据。<br>需提前调用[acl.prof.create_config](function-create_config.md)接口创建aclprofConfig类型的数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

与[acl.prof.stop](function-stop.md)接口配对使用，先调用acl.prof.start接口再调用acl.prof.stop接口。
