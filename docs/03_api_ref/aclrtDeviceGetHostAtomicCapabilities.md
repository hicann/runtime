# aclrtDeviceGetHostAtomicCapabilities

## 产品支持情况

| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

查询指定Device与Host之间支持的原子操作详情。

## 函数原型

```
aclError aclrtDeviceGetHostAtomicCapabilities(uint32_t* capabilities, const aclrtAtomicOperation* operations, const uint32_t count, int32_t deviceId)
```

## 参数说明

| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| capabilities | 输出 | 原子操作支持能力数组，数组长度与count参数值一致。数组中的每个元素是一个位掩码，位掩码的每一位代表对不同数据类型原子操作的支持情况，1表示支持，0表示不支持。类型定义请参见[aclrtAtomicOperationCapability](aclrtAtomicOperationCapability.md)。 |
| operations | 输入 | 待查询的原子操作数组，数组长度与count参数值一致。类型定义请参见[aclrtAtomicOperation](aclrtAtomicOperation.md)。 |
| count | 输入 | 待查询的原子操作数量，其大小必须与capabilities以及operations参数数组的长度一致。 |
| deviceId | 输入 | Device ID。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。
