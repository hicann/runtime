# acltdtUnbindQueueRoutes

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

解绑定数据队列路由关系。

## 函数原型

```
aclError acltdtUnbindQueueRoutes(acltdtQueueRouteList *qRouteList)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| qRouteList | 输入/输出 | 路由关系数组的指针，接口调用完成后返回路由去绑定结果。<br>可先通过[acltdtQueryQueueRoutes](acltdtQueryQueueRoutes.md)获取路由关系数组。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

只有当所有队列关系解绑定成功，本接口才会返回成功；任何一条解绑定失败，本接口返回失败，如果您需要知道具体哪个路由关系解绑定失败，您可以先调用[acltdtGetQueueRoute](acltdtGetQueueRoute.md)接口从路由关系数组中获取每一个路由关系，再调用[acltdtGetQueueRouteParam](acltdtGetQueueRouteParam.md)接口查询绑定关系状态。

