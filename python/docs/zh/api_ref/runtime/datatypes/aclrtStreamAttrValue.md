# aclrtStreamAttrValue

| 成员名称 | 说明 |
| --- | --- |
| failureMode | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_FAILURE_MODE（表示Stream的任务调度模式）属性时，属性值的取值如下：<br>- 0：某个任务失败后，继续执行下一个任务。默认值为0。<br>- 1：某个任务失败后，停止执行后续的任务，通常称作遇错即停。触发遇错即停之后，不支持再下发新任务。当Stream上设置了遇错即停模式，该Stream所在的Context下的其它Stream也是遇错即停。 |
| overflowSwitch | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_FLOAT_OVERFLOW_CHECK（表示溢出检测开关）属性时，属性值的取值如下：<br>- 0：关闭溢出检测。默认值为0。<br>- 1：打开溢出检测。 |
| userCustomTag | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_USER_CUSTOM_TAG（表示溢出检测分组标签）属性时，属性值的取值范围：0~uint32_t类型的最大值。 |
| streamPriority | 设置aclrtStreamAttr中的ACL_STREAM_ATTR_PRIORITY（表示stream优先级）属性时，属性值取值范围：[0, 7]，数字越小代表优先级越高，默认值为0。 |
| reserve | 预留值。 |
