# aclrtCreateContext

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在当前进程或线程中显式创建Context。

## 函数原型

```
aclError aclrtCreateContext(aclrtContext *context, int32_t deviceId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| context | 输出 | Context的指针。 |
| deviceId | 输入 | 在指定的Device下创建Context。<br>用户调用[aclrtGetDeviceCount](aclrtGetDeviceCount.md)接口获取可用的Device数量后，这个Device ID的取值范围：[0, (可用的Device数量-1)] |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   若不调用aclrtCreateContext接口显式创建Context，那系统会使用默认Context，该默认Context是在调用[aclrtSetDevice](aclrtSetDevice.md)接口时隐式创建的。
    -   隐式创建Context：适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。
    -   显式创建Context：适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性。

-   在某一进程中指定Device，该进程内的多个线程可共用在此Device上显式创建的Context（调用[aclrtCreateContext](aclrtCreateContext.md)接口显式创建Context）。
-   若在某一进程内创建多个Context（Context的数量与Stream相关，Stream数量有限制，请参见[aclrtCreateStream](aclrtCreateStream.md)），当前线程在同一时刻内只能使用其中一个Context，建议通过[aclrtSetCurrentContext](aclrtSetCurrentContext.md)接口明确指定当前线程的Context，增加程序的可维护性**。**
-   调用本接口创建的Context中包含1个默认Stream。
-   如果在应用程序中没有调用[aclrtSetDevice](aclrtSetDevice.md)接口，那么在首次调用aclrtCreateContext接口时，系统内部会根据该接口传入的Device ID，为该Device绑定一个默认Stream（一个Device仅绑定一个默认Stream），因此在首次调用aclrtCreateContext接口时，占用的Stream数量 = Device上绑定的默认Stream + Context中包含的Stream。

