# aclrtCreateEvent

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建Event，创建出来的Event可用于统计两个Event之间的耗时、多Stream场景下的同步等待等场景。

## 函数原型

```
aclError aclrtCreateEvent(aclrtEvent *event)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| event | 输出 | Event的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   采用本API创建的Event不支持在[aclrtResetEvent](aclrtResetEvent.md)接口中使用，否则会导致未定义的行为。
-   调用本接口创建Event后，后续调用[aclrtRecordEvent](aclrtRecordEvent.md)接口时，系统内部才会申请Event资源，因此会受Event数量的限制，Event达到上限后，系统内部会等待资源释放。

    不同型号的硬件支持的Event数量不同，如下表所示：

    
    | 型号 | 单个Device支持的Event最大数 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 65536 |

