# aclrtMemLocationType

| 数据格式 | 说明 |
| --- | --- |
| ACL_MEM_LOCATION_TYPE_HOST = 0 | 通过acl接口（例如aclrtMallocHost）申请的Host内存。 |
| ACL_MEM_LOCATION_TYPE_DEVICE = 1 | 通过acl接口（例如aclrtMalloc）申请的Device内存。 |
| ACL_MEM_LOCATION_TYPE_UNREGISTERED = 2 | 未通过acl接口申请的内存。 |
| ACL_MEM_LOCATION_TYPE_MANAGED = 3 | UVM(Unified Virtual Memory, 统一虚拟内存)类型的内存。 |
| ACL_MEM_LOCATION_TYPE_HOST_NUMA = 4 | 通过aclrtMallocPhysical接口按照NUMA ID申请Host内存。 |
