# aclprofGetOpTypeLen

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取算子类型的字符串长度，用于内存申请。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

## 函数原型

```
aclError aclprofGetOpTypeLen(const void *opInfo, size_t opInfoLen, uint32_t index, size_t *opTypeLen)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子的算子类型名称。<br>用户调用[aclprofGetOpNum](aclprofGetOpNum.md)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |
| opTypeLen | 输出 | opType的长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

