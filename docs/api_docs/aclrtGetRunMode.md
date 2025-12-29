# aclrtGetRunMode

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取当前AI软件栈的运行模式。

## 函数原型

```
aclError aclrtGetRunMode(aclrtRunMode *runMode)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| runMode | 输出 | 运行模式的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

