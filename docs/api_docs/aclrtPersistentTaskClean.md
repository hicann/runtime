# aclrtPersistentTaskClean

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

清理ACL\_STREAM\_PERSISTENT类型的Stream上的任务，适用于在不删除该类型Stream的情况下重新下发任务的场景。

ACL\_STREAM\_PERSISTENT类型的Stream需调用[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口创建。

## 函数原型

```
aclError aclrtPersistentTaskClean(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

