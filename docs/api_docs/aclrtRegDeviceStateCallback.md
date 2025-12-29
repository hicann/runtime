# aclrtRegDeviceStateCallback

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

注册Device状态回调函数，不支持重复注册。

当Device状态发生变化时（例如调用[aclrtSetDevice](aclrtSetDevice.md)、[aclrtResetDevice](aclrtResetDevice.md)等接口），Runtime模块会触发该回调函数的调用。

## 函数原型

```
aclError aclrtRegDeviceStateCallback(const char *regName, aclrtDeviceStateCallback callback, void *args)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| regName | 输入 | 注册名称，保持唯一，不能为空，输入保证字符串以\0结尾。 |
| callback | 输入 | 回调函数。若callback不为NULL，则表示注册回调函数；若为NULL，则表示取消注册回调函数。<br>回调函数的函数原型为：<br>typedef enum {<br>   ACL_RT_DEVICE_STATE_SET_PRE = 0, // 调用set接口之前（例如aclrtSetDevice）之后<br>   ACL_RT_DEVICE_STATE_SET_POST,  // 调用set接口之后（例如aclrtSetDevice）之后<br>   ACL_RT_DEVICE_STATE_RESET_PRE,  // 调用reset接口之前（例如aclrtResetDevice）之前<br>   ACL_RT_DEVICE_STATE_RESET_POST, // 调用reset接口之后（例如aclrtResetDevice）之前<br>} aclrtDeviceState;<br>typedef void (*aclrtDeviceStateCallback)(uint32_t devId, aclrtDeviceState state, void *args); |
| args | 输入 | 待传递给回调函数的用户数据的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

