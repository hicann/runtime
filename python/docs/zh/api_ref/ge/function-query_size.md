# 函数：query\_size

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

根据模型文件获取模型执行时所需的权值内存大小、工作内存大小。

## 函数原型

- **C函数原型**

    ```c
    aclError aclmdlQuerySize(const char *fileName, size_t *workSize, size_t *weightSize)
    ```

- **python函数**

    ```python
    work_size, weight_size, ret = acl.mdl.query_size(file_name)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| file_name | str，需要获取内存信息的模型路径，路径中包含文件名。运行程序（APP）的用户需要对该路径有访问权限。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| work_size | int，模型执行时所需的工作内存的大小，单位Byte。 |
| weight_size | int，模型执行时所需权值内存的大小，单位Byte。 |
| ret | int，错误码，返回0表示成功，返回[其它值](aclError.md)表示失败。 |

## 约束说明

当由用户管理内存时，为节省内存资源，在申请工作内存、权值内存前，需要调用[acl.mdl.query\_size](function-query_size.md)接口查询模型运行时所需工作内存、权值内存的大小。

如果模型输入数据的Shape不确定，则不能调用[acl.mdl.query\_size](function-query_size.md)接口查询内存大小，在加载模型时，就无法由用户管理内存，此时需选择由系统管理内存的模型加载接口（例如，[acl.mdl.load\_from\_file](function-load_from_file.md)、[acl.mdl.load\_from\_mem](function-load_from_mem.md)）。

## 资源参考

接口调用流程，参见[模型加载](https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/others/acldevg/aclpythondevg_0031.html)。
