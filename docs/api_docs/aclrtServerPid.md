# aclrtServerPid

```
typedef struct {
    uint32_t sdid; 
    int32_t *pid;  
    size_t num; 
} aclrtServerPid;
```


| 成员名称 | 说明 |
| --- | --- |
| sdid | 针对Atlas A3 训练系列产品/Atlas A3 推理系列产品中的超节点产品，sdid（SuperPOD Device ID）表示超节点产品中的Device唯一标识，可提前调用[aclGetDeviceInfo](aclrtGetDeviceInfo.md)接口获取。 |
| pid | Host侧进程ID白名单数组。 |
| num | pid数组长度。 |

