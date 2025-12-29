# aclrtGetCurrentContext

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取线程的Context。

如果用户多次调用[aclrtSetCurrentContext](aclrtSetCurrentContext.md)接口设置当前线程的Context，则获取的是最后一次设置的Context。

## 函数原型

```
aclError aclrtGetCurrentContext(aclrtContext *context)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| context | 输出 | 线程当前Context的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

