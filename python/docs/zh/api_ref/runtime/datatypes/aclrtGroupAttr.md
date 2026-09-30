# aclrtGroupAttr

<!-- npu="310b" id1 -->
Atlas 200I/500 A2推理产品，不支持该枚举值。
<!-- end id1 -->

<!-- npu="910" id2 -->
Atlas训练系列产品，不支持该枚举值。
<!-- end id2 -->

<!-- npu="910b" id3 -->
Atlas A2系列产品，不支持该枚举值。
<!-- end id3 -->

<!-- npu="A3" id4 -->
Atlas A3系列产品，不支持该枚举值。
<!-- end id4 -->

<!-- npu="310p" id5 -->
在Atlas推理系列产品的Control CPU开放形态下，仅支持配置ACL\_GROUP\_AICORE\_INT、ACL\_GROUP\_GROUPID\_INT。
<!-- end id5 -->

| 数据格式 | 说明 |
| --- | --- |
| ACL_GROUP_AICORE_INT= 0 | 指定Group对应的aicore个数，属性值的数据类型为整型。 |
| ACL_GROUP_AIV_INT = 1 | 指定Group对应的vector core个数，属性值的数据类型为整型。 |
| ACL_GROUP_AIC_INT = 2 | 指定Group对应的aicpu线程数，属性值的数据类型为整型。 |
| ACL_GROUP_SDMANUM_INT = 3 | 内存异步拷贝的通道数，属性值的数据类型为整型。 |
| ACL_GROUP_SDMANUM_INT = 4 | 指定Group下可以被同时调度执行的Stream个数，小于或等于32，当前系统级最大一共可以同时调度32个Stream。属性值的数据类型为整型。 |
| ACL_GROUP_GROUPID_INT = 5 | 指定Group的ID。属性值的数据类型为整型。 |
