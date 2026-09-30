# 函数：model\_subscribe

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

网络场景下，订阅算子的基本信息，包括算子名称、算子类型、算子执行耗时等。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofModelSubscribe(uint32_t modelId, const aclprofSubscribeConfig *profSubscribeConfig)
    ```

- **python函数**

    ```python
    ret = acl.prof.model_subscribe(model_id, subscribe_config)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_id | int，待订阅的网络模型的ID。<br>调用`acl.mdl.load_from_file`<br>接口`acl.mdl.load_from_mem`<br>接口`acl.mdl.load_from_file_with_mem`<br>接口`acl.mdl.load_from_mem_with_mem`<br>接口加载模型成功后，会返回模型ID。 |
| subscribe_config | int，待订阅的配置信息。调用[acl.prof.create_subscribe_config](function-create_subscribe_config.md)接口创建配置数据。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

需要与[acl.prof.model\_unsubscribe](function-model_unsubscribe.md)接口配对使用。
