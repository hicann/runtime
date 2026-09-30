# 函数：bundle\_load\_from\_mem

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

模型执行阶段若涉及动态更新变量的场景，从内存加载离线模型数据，由系统内部管理模型运行的内存。

**本接口需与以下其它接口配合使用**，以便实现动态更新变量的目的，请参见[acl.mdl.bundle\_load\_from\_file](function-bundle_load_from_file.md)处的说明。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlBundleLoadFromMem(const void *model, size_t modelSize, uint32_t *bundleId)
    ```

- **python函数**

    ```python
    bundle_id, ret = acl.mdl.bundle_load_from_mem(model, model_size)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model | int，存放模型数据的指针地址。此处的模型文件是基于构图方式构建出来的，调用aclgrphBundleBuildModel接口编译模型、调用aclgrphBundleSaveModel接口保存模型，再由用户自行将保存出来的om模型文件读入内存，构图接口详细描述参见《图开发》。 |
| model_size | int，内存中的模型数据长度，单位Byte。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| bundle_id | int，系统成功加载模型后，返回bundle_id作为后续操作时识别模型的标志。 |
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