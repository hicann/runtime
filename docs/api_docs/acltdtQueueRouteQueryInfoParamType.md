# acltdtQueueRouteQueryInfoParamType

```
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM = 0,  //查询匹配模式
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32,  //指定要查询的源队列ID
    ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32   //指定要查询的目标队列ID
} acltdtQueueRouteQueryInfoParamType;
```

选择ACL\_TDT\_QUEUE\_ROUTE\_QUERY\_MODE\_ENUM类型后，参数值来源于[acltdtQueueRouteQueryMode](acltdtQueueRouteQueryMode.md)枚举值。

