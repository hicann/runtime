# aclmdlRICaptureMode

```
typedef enum {
    ACL_MODEL_RI_CAPTURE_MODE_GLOBAL = 0,   // 全局禁止，所有线程都不可以调用非安全函数
    ACL_MODEL_RI_CAPTURE_MODE_THREAD_LOCAL, // 当前线程禁止调用非安全函数
    ACL_MODEL_RI_CAPTURE_MODE_RELAXED,      // 全局不禁止，所有线程都可以调用非安全函数
} aclmdlRICaptureMode;
```

