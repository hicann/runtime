# aclrtStreamAttrValue

```
typedef union {
    uint64_t failureMode;
    uint32_t overflowSwitch; 
    uint32_t userCustomTag; 
    uint32_t cacheOpInfoSwitch;
    uint32_t reserve[4];
} aclrtStreamAttrValue;
```


| 成员名称 | 说明 |
| --- | --- |
| failureMode | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_FAILURE_MODE（表示Stream的任务调度模式）属性时，属性值的取值如下：<br><br>  - 0：某个任务失败后，继续执行下一个任务。默认值为0。<br>  - 1：某个任务失败后，停止执行后续的任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停 。该约束适用于以下产品型号：<br>Atlas A3 训练系列产品/Atlas A3 推理系列产品<br>Atlas A2 训练系列产品/Atlas A2 推理系列产品 |
| overflowSwitch | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK（表示溢出检测开关）属性时，属性值的取值如下：<br><br>  - 0：关闭溢出检测。默认值为0。<br>  - 1：打开溢出检测。 |
| userCustomTag | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_USER_CUSTOM_TAG（表示溢出检测分组标签）属性时，属性值的取值范围：0~uint32_t类型的最大值。 |
| cacheOpInfoSwitch | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_CACHE_OP_INFO （表示算子信息缓存开关）属性时，属性值的取值如下：<br><br>  - 0：关闭算子信息缓存开关。默认值为0。<br>  - 1：开启算子信息缓存开关。 |
| reserve | 预留值。 |

