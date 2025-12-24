# acltdtQueueRouteQueryMode<a name="ZH-CN_TOPIC_0000001265400718"></a>

```
typedef enum {
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC = 0,         //指定为只根据源队列ID匹配查询
    ACL_TDT_QUEUE_ROUTE_QUERY_DST = 1,         //指定为只根据目标队列ID匹配查询
    ACL_TDT_QUEUE_ROUTE_QUERY_SRC_AND_DST = 2  //指定为同时根据源、目标队列ID匹配查询
} acltdtQueueRouteQueryMode;
```

