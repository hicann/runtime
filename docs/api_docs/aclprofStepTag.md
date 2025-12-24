# aclprofStepTag<a name="ZH-CN_TOPIC_0000001265241378"></a>

```
typedef enum{
    ACL_STEP_START = 0, // step  start
    ACL_STEP_END = 1    // step  end
} aclprofStepTag
```

>![](public_sys-resources/icon-note.gif) **说明：** 
>同一个[aclprofStepInfo](aclprofStepInfo.md)对象、同一个tag只能设置一次，否则Profiling解析会出错。

