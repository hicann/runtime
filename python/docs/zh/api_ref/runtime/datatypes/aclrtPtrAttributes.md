# aclrtPtrAttributes

| 成员名称 | 说明 |
| --- | --- |
| location | dict，内存所在位置，具体请参见[aclrtMemLocation](aclrtMemLocation.md)。<br>当type为ACL_MEM_LOCATION_TYPE_HOST时，id无效。 |
| pageSize | int，页表大小，单位Byte。 |
| rsv[4] | list，预留参数。 |
