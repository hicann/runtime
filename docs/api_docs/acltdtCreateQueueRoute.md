# acltdtCreateQueueRoute

## 产品支持情况


| 产品 | 是否支持 |
| --- | --- |
| Atlas A3 训练系列产品/Atlas A3 推理系列产品 | √ |
| Atlas A2 训练系列产品/Atlas A2 推理系列产品 | √ |

## 功能说明

创建acltdtQueueRoute类型的数据，表示创建队列路由配置。

## 函数原型

```
acltdtQueueRoute* acltdtCreateQueueRoute(uint32_t srcId, uint32_t dstId)
```

## 参数说明


| 参数名 | 输入/输出 | 说明 |
| --- | --- | --- |
| srcId | 输入 | 源队列ID。 |
| dstId | 输入 | 目的队列ID。 |

## 返回值说明

-   返回acltdtQueueRoute类型的指针，表示成功。
-   返回nullptr，表示失败。

