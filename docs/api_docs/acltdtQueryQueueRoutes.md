# acltdtQueryQueueRoutes

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

根据指定条件查询数据队列路由关系。

## 函数原型

```
aclError acltdtQueryQueueRoutes(const acltdtQueueRouteQueryInfo *queryInfo, acltdtQueueRouteList *qRouteList)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| queryInfo | 输入 | 查询条件的指针。<br>需提前调用[acltdtCreateQueueRouteQueryInfo](acltdtCreateQueueRouteQueryInfo.md)接口创建acltdtQueueRouteQueryInfo类型的数据。 |
| qRouteList | 输入&输出 | 路由关系数组的指针。<br>需提前调用[acltdtCreateQueueRouteList](acltdtCreateQueueRouteList.md)接口创建acltdtQueueRouteList类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

