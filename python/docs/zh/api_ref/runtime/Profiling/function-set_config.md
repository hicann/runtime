# 函数：set\_config

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

[acl.prof.create\_config](function-create_config.md)接口的扩展接口，用于设置性能数据采集参数。

该接口支持多次调用，用户需要保证数据的一致性和准确性。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofSetConfig(aclprofConfigType configType, const char *config, size_t configLength)
    ```

- **python函数**

    ```python
    ret = acl.prof.set_config(config_type, config)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| config_type | int，作为config_type参数值。每个常量表示不同采集配置，若要使用该接口下不同的选项采集多种性能数据，则需要多次调用该接口，详细说明见[aclprofConfigType](./../datatypes/aclprofConfigType.md)。 |
| config | str，配置项的参数值。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

先调用acl.prof.set\_config接口再调用[acl.prof.start](function-start.md)接口，可根据需求选择调用该接口。
