# acltdtGetQueueAttr

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

获取队列属性值。

## 函数原型

```
aclError acltdtGetQueueAttr(const acltdtQueueAttr *attr, acltdtQueueAttrType type, size_t len, size_t *paramRetSize, void *param)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| attr | 输入 | 队列属性配置信息的指针。<br>需提前调用[acltdtCreateQueueAttr](acltdtCreateQueueAttr.md)接口创建acltdtQueueAttr类型的数据。 |
| type | 输入 | 属性类型。 |
| len | 输入 | 属性值的字节数。<br><br>  - 属性参数的类型为*_UINT64时，此处配置为8；<br>  - 属性参数的类型为*_UINT32时，此处配置为4；<br>  - 属性参数的类型为*_PTR时，若操作系统是32位，则此处配置为4；若操作系统是64位，则配置为8。 |
| paramRetSize | 输出 | 实际返回的属性值字节数的指针。 |
| param | 输出 | 指向属性值的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

