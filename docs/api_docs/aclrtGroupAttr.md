# aclrtGroupAttr<a name="ZH-CN_TOPIC_0000001265400386"></a>

```
typedef enum aclrtGroupAttr
{
    ACL_GROUP_AICORE_INT,     //指定Group对应的AI Core个数，属性值的数据类型为整型。
    ACL_GROUP_AIV_INT,       //指定Group对应的Vector Core个数，属性值的数据类型为整型。
    ACL_GROUP_AIC_INT,       //指定Group对应的AI CPU线程数，属性值的数据类型为整型。
    ACL_GROUP_SDMANUM_INT,   //内存异步拷贝的通道数，属性值的数据类型为整型。
    ACL_GROUP_ASQNUM_INT,    //指定Group下可以被同时调度执行的Stream个数，小于或等于32，当前系统级最大一共可以同时调度32个Stream。属性值的数据类型为整型。
    ACL_GROUP_GROUPID_INT    //指定Group的ID。属性值的数据类型为整型。
} aclrtGroupAttr;
```

