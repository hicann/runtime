# acltdtGetQueueRouteNum

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

从队列路由配置数组中获取路由数量。

## 函数原型

```
size_t acltdtGetQueueRouteNum(const acltdtQueueRouteList *routeList)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| routeList | 输入 | 队列路由配置数组。<br>需提前调用[acltdtCreateQueueRouteList](acltdtCreateQueueRouteList.md)接口创建acltdtQueueRouteList类型的数据。 |

## 返回值说明

返回路由数量。

