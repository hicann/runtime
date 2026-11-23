# aclrtPtrAttributes

| 成员名称 | 说明 |
| --- | --- |
| location | dict，内存所在位置，具体请参见[aclrtMemLocation](aclrtMemLocation.md)。<br>当type为ACL_MEM_LOCATION_TYPE_HOST时，id无效。 |
| page_size | int，页表大小，单位为字节。 |
| host_ptr | int，Host 侧内存地址。C 接口返回空指针时，该值为 `0`。 |
| device_ptr | int，Device 侧内存地址。C 接口返回空指针时，该值为 `0`。 |
