# Runtime 错误码使用规范（EE/EH 系列）

## Overview

CANN Runtime 有两层错误码：**EE 系列**（Runtime 核心层，`src/runtime/`）和 **EH 系列**（ACL 对外 API 层，`src/acl/`）。选择错误码必须遵循场景优先级，禁止随意使用兜底码。当前仅针对外部用户错误进行分析。

**核心使用原则**：

1. **确定层级**：代码在 `src/runtime/` → EE；代码在 `src/acl/` → EH
2. **确定场景**：按决策树选择最优错误码，选择时须确认该码预定义的 suggestion 对当前场景有实际指导意义；若 suggestion 与场景不符，应改选更贴切的错误码。禁止使用兜底码，除非确实无法归类
3. **⛔ 禁用码**：EE1001/EH0001/EH0002 仅兜底使用，Runtime/ACL 不应再增量调用
4. **使用前检查**：每次使用本规范前，必须从 `src/dfx/error_manager/error_code.json` 中对比 EE/EH 错误码是否有新增或修改（ErrCode、ErrMessage、Arglist）。如有变更：
   - 仅在**当前调用期间**临时将变更内容分析总结并更新到本文档对应场景中
   - 当前调用完成后，**恢复文档至固有规则现状**，删除临时更新内容
   - 目的：保证本文档的规范性不被单次变更打破，新增码应经评审后正式纳入
5. **使用后检查**：选定错误码后，对照"常见错误"章节逐一自检，确认未落入已知陷阱

**标注说明**：⛔=兜底码（不应增量调用）；🔸=已定义但源码中无实际使用；⭐=同类场景中优先使用的码；

## EE错误码一览表

| ErrCode | errTitle(分类) | Arglist | ErrMessage | suggestion | 使用场景 | 使用示例 | 打屏效果 | 说明 |
|---------|---------------|---------|------------|------------|---------|---------|---------|------|
| EE1001 ⛔ | 输入参数非法 · Invalid_Argument(兜底) | `extend_info` | `The argument is invalid. Reason: %s` | Cause: N/A.<br>Solution: 1. Check the input parameter range of the function. 2. Check the function invocation relationship. | ⛔ 仅在宏ERROR_RETURN_WITH_EXT_ERRCODE中调用，用于rt接口层做兜底，其他场景不应增量调用 | / | `The argument is invalid. Reason: kernel does not have param info. ErrorCode=EE1001.` | ⛔ 仅在宏ERROR_RETURN_WITH_EXT_ERRCODE中调用，用于rt接口层做兜底，其他场景不应增量调用 |
| EE1002 | 执行错误 · Stream_Synchronize_Timeout | `extend_info` | `Stream synchronize timeout. %s` | Cause: 1. The timeout interval may be improperly set.<br>Solution: 1. Check whether the timeout interval is properly set. 2. Check whether the network is normal. | 流同步超时 | `stream_c.cc:232`<br>`COND_RETURN_AND_MSG_OUTER(error == RT_ERROR_STREAM_SYNC_TIMEOUT, error, ErrorCode::EE1002, "DataDumpLoadInfoTask synchronize");` | `Stream synchronize timeout. DataDumpLoadInfoTask synchronize. ErrorCode=EE1002.` | 专用于流同步超时 |
| EE1003 ⭐ | 输入参数非法 · Invalid_Argument | `func, value, param, expect` | `%s failed because value %s for parameter %s is invalid. Expected value: %s.` | Cause: N/A.<br>Solution: 1. Check the input parameter range of the function. 2. Check the function invocation relationship. | 参数值非法+参数名参数值可打印+能给出期望值 | `runtime.cc:4312`<br>`RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1003, userDevId, "userDevId", "[0, " + std::to_string(userDeviceCnt) + ")");` | `rtGetUserDevIdByDeviceId failed because value 8 for parameter userDevId is invalid. Expected value: [0, 4). ErrorCode=EE1003.` | ⭐ 首选通用码 |
| EE1004 ⭐ | 输入参数非法 · Null_Pointer | `func, param` | `%s failed because %s cannot be a NULL pointer.` | Cause: N/A.<br>Solution: Try again with a correct pointer argument. | NULL指针 | `kernel_utils.cc:213`<br>`COND_RETURN_AND_MSG_OUTER((kernel == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1004, "rtModelTaskSetParams", "params->kernelTaskParams->funcHandle");` | `rtModelTaskSetParams failed because params->kernelTaskParams->funcHandle cannot be a NULL pointer. ErrorCode=EE1004.` | ⭐ 空指针专用码 |
| EE1005 | 不支持 · Not_Supported | `func` | `The current system or device does not support %s.` | 无 | 完整功能芯片不支持 | `api_impl.cc:4274`<br>`if (!IS_SUPPORT_CHIP_FEATURE(dev->GetChipType(), RtOptionalFeatureType::RT_FEATURE_MODEL_ABORT)) { RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1005); return RT_ERROR_FEATURE_NOT_SUPPORT; }` | `The current system or device does not support rtModelAbort. ErrorCode=EE1005.` | 仅芯片层面不支持某个完整功能 |
| EE1006 | 不支持 · Not_Supported | `func, type, reason` | `%s failed. %s is not supported. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 非完整功能，某个配置参数不支持（非完整功能，即非一个完整的rt/rts接口） | `api_error.cc:1027`<br>`COND_RETURN_AND_MSG_OUTER((flags & RT_STREAM_HUGE) != 0U, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1006, __func__, "Parameter flags value " + std::to_string(flags), "The current SoC only supports streams of normal task capacity, and does not support huge stream creation");` | `StreamCreate failed. Parameter flags value 4 is not supported. Reason: The current SoC only supports streams of normal task capacity, and does not support huge stream creation. ErrorCode=EE1006.` | ①如通过升级版本可解决，或因版本不兼容导致不支持，需要在Reason中写出支持的软件版本信息；<br>②非升级可解决，Reason可以写不支持的原则，可以写支持的操作，可以写不支持的详细信息。 |
| EE1007 | 资源错误 · Bind_Stream | `id, reason` | `Failed to bind stream (stream_id=%s). Reason: %s.` | Cause: N/A.<br>Solution: Unbind the stream from the already bound model and then rebind it to the current model. | 流绑定到模型失败 | `model.cc:366`<br>`if (streamIn->GetModelNum() >= RT_MAX_MODELS_IN_ONE_STREAM) { RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, streamId, "The number of models exceeds the upper limit 256"); return RT_ERROR_STREAM_REUSE_LIMIT_MODEL_NUM; }` | `Failed to bind stream (stream_id=15). Reason: The number of models exceeds the upper limit 256. ErrorCode=EE1007.` | 专用于流绑定失败 |
| EE1009 | 执行错误 · Model | `id, reason` | `Failed to execute model (model_id=%s). Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 模型执行失败 | `capture_model.cc:490`<br>`COND_RETURN_AND_MSG_OUTER(streamNum == 0U, RT_ERROR_INVALID_VALUE, ErrorCode::EE1009, std::to_string(Id_()), "The current aclgraph model running instance neither contains any executable task nor contains any executable stream");` | `Failed to execute model (model_id=1). Reason: The current aclgraph model running instance neither contains any executable task nor contains any executable stream. ErrorCode=EE1009.` | id为模型ID |
| EE1010 | 执行错误 · Invalid_Context | `func, object, extend_info` | `%s execution failed because %s does not belong to the current context. Extended information: %s.` | Cause: N/A.<br>Solution: N/A. | stream/event不属于当前Context | `error_message_manage.hpp:197`<br>`COND_RETURN_AND_MSG_INVALID_CONTEXT_STREAM(curStm, curCtx, RT_ERROR_STREAM_CONTEXT);` // 内部展开：`RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1010, __func__, "stream", extendInfo);` | `rtKernelLaunch execution failed because stream does not belong to the current context. Extended information: stream_id=15, stream_ctx=0x7f..., cur_ctx=0x7f.... ErrorCode=EE1010.` | extend_info用于输出资源ID及Context指针，辅助定位归属关系 |
| EE1011 | 输入参数非法 · Invalid_Argument | `func, value, param, reason` | `%s failed. Value %s for parameter %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: 1. Check the input parameter range of the function. 2. Check the function invocation relationship. | 无法给出期望值，能给出非法值+原因，且"for parameter %s"通顺 | `api_impl.cc:478`<br>`kernel = Runtime::Instance()->KernelLookup(stubFunc); COND_RETURN_AND_MSG_OUTER(kernel == nullptr, RT_ERROR_KERNEL_NULL, ErrorCode::EE1011, __func__, static_cast<const char_t *>(stubFunc), "stubFunc", "The corresponding kernel cannot be found through stubFunc. The specified function address is invalid or the kernel status is abnormal");` | `rtKernelLaunch failed. Value "kernel_Add" for parameter stubFunc is invalid. Reason: The corresponding kernel cannot be found through stubFunc. The specified function address is invalid or the kernel status is abnormal. ErrorCode=EE1011.` | 加"parameter"通顺→EE1011；冗余→EE1012 |
| EE1012 | 输入参数非法 · Invalid_Argument | `func, value, param, reason` | `%s failed. Value %s for %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 无法给出期望值，能给出非法值+原因，加"parameter"冗余 | `api_impl.cc:4777`<br>`COND_RETURN_AND_MSG_OUTER(inNotify->CheckIpcNotifyDevId() != RT_ERROR_NONE, RT_ERROR_INVALID_VALUE, ErrorCode::EE1012, __func__, dev->Id_(), "current deviceId", "The current device cannot deliver Notify Wait, the corresponding Notify Wait must be delivered on the device that creates the IPC Notify");` | `rtNotifyWait failed. Value 0 for current deviceId is invalid. Reason: The current device cannot deliver Notify Wait, the corresponding Notify Wait must be delivered on the device that creates the IPC Notify. ErrorCode=EE1012.` | 与EE1011 Arglist相同，仅模板差异：EE1011有"for parameter"，EE1012仅有"for" |
| EE1013 | 资源错误 · Insufficient_Host_Memory | `buf_size, alloc_interface` | `Failed to allocate %s bytes of host memory via %s to Runtime.` | Cause: Allocation failed due to insufficient host memory.<br>Solution: Ensure that there is sufficient memory available. You can stop unnecessary processes to free up memory. | Host内存分配失败 | `ffts_task.cc:236`<br>`RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, std::to_string(sizeof(std::vector<rtFftsPlusTaskErrInfo_t>)), "new");` | `Failed to allocate 4096 bytes of host memory via new to Runtime. ErrorCode=EE1013.` | 默认内存单位为bytes；alloc_interface为分配接口名（如new/malloc） |
| EE1014 | 执行错误 · File_Parse | `reason` | `Failed to parse the binary file of the operator. Reason: %s.` | Cause: 1. The binary file of the operator is damaged. 2. The build parameter is incorrect.<br>Solution: Rebuild and load the binary file of the operator. | 由算子二进制文件损坏或构建参数无效，导致的算子ELF bin解析失败 | `elf.cc:215`<br>`RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1014, "The value " + std::to_string(size) + " of e_shentsize or the value " + std::to_string(num) + " of e_shnum in the operator binary ELF file header is incorrect. The expected value complies the following rule: both e_shentsize and e_shnum are not 0, and the product of the values of e_shnum and e_shentsize cannot be greater than the maximum value of uint64_t");` | `Failed to parse the binary file of the operator. Reason: The value 2048 of e_shentsize or the value 0 of e_shnum in the operator binary ELF file header is incorrect. The expected value complies the following rule: both e_shentsize and e_shnum are not 0, and the product of the values of e_shnum and e_shentsize cannot be greater than the maximum value of uint64_t. ErrorCode=EE1014.` | Reason中要详细描述文件解析失败的原因 |
| EE1015 | 不支持 · Incorrect_Driver_Version | `func, reason` | `%s failed. Reason: The driver version capacity is insufficient. %s` | Cause: N/A.<br>Solution: Upgrade the driver software version. | 驱动版本不正确，升级驱动版本可解决 | `runtime.cc:1897`<br>`COND_RETURN_AND_MSG_OUTER(tsdOpenNetService_ == nullptr, RT_ERROR_DRV_TSD_ERR, ErrorCode::EE1015, __func__, "Symbol TsdOpenNetService not found in libtsdclient.so.");` | `OpenNetService failed. Reason: The driver version capacity is insufficient. Symbol TsdOpenNetService not found in libtsdclient.so. ErrorCode=EE1015.` | 驱动符号不存在如需上报errmsg，可使用此错误码 |
| EE1016 | 不支持 · Not_Supported | `func, reason` | `%s failed. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | ①固有不支持：某种状态或场景下不支持做某类操作，如非ACL Graph模型不支持ModelUpdate、遇错即停模式从stop修改为continue不支持；<br>②完整功能不支持（完整功能，即一个完整的rt/rts接口） | ①固有不支持示例一：`api_impl.cc:1904`<br>`COND_RETURN_AND_MSG_OUTER((curStm->GetFailureMode() == STOP_ON_FAILURE) && (failmode == CONTINUE_ON_FAILURE), RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016, __func__, RtFmtMsg("Changing stream %u from stop mode to continue mode is not supported", curStm->Id_()));`<br>②固有不支持示例二：`COND_RETURN_AND_MSG_OUTER(mdl->GetModelType() != RT_MODEL_CAPTURE_MODEL, RT_ERROR_FEATURE_NOT_SUPPORT, ErrorCode::EE1016, __func__, "Non ACL Graph mode is not supported");`<br>③完整功能不支持示例：`api_error.cc:1766`<br>`COND_RETURN_AND_MSG_OUTER(error == RT_ERROR_STREAM_CAPTURE_MODE_BLOCK_ASYNC, error, ErrorCode::EE1016, __func__, "the operation has been converted to a synchronous operation. Operation not permitted when a stream is capturing and the specified capture mode is not relaxed");` | ①固有不支持示例一：`StreamSetMode failed. Reason: Changing stream 15 from stop mode to continue mode is not supported. ErrorCode=EE1016.`<br>②固有不支持示例二：`ModelUpdate failed. Reason: Non ACL Graph mode is not supported. ErrorCode=EE1016.`<br>③完整功能不支持示例：`MemCopy failed. Reason: the operation has been converted to a synchronous operation. Operation not permitted when a stream is capturing and the specified capture mode is not relaxed. EE1017. ErrorCode=EE1016.` | reason描述要点：<br>①固有不支持→强调是什么状态或场景不支持什么操作；<br>②完整功能不支持→可以写不支持的原则，可以写支持的操作，可以写不支持的详细信息 |
| EE1017 | 输入参数非法 · Invalid_Argument | `func, param, reason` | `%s failed. Parameter %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 无法给出参数具体值 | `stream.cc:1996`<br>`COND_RETURN_AND_MSG_OUTER(binHandle->GetKernelRegType() != RT_KERNEL_REG_TYPE_NON_CPU, RT_ERROR_INVALID_VALUE, ErrorCode::EE1017, __func__, "binHandle", "The binHandle obtained after registering the AI CPU operator is not supported");` | `BinaryGetMetaNum failed. Parameter binHandle is invalid. Reason: The binHandle obtained after registering the AI CPU operator is not supported. ErrorCode=EE1017.` | 两个或多个用户参数关系不满足时也可以使用，如用户参数A和B不满足A<B，具体参数值和参数关系在Reason里呈现 |
| EE1018 | 输入参数非法 · API_Call_Sequence | `func, reason` | `%s failed. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | API调用顺序错误 | `model.cc:888`<br>`COND_RETURN_AND_MSG_OUTER((endGraphNotify_ == nullptr) && dev->IsStarsPlatform(), RT_ERROR_MODEL_NOT_END, ErrorCode::EE1018, "aclmdlRIBuildEnd", "Before calling aclmdlRIBuildEnd, you must call aclmdlRIEndTask...");` | `aclmdlRIBuildEnd failed. Reason: Before calling aclmdlRIBuildEnd, you must call aclmdlRIEndTask... ErrorCode=EE1018.` | Reason应明确正确调用顺序 |
| EE1019 | 执行错误 · Execution_Error | `func, reason` | `%s failed. Reason: %s.` | Cause: N/A.<br>Solution: 1. Reduce the number of tasks delivered to the same stream. 2. Use multiple streams to submit tasks in parallel. | 流任务下发失败 | `stream_xpu.cc:105`<br>`RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1019, "Adding task to stream", "Stream task public buffer is full");` | `Adding task to stream failed. Reason: Stream task public buffer is full. ErrorCode=EE1019.` | / |
| EE1020 | 其他 · 标准函数失败 | `func1, func2, ret_code, reason, extend_info` | `%s failed. Reason: Standard function %s failed. [Errno %s] %s. %s` | Cause: N/A.<br>Solution: N/A. | 标准库函数失败，如memcpy_s | `task_to_sqe.cc:99`<br>`const errno_t ret = memcpy_s(...); COND_RETURN_AND_MSG_OUTER(ret != EOK, RT_ERROR_SEC_HANDLE, ErrorCode::EE1020, __func__, "memcpy_s", std::to_string(ret), strerror(ret), "src=..., dest=..., dest_max=..., count=...");` | `TaskToSqe failed. Reason: Standard function memcpy_s failed. [Errno 22] Invalid argument. src=... ErrorCode=EE1020.` | 如参数是用户传入，extend_info打印参数名而非默认src、dst等 |
| EE1021 | 资源错误 · Resource_Error | `resource_type, api` | `The runtime module failed to create host %s through API %s.` | Cause: Failed to create resources such as semaphores, locks, or threads due to insufficient system resources.<br>Solution: Stop unnecessary threads and ensure that the required resource is available. | 线程/锁/信号量创建失败 | `stars_engine.cc:171`<br>`const rtError_t error = mmSemInit(&recycleThreadSem_, 0U); if (error != RT_ERROR_NONE) { RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1021, "semaphore", "sem_init"); return RT_ERROR_MEMORY_ALLOCATION; }` | `The runtime module failed to create host semaphore through API sem_init. ErrorCode=EE1021.` | / |
| EE1022  | 输入参数非法 · Invalid_Argument(多参数) | `func, values, params, reason` | `%s failed. Values %s for parameters %s are invalid. Reason: %s.` | Cause: N/A.<br>Solution: 1. Check the input parameter value ranges of the function. 2. Check the function invocation relationship. | 多个参数同时非法 | `api_error_aclgraph.cc:64`<br>`COND_RETURN_AND_MSG_OUTER((status == nullptr) && (captureMdl == nullptr), RT_ERROR_INVALID_VALUE, ErrorCode::EE1022, __func__, "nullptr and nullptr", "status and captureMdl", "Parameters status and captureMdl cannot both be nullptr");` | `aclmdlRICaptureGetInfo failed. Values nullptr and nullptr for parameters status and captureMdl are invalid. Reason: Parameters status and captureMdl cannot both be nullptr. ErrorCode=EE1022.` | 多参数同时非法。|
| EE2002 | 配置与环境错误 · Invalid_Environment_Variable | `value, env, expect` | `Value %s for environment variable %s is invalid. Expected value: %s.` | Cause: N/A.<br>Solution: Reset the environment variable by referring to the Environment Variable Reference. | 环境变量值无效 | `runtime.cc:1135`<br>`MM_SYS_GET_ENV(MM_ENV_LD_LIBRARY_PATH, getPath); if (getPath == nullptr) { RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE2002, "NULL", "LD_LIBRARY_PATH", "a valid path containing \"runtime/lib64\""); return RT_ERROR_INVALID_VALUE; }` | `Value NULL for environment variable LD_LIBRARY_PATH is invalid. Expected value: a valid path containing "runtime/lib64". ErrorCode=EE2002.` | / |
| EE4001 🔸 | 执行错误 · Model_Binding | `extend_info` | `Failed to bind the stream to the model. %s` | Cause: The stream has been bound to another model.<br>Solution: Remove the repeated binding operation on the stream from the code. | 流绑定到模型失败 | 🔸 主线无使用 | / | 🔸 主线无使用 |
| EE4002 🔸 | 执行错误 · Model_Unbinding | `extend_info` | `Failed to unbind the stream to the model. %s` | Cause: 1. The stream to be unbound is not bound to the model. 2. The model is running.<br>Solution: 1. Check the code to ensure that the stream to be unbound is bound to the model. 2. Ensure that the model is not running. | 流从模型解绑失败 | 🔸 主线无使用 | 🔸 主线无使用 | 🔸 主线无使用 |
| EE4004 🔸 | 执行错误 · Profiling_Enable | `extend_info` | `Failed to enable profiling. %s` | Cause: N/A.<br>Solution: Do not enable profiling repeatedly. | Profiling重复开启 | 🔸 主线无使用 | 🔸 主线无使用 | 🔸 主线无使用 |

## EH错误码一览表

| ErrCode | errTitle(分类) | Arglist | ErrMessage | suggestion | 使用场景 | 使用示例 | 打屏效果 | 说明 |
|---------|---------------|---------|------------|------------|---------|---------|---------|------|
| EH0001 ⛔ | 输入参数非法 · Invalid_Argument(兜底) | `value, param, reason` | `Value %s for %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | ⛔ 仅兜底，不应增量调用 | N/A | `Value 1024 for offset+count is invalid. Reason: must be <= symbolSize. ErrorCode=EH0001.` | ⛔ 仅兜底，不应增量调用 |
| EH0002 ⛔ | 输入参数非法 · Null_Pointer(不含函数名) | `param` | `Argument %s must not be null.` | Cause: N/A.<br>Solution: Try again with a correct pointer argument. | ⛔ 不应增量调用，优先用EH0008 | `kernel.cpp:218`<br>`acl::AclErrorLogManager::ReportInputError("EH0002", {"param"}, {"dptr and size"});` | `Argument dptr and size must not be null. ErrorCode=EH0002.` | ⛔ 不含函数名，新代码优先用EH0008。 |
| EH0003 | 配置与环境错误 · Invalid_Path | `path, reason` | `Path %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 文件路径本身无效 | `acl_rt_impl_base.cpp:176`<br>`if (mmRealPath(configPath, realPath, MMPA_MAX_PATH) != EN_OK) { acl::AclErrorLogManager::ReportInputError(acl::INVALID_PATH_MSG, {"path", "reason"}, {configPath, formatErrMsg.c_str()}); return ACL_ERROR_INVALID_FILE; }` | `Path /usr/local/Ascend/ascend-toolkit/latest/acl.json is invalid. Reason: No such file or directory. ErrorCode=EH0003.` | ⚠️ EH0003=路径无效；EH0004=内容无效。 |
| EH0004 | 配置与环境错误 · File_Operation | `path, reason` | `File %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 文件内容无效 | `acl.cpp:403`<br>`if (!aclInitJsonHash.empty() && currentHash != aclInitJsonHash) { acl::AclErrorLogManager::ReportInputError(acl::INVALID_FILE_MSG, {"path", "reason"}, {configPath, errMsg.c_str()}); return ACL_ERROR_INVALID_PARAM; }` | `File /home/user/acl_init2.json is invalid. Reason: config content differs from the first aclInit config file path: /home/user/acl_init.json. ErrorCode=EH0004.` | ⚠️ EH0004=内容无效；EH0003=路径无效。 |
| EH0005 🔸 | 输入参数非法 · AIPP专用 | `param, reason` | `AIPP argument %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | AIPP参数非法 | 🔸 源码中无实际使用 | N/A | 🔸 AIPP专用码，预留未使用。 |
| EH0006 | 不支持 · Not_Supported | `feature, reason` | `%s is not supported. Reason: %s.` | N/A | 非芯片原因不支持 | `tensor_data_transfer.cpp:926`<br>`if (dataset->freeSelf) { acl::AclErrorLogManager::ReportInputError(acl::UNSUPPORTED_FEATURE_MSG, {"feature", "reason"}, {__func__, "item cannot be added because internal item already exists"}); return ACL_ERROR_FEATURE_UNSUPPORTED; }` | `acltdtAddDataItem is not supported. Reason: item cannot be added because internal item already exists. ErrorCode=EH0006.` | 芯片不支持→EH0011；非芯片→EH0006 |
| EH0007 ⭐ | 输入参数非法 · Invalid_Argument | `func, value, param, expect` | `%s failed because value %s for parameter %s is invalid. Expected value: %s.` | Cause: N/A.<br>Solution: 1. Check the input parameter range of the function. 2. Check the function invocation relationship. | 能输出非法值+参数名可打印+期望值 | `memory.cpp:108`<br>`acl::AclErrorLogManager::ReportInputError(acl::INVALID_VALUE_MSG, {"func", "value", "param", "expect"}, {__func__, acl::GetMemcpyKindDesc(kind), "kind", "ACL_MEMCPY_HOST_TO_DEVICE(1) or ..."});` | `GetMemcpy2dKind failed because value ACL_MEMCPY_HOST_TO_HOST for parameter kind is invalid. Expected value: ACL_MEMCPY_HOST_TO_DEVICE(1) or ... ErrorCode=EH0007.` | ⭐ ACL层首选码 |
| EH0008 ⭐ | 输入参数非法 · Null_Pointer(含函数名) | `func, param` | `%s failed because %s cannot be a NULL pointer.` | Cause: N/A.<br>Solution: Try again with a correct pointer argument. | NULL指针含函数名 | `memory.cpp:167`<br>`ACL_REQUIRES_NOT_NULL_WITH_INPUT_REPORT(dst);` | `aclrtMemcpy failed because dst cannot be a NULL pointer. ErrorCode=EH0008.` | ⭐ 空指针专用错误码 |
| EH0009 | 输入参数非法 · Invalid_Argument | `func, value, param, reason` | `%s failed. Value %s for parameter %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: 1. Check the input parameter range of the function. 2. Check the function invocation relationship. | 无法给出期望值，能给出具体非法值+原因 | `memory.cpp:176`<br>`acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_REASON_MSG, {"func", "value", "param", "reason"}, {__func__, widthVal.c_str(), "width", errMsg.c_str()});` | `CheckMemcpy2dPitchParam failed. Value 2048 for parameter width is invalid. Reason: must be less than spitch and dpitch, spitch=1024, dpitch=1024. ErrorCode=EH0009.` | 能给出具体非法值→EH0009；不能→EH0012 |
| EH0010 | 资源错误 · Insufficient_Host_Memory | `buf_size, alloc_interface` | `Failed to allocate %s bytes of host memory via %s to ACL.` | Cause: Allocation failed due to insufficient host memory.<br>Solution: Ensure that there is sufficient memory available. You can stop unnecessary processes to free up memory. | ACL层Host内存分配失败 | `json_parser.cpp:125`<br>`acl::AclErrorLogManager::ReportInputError(acl::ALLOC_MEMORY_FAILED_MSG, {"buf_size", "alloc_interface"}, {lengthVal.c_str(), "new"});` | `Failed to allocate 1024 bytes of host memory via new to ACL. ErrorCode=EH0010.` | 默认内存单位为bytes；alloc_interface为分配接口名（如new/malloc） |
| EH0011 | 不支持 · Not_Supported(芯片) | `func` | `The current system or device does not support %s.` | 无 | 芯片原因不支持 | `device.cpp:80`<br>`if (strncmp(socVersion.c_str(), "Ascend910", ...) != 0) { acl::AclErrorLogManager::ReportInputError(acl::UNSUPPORTED_SYSTEM_MSG, {"func"}, {"aclrtSetDeviceWithoutTsdVXX, only Ascend 910 chips are supported"}); return ACL_ERROR_API_NOT_SUPPORT; }` | `The current system or device does not support aclrtSetDeviceWithoutTsdVXX, only Ascend 910 chips are supported. ErrorCode=EH0011.` | 无reason字段 |
| EH0012 | 输入参数非法 · Invalid_Argument | `func, param, reason` | `%s failed. Parameter %s is invalid. Reason: %s.` | Cause: N/A.<br>Solution: N/A. | 无法给出参数具体值 | `allocator.cpp:157`<br>`const auto iter = g_AllocatorDesMap.find(stream); if (iter == g_AllocatorDesMap.end()) { acl::AclErrorLogManager::ReportInputError(acl::INVALID_PARAM_NO_VALUE_MSG, {"func", "param", "reason"}, {__func__, "stream", "The stream is not registered with any allocator"}); return ACL_ERROR_INVALID_PARAM; }` | `aclrtGetAllocator failed. Parameter stream is invalid. Reason: The stream is not registered with any allocator. ErrorCode=EH0012.` | 两个或多个用户参数关系不满足时也可以使用，如用户参数A和B不满足A<B，具体参数值和参数关系在Reason里呈现 |
| EH0013 | 其他 · 标准函数失败 | `func1, func2, ret_code, reason, extend_info` | `%s failed. Reason: Standard function %s failed. [Errno %s] %s. %s` | Cause: N/A.<br>Solution: N/A. | ACL层标准库函数失败 | `memory.cpp:1698`<br>`const auto ret = memcpy_s(...); if (ret != EOK) { const std::string extendInfo = "src=...,dst=...,dstLen=...,srcLen=..."; acl::AclErrorLogManager::ReportInputError(acl::STANDARD_FUNC_FAILED_MSG, {"func1", "func2", "ret_code", "reason", "extend_info"}, {__func__, "memcpy_s", retVal.c_str(), strerror(ret), extendInfo.c_str()}); }` | `GetBufDataWithOffset failed. Reason: Standard function memcpy_s failed. [Errno 22] Invalid argument. src=... ErrorCode=EH0013.` | 如参数是用户传入，extend_info打印参数名而非默认src、dst等 |
| EH0014 | 输入参数非法 · Null_Pointer(多指针同时NULL) | `func, param` | `%s failed because %s cannot be NULL pointers at the same time.` | Cause: N/A.<br>Solution: Try again with correct pointer arguments. | 多个指针同时为NULL | `kernel.cpp:216`<br>`if ((dptr == nullptr) && (size == nullptr)) { acl::AclErrorLogManager::ReportInputError(acl::INVALID_NULL_POINTER_AT_SAME_TIME_MSG, {"func", "param"}, {"aclrtBinaryGetGlobal", "dptr and size"}); return ACL_ERROR_INVALID_PARAM; }` | `aclrtBinaryGetGlobal failed because dptr and size cannot be NULL pointers at the same time. ErrorCode=EH0014.` |  多指针同时NULL。` |

## 易混淆错误码解析1：输入参数非法（Invalid Argument）

### EE 层选择决策树

```
输入参数非法？
  ├─ 多个参数同时非法（≥2个参数同时为NULL或同时非法）？
  │     ├─ 是 → EE1022（多参数同时非法专用）
  │     └─ 否 → 单个参数为 NULL 指针？
  │           ├─ 是 → ⭐ EE1004（空指针专用，优先使用）
  │           └─ 否 → 能给出精确期望值？
  │                 ├─ 是 → ⭐ EE1003（首选通用码）
  │                 └─ 否 → 无法给出期望值，但能用 Reason 解释原因？
  │                       ├─ 是 → Reason 描述在"for parameter %s"语境下通顺？
  │                       │     ├─ 是 → EE1011（"...for parameter %s is invalid. Reason: %s"）
  │                       │     └─ 否 → EE1012（"...for %s is invalid. Reason: %s"，省去"parameter"字样）
  │                       └─ 否 → 无法给出参数的具体输入值及期望值？
  │                             ├─ 是 → EE1017
  │                             └─ 否 → ⛔ EE1001（仅在宏ERROR_RETURN_WITH_EXT_ERRCODE中调用，用于rt接口层做兜底，Runtime其他场景不应触发EE1001）
```

#### EE1011 vs EE1012 选择规则

两者 Arglist 完全相同（func, value, param, reason），仅消息模板差异：

| 错误码 | 第3个 %s 前的文本 | 示例输出 |
|--------|-------------------|----------|
| **EE1011** | `for parameter` | `aclrtMalloc failed. Value 3 for parameter deviceId is invalid. Reason: ...` |
| **EE1012** | `for`（省去"parameter"） | `aclrtMalloc failed. Value 3 for deviceId is invalid. Reason: ...` |

**选择方法**：将第3个 arg 代入两种模板，读起来哪个自然就用哪个。如果加"parameter"反而语句不通（如参数名本身已是描述性短语"queue name length"），则用 EE1012；否则优先 EE1011。

### EH 层选择决策树

```
输入参数非法？
  ├─ 多个指针同时为NULL？
  │     ├─ 是 → EH0014（多指针同时NULL专用）
  │     └─ 否 → 单个参数为 NULL 指针？
  │           ├─ 是 → 能包含函数名？
  │           │     ├─ 是 → ⭐ EH0008
  │           │     └─ 否 → ⛔ EH0002
  │           └─ 否 → 能给出精确期望值？
  │                 ├─ 是 → ⭐ EH0007
  │                 └─ 否 → 无法给出期望值，但能给出具体非法值+Reason？
  │                       ├─ 是 → EH0009（"...Value %s for parameter %s is invalid. Reason: %s"）
  │                       └─ 否 → 无法给出参数的具体输入值？
  │                             ├─ 是 → EH0012（"...Parameter %s is invalid. Reason: %s"）
  │                             └─ 否 → ⛔ EH0001（仅兜底，ACL不应触发EH0001）
```

#### EH0009 vs EH0012 选择规则

两者核心差异是 Arglist 不同：

| 错误码 | Arglist | 能否给出具体非法值？ | 示例输出 |
|--------|---------|---------------------|----------|
| **EH0009** | func, value, param, reason | **能** | `aclrtDeviceCanAccessPeer failed. Value 0 for parameter deviceId is invalid. Reason: deviceId and peerDeviceId must be different.` |
| **EH0012** | func, param, reason | **不能** | `aclrtGetAllocator failed, Parameter stream is invalid. Reason: The stream is not registered with any allocator.` |

**选择方法**：能给出参数的具体输入值时优先用 EH0009（信息更完整）；无法给出具体值（如属性非法、条件性冲突）时用 EH0012。

#### EE 与 EH 参数非法优先级对齐映射

| 优先级 | EE 码（Runtime层） | EH 码（ACL层） | 语义对齐 |
|--------|--------------------|----------------|----------|
| 多个参数同时无效 | EE1022 | EH0014 | 多个参数同时满足非法条件，EH0014限定多参数为NULL |
| 空指针 | EE1004 | EH0008 ⭐ | 空指针专用 |
| 值+期望值 | EE1003 | EH0007 | 能输出非法值及期望正确值 |
| 值+原因 | EE1011 ⭐ / EE1012 | EH0009 | 无法给出期望值，能给出非法值+原因 |
| 无值+原因 | EE1017 | EH0012 | 无法给出具体输入值，仅参数名+原因 |
| 兜底 | EE1001 ⛔ | EH0001 ⛔ | 仅做兜底使用，其他场景不应触发 |

## 易混淆错误码解析2：不支持（Not Supported）

### EE 层选择决策树

```
驱动版本不正确，对应的驱动接口找不到，通过升级驱动包可解决？
  ├─ 是 → EE1015
  ├─ 否 → 完整功能，当前芯片不支持？
  │     ├─ 是 → EE1005
  │     └─ 否 → 非完整功能的某个配置参数不支持？
  │          ├─ 是 → EE1006
  │          └─ 否 → EE1016
```

| 优先级 | 错误码 | 消息格式（JSON ErrMessage） | Arglist | 选择依据 | 典型场景 |
|--------|--------|---------------------------|---------|----------|----------|
| **1** | **EE1015** | `%s failed. Reason: The driver version capacity is insufficient. %s` | func, reason | 驱动版本不正确，对应的驱动接口找不到，通过升级驱动包可解决 | 驱动版本不支持 halxxx 接口 |
| **2** | **EE1005** | `The current system or device does not support %s.` | func | 完整功能，当前芯片不支持 | aclrtMemMap 在当前芯片不支持 |
| **3** | **EE1006** | `%s failed. %s is not supported. Reason: %s.` | func, type, reason | 非完整功能的某个配置参数不支持。<br>①如通过升级版本可解决，或因版本不兼容导致不支持，需要在Reason中写出支持的软件版本信息；<br>②非升级可解决，Reason可以写不支持的原则，可以写支持的操作，可以写不支持的详细信息。 | ACL_FLOAT16 数据类型在当前SoC不支持 |
| **4** | **EE1016‑固有不支持** | `%s failed. Reason: %s.` | func, reason | 某种状态或场景下不支持做某类操作 | 遇错即停模式从 stop 修改为 continue 不支持 |
| **4** | **EE1016‑完整功能不支持** | `%s failed. Reason: %s.` | func, reason | 完整功能不支持，和芯片无关 | MemCopy操作已被转换为同步操作。当流正在捕获且指定的捕获模式非宽松模式时，不允许执行该操作。 |


#### EE1005 vs EE1006 vs EE1016 选择规则

| 对比 | 关键区别 | 选择方法 |
|------|---------|---------|
| EE1005 vs EE1016‑版本相关不支持 | 同是完整功能不支持。EE1005 芯片层面，EE1016 非芯片原因 | 根因在芯片→EE1005；根因在软件版本或某种状态不支持某种操作→EE1016 |
| EE1006 vs EE1016‑版本相关不支持 | EE1006 **非完整功能**（配置参数），EE1016‑版本相关 **完整功能** | 不支持的是某个配置参数→EE1006；不支持的是完整功能本身→EE1016 |

### EH 层选择决策树

```
完整功能，当前芯片不支持？
  ├─ 是 → EH0011
  └─ 否 → EH0006
```

**选择方法**：根因是**当前芯片不支持**（换芯片可解决）→ EH0011；根因是**非芯片原因**（配置参数版本/固有限制/软件版本）→ EH0006。

#### EE 与 EH 不支持对齐映射

| 不支持类型 | EE 码 | EH 码 | 备注 |
|-----------|-------|-------|------|
| 驱动版本不正确 | EE1015 | — | 内部原因，EH层不映射 |
| 完整功能，芯片不支持 | EE1005 | EH0011 | 换芯片可解决 |
| 非完整功能配置参数 | EE1006 | EH0006 | reason 注明详细要求 |
| 固有不支持 | EE1016‑固有不支持 | EH0006| reason 说明是固有限制 |
| 完整功能不支持 | EE1016‑完整功能不支持 | EH0006 | reason 注明详细要求 |

## 常见错误

### ❌ 错误1：用兜底码替代专用码

```cpp
// ✗ 错误：明明是 NULL 指针，却用 EE1001
RT_LOG_OUTER_MSG(RT_INVALID_ARGUMENT_ERROR, "stream cannot be NULL");

// ✓ 正确：用专用码 EE1004
PARAM_NULL_RETURN_ERROR_WITH_EXT_ERRCODE(stream, RT_ERROR_INVALID_VALUE);
```

### ❌ 错误2：EH0003/EH0004 混淆

```cpp
// ✗ 错误：文件 JSON 解析失败却用 EH0003（路径无效）
ReportInputError(INVALID_PATH_MSG, {"path", "reason"}, {fileName, "JSON parse error"});

// ✓ 正确：文件内容无效用 EH0004
ReportInputError(INVALID_FILE_MSG, {"path", "reason"}, {fileName, "JSON parse error at line 5"});
```

### ❌ 错误3：EE1012 误用（应按语境选择 EE1011 或 EE1012）

```cpp
// ✗ 错误：参数名为 "deviceId"，加"parameter"完全通顺，却用了 EE1012
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1012, "3", "deviceId", "must be in [0,7]");
// 输出：aclrtMalloc failed. Value 3 for deviceId is invalid. — 缺少"parameter"不够正式

// ✓ 正确：参数名为 "deviceId"，加"parameter"通顺 → 用 EE1011
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1011, "3", "deviceId", "must be in [0,7]");
// 输出：aclrtMalloc failed. Value 3 for parameter deviceId is invalid.

// ✓ 正确：参数名为 "queue name length"，加"parameter"冗余 → 用 EE1012
RT_LOG_OUTER_MSG_WITH_FUNC(ErrorCode::EE1012, "256", "queue name length", "must be <= 128");
// 输出：aclrtSetQueueAttr failed. Value 256 for queue name length is invalid. — 自然通顺
```

### ❌ 错误4：版本相关的完整功能不支持误用 EE1005

```cpp
// ✗ 错误：CANN版本相关的完整功能不支持，却用了芯片层面的EE1005
// 输出：The current system or device does not support aclrtXxx.
// 问题：根因是CANN版本而非芯片，用户误以为换芯片才能解决

// ✓ 正确：用 EE1016‑版本相关不支持
EE1016: func="aclrtXxx", reason="This feature requires CANN 3.x. CANN 2.x and 3.x packages are incompatible. Please upgrade the CANN package to 3.x."
// 输出：aclrtXxx failed. Reason: This feature requires CANN 3.x. CANN 2.x and 3.x packages are incompatible. Please upgrade the CANN package to 3.x.
```

### ❌ 错误5：固有不支持误用 EE1006

```cpp
// ✗ 错误：遇错即停模式从stop改为continue是固有不支持，却用了EE1006
// 输出：aclrtSetErrMode execution failed because stop-to-continue mode switch is not supported. Reason: ...
// 问题：这不是配置参数的版本依赖问题，而是固有限制

// ✓ 正确：用 EE1016‑固有不支持
EE1016: func="aclrtSetErrMode", reason="Changing stop mode to continue mode is intrinsically not supported and cannot be resolved by upgrading."
// 输出：aclrtSetErrMode failed. Reason: Changing stop mode to continue mode is intrinsically not supported and cannot be resolved by upgrading.
```

### ❌ 错误6：非算子 ELF 解析场景误用 EE1014

EE1014 的 ErrMessage 模板硬编码为 `Failed to parse the binary file of the operator. Reason: %s.`，仅适用于算子 ELF bin 解析失败。其他文件操作场景误用会输出误导性信息，且其 suggestion（Rebuild and load the binary file of the operator）对非解析场景无指导意义。

```cpp
// ✗ 错误：读取二进制文件时路径无法访问，却用了 EE1014
RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1014, RtFmtMsg("Path %s cannot be accessed", binPath_.c_str()));
// 输出：Failed to parse the binary file of the operator. Reason: Path /xxx/xxx cannot be accessed. ErrorCode=EE1014.
// 问题：实际场景是路径访问失败，非算子ELF解析失败，ErrMessage 与 suggestion 均不适用

// ✓ 正确：用 EE1012（无法给出期望值，能给出非法值+原因）
RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1012, "Read binary file", binPath_, "binPath_", RtFmtMsg("Path %s cannot be accessed", binPath_.c_str()));
// 输出：Read binary file failed. Value /xxx/xxx for binPath_ is invalid. Reason: Path /xxx/xxx cannot be accessed. ErrorCode=EE1012.
```

### ❌ 错误7：流状态限制误用 EE1006（model stream 场景）

stream 处于 model stream 状态（`GetBindFlag()` 为 true）时不支持某些操作，属于"某种状态下不支持某类操作"的固有不支持。若将 model stream 误当作配置参数类型，会错用 EE1006。

```cpp
// ✗ 错误：model stream 是流的运行时状态，不是配置参数，却用了 EE1006
COND_RETURN_AND_MSG_OUTER(stm->GetBindFlag(), RT_ERROR_STREAM_INVALID, ErrorCode::EE1006, __func__,
    "Clearing model stream", "xxx");
// 输出：StreamClear failed. Clearing model stream is not supported. Reason: xxx. ErrorCode=EE1006.
// 问题：model stream 是 stream 的运行时状态而非配置参数，不属于"非完整功能，某个配置参数不支持"，误用 EE1006 会引导用户去检查参数配置；往上追溯到rtStreamClear接口，是完整功能（非"非完整功能"）。两个条件都不满足EE1006的使用前提

// ✓ 正确：model stream 是一种状态/场景，该状态下不支持 clear 操作 → EE1016-固有不支持
COND_RETURN_AND_MSG_OUTER(
    stm->GetBindFlag(), RT_ERROR_STREAM_INVALID, ErrorCode::EE1016, __func__, "Clearing model stream is not supported");
// 输出：StreamClear failed. Reason: Clearing model stream is not supported. ErrorCode=EE1016.
```

## 关键源文件索引

| 文件 | 作用 |
|-----|------|
| `src/dfx/error_manager/error_code.json` | ErrCode 元数据定义 |
| `src/runtime/core/inc/common/rt_log.h` | ErrorCode 枚举 |
| `src/runtime/core/inc/common/error_code_meta.h` | X-Macro 参数表 |