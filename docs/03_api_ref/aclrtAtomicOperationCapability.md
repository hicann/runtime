# aclrtAtomicOperationCapability

```
typedef enum aclrtAtomicOperationCapability {
    ACL_RT_ATOMIC_CAPABILITY_SIGNED = 1U << 0,      // 有符号类型
    ACL_RT_ATOMIC_CAPABILITY_UNSIGNED = 1U << 1,    // 无符号类型
    ACL_RT_ATOMIC_CAPABILITY_REDUCATION = 1U << 2,  // 规约操作
    ACL_RT_ATOMIC_CAPABILITY_SCALAR8 = 1U << 3,     // 8位(1字节)标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR16 = 1U << 4,    // 16位(2字节)标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR32 = 1U << 5,    // 32位(4字节)标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR64 = 1U << 6,    // 64位(8字节)标量数据
    ACL_RT_ATOMIC_CAPABILITY_SCALAR128 = 1U << 7,   // 128位(16字节)标量数据
    ACL_RT_ATOMIC_CAPABILITY_VECTOR32X4 = 1U << 8,  // 4个32位的向量数据操作，即一次性对连续的4个32位数据执行原子计算
} aclrtAtomicOperationCapability;
```
