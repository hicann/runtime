# aclrtMemcpy

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

实现内存复制。

## 函数原型

```
aclError aclrtMemcpy(void *dst, size_t destMax, const void *src, size_t count, aclrtMemcpyKind kind)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dst | 输入 | 目的内存地址指针。 |
| destMax | 输入 | 目的内存地址的最大内存长度，单位Byte。 |
| src | 输入 | 源内存地址指针。 |
| count | 输入 | 内存复制的长度，单位Byte。 |
| kind | 输入 | 内存复制的类型，预留参数，配置枚举值中的值无效，系统内部会根据源内存地址指针、目的内存地址指针判断是否可以将源地址的数据复制到目的地址，如果不可以，则系统会返回报错。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   本接口会立刻进行内存复制，函数内部不会进行隐式的device同步或流同步。
-   如果执行两个Device间的内存复制，需先调用[aclrtDeviceCanAccessPeer](aclrtDeviceCanAccessPeer.md)接口查询两个Device间是否支持数据交互、调用[aclrtDeviceEnablePeerAccess](aclrtDeviceEnablePeerAccess.md)接口开启两个Device间的数据交互功能，再调用本接口进行内存复制。

    **该约束适用以下型号：**

    Atlas A2 训练系列产品/Atlas A2 推理系列产品

