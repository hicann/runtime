# aclrtGetLastError

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前线程的Runtime（运行时管理模块）错误码，获取后清空当前线程的错误码，这时在线程中无新增错误码之前，调用本接口获取到的是ACL\_SUCCESS。

## 函数原型

```
aclError aclrtGetLastError(aclrtLastErrLevel level)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| level | 输入 | 指定获取错误码的级别，当前仅支持线程级别。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

