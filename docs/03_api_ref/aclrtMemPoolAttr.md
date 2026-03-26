# aclrtMemPoolAttr

```
typedef enum aclrtMemPoolAttr{
    ACL_RT_MEM_POOL_REUSE_FOLLOW_EVENT_DEPENDENCIES = 0x1,
    ACL_RT_MEM_POOL_REUSE_ALLOW_OPPORTUNISTIC = 0x2,
    ACL_RT_MEM_POOL_REUSE_ALLOW_INTERNAL_DEPENDENCIES = 0x3,
    ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD = 0x4,
    ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_CURRENT = 0x5,
    ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_HIGH = 0x6,
    ACL_RT_MEM_POOL_ATTR_USED_MEM_CURRENT = 0x7,
    ACL_RT_MEM_POOL_ATTR_USED_MEM_HIGH = 0x8
} aclrtMemPoolAttr;
```

| 枚举项 | 说明 |
| --- | --- |
| ACL_RT_MEM_POOL_REUSE_FOLLOW_EVENT_DEPENDENCIES | 事件依赖内存复用开关。<br>在执行某个Stream任务时，系统会查找与该Stream通过Event关联的其他Stream，并复用这些关联Stream中的任务已归还到内存池中的内存。此机制适用于用户应用程序中通过Event实现Stream间任务同步的场景。<br>属性值类型为uint32_t，取值如下：<br><ul><li> 1: 启用事件依赖内存复用。<li> 2: 关闭事件依赖内存复用。</ul>|
| ACL_RT_MEM_POOL_REUSE_ALLOW_OPPORTUNISTIC | 机会主义内存复用开关。<br>在执行某个Stream的任务时，系统会检索内存池中可复用的内存，但不保证内存复用一定成功。当内存复用失败时，程序会报错停止。<br>属性值类型为uint32_t，取值如下：<br><ul><li> 1: 启用机会主义内存复用。<li> 2: 关闭机会主义内存复用。</ul>|
| ACL_RT_MEM_POOL_REUSE_ALLOW_INTERNAL_DEPENDENCIES | 隐式依赖流间内存复用特性开关。<br>在执行某个Stream的任务时，系统会检索内存池中可复用的内存。若这些内存曾被其他Stream使用，但相关Stream之间不存在任务依赖关系，则系统将自动在相关Stream之间增加Event同步等待逻辑，以确保前一个Stream中的任务对内存的访问已经结束，从而实现安全的内存复用。<br>属性值类型为uint32_t，取值如下：<br><ul><li> 1: 启用隐式依赖内存复用。<li> 2: 关闭隐式依赖内存复用。</ul> |
| ACL_RT_MEM_POOL_ATTR_RELEASE_THRESHOLD | 释放空闲物理内存时，内存池中要保留的内存大小阈值，单位Byte。默认值为0。<br>当内存池中的空闲物理内存超过该阈值时，在下一次Stream同步（例如调用aclrtSynchronizeStream接口）时，系统将尝试释放空闲内存。<br>属性值类型为uint64_t。|
| ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_CURRENT | 内存池中当前被申请的内存总量，该属性只读。<br>属性值类型为uint64_t。|
| ACL_RT_MEM_POOL_ATTR_RESERVED_MEM_HIGH | 内存池中当前被申请的内存总量的历史峰值。<br>属性值类型为uint64_t。<br>设置该属性时，属性值只能为0。|
| ACL_RT_MEM_POOL_ATTR_USED_MEM_CURRENT | 内存池中实际正在使用的内存总量，该属性只读。<br>属性值类型为uint64_t。|
| ACL_RT_MEM_POOL_ATTR_USED_MEM_HIGH | 内存池中实际正在使用的内存总量的历史峰值。<br>属性值类型为uint64_t。<br>设置该属性时，属性值只能为0。|
