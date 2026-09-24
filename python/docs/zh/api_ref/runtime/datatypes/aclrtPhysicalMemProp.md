# aclrtPhysicalMemProp

| 成员名称 | 描述 |
| --- | --- |
| handleType | handle类型，当前仅支持"ACL_MEM_HANDLE_TYPE_NONE"。 |
| allocationType | 内存分配类型，当前仅支持"ACL_MEM_ALLOCATION_TYPE_PINNED"。 |
| memAttr | 内存属性，具体请参见[aclrtMemAttr](../datatypes/aclrtMemAttr.md)。 |
| location | 设置内存所在位置，具体请参见[aclrtMemLocation](aclrtMemLocation.md)。请参考以下示例传入，其中"id"表示Device的ID或NUMA ID，"type"为内存所在位置类型。<br>location = {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'id' : 0, <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'type' : ACL_MEM_LOCATION_TYPE_DEVICE<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } |
| reserve | 预留。 |
