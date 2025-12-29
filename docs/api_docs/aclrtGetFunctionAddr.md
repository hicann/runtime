# aclrtGetFunctionAddr

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据核函数句柄获取Device侧算子起始地址。

不同产品上的AI数据处理核心单元不同，关于Core的定义及详细说明，请参见[aclrtDevAttr](aclrtDevAttr.md)。

## 函数原型

```
aclError aclrtGetFunctionAddr(aclrtFuncHandle funcHandle, void **aicAddr, void **aivAddr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| funcHandle | 输入 | 核函数句柄。 |
| aicAddr | 输出 | AI Core或Cube Core上的算子起始地址。<br><br>  - 对于以下产品，此处返回的是Cube Core上的算子起始地址。Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| aivAddr | 输出 | Vector Core上的算子起始地址。<br>若通过本接口获取到aivAddr为空，则表示该算子不在Vector Core上执行。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

