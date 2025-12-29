# aclrtGetDeviceIdFromExceptionInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取异常信息中的Device ID。该接口与[aclrtSetExceptionInfoCallback](aclrtSetExceptionInfoCallback.md)接口配合使用。

## 函数原型

```
uint32_t aclrtGetDeviceIdFromExceptionInfo(const aclrtExceptionInfo *info)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| info | 输入 | 异常信息的指针。<br>在执行任务之前调用[aclrtSetExceptionInfoCallback](aclrtSetExceptionInfoCallback.md)接口，系统会将产生异常的任务ID、Stream ID、线程ID、Device ID存放在aclrtExceptionInfo结构体中。 |

## 返回值说明

返回异常信息中的Device ID，返回值为0xFFFFFFFF（以十六进制为例）时表示Device异常。

