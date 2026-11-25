# 函数：acl.rt.device\_set\_limit

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

设置当前Device资源限制，例如SIMT（Single Instruction Multiple Thread）算子栈空间大小、SIMT Printf维测空间大小等。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtDeviceSetLimit(aclrtDeviceLimit limit, size_t value)
    ```

- **python函数**

    ```python
    ret = acl.rt.device_set_limit(limit, value)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| limit | int，资源类型，取值见[aclrtDeviceLimit](../datatypes/aclrtDeviceLimit.md)。 |
| value | int，资源限制的大小，单位Byte。该参数的取值与limit类型有关，详见[aclrtDeviceLimit](../datatypes/aclrtDeviceLimit.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，错误码，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

## 约束说明

- 各产品型号对limit资源类型的支持情况不同，对于不支持的资源类型，接口返回ACL\_ERROR\_RT\_FEATURE\_NOT\_SUPPORT。
- 通过本接口配置SIMD相关选项（例如limit为ACL\_RT\_DEV\_LIMIT\_SIMD\_STACK\_SIZE）及SIMT相关选项（例如limit为ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE）的资源限制时，建议在调用acl.init接口之后、acl.rt.set\_device接口之前调用本接口，确保资源限制配置生效。

    若涉及多次调用acl.rt.set\_device接口，由于acl.rt.set\_device、acl.rt.reset\_device接口内部涉及引用计数，两者配对使用，引用计数减到0之后，调用本接口配置资源限制值之后，再调用acl.rt.set\_device接口，配置才可以生效。调用顺序如下所示：

    ```text
    acl.init-->acl.rt.device_set_limit（第一次调用接口设置）-->acl.rt.set_device（这时资源限制的配置生效）-->业务处理-->acl.rt.reset_device（重置Device资源）-->acl.rt.device_set_limit（第二次调用接口设置）-->acl.rt.set_device（这时资源限制的配置生效）
    ```

    通过本接口或acl.init接口均可配置资源限制值，例如SIMT算子栈空间大小、SIMT Printf维测空间大小等。其中，通过本接口配置更为灵活，便于调整资源限制值。若通过两种方式配置资源限制值，则后配置的覆盖先配置的。
- 通过本接口配置SIMD相关选项（例如limit为ACL\_RT\_DEV\_LIMIT\_SIMD\_STACK\_SIZE）及SIMT相关选项（例如limit为ACL\_RT\_DEV\_LIMIT\_SIMT\_STACK\_SIZE）的资源限制时，这些配置作用于当前进程，所有Device共用同一套配置，无法为不同的Device设置不同的资源限制值。

    本接口内部固定使用Device0进行设置。若设置了ASCEND\_RT\_VISIBLE\_DEVICES环境变量且该变量中不包含Device0，则通过本接口或acl.init接口配置资源限制值均会失败。因此，若使用ASCEND\_RT\_VISIBLE\_DEVICES环境变量，需确保其值中包含Device0。

<!-- npu="950" id7 -->
- 通过本接口配置L2 Cache持久化大小时，limit参数应设置为ACL\_RT\_DEV\_LIMIT\_PERSISTING\_L2CACHE\_SIZE，该配置仅Ascend 950PR&950DT系列产品支持。L2 Cache持久化大小为Device级别配置，因此在设置该大小前，需先指定用于运算的Device（例如调用acl.rt.set\_device接口）。当调用acl.rt.reset\_device引用计数减到0，实际释放Device资源时，当前Device的L2 Cache持久化大小将被恢复为0。
<!-- end id7 -->
