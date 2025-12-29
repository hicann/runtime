# aclrtDestroyStream

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁Stream，销毁通过[aclrtCreateStream](aclrtCreateStream.md)或[aclrtCreateStreamWithConfig](aclrtCreateStreamWithConfig.md)或[aclrtCreateStreamV2](aclrtCreateStreamV2.md)接口创建的Stream，若Stream上有未完成的任务，会等待任务完成后再销毁Stream。

## 函数原型

```
aclError aclrtDestroyStream(aclrtStream stream)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输入 | 待销毁的Stream。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

## 约束说明

-   在调用aclrtDestroyStream接口销毁指定Stream前，需要先调用[aclrtSynchronizeStream](aclrtSynchronizeStream.md)接口确保Stream中的任务都已完成。
-   调用aclrtDestroyStream接口销毁指定Stream时，需确保该Stream在当前Context下。
-   在调用aclrtDestroyStream接口销毁指定Stream时，需确保其它接口没有正在使用该Stream。

