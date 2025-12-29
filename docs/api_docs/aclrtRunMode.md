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
| ACL_DEVICE | AI软件栈运行在Device的Control CPU或板端环境上。<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品，不支持该选项。<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品，不支持该选项。 |
| ACL_HOST | AI软件栈运行在Host CPU上。 |

