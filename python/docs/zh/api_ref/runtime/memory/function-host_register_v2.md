# 函数：host\_register\_v2

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

注册Host内存地址。

取消注册需调用[acl.rt.host\_unregister](function-host_unregister.md)接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtHostRegisterV2(void *ptr, uint64_t size, uint32_t flag)
    ```

- **python函数**

    ```python
    ret = acl.rt.host_register_v2(ptr，size，flag)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| ptr | Host内存地址。<br>Host内存地址需4K页对齐。<br>当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用aclrtMallocHost接口来申请Host锁页内存。<br>当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此既支持调用aclrtMallocHost接口申请Host锁页内存，也支持使用malloc接口申请Host非锁页内存。 |
| size | 内存大小，单位Byte。 |
| flag | 内存注册类型。<br>0x2：ACL_HOST_REG_MAPPED：将Host内存映射注册为Device可访问的内存地址，再配合调用[acl.rt.host_get_device_pointer](function-host_get_device_pointer.md)接口获取映射后的Device内存地址。<br>0x4：ACL_HOST_REG_IOMEMORY：将Host上第三方PCIe设备的IO space（寄存器、缓存）映射注册为Device可访问，包括读写。使用该值时不支持锁业内存，因此该值不能与ACL_HOST_REG_PINNED组合使用。预留选项，当前不支持。<br>0x8：ACL_HOST_REG_READONLY：Host内存映射注册为Device只读。预留选项，当前不支持。<br>0x10000000：ACL_HOST_REG_PINNED：将Host非锁页内存注册为锁页内存。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |

<!-- npu="A3" id7 -->
## 约束说明

<!-- npu="A3" id8 -->
对于Atlas A3系列产品，若将flag设置为ACL\_HOST\_REG\_IOMEMORY，则仅支持X86架构，不支持ARM架构。
<!-- end id8 -->
<!-- end id7 -->
