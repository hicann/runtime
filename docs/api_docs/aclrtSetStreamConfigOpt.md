# aclrtSetStreamConfigOpt

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | ☓ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | ☓ |

## 功能说明

设置Stream配置对象中的各属性的取值。

本接口需要配合其它接口一起使用，创建Stream，接口调用顺序如下：

1.  调用[aclrtCreateStreamConfigHandle](aclrtCreateStreamConfigHandle.md)接口创建Stream配置对象。
2.  多次调用aclrtSetStreamConfigOpt接口设置配置对象中每个属性的值。
3.  调用[aclrtCreateStreamV2](aclrtCreateStreamV2.md)接口创建Stream。
4.  Stream使用完成后，调用[aclrtDestroyStreamConfigHandle](aclrtDestroyStreamConfigHandle.md)接口销毁Stream配置对象，调用[aclrtDestroyStream](aclrtDestroyStream.md)接口销毁Stream。

## 函数原型

```
aclError aclrtSetStreamConfigOpt(aclrtStreamConfigHandle *handle, aclrtStreamConfigAttr attr, const void *attrValue, size_t valueSize)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| handle | 输出 | Stream配置对象的指针。需提前调用[aclrtCreateStreamConfigHandle](aclrtCreateStreamConfigHandle.md)接口创建该对象。 |
| attr | 输入 | 指定需设置的属性。 |
| attrValue | 输入 | 指向属性值的指针，attr对应的属性取值。<br>如果属性值本身是指针，则传入该指针的地址。 |
| valueSize | 输入 | attrValue部分的数据长度。<br>用户可使用C/C++标准库的函数sizeof(*attrValue)查询数据长度。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

