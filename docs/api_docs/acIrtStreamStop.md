# acIrtStreamStop

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

仅停止指定Stream上的正在执行的任务，不清理任务。

## 函数原型

```
aclError aclrtStreamStop(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定待停止任务的Stream。类型定义请参见[aclrtStream](aclrtStream.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   不支持使用[aclmdlRIBindStream](aclmdlRIBindStream.md)接口来绑定模型运行实例的Stream。
-   不支持默认Stream（即stream参数传入NULL）。
-   对于Atlas A2 训练系列产品/Atlas A2 推理系列产品、Atlas A3 训练系列产品/Atlas A3 推理系列产品，该接口仅支持如下方式创建的Stream：调用[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口，将flag设置为ACL\_STREAM\_DEVICE\_USE\_ONLY（表示该Stream仅在Device上调用）。

