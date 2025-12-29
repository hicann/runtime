# aclrtQueryEventWaitStatus

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

调用[aclrtStreamWaitEvent](aclrtStreamWaitEvent.md)接口后查询该Event对应的等待任务是否都执行完成。

## 函数原型

```
aclError aclrtQueryEventWaitStatus(aclrtEvent event, aclrtEventWaitStatus *status)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 指定待查询的Event。 |
| status | 输出 | Event状态的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

通过[aclrtCreateEventExWithFlag](aclrtCreateEventExWithFlag.md)接口创建的Event，不支持调用本接口。

