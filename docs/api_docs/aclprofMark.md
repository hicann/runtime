# aclprofMark

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

msproftx标记瞬时事件。

调用此接口后，Profiling自动在Stamp指针中加上当前时间戳，将Event type设置为Mark，表示开始一次msproftx采集。

## 函数原型

```
aclError aclprofMark(void *stamp)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stamp | 输入 | Stamp指针，指代msproftx事件标记。<br>指定[aclprofCreateStamp](aclprofCreateStamp.md)接口的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

在[aclprofCreateStamp](aclprofCreateStamp.md)接口和[aclprofDestroyStamp](aclprofDestroyStamp.md)接口之间调用。

