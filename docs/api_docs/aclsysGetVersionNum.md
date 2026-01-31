# aclsysGetVersionNum

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据软件包名称查询版本号，版本号是数值类型，通过计算各包安装目录下version.info文件中的version字段的主、次、补丁等版本信息的权重得出。

获取数值类型的版本号并进行比较，数值较大的表示版本发布时间较新，可用于了解版本发布的先后顺序，以及在代码中根据版本区分不同的接口调用逻辑等。

## 函数原型

```
aclError aclsysGetVersionNum(char *pkgName，int32_t * versionNum)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| pkgName | 输入 | 软件包名称，与${INSTALL_DIR}/share/info下的目录名称保持一致。<br>${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。 |
| versionNum | 输出 | 数值类型的版本号。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

