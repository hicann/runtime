# aclrtGetGroupCount

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

查询当前Context下可以使用的Group个数。

## 函数原型

```
aclError  aclrtGetGroupCount(uint32_t *count)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| count | 输出 | 当前Context下可用Group个数的指针。 |

