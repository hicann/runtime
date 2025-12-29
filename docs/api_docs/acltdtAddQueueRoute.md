# acltdtAddQueueRoute

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

向队列路由配置数组中添加队列路由配置信息。

## 函数原型

```
aclError acltdtAddQueueRoute(acltdtQueueRouteList *routeList, const acltdtQueueRoute *route)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| routeList | 输入&输出 | 队列路由配置数组。<br>需提前调用[acltdtCreateQueueRouteList](acltdtCreateQueueRouteList.md)接口创建acltdtQueueRouteList类型的数据。 |
| route | 输入 | 需添加的队列路由配置信息的指针。<br>需提前调用[acltdtCreateQueueRoute](acltdtCreateQueueRoute.md)接口创建acltdtQueueRoute类型的数据。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

