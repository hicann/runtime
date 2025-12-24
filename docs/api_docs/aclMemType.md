# aclMemType<a name="ZH-CN_TOPIC_0000001312721793"></a>

```
typedef enum {
    ACL_MEMTYPE_DEVICE = 0,  //Device内存
    ACL_MEMTYPE_HOST = 1,    //Host内存
    ACL_MEMTYPE_HOST_COMPILE_INDEPENDENT = 2   //Host内存
} aclMemType;
```

ACL\_MEMTYPE\_HOST和ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT都标识Host内存，但在使用上有区别：

-   ACL\_MEMTYPE\_HOST：若通过aclSetCompileopt接口将ACL\_OP\_JIT\_COMPILE设置为disable，设置该选项时，算子输入或输出的值的变化，不会触发算子重新编译；若通过aclSetCompileopt接口将ACL\_OP\_JIT\_COMPILE设置为enable，算子输入或输出的值的变化，会触发算子重新编译。
-   ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT ：设置该选项时，算子输入或输出的值的变化，都不会触发算子重新编译。若算子编译时依赖其输入或输出的值，此时如果设置为ACL\_MEMTYPE\_HOST\_COMPILE\_INDEPENDENT，则可能会导致编译失败。

