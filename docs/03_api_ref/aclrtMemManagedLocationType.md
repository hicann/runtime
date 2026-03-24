# aclrtMemManagedLocationType

```
typedef enum aclrtMemManagedLocationType {
    ACL_MEM_LOCATIONTYPE_INVALID = 0,
    ACL_MEM_LOCATIONTYPE_DEVICE,
    ACL_MEM_LOCATIONTYPE_HOST,
    ACL_MEM_LOCATIONTYPE_HOST_NUMA,
    ACL_MEM_LOCATIONTYPE_HOST_NUMA_CURRENT,
} aclrtMemManagedLocationType;
```

**表 1**  枚举项说明


| 枚举项 | 说明 |
| --- | --- |
| ACL_MEM_LOCATIONTYPE_INVALID | 无效位置。 |
| ACL_MEM_LOCATIONTYPE_DEVICE | 位置在Device。 |
| ACL_MEM_LOCATIONTYPE_HOST | 位置在Host。 |
| ACL_MEM_LOCATIONTYPE_HOST_NUMA | 位置在Host NUMA节点，设置该类型location时，需传入合理的NUMA ID。 |
| ACL_MEM_LOCATIONTYPE_HOST_NUMA_CURRENT | 位置在当前线程关联的NUMA节点上，设置该类型location时，用户传入的id无效，接口内部会自动获取当前线程所在NUMA节点的id并使用。 |

