# 函数：load\_from\_file

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

从文件加载离线模型数据，由系统内部管理内存。

本接口中通过modelPath参数传入的文件是\*.om模型文件。关于如何获取om模型文件，请参见[《ATC离线模型编译工具》](https://hiascend.com/document/redirect/cannCommunityATC)中的 [--mode](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/devaids/atctool/docs/zh/user_guides/atc_tools/CLI_options/--model.md)”。

若对om模型文件大小有限制，本接口还支持加载外置权重文件，但需在构建模型时，将权重保存在单独的文件中。例如在使用ATC工具生成om文件时，将--external\_weight参数设置为1（1表示将原始网络中的Const/Constant节点的权重保存在单独的文件中），且该文件保存在与om文件同级的weight目录下），那么在使用本接口加载om文件时，需将weight目录与om文件放在同级目录下，这时本接口会自行到weight目录下查找权重文件，否则可能会导致单独的权重文件加载不成功。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlLoadFromFile(const char *modelPath, uint32_t *modelId)
    ```

- **python函数**

    ```python
    model_id, ret = acl.mdl.load_from_file(model_path)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_path | str，离线模型文件的存储路径，路径中包含文件名。运行程序（APP）的用户需要对该存储路径有访问权限。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| model_id | int，系统完成模型加载后生成的模型ID对应的指针地址。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

当前还提供了[acl.mdl.set\_config\_opt](function-set_config_opt.md)接口、[acl.mdl.load\_with\_config](function-load_with_config.md)接口来实现模型加载，通过配置对象中的属性来区分，在加载模型时是从文件加载，还是从内存加载，以及内存是由系统内部管理，还是由用户管理。
