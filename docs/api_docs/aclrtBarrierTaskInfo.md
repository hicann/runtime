# aclrtBarrierTaskInfo

```
typedef struct { 
    size_t barrierNum;   
    aclrtBarrierCmoInfo cmoInfo[ACL_RT_CMO_MAX_BARRIER_NUM]; 
} aclrtBarrierTaskInfo;
```


| 成员名称 | 说明 |
| --- | --- |
| barrierNum | cmoInfo数组的长度。 |
| cmoInfo | Cache内存操作的任务信息。类型定义请参见[aclrtBarrierCmoInfo](aclrtBarrierCmoInfo.md)。<br>#define ACL_RT_CMO_MAX_BARRIER_NUM 6U |

