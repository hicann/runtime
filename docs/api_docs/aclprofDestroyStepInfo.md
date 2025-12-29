# aclprofDestroyStepInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁通过[aclprofCreateStepInfo](aclprofCreateStepInfo.md)接口创建的aclprofStepInfo类型的数据。

## 约束说明

-   与[aclprofCreateStepInfo](aclprofCreateStepInfo.md)接口配对使用，先调用aclprofCreateStepInfo接口再调用aclprofDestroyStepInfo接口。
-   同一aclprofStepInfo数据重复调用aclprofDestroyStepInfo接口，会出现重复释放内存的报错。

## 函数原型

```
void aclprofDestroyStepInfo(aclprofStepInfo* stepinfo)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stepinfo | 输入 | 指定迭代信息。需提前调用[aclprofCreateStepInfo](aclprofCreateStepInfo.md)接口创建[aclprofStepInfo](aclprofStepInfo.md)类型的数据。 |

