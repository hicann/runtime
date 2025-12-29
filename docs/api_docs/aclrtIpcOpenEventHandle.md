# aclrtIpcOpenEventHandle

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在本进程中获取handle的信息，并返回本进程可以使用的Event指针。

本接口需与其它接口配合使用，以便实现不同进程间的任务同步，请参见[aclrtIpcGetEventHandle](aclrtIpcGetEventHandle.md)接口处的说明。

## 函数原型

```
aclError aclrtIpcOpenEventHandle(aclrtIpcEventHandle handle, aclrtEvent *event)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输入 | Event句柄。<br>必须先调用[aclrtIpcGetEventHandle](aclrtIpcGetEventHandle.md)接口获取指定Event的句柄，再作为入参传入。 |
| event | 输出 | Event指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

