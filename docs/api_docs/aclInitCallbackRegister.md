# aclInitCallbackRegister

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册初始化回调函数。

若在[aclInit](aclInit.md)接口之前调用本接口，则会在初始化时触发回调函数的调用；若在[aclInit](aclInit.md)接口之后调用本接口，则会在注册时立即触发回调函数的调用。

## 函数原型

```
aclError aclInitCallbackRegister(aclRegisterCallbackType type, aclInitCallbackFunc cbFunc, void *userData)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| type | 输入 | 注册类型，按照不同的功能区分。 |
| cbFunc | 输入 | 初始化回调函数。<br>回调函数的函数原型为：<br>typedef aclError (*aclInitCallbackFunc)(const char *configStr, size_t len, void *userData);<br>configStr跟aclInit接口中的json文件内容保持一致；len表示json文件内容的长度，单位Byte。 |
| userData | 输入 | 待传递给回调函数的用户数据的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

