# aclCANNPackageName<a name="ZH-CN_TOPIC_0000002195073950"></a>

设置为ACL\_PKG\_NAME\_CANN，表示查询CANN的版本号；设置为其它值，表示查询CANN中具体某个模块的版本号。

```
typedef enum aclCANNPackageName {
    ACL_PKG_NAME_CANN, 
    ACL_PKG_NAME_RUNTIME,
    ACL_PKG_NAME_COMPILER,
    ACL_PKG_NAME_HCCL,
    ACL_PKG_NAME_TOOLKIT,
    ACL_PKG_NAME_OPP,
    ACL_PKG_NAME_OPP_KERNEL,
    ACL_PKG_NAME_DRIVER
} aclCANNPackageName;
```

