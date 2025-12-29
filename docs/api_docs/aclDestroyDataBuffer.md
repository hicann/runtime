# aclDestroyDataBuffer

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

销毁通过[aclCreateDataBuffer](aclCreateDataBuffer.md)接口创建的aclDataBuffer类型的数据。

此处仅销毁aclDataBuffer类型的数据，调用[aclCreateDataBuffer](aclCreateDataBuffer.md)接口创建aclDataBuffer类型数据时传入的data的内存需由用户自行释放。

## 函数原型

```
aclError aclDestroyDataBuffer(const aclDataBuffer *dataBuffer)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| dataBuffer | 输入 | 待销毁的aclDataBuffer类型的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

