# aclmdlConfigAttr

| 模型加载配置类型 | 含义 |
| --- | --- |
| ACL_MDL_PRIORITY_INT32 = 0 | 模型执行的优先级，数字越小优先级越高，取值[0, 7]，可选项。默认值为0。 |
| ACL_MDL_LOAD_TYPE_SIZET = 1 | 模型加载方式，具体请参见表1，必选项。 |
| ACL_MDL_PATH_PTR = 2 | 离线模型文件路径的指针地址，如果选择从文件加载模型，则该选项必选。 |
| ACL_MDL_MEM_ADDR_PTR = 3 | 模型在内存中的起始地址，如果选择从内存加载模型，则该选项必选。 |
| ACL_MDL_MEM_SIZET = 4 | 模型在内存中的大小，如果选择从内存加载模型，则该选项必选，与ACL_MDL_MEM_ADDR_PTR选项配合使用。 |
| ACL_MDL_WEIGHT_ADDR_PTR = 5 | Device上模型权值内存（存放权值数据）的指针地址，如果需要由用户管理权值内存，则该选项必选。若不配置该选项，则表示由系统管理内存。 |
| ACL_MDL_WEIGHT_SIZET = 6 | 权值内存大小，单位为Byte，如果需要由用户管理权值内存，则该选项必选，与ACL_MDL_WEIGHT_ADDR_PTR选项配合使用。 |
| ACL_MDL_WORKSPACE_ADDR_PTR = 7 | Device上模型所需工作内存（存放模型输入/输出等数据）的指针地址，如果需要由用户管理工作内存，则该选项必选。若不配置该选项，则表示由系统管理内存。 |
| ACL_MDL_WORKSPACE_SIZET = 8 | 模型所需工作内存的大小，单位为Byte，如果需要由用户管理权值内存，则该选项必选，与ACL_MDL_WORKSPACE_ADDR_PTR选项配合使用。 |
| ACL_MDL_INPUTQ_NUM_SIZET = 9 | 模型输入队列大小，带队列加载模型时，该选项必选，与ACL_MDL_INPUTQ_ADDR_PTR选项配合使用。 |
| ACL_MDL_INPUTQ_ADDR_PTR = 10 | 模型输入队列ID的指针地址，带队列加载模型时，该选项必选，一个模型输入对应一个队列ID。 |
| ACL_MDL_OUTPUTQ_NUM_SIZET = 11 | 模型输出队列大小，带队列加载模型时，该选项必选，与ACL_MDL_OUTPUTQ_ADDR_PTR选项配合使用。 |
| ACL_MDL_OUTPUTQ_ADDR_PTR = 12 | 模型输出队列ID的指针地址，带队列加载模型时，该选项必选，一个模型输出对应一个队列ID。 |
| ACL_MDL_WORKSPACE_MEM_OPTIMIZE = 13 | 是否开启模型工作内存优化功能，1开启，0不开启。若关注内存规划或内存资源有限时，建议在模型加载前，开启工作内存优化功能，此时工作内存中不包含存放模型输入、输出数据的内存，工作内存大小会减小，达到节省内存的目的。在模型执行前，还需要由用户申请存放模型输入、输出数据的内存，因此即使在模型加载时开启工作内存优化功能，也不会影响后续的模型执行。 |
| ACL_MDL_WEIGHT_PATH_PTR = 14 | 权重文件所在目录的指针地址。对om模型文件大小有限制的场景下，通过本参数可实现权重文件外置功能。如果将ACL_MDL_LOAD_TYPE_SIZET设置为ACL_MDL_LOAD_FROM_MEM，表示从内存加载模型数据，则支持使用ACL_MDL_WEIGHT_PATH_PTR指定权重文件目录。一般对om模型文件大小有限制或模型文件加密的场景下，需单独指定权重文件目录，但前提是需在使用ATC工具生成om文件时，将<br> -external_weight参数设置为1（1表示将原始网络中的Const/Constant节点的权重保存在单独的文件中）。 |
| ACL_MDL_MEM_MALLOC_POLICY_SIZET | 内存分配规则，该选项对应的值为size_t类型。当前版本不支持该配置。支持如下取值：<li> ACL_MEM_MALLOC_HUGE_FIRST当申请的内存小于等于1M时，即使使用该内存分配规则，也是申请普通页的内存。当申请的内存大于1M时，优先申请大页内存，如果大页内存不够，则使用普通页的内存。</li><li> ACL_MEM_MALLOC_HUGE_ONLY仅申请大页，如果大页内存不够，则返回错误。</li><li> ACL_MEM_MALLOC_NORMAL_ONLY仅申请普通页，如果普通页内存不够，则返回错误。</li><li> ACL_MEM_TYPE_LOW_BAND_WIDTH从带宽低的物理内存上申请内存。</li><li> ACL_MEM_TYPE_HIGH_BAND_WIDTH从带宽高的物理内存上申请内存。</li> |
| ACL_MDL_WITHOUT_GRAPH_INT32 | 模型加载后是否保留计算图及其预缓存信息，只支持输入为静态Shape的场景。该选项对应的值为INT32类型，取值范围如下：<li> 0：默认值，保留计算图及其预缓存信息。</li><li>1：不保留计算图及其预缓存信息。设置为1时，模型加载成功后会释放计算图及其预缓存信息，用于节省内存，但预缓存信息被释放，会影响Profiling数据采集以及异常场景下的算子信息获取，因此：Profiling数据采集场景下，需在模型加载前调用`acl.prof.start`接口打开Profling开关，否则Profiling功能不可用。异常场景下，调用[acl.mdl.create_and_get_op_desc](function-create_and_get_op_desc.md)接口获取算子描述信息时会失败。</li> |

<!-- npu="910" id6 -->
ACL\_MDL\_PRIORITY\_INT32取值说明：Atlas训练系列产品，docker容器内安装CANN，且配置算力分组的场景，该枚举值不生效。
<!-- end id6 -->

**表 1** ACL\_MDL\_LOAD\_TYPE\_SIZET对应的属性值

| 模型加载方式 | 含义 |
| --- | --- |
| ACL_MDL_LOAD_FROM_FILE = 1 | 从文件加载离线模型数据，由系统内部管理内存。 |
| ACL_MDL_LOAD_FROM_FILE_WITH_MEM = 2 | 从文件加载离线模型数据，由用户自行管理模型运行的内存。 |
| ACL_MDL_LOAD_FROM_MEM = 3 | 从内存加载离线模型数据，由系统内部管理模型运行的内存。 |
| ACL_MDL_LOAD_FROM_MEM_WITH_MEM = 4 | 从内存加载离线模型数据，由用户自行管理模型运行的内存。 |
| ACL_MDL_LOAD_FROM_FILE_WITH_Q = 5 | 从文件加载离线模型数据，模型的输入、输出数据都存放在队列中。 |
| ACL_MDL_LOAD_FROM_MEM_WITH_Q = 6 | 从内存加载离线模型数据，模型的输入、输出数据都存放在队列中。 |

注意：如果将ACL_MDL_LOAD_TYPE_SIZET设置为ACL_MDL_LOAD_FROM_MEM，表示从内存加载模型数据，还支持使用ACL_MDL_WEIGHT_PATH_PTR选项指定权重文件目录。
