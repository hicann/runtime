# aclprofGetOpEnd

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取算子执行的结束时间，单位为ns。

建议用户新建一个线程，在新线程内调用该接口，否则可能阻塞主线程中的其它任务调度。

## 函数原型

```
uint64_t aclprofGetOpEnd(const void *opInfo, size_t opInfoLen, uint32_t index)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| opInfo | 输入 | 包含算子信息的地址。 |
| opInfoLen | 输入 | 算子信息的长度。 |
| index | 输入 | 指定获取第几个算子执行的结束时间。<br>用户调用[aclprofGetOpNum](aclprofGetOpNum.md)接口获取算子数量后，这个index的取值范围：[0, (算子数量-1)]。 |

## 返回值说明

算子执行结束时间。

