# aclrtHostRegisterType

| 数据格式 | 说明 |
| --- | --- |
| ACL_HOST_REGISTER_MAPPED = 0 | Host内存映射注册为Device可访问，包括读写。 |
| ACL_HOST_REGISTER_IOMEMORY = 4 | 将Host上第三方PCIe设备的IO space(寄存器、缓存)映射注册为Device可访问，包括读写。预留选项，当前不支持。 |
| ACL_HOST_REGISTER_READONLY = 8 | Host内存映射注册为Device只读。 |
