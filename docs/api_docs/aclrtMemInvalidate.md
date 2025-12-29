# aclrtMemInvalidate

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

将Cache中的数据设置成无效。

该版本不需要用户处理CPU与NPU之间的Cache一致性，无需调用该接口。

## 函数原型

```
aclError aclrtMemInvalidate(void *devPtr, size_t size)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| devPtr | 输入 | 需要将其中Cache数据置为无效的DDR内存起始地址指针。 |
| size | 输入 | DDR内存大小，单位Byte。<br>size不能为0。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

