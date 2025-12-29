# aclrtCreateStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建Stream。

该接口不支持设置Stream的优先级；若不设置，Stream的优先级默认为最高。如需在创建Stream时设置优先级，请参见[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口。

## 函数原型

```
aclError aclrtCreateStream(aclrtStream *stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输出 | Stream的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   每个Context对应一个默认Stream，该默认Stream是调用[aclrtSetDevice](aclrtSetDevice.md)接口或[aclrtCreateContext](aclrtCreateContext.md)接口隐式创建的，默认Stream的优先级不支持设置，为最高优先级。推荐调用aclrtCreateStream接口显式创建Stream。
    -   隐式创建Stream：适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。
    -   显式创建Stream：**推荐显式**，适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性。

-   Atlas A3 训练系列产品/Atlas A3 推理系列产品、Atlas A2 训练系列产品/Atlas A2 推理系列产品的硬件支持的Stream最大数为1984。如果已存在多个Stream（包含默认Stream、执行内部同步的Stream），则只能显式创建N个Stream，N = Stream最大数 - 已存在的Stream数。例如，Stream最大数为1024，已存在2个Stream，则只能调用本接口显式创建1022个Stream。