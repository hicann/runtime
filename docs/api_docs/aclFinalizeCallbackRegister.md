# aclFinalizeCallbackRegister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册去初始化回调函数。

在[aclFinalize](aclFinalize.md)接口之前调用本接口，在去初始化时触发回调函数的调用。

## 函数原型

```
aclError aclFinalizeCallbackRegister(aclRegisterCallbackType type, aclFinalizeCallbackFunc cbFunc, void *userData)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| type | 输入 | 注册类型，按照不同的功能区分。 |
| cbFunc | 输入 | 去初始化回调函数。<br>回调函数定义如下：<br>typedef aclError (*aclFinalizeCallbackFunc)(void *userData); |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

