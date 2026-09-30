# 函数：init

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

初始化Profiling，目前用于设置保存性能数据的文件的路径。

## 函数原型

- **C函数原型**

    ```c
    aclError aclprofInit(const char *profilerResultPath, size_t length)
    ```

- **python函数**

    ```python
    ret = acl.prof.init(profiler_result_path)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| profiler_result_path | str，指定保存性能数据的文件的路径，此路径为绝对路径。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码。<br>返回0表示成功。<br>返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

与[acl.prof.finalize](function-finalize- 2.md)接口配对使用，先调用aclprofInit接口再调用aclprofFinalize接口。
