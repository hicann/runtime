# aclrtCreateStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建Stream。

该接口不支持设置Stream的优先级；若不设置，Stream的优先级默认为最高。如需在创建Stream时设置优先级，请参见[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)接口。

若不显式调用Stream创建接口，那么每个Context对应一个默认Stream，该默认Stream是调用[aclrtSetDevice](aclrtSetDevice.md)接口或[aclrtCreateContext](aclrtCreateContext.md)接口隐式创建的，默认Stream的优先级不支持设置，为最高优先级。默认Stream适合简单、无复杂交互逻辑的应用，但缺点在于，在多线程编程中，执行结果取决于线程调度的顺序。显式创建的Stream适合大型、复杂交互逻辑的应用，且便于提高程序的可读性、可维护性，**推荐显式**。

## 函数原型

```
aclError aclrtCreateStream(aclrtStream *stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输出 | Stream的指针。类型定义请参见[aclrtStream](aclrtStream.md)。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

不同型号的硬件支持的Stream最大数不同，如果已存在多个Stream（包含默认Stream、执行内部同步的Stream），则只能显式创建N个Stream，N = Stream最大数 - 已存在的Stream数。


| 型号 | Stream最大数 |
| --- | --- |
| Ascend 950PR/Ascend950DT<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 | 1984 |

