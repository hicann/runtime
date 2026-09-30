# 函数：set\_config\_opt

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

设置模型加载的配置对象中的各属性的取值，包括模型执行的优先级、模型的文件路径或内存地址、内存大小等。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlSetConfigOpt(aclmdlConfigHandle *handle, aclmdlConfigAttr attr, const void *attrValue, size_t valueSize)
    ```

- **python函数**

    ```python
    ret = acl.mdl.set_config_opt(config_handle, attr, attr_value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| config_handle | int，指定模型加载的配置对象的指针地址。需提前调用[acl.mdl.create_config_handle](function-create_config_handle.md)接口创建该对象的指针地址。 |
| attr | int，指定需设置的属性，取值请参考[aclmdlConfigAttr](aclmdlConfigAttr.md)。 |
| attr_value | int/str，指定设置属性的值，取值请参考[aclmdlConfigAttr](aclmdlConfigAttr.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

本接口需要与以下其它接口配合，实现模型加载功能：

1. 调用[acl.mdl.create\_config\_handle](function-create_config_handle.md)接口创建模型加载的配置对象。
2. 多次调用[acl.mdl.set\_config\_opt](function-set_config_opt.md)接口设置配置对象中每个属性的值。
3. 调用[acl.mdl.load\_with\_config](function-load_with_config.md)接口指定模型加载时需要的配置信息，并进行模型加载。
4. 模型加载成功后，调用[acl.mdl.destroy\_config\_handle](function-destroy_config_handle.md)接口销毁。

## 资源参考

使用[acl.mdl.set\_config\_opt](function-set_config_opt.md)接口、[acl.mdl.load\_with\_config](function-load_with_config.md)接口时，是通过配置对象中的属性来区分，在加载模型时是从文件加载，还是从内存加载，以及内存是由系统内部管理，还是由用户管理。

当前还提供了以下接口实现模型加载的功能，从使用的接口上区分从文件加载，还是从内存加载，以及内存是由系统内部管理，还是由用户管理。

- [acl.mdl.load\_from\_file](function-load_from_file.md)接口
- [acl.mdl.load\_from\_mem](function-load_from_mem.md)接口
- [acl.mdl.load\_from\_file\_with\_mem](function-load_from_file_with_mem.md)接口
- [acl.mdl.load\_from\_mem\_with\_mem](function-load_from_mem_with_mem.md)接口
