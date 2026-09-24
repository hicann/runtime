# 函数：host\_register

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

将Host内存映射注册为Device可访问的内存地址，并获取映射后的Device内存地址，该地址仅支持在Device上访问，例如作为核函数的参数，供Device的AI Core访问。若涉及Host侧的内存处理，需使用原始Host内存地址。

取消注册需调用[acl.rt.host\_unregister](function-host_unregister.md)接口。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtHostRegister(void *ptr, uint64_t size, aclrtHostRegisterType type, void **devPtr)
    ```

- **python函数**

    ```python
    dev_ptr, ret = acl.rt.host_register(ptr, size, type)
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| ptr | int，Host内存地址。Host内存地址需4K页对齐。当os内核版本为5.10或更低时，使用非锁页内存会导致异常，因此必须调用[acl.rt.malloc_host](function-malloc_host.md)接口来申请Host内存；当os内核版本为5.10以上时，支持使用非锁页的Host内存，因此也支持不调用[acl.rt.malloc_host](function-malloc_host.md)接口申请Host内存。 |
| size | int，内存大小，单位Byte。 |
| type | int，内存注册类型。类型定义请参见[aclrtHostRegisterType](../datatypes/aclrtHostRegisterType.md)。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| dev_ptr | int，Host内存映射成的Device可访问的内存地址。 |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
