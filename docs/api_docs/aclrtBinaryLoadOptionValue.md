# aclrtBinaryLoadOptionValue

```
typedef union aclrtBinaryLoadOptionValue {
    uint32_t isLazyLoad;
    uint32_t magic;
    int32_t cpuKernelMode;
    uint32_t rsv[4];
} aclrtBinaryLoadOptionValue;
```


| 成员名称 | 描述 |
| --- | --- |
| isLazyLoad | 指定解析算子二进制、注册算子后，是否加载算子到Device侧。<br>取值如下：<br><br>  - 1：调用本接口时不加载算子到Device侧。<br>  - 0：调用本接口时加载算子到Device侧。如果不指定ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD选项，系统默认按此值处理。 |
| magic | 标识算子计算单元的魔术数字。<br>取值为如下宏：<br><br>  - ACL_RT_BINARY_MAGIC_ELF_AICORE<br>  - ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE<br>  - ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE<br><br>宏的定义如下：<br>#define ACL_RT_BINARY_MAGIC_ELF_AICORE  0x43554245U<br>#define ACL_RT_BINARY_MAGIC_ELF_VECTOR_CORE 0x41415246U<br>#define ACL_RT_BINARY_MAGIC_ELF_CUBE_CORE  0x41494343U<br>关于Core的定义及详细说明，请参见[aclrtDevAttr](aclrtDevAttr.md)。 |
| cpuKernelMode | AI CPU算子注册模式。<br>取值如下：<br><br>  - 0：调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，AI CPU算子库文件（.so）已经在调用[aclrtSetDevice](aclrtSetDevice.md)接口时被加载到Device。适用于加载CANN内置算子。<br>  - 1：调用[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，[aclrtBinaryLoadFromFile](aclrtBinaryLoadFromFile.md)接口会查找算子信息库文件同名的AI CPU算子库文件（.so）。适用于加载用户自定义算子。<br>  - 2：调用[aclrtBinaryLoadFromData](aclrtBinaryLoadFromData.md)接口加载算子，并配合使用[aclrtRegisterCpuFunc](aclrtRegisterCpuFunc.md)接口注册AI CPU算子信息。适用于没有算子信息库文件，也没有算子库文件的场景。 |
| rsv | 预留值。 |

