# aclsysGetVersionStr

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据软件包名称查询版本号，版本号是字符串类型，与各包安装目录下version.info文件中的version保持一致。

## 函数原型

```
aclError aclsysGetVersionStr(char *pkgName, char * versionStr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| pkgName | 输入 | 软件包名称，与${INSTALL_DIR}/share/info下的目录名称保持一致。<br>${INSTALL_DIR}请替换为CANN软件安装后文件存储路径。以root用户安装为例，安装后文件默认存储路径为：/usr/local/Ascend/cann。 |
| versionStr | 输出 | 版本号。<br>建议用户声明一个长度为ACL_PKG_VERSION_MAX_SIZE的字符数组，用于存放版本号。例如：char versionStr[ACL_PKG_VERSION_MAX_SIZE] = {0};<br>ACL_PKG_VERSION_MAX_SIZE宏的定义如下：<br>#define ACL_PKG_VERSION_MAX_SIZE  128 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

