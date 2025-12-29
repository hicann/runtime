# acltdtGetQueueRoute

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

从队列路由配置数组中获取指定的队列路由配置信息。

## 函数原型

```
aclError acltdtGetQueueRoute(const acltdtQueueRouteList *routeList, size_t index, acltdtQueueRoute *route)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| routeList | 输入 | 队列路由配置数组。<br>需提前调用[acltdtCreateQueueRouteList](acltdtCreateQueueRouteList.md)接口创建acltdtQueueRouteList类型的数据。 |
| index | 输入 | 指定获取哪一个队列路由配置信息，index编号从0开始。 |
| route | 输入&输出 | 需添加的队列路由配置信息的指针。 |

## 返回值说明

返回0表示成功，返回其他值表示失败，请参见[aclError](aclError.md)。

