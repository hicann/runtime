# aclrtLaunchKernelCfg

## 说明

任务下发的配置信息。

## 定义

```python
cfg= [{"id": attr_id, "value": attr_value}]
```

说明：cfg中可同时包含多个dict，每个dict中包含一对id和value。

## 成员

| 成员名称 | 说明 |
| --- | --- |
| attr_id | int，属性id，取值参考[aclrtLaunchKernelAttrId](aclrtLaunchKernelAttrId-aclrtLaunchKernelAttrValue.md)。 |
| attr_value | int，属性值，取值参考[aclrtLaunchKernelAttrValue](aclrtLaunchKernelAttrId-aclrtLaunchKernelAttrValue.md)。 |

说明：attr\_id和attr\_value配对使用，attr\_value随着attr\_id的取值来配置不同的值。
