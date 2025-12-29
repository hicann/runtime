# aclrtDestroyContext

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁Context，释放Context的资源。只能销毁通过[aclrtCreateContext](aclrtCreateContext.md)接口创建的Context。

## 函数原型

```
aclError aclrtDestroyContext(aclrtContext context)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| context | 输入 | 需销毁的Context。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

