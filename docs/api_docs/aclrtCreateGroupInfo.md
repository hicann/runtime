# aclrtCreateGroupInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

根据实际支持的Group数量创建aclrtGroupInfo类型的连续内存块，并返回对应指针。

如需销毁aclrtGroupInfo类型的数据，请参见[aclrtDestroyGroupInfo](aclrtDestroyGroupInfo.md)。

## 函数原型

```
aclrtGroupInfo *aclrtCreateGroupInfo()
```

## 参数说明

无

## 返回值说明

返回aclrtGroupInfo类型的指针，如果无Group或不支持Group则返回nullptr。

