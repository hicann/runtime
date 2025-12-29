# aclprofDestroyConfig

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁通过[aclprofCreateConfig](aclprofCreateConfig.md)接口创建的aclprofConfig类型的数据。

## 约束说明

-   与[aclprofCreateConfig](aclprofCreateConfig.md)接口配对使用，先调用aclprofCreateConfig接口再调用aclprofDestroyConfig接口。
-   同一aclprofConfig指针重复调用aclprofDestroyConfig接口，会出现重复释放内存的报错。

## 函数原型

```
aclError aclprofDestroyConfig(const aclprofConfig *profilerConfig)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| profilerConfig | 输入 | 待销毁的aclprofConfig类型的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

