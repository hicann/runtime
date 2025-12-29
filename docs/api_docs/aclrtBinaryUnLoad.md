# aclrtBinaryUnLoad

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

删除binHandle指向的算子二进制数据，同时也删除加载算子二进制文件时拷贝到Device上的算子二进制数据。

## 函数原型

```
aclError aclrtBinaryUnLoad(aclrtBinHandle binHandle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| binHandle | 输入 | 算子二进制句柄。<br>该handle在调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)、[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)或者[aclrtBinaryLoad](aclrtBinaryLoad.md)接口时生成。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

调用本接口删除算子二进制数据时，需跟[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)、[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)或者[aclrtBinaryLoad](aclrtBinaryLoad.md)接口在同一个Context下，这样才能一并删除加载算子二进制文件时拷贝到Device上的算子二进制数据，否则可能会导致Device上的算子二进制数据删除异常。

