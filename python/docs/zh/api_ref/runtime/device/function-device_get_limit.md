# 函数：acl.rt.device\_get\_limit

## 产品支持情况

<!-- npu="950" id1 -->
- Ascend 950PR&950DT系列产品：支持
<!-- end id1 -->
<!-- npu="A3" id2 -->
- Atlas A3系列产品：支持
<!-- end id2 -->
<!-- npu="910b" id3 -->
- Atlas A2系列产品：支持
<!-- end id3 -->
<!-- npu="310b" id4 -->
- Atlas 200I/500 A2推理产品：不支持
<!-- end id4 -->
<!-- npu="310p" id5 -->
- Atlas推理系列产品：不支持
<!-- end id5 -->
<!-- npu="910" id6 -->
- Atlas训练系列产品：不支持
<!-- end id6 -->

## 功能说明

获取当前Device资源限制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDeviceGetLimit(aclrtDeviceLimit limit, size_t *value)
    ```

- **python函数**

    ```python
    value, ret = acl.rt.device_get_limit(limit)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| limit | int，资源类型，取值见[aclrtDeviceLimit](../datatypes/aclrtDeviceLimit.md) |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| value | int，资源限制的大小，单位Byte。 |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 通过acl.rt.device\_set\_limit接口配置的SIMD相关选项及SIMT相关选项的资源限制，这些配置作用于当前进程，所有Device共用同一套配置，任意Device上查询返回相同值。
- 当查询SIMD相关选项及SIMT相关选项的资源限制，通过本接口获取的是当前进程的瞬时值，不保证多线程并发安全。

    例如：首先调用acl.rt.device\_set\_limit将栈大小设置为A，随后调用acl.rt.set\_device使其生效。此时，调用acl.rt.device\_get\_limit接口查询得到的值为A，且资源限制的大小亦为A。随后再次调用acl.rt.device\_set\_limit将其修改为B，但未重新调用acl.rt.set\_device。此时，调用acl.rt.device\_get\_limit接口查询得到的值为B，而实际资源限制的大小仍为A。

<!-- npu="950" id7 -->
- 当查询L2 Cache持久化大小时，需先指定用于运算的Device（例如调用acl.rt.set\_device接口），不同Device可返回不同值。仅Ascend 950PR&950DT系列产品支持查询该配置。
<!-- end id7 -->

<!-- npu="A3,910b" id8 -->
- 对于Atlas A3系列产品、Atlas A2系列产品，查询ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE、ACL\_RT\_DEV\_LIMIT\_SIMT\_DVG\_WARP\_STACK\_SIZE、ACL\_RT\_DEV\_LIMIT\_SIMT\_PRINTF\_FIFO\_SIZE、ACL\_RT\_DEV\_LIMIT\_PERSISTING\_L2CACHE\_SIZE时返回ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT。
<!-- end id8 -->

<!-- npu="950" id9 -->
- 对于Ascend 950PR&950DT系列产品，查询ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE返回对齐后×32的值（每warp线程数），如设置256则查询返回8192；查询ACL\_RT\_DEV\_LIMIT\_SIMT\_DVG\_WARP\_STACK\_SIZE返回对齐后的值（不乘线程数），如设置512则查询返回512。
<!-- end id9 -->
