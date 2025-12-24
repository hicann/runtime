# acltdtQueueRouteQueryInfoParamType<a name="ZH-CN_TOPIC_0000001312481713"></a>

```
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_MODE_ENUM = 0,  //查询匹配模式，选择该参数类型后，参数值来源于acltdtQueueRouteQueryMode枚举值
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_ID_UINT32,  //指定要查询的源队列ID
    ACL_TDT_QUEUE_ROUTE_QUERY_DST_ID_UINT32   //指定要查询的目标队列ID
} acltdtQueueRouteQueryInfoParamType;
```

