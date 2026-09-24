# 函数：get\_version（废弃）

**知：此接口后续版本会废弃，请使用[acl.sys.get\_version\_str](function-get_version_str.md)接口。**

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

查询接口版本号，pyacl接口版本号命名可以采用：A.B.C模式，其中，A表示有不兼容修改，B表示新增接口，C表示bug修复。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtGetVersion(int32_t *majorVersion, int32_t *minorVersion, int32_t *patchVersion)
    ```

- **python函数**

    ```python
    major_version, minor_version, patch_version, ret = acl.get_version()
    ```

## 参数说明

无

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| major_version | int，主版本号，从1开始，如果出现接口的不兼容变更时，加1。 |
| minor_version | int，次版本号，从0开始，按照迭代周期，有新增接口时加1。 |
| patch_version | int，补丁版本号，从0开始，表示本版本仅仅解决了问题，在“majorVersion”、“minorVersion”不变的情况下加1。但“majorVersion”、“minorVersion”增加的时候，“patchVersion”一般为“0”。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
