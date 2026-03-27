# acltdtSetQueueRouteQueryInfo

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Ascend 950PR/Ascend950DT | √ |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

设置路由关系查询条件。

## 函数原型

```
aclError acltdtSetQueueRouteQueryInfo(acltdtQueueRouteQueryInfo *param, acltdtQueueRouteQueryInfoParamType type, size_t len, const void *value)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| param | 输入&输出 | 队列路由关系查询条件的指针。<br>需提前调用[acltdtCreateQueueRouteQueryInfo](acltdtCreateQueueRouteQueryInfo.md)创建acltdtQueueRouteQueryInfo类型的数据。 |
| type | 输入 | 参数类型。类型定义请参见[acltdtQueueRouteQueryInfoParamType](acltdtQueueRouteQueryInfoParamType.md)。 |
| len | 输入 | 参数值的字节数。<br><br>  - 属性参数的类型为*_UINT64时，此处配置为8；<br>  - 属性参数的类型为*_UINT32时，此处配置为4；<br>  - 属性参数的类型为*_PTR时，若操作系统是32位，则此处配置为4；若操作系统是64位，则配置为8。 |
| value | 输入 | 参数值的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

