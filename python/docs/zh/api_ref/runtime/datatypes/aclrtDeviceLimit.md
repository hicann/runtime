# aclrtDeviceLimit

| 数据格式 | 说明 |
| --- | --- |
| ACL_RT_DEV_LIMIT_SIMT_STACK_SIZE = 0 | SIMT栈大小（per-thread） |
| ACL_RT_DEV_LIMIT_SIMT_DVG_WARP_STACK_SIZE = 1 | SIMT分支栈大小（per-warp） |
| ACL_RT_DEV_LIMIT_SIMD_STACK_SIZE = 2 | AI Core栈大小（每核） |
| ACL_RT_DEV_LIMIT_SIMD_PRINTF_FIFO_SIZE_PER_CORE = 3 | SIMD printf FIFO大小（每核） |
| ACL_RT_DEV_LIMIT_SIMT_PRINTF_FIFO_SIZE = 4 | SIMT printf FIFO大小 |

<!-- npu="950" id1 -->
对于Ascend 950PR&950DT系列产品，以上选项都支持。但ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE和ACL\_RT\_DEV\_LIMIT\_SIMT\_DVG\_WARP\_STACK\_SIZE不能同时设置为0，否则接口返回ACL\_ERROR\_RT\_PARAM\_INVALID。
<!-- end id1 -->

<!-- npu="A3,910b" id2 -->
对于Atlas A3系列产品、Atlas A2系列产品，仅支持SIMD相关选项（例如ACL\_RT\_DEV\_LIMIT\_SIMD\_STACK\_SIZE），不支持SIMT相关选项（例如ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE）。
<!-- end id2 -->

各枚举项的说明如下：

- ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE

    用于设置SIMT（Single Instruction Multiple Thread）算子每个线程的栈空间大小，单位Byte。默认值为1152Byte。

    设置为ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE类型时，value取值必须是128Byte的整数倍，如果传入的不是128Byte的整数倍，则接口内部会自动向上取整，确保其为128Byte的整数倍。实际每个线程的栈空间大小为\(value向上128Byte取整后 \* 32\)Byte。

- ACL\_RT\_DEV\_LIMIT\_SIMT\_DVG\_WARP\_STACK\_SIZE

    用于设置SIMT算子的分支（Divergence）栈空间大小，单位Byte。默认值为1024Byte。

    设置为ACL\_RT\_DEV\_LIMIT\_SIMT\_DVG\_WARP\_STACK\_SIZE类型时，value取值必须是128Byte的整数倍，如果传入的不是128Byte的整数倍，则接口内部会自动向上取整，确保其为128Byte的整数倍。

- ACL\_RT\_DEV\_LIMIT\_SIMD\_STACK\_SIZE

    用于控制进程中SIMD（Single Instruction Multiple Data）算子执行时为每个AI Core分配的栈空间大小，单位Byte。默认值为32768Byte（即32K）。

    对于Atlas A3系列产品、Atlas A2系列产品，设置为ACL\_RT\_DEV\_LIMIT\_SIMD\_STACK\_SIZE类型时，value的取值范围为\(32768, 196608\] Byte，即\(32, 192\] KB。

    对于Ascend 950PR&950DT系列产品，设置为ACL\_RT\_DEV\_LIMIT\_SIMD\_STACK\_SIZE类型时，value的取值范围为\(32768, 131072\] Byte，即\(32, 128\] KB。

    当value的取值大于32K时，接口内部会向上取整，确保其为16K的整数倍；当value的取值小于或等于32K时，默认按32K处理。

- ACL\_RT\_DEV\_LIMIT\_SIMD\_PRINTF\_FIFO\_SIZE\_PER\_CORE

    用于控制每个Core上SIMD算子可以Printf打印的空间大小，单位Byte。默认值为32768Byte（即32K）。

    设置为ACL\_RT\_DEV\_LIMIT\_SIMD\_PRINTF\_FIFO\_SIZE\_PER\_CORE类型时，value取值必须是8Byte的整数倍，如果传入的不是8Byte的整数倍，则接口内部会自动向上取整，确保其为8Byte的整数倍。value的取值范围为\[1024, 67108864\]Byte，即\[1KB, 64MB\]。

- ACL\_RT\_DEV\_LIMIT\_SIMT\_PRINTF\_FIFO\_SIZE

    用于控制SIMT算子可以Printf打印的空间大小，单位Byte。默认值为2097152Byte（即2M）。

    设置为ACL\_RT\_DEV\_LIMIT\_SIMT\_PRINTF\_FIFO\_SIZE类型时，value取值必须是8Byte的整数倍，如果传入的不是8Byte的整数倍，则接口内部会自动向上取整，确保其为8Byte的整数倍。value的取值范围为\[1048576, 67108864\]Byte，即\[1, 64\]MB。
