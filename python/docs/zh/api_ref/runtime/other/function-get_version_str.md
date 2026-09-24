# 函数：get\_version\_str

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

根据软件包名称查询版本号，版本号是字符串类型，与各包安装目录下version.info文件中的version保持一致。

## 函数原型

- **C函数原型**

    ```c
    aclError aclsysGetVersionStr(char *pkgName, char *versionStr)
    ```

- **python函数**

    ```python
    version_str, ret = acl.get_version_str(pkgName)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| pkgName | str，软件包名称。<br>CANN包名称与${INSTALL_DIR}/share/info下的目录名称保持一致。${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。<br>驱动包名称为driver。<br>固件包名称为firmware。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| version_str | str，字符串类型的版本号。 |
| ret | int，返回0表示成功，返回其他值表示失败，请参见[其它值](../datatypes/aclError.md)。 |
