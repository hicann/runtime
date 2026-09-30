# 函数：host\_get\_device\_pointer

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

获取由[acl.rt.host\_register](function-host_register.md)接口或[acl.rt.host\_register\_v2](function-host_register_v2.md)接口注册映射的Device内存地址。映射后的Device内存地址不能用于内存操作，例如内存复制。

## 函数原型

- **C函数原型**

    ```c
    aclError aclrtHostGetDevicePointer(void *pHost, void **pDevice, uint32_t flag)
    ```

- **python函数**

    ```python
    ptr_device, ret = acl.rt.host_get_device_pointer（ptr_host，flag）
    ```

## 参数说明

| 参数名 | 说明 |
| --- | --- |
| ptr_host | 通过[acl.rt.host_register](function-host_register.md)接口或[acl.rt.host_register_v2](function-host_register_v2.md)接口注册映射的Host内存地址。 |
| flag | 预留参数，当前固定配置为0。 |

## 返回值说明

| 返回值 | 说明 |
| --- | --- |
| ptr_device | int，device内存地址 |
| ret | int，返回0表示成功，返回[其它值](../datatypes/aclError.md)表示失败。 |
