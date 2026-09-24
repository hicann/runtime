# 函数：load\_from\_mem

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

从内存加载om模型文件数据，由系统内部管理模型运行的内存。

关于如何获取om模型文件，请参见[《ATC离线模型编译工具》](https://hiascend.com/document/redirect/cannCommunityATC)中的 [--mode](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/devaids/atctool/docs/zh/user_guides/atc_tools/CLI_options/--model.md)”。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlLoadFromMem(const void *model, size_t modelSize, uint32_t* modelId)
    ```

- **python函数**

    ```python
    model_id, ret = acl.mdl.load_from_mem(model, model_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model | int，模型数据的内存地址对应的指针地址。 |
| model_size | int，内存中的模型数据长度，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| model_id | int，系统完成模型加载后生成的模型ID对应的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

<!-- npu="950,A3,910b,910,310p,310b" id7 -->
Ascend EP形态下，model参数处需申请Host上的内存。
<!-- end id7 -->

<!-- npu="310b" id8 -->
Ascend RC形态下，model参数处需申请Device上的内存。
<!-- end id8 -->

<!-- npu="310p" id9 -->
Control CPU开放形态下，model参数处需申请Device上的内存。
<!-- end id9 -->

## 资源参考

当前还提供了[acl.mdl.set\_config\_opt](function-set_config_opt.md)接口、[acl.mdl.load\_with\_config](function-load_with_config.md)接口来实现模型加载，通过配置对象中的属性来区分，在加载模型时是从文件加载，还是从内存加载，以及内存是由系统内部管理，还是由用户管理。
