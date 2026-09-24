# aclmdlExecConfigAttr

| 参数项 | 含义 |
| --- | --- |
| ACL_MDL_STREAM_SYNC_TIMEOUT = 0 | 在执行模型推理时控制Stream任务的超时时间。该属性值为INT32类型。取值说明如下：<br> -1：表示永久等待，默认永久等待。<br> >0：配置具体的超时时间，单位是毫秒。 |
| ACL_MDL_EVENT_SYNC_TIMEOUT = 1 | 在执行模型推理时控制Event任务的超时时间。该属性值为INT32类型。取值说明如下：<br> -1：表示永久等待，默认永久等待。<br> >0：配置具体的超时时间，单位是毫秒。 |
| ACL_MDL_WORK_ADDR_PTR = 2 | 模型所需工作内存（Device上存放模型执行过程中的临时数据）的指针地址，由用户管理工作内存。一般用于模型一次加载、多并发执行的场景。 |
| ACL_MDL_WORK_SIZET = 3 | 模型所需工作内存的大小，单位为Byte。一般用于模型一次加载、多并发执行的场景。 |
| ACL_MDL_MPAIMID_SIZET = 4 | 预留配置。 |
| ACL_MDL_AICQOS_SIZET = 5 | 预留配置。 |
| ACL_MDL_AICOST_SIZET = 6 | 预留配置。 |
| ACL_MDL_MEC_TIMETHR_SIZET = 7 | 预留配置。 |

<!-- npu="950,A3,910b,910,310p,310b" id7 -->
注意，当前版本仅支持ACL_\MDL\_STREAM\_SYNC\_TIMEOUT和ACL\_MDL\_EVENT\_SYNC\_TIMEOUT。
<!-- end id7 -->