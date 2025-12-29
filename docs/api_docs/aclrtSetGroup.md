# aclrtSetGroup

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

指定当前运算使用哪个Group的算力，该接口必须在指定Context后调用。

## 函数原型

```
aclError aclrtSetGroup(int32_t groupId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| groupId | 输入 | 表示Group的ID，用于指定当前计算要使用的Group。<br>您需要提前调用[aclrtGetGroupInfoDetail](aclrtGetGroupInfoDetail.md)接口获取Group的ID。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

