# aclrtDestroyGroupInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

销毁aclrtGroupInfo类型的数据，释放相关的内存。只能销毁通过[aclrtCreateGroupInfo](aclrtCreateGroupInfo.md)接口创建的aclrtGroupInfo类型。

## 函数原型

```
aclError aclrtDestroyGroupInfo(aclrtGroupInfo *groupInfo)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| groupInfo | 输入 | 待销毁的aclrtGroupInfo类型数据的指针。 |

## 返回值说明

返回0表示成功，非零表示失败，请参见[aclError](aclError.md)。

