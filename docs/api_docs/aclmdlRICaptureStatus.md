# aclmdlRICaptureStatus<a name="ZH-CN_TOPIC_0000002222021281"></a>

```
typedef enum {
    ACL_MODEL_RI_CAPTURE_STATUS_NONE = 0,    // Stream不在捕获状态
    ACL_MODEL_RI_CAPTURE_STATUS_ACTIVE,      // Stream处于正常捕获状态
    ACL_MODEL_RI_CAPTURE_STATUS_INVALIDATED, // 捕获失败状态
} aclmdlRICaptureStatus;
```

