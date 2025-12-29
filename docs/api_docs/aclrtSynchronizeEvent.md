# aclrtSynchronizeEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

阻塞当前线程运行直到Event捕获的所有任务都执行完成。具体见[aclrtRecordEvent](aclrtRecordEvent.md)接口参考Event捕获的细节。

## 函数原型

```
aclError aclrtSynchronizeEvent(aclrtEvent event)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输入 | 需等待的Event。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

