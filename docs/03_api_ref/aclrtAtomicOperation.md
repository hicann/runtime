# aclrtAtomicOperation

```
typedef enum aclrtAtomicOperation {
    ACL_RT_ATOMIC_OPERATION_INTEGER_ADD = 0,         // 整型数据原子加操作，对应Ascend C的asc_atomic_add接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_MIN = 1,         // 整型数据原子求最小值操作，对应Ascend C的asc_atomic_min接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_MAX = 2,         // 整型数据原子求最大值操作，对应Ascend C的asc_atomic_max接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_INCREMENT = 3,   // 原子加1操作，对应Ascend C的asc_atomic_inc接口
    ACL_RT_ATOMIC_OPERATION_INTEGER_DECREMENT = 4,   // 原子减1操作，对应Ascend C的asc_atomic_dec接口
    ACL_RT_ATOMIC_OPERATION_AND = 5,                 // 原子与(&)操作，对应Ascend C的asc_atomic_and接口
    ACL_RT_ATOMIC_OPERATION_OR = 6,                  // 原子或(|)操作，对应Ascend C的asc_atomic_or接口
    ACL_RT_ATOMIC_OPERATION_XOR = 7,                 // 原子异或(^)操作，对应Ascend C的asc_atomic_xor接口
    ACL_RT_ATOMIC_OPERATION_EXCHANGE = 8,            // 原子赋值操作，对应Ascend C的asc_atomic_exch接口
    ACL_RT_ATOMIC_OPERATION_CAS = 9,                 // 原子比较赋值操作，对应Ascend C的asc_atomic_cas接口
    ACL_RT_ATOMIC_OPERATION_FLOAT_ADD = 10,          // 浮点型数据原子加操作，对应Ascend C的asc_atomic_add接口
    ACL_RT_ATOMIC_OPERATION_FLOAT_MIN = 11,          // 浮点型数据原子求最小值操作，对应Ascend C的asc_atomic_min接口
    ACL_RT_ATOMIC_OPERATION_FLOAT_MAX = 12,          // 浮点型数据原子求最大值操作，对应Ascend C的asc_atomic_max接口

    /* 以上选项是基于SIMT（Single Instruction Multiple Thread）编程的原子操作 */
    /* 以下选项是基于SIMD（Single Instruction Multiple Data）编程的原子操作 */

    ACL_RT_ATOMIC_OPERATION_DMA_ADD = 30,            // 原子加操作，对应Ascend C的SetAtomicAdd接口
    ACL_RT_ATOMIC_OPERATION_DMA_MIN = 31,            // 原子求最小值操作，对应Ascend C的SetAtomicMin接口
    ACL_RT_ATOMIC_OPERATION_DMA_MAX = 32,            // 原子求最大值操作，对应Ascend C的SetAtomicMax接口

    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_ADD = 40,    // 原子加操作，对应Ascend C的AtomicAdd接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_MIN = 41,    // 原子求最小值操作，对应Ascend C的AtomicMin接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_MAX = 42,    // 原子求最大值操作，对应Ascend C的AtomicMax接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_CAS = 43,    // 原子比较赋值操作，对应Ascend C的AtomicCas接口
    ACL_RT_ATOMIC_OPERATION_SIMD_SCALAR_EXCH = 44,   // 原子赋值操作，对应Ascend C的AtomicExch接口
} aclrtAtomicOperation;
```
