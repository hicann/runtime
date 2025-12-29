# aclrtProcessHostFunc

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

等待指定时间后，触发回调处理，由[aclrtSubscribeHostFunc](aclrtSubscribeHostFunc.md)接口指定的线程处理回调。

线程需由用户提前自行创建，并自定义线程函数，在线程函数内调用本接口，等待指定时间后通过系统内部进行算子计算。

## 函数原型

```
aclError aclrtProcessHostFunc(int32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 超时时间，单位为ms。<br>取值范围：<br><br>  - -1：表示无限等待<br>  - 大于0（不包含0）：表示等待的时间 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

