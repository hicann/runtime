# aclrtUpdateTaskAttrId

```
typedef enum { 
    ACL_RT_UPDATE_RANDOM_TASK = 1, 
    ACL_RT_UPDATE_AIC_AIV_TASK,     
} aclrtUpdateTaskAttrId;
```


| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_UPDATE_RANDOM_TASK | 随机数生成任务。<br>不同型号对该任务支持的情况不同：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品支持随机数生成任务<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品支持随机数生成任务 |
| ACL_RT_UPDATE_AIC_AIV_TASK | 在Cube\Vector计算单元上执行的计算任务。 |

