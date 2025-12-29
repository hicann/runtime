# aclrtCreateStreamV2

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

创建Stream，支持创建Stream时增加Stream配置。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1.  调用[aclrtCreateStreamConfigHandle](aclrtCreateStreamConfigHandle.md)接口创建Stream配置对象。
2.  多次调用[aclrtSetStreamConfigOpt](aclrtSetStreamConfigOpt.md)接口设置配置对象中每个属性的值。
3.  调用aclrtCreateStreamV2接口创建Stream。
4.  Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](aclrtDestroyStreamConfigHandle.md)接口销毁Stream配置对象，调用[aclrtDestroyStream](aclrtDestroyStream.md)接口销毁Stream。

## 函数原型

```
aclError aclrtCreateStreamV2(aclrtStream *stream, const aclrtStreamConfigHandle *handle)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| stream | 输出 | Stream的指针。 |
| handle | 输入 | Stream配置对象的指针。与[aclrtSetStreamConfigOpt](aclrtSetStreamConfigOpt.md)中的handle保持一致。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

