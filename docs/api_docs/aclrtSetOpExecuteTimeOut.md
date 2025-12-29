# aclrtSetOpExecuteTimeOut

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置算子执行的超时时间，单位为秒。

对于以下产品型号，建议使用aclrtSetOpExecuteTimeOutV2接口，该接口会返回实际生效的超时时间：

Atlas A3 训练系列产品/Atlas A3 推理系列产品

Atlas A2 训练系列产品/Atlas A2 推理系列产品

## 函数原型

```
aclError aclrtSetOpExecuteTimeOut(uint32_t timeout)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| timeout | 输入 | 设置超时时间，单位为秒。<br>将该参数设置为0时，表示使用最大超时时间。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   一个进程内多次调用本接口，则以最后一次设置的时间为准。
-   不调用本接口，算子的默认超时时间如下：
    在Atlas A3 训练系列产品/Atlas A3 推理系列产品上，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为60秒。
    在Atlas A2 训练系列产品/Atlas A2 推理系列产品上，AI Core算子的默认超时时间为1091秒，AI CPU算子的默认超时时间为28秒。

-   在Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品上，算子的最大超时时间为：interval \* 254，单位是微秒，interval可通过aclrtGetOpTimeoutInterval接口获取。AI Core算子和AI CPU算子的interval相同，因此算子的最大超时时间都为interval \* 254。

    ​    

