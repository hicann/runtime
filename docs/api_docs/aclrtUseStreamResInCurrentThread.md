# aclrtUseStreamResInCurrentThread

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

在当前线程中使用指定Stream上的Device资源限制。如果多次调用本接口设置Stream，将以最后一次设置为准。

## 函数原型

```
aclError aclrtUseStreamResInCurrentThread(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 指定Stream。<br>需先调用[aclrtSetStreamResLimit](aclrtSetStreamResLimit.md)接口设置该Stream上的Device资源限制。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

