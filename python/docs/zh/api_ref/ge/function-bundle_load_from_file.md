# 函数：bundle\_load\_from\_file

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

模型执行阶段若涉及动态更新变量的场景，可调用本接口从文件加载离线模型数据（适配AI处理器的离线模型），由系统内部管理内存。

**本接口需与以下其它接口配合使用**，以便实现动态更新变量的目的，关键接口的调用流程如下：

1. 基于构图方式编译并保存模型，模型中包含多个图，例如推理图、变量初始化图、变量更新图等。

    此处是调用aclgrphBundleBuildModel接口编译模型、调用aclgrphBundleSaveModel接口保存模型，接口详细描述参见《图开发》。

2. 调用[acl.mdl.bundle\_load\_from\_file](function-bundle_load_from_file.md)或[acl.mdl.bundle\_load\_from\_mem](function-bundle_load_from_mem.md)接口加载模型。
3. 调用[acl.mdl.bundle\_get\_model\_id](function-bundle_get_model_id.md)接口获取多个图的ID。
4. 根据多个图的ID，分别调用模型执行接口（例如[acl.mdl.execute](function-execute.md)）执行各个图。

    若涉及变量更新，则在执行变量更新图之前，先调用[acl.mdl.set\_dataset\_tensor\_desc](function-set_dataset_tensor_desc.md)接口设置图的tensor描述信息，再执行变量更新图，然后再执行一次推理图。

5. 推理结束后，调用[acl.mdl.bundle\_unload](function-bundle_unload.md)接口卸载模型。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlBundleLoadFromFile(const char *modelPath, uint32_t *bundleId)
    ```

- **python函数**

    ```python
    bundle_id, ret = acl.mdl.bundle_load_from_file(model_path)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| model_path | str，存放模型文件路径的字符串，路径中包含文件名。运行程序（APP）的用户需要对该存储路径有访问权限。此处的模型文件是基于构图方式构建出来的，调用aclgrphBundleBuildModel接口编译模型、调用aclgrphBundleSaveModel接口保存模型，接口详细描述参见《图开发》。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| bundle_id | int，系统成功加载模型后，返回bundle_id作为后续操作时识别模型的标志。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 资源参考

接口调用流程及示例代码请参见[权重更新](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0158.html)。
