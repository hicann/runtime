# 函数：get\_cann\_version

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

查询CANN软件包版本号。

## 函数原型

- **C函数原型**

    ```c
    aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)
    ```

- **python函数**

    ```python
    version, ret = acl.get_cann_version(name)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| name | int，指定要查询的软件包，具体请参见[aclCANNPackageName](../datatypes/aclCANNPackageName.md)。若指定要查询的软件包没有安装，则本接口返回报错，错误码100003。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| version | dict，CANN软件包版本号，具体请参见[aclCANNPackageVersion](../datatypes/aclCANNPackageVersion.md)。 |
| ret | int，返回0表示成功，返回其他值表示失败，请参见[其它值](../datatypes/aclError.md)。 |
