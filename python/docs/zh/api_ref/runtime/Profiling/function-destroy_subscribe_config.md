# 函数：destroy\_subscribe\_config

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

销毁aclprofSubscribeConfig类型的数据，只能销毁通过[acl.prof.create\_subscribe\_config](function-create_subscribe_config.md)接口创建的aclprofSubscribeConfig类型。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofDestroySubscribeConfig(const aclprofSubscribeConfig *profSubscribeConfig)
    ```

- **python函数**

    ```python
    ret = acl.prof.destroy_subscribe_config(subscribe_config)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| subscribe_config | int，待销毁的aclprofSubscribeConfig类型的地址对象。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 与[acl.prof.create\_subscribe\_config](function-create_subscribe_config.md)接口配对使用，先调用acl.prof.create\_subscribe\_config接口再调用acl.prof.destroy\_subscribe\_config接口。
- 同一aclprofSubscribeConfig重复调用acl.prof.destroy\_subscribe\_config接口，会出现重复释放内存的报错。
