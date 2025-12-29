# aclrtRegStreamStateCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册Stream状态回调函数，不支持重复注册。

当Stream状态发生变化时（例如调用[aclrtCreateStream](aclrtCreateStream.md)、[aclrtDestroyStream](aclrtDestroyStream.md)等接口），Runtime模块会触发该回调函数的调用。此处的Stream包含显式创建的Stream以及默认Stream。

## 函数原型

```
aclError aclrtRegStreamStateCallback(const char *regName, aclrtStreamStateCallback callback, void *args)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| regName | 输入 | 注册唯一名称，不能为空，输入保证字符串以\0结尾。 |
| callback | 输入 | 回调函数。若callback不为NULL，则表示注册回调函数；若为NULL，则表示取消注册回调函数。<br>回调函数的函数原型为：<br>typedef enum {<br>   ACL_RT_STREAM_STATE_CREATE_POST = 1,  // 调用create接口（例如aclrtCreateStream）之后<br>   ACL_RT_STREAM_STATE_DESTROY_PRE,  // 调用destroy接口（例如aclrtDestroyStream）之前<br>} aclrtStreamState;<br>typedef void (*aclrtStreamStateCallback)(aclrtStream stm, aclrtStreamState state, void *args); |
| args | 输入 | 待传递给回调函数的用户数据的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

