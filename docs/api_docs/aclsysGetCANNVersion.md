# aclsysGetCANNVersion

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询CANN软件包版本号。

## 函数原型

```
aclError aclsysGetCANNVersion(aclCANNPackageName name, aclCANNPackageVersion *version)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| name | 输入 | 指定要查询的软件包。<br>若指定要查询的软件包没有安装，则本接口返回报错。 |
| version | 输出 | CANN软件包版本号。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

