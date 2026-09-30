# aclrtHostRegisterType

| 数据格式 | 说明 |
| --- | --- |
| ACL_HOST_REGISTER_MAPPED = 0 | Host内存映射注册为Device可访问，包括读写。 |
| ACL_HOST_REGISTER_IOMEMORY = 4 | 将Host上第三方PCIe设备的IO space(寄存器、缓存)映射注册为Device可访问，包括读写。 |
| ACL_HOST_REGISTER_READONLY = 8 | Host内存映射注册为Device只读。预留选项，当前不支持。 |

<!-- npu="A3" id1 -->
对于Atlas A3系列产品，如果设置了ACL\_HOST\_REGISTER\_IOMEMORY选项，则仅支持X86架构，不支持ARM架构。
<!-- end id1 -->
