# aclrtBinaryLoadOptionType/aclrtBinaryLoadOptionValue

| aclrtBinaryLoadOptionType | aclrtBinaryLoadOptionValue |
| --- | --- |
| ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD = 1 | 指定解析算子二进制、注册算子后，是否加载算子到Device侧。<br>取值如下：<br>- 0：不加载算子到Device侧。默认值，如果不指定ACL_RT_BINARY_LOAD_OPT_LAZY_LOAD选项，系统默认按此值处理。<br>- 1：加载算子到Device侧。此时，系统仅将算子加载至当前Context所对应的Device上，因此在调用[acl.rt.launch_kernel_with_config](../Kernel/function-launch_kernel_with_config.md)接口启动算子计算任务时，所在的Device必须与算子加载时的Device相同。 |
| ACL_RT_LOAD_BINARY_OPT_MAGIC = 2 | 标识算子类型的魔术数字。目前暂不支持。 |
| ACL_RT_BINARY_LOAD_OPT_CPU_KERNEL_MODE = 3 | AI CPU算子注册模式。<br>取值如下：<br> - 0：调用[acl.rt.binary_load_from_file](../Kernel/function-binary_load_from_file.md)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，AI CPU算子库文件（.so）已经在调用[acl.rt.set_device](../device/function-set_device.md)接口时被加载到Device。适用于加载CANN内置算子。<br>- 1：调用[acl.rt.binary_load_from_file](../Kernel/function-binary_load_from_file.md)接口加载算子时，使用算子信息库文件（.json）注册算子。该场景下，[acl.rt.binary_load_from_file](../Kernel/function-binary_load_from_file.md)接口会查找算子信息库文件同名的AI CPU算子库文件（.so）。适用于加载用户自定义算子。<br> - 2：调用[acl.rt.binary_load_from_data](../Kernel/function-binary_load_from_data.md)接口加载算子，并配合使用[acl.rt.register_cpu_func](../Kernel/function-register_cpu_func.md)接口注册AI CPU算子信息。适用于没有算子信息库文件，也没有算子库文件的场景。 |
