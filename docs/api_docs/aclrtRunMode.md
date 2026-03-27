# aclrtRunMode

```
typedef enum aclrtRunMode {
    ACL_DEVICE,
    ACL_HOST,
} aclrtRunMode;
```

**表 1**  枚举项说明


| 枚举项 | 说明 |
| --- | --- |
| ACL_DEVICE | AI软件栈运行在Device的Control CPU或板端环境上。<br>不支持配置该选项。 |
| ACL_HOST | AI软件栈运行在Host CPU上。 |

