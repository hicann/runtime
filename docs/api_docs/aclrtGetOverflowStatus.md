# aclrtGetOverflowStatus

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前Device下所有Stream上任务的溢出状态，并将状态值拷贝到用户申请的Device内存中。异步接口。

## 函数原型

```
aclError aclrtGetOverflowStatus(void *outputAddr, size_t outputSize, aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| outputAddr | 输入&输出 | 用户申请的Device内存，例如通过aclrtMalloc接口申请。 |
| outputSize | 输入 | 需申请的Device内存大小，单位Byte，固定大小为64Byte。 |
| stream | 输入 | 指定Stream，用于下发溢出状态查询任务。类型定义请参见[aclrtStream](aclrtStream.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

对于以下产品型号，调用本接口查询出来的溢出状态是进程级别的：

-   Ascend 950PR/Ascend950DT
-   Atlas A3 训练系列产品/Atlas A3 推理系列产品
-   Atlas A2 训练系列产品/Atlas A2 推理系列产品

