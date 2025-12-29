# aclFloatToFloat16

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将float（指float32）类型的数据转换为[aclFloat16](aclFloat16.md)类型的数据。

## 函数原型

```
aclFloat16 aclFloatToFloat16(float value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| value | 输入 | 待转换的数据。 |

## 返回值说明

转换后的数据。

**注意**，由于C语言无float16类型，此处返回值使用uint16\_t对数据进行存储。若用户需要打印，需自行将uint16\_t解释成float16进行打印，或者转成float进行打印。

