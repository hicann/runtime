# aclrtFreeHostWithDevSync

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

释放Host内存。

本接口内部会进行隐式的Device同步，并等待使用该内存的任务完成。

## 函数原型

```
aclError aclrtFreeHostWithDevSync(void *hostPtr)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| hostPtr | 输入 | 待释放内存的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

