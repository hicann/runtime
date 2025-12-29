# aclrtGetAllGroupInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

查询当前Context下可以使用的所有Group的详细算力信息。

## 函数原型

```
aclError  aclrtGetAllGroupInfo(aclrtGroupInfo *groupInfo)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| groupInfo | 输出 | 获取所有Group对应的详细算力信息的指针。<br>需提前调用[aclrtCreateGroupInfo](aclrtCreateGroupInfo.md)接口创建aclrtGroupInfo类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

