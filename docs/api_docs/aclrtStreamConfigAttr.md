# aclrtStreamConfigAttr

```
typedef enum {
    ACL_RT_STREAM_WORK_ADDR_PTR = 0, 
    ACL_RT_STREAM_WORK_SIZE, 
    ACL_RT_STREAM_FLAG,
    ACL_RT_STREAM_PRIORITY,
} aclrtStreamConfigAttr;
```

**表 1**  枚举项说明


| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_STREAM_WORK_ADDR_PTR | 某一个Stream上的模型所需工作内存（Device上存放模型执行过程中的临时数据）的指针，由用户管理工作内存。该配置主要用于多模型在同一个Stream上串行执行时想共享工作内存的场景，此时需按多个模型中最大的工作内存来申请内存，可提前使用aclmdlQuerySize查询各模型所需的工作内存大小。<br>如果同时配置ACL_RT_STREAM_WORK_ADDR_PTR以及aclmdlExecConfigAttr中的ACL_MDL_WORK_ADDR_PTR（表示某个模型的工作内存），则以aclmdlExecConfigAttr中的ACL_MDL_WORK_ADDR_PTR优先。 |
| ACL_RT_STREAM_WORK_SIZE | 模型所需工作内存的大小，单位为Byte。 |
| ACL_RT_STREAM_FLAG | 预留配置，默认值为0。 |
| ACL_RT_STREAM_PRIORITY | Stream的优先级，数字越小优先级越高，取值[0,7]。默认值为0。 |

