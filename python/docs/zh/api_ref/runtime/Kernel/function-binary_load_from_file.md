# 函数：binary\_load\_from\_file

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

从文件加载并解析算子二进制文件，输出指向算子二进制的binHandle。

对于AI Core算子，若使用本接口加载并解析算子二进制文件，需配套使用[acl.rt.launch\_kernel\_with\_config](function-launch_kernel_with_config.md)接口下发计算任务。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtBinaryLoadFromFile(const char* binPath, aclrtBinaryLoadOptions *options, aclrtBinHandle *binHandle)
    ```

- **python函数**

    ```python
    bin_handle, ret = acl.rt.binary_load_from_file(bin_path, options)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| bin_path | str，算子二进制文件（.o文件）的路径，要求绝对路径。对于AI CPU算子，该参数支持传算子信息库文件（.json）。 |
| options | list，加载算子二进制文件的可选参数，结构参考[aclrtBinaryLoadOptions](../datatypes/aclrtBinaryLoadOptions.md)，若参数为空，可将options设置为[]。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| bin_handle | int，标识算子二进制的句柄。 |
| ret | int，返回0表示成功，返回其他值表示失败。 |

## 约束说明

针对某一型号的产品，编译生成的算子二进制文件，必须在相同型号的产品上使用。
