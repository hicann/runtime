# Error Message 翻译总表汇总

---

## EE1003

**errTitle:** Invalid_Argument

**new ErrMessage:** %s failed because value %s for parameter %s is invalid. Expected value: %s.

**Arglist:** func, value, param, expect

**reason具体描述:**

- 1.exclusive OR value with RT_EVENT_FLAG
- 2.greater than or equal to 0

**suggestion.Solution:**

- 1.Check the input parameter range of the function.
- 2.Check the function invocation relationship.

---

## EE1006

**errTitle:** Not_Supported

**new ErrMessage:** %s failed. %s is not supported. Reason: %s.

**Arglist:** func, type, reason

**reason具体描述:**

- 1.The P2P memory type is not supported in OFFLINE mode.
- 2.Fusion tasks support only the combinations of HCOMM and AI Core, AI CPU and AI Core, CCU and AIC, or a single CCU task.
- 3.The current SoC supports only streams with a normal number of tasks and does not support huge streams.
- 4.Device-only events can be called only on the device.
- 5.The current stream is used to carry AI CPU scheduling tasks and does not support priority setting.
- 6.The current SoC does not support the reduction operation of this data type.
- 7.The current SoC does not support P2P memory allocation.
- 8.The policy of allocating only huge page memory conflicts with the policy of allocating the underlying cache memory.

**suggestion.Possible Cause:**

- 1.The current CANN software version is not supported.
- 2.The current driver software version does not supported.
- 3.The current chip version is not supported.

**suggestion.Solution:**

- 1.Upgrade the CANN software version.
- 2.Upgrade the driver software version.

---

## EE1007

**errTitle:** Resource_Error_Bind_Stream

**new ErrMessage:** Failed to bind stream with ID %s. Reason: %s.

**Arglist:** id, reason

**reason具体描述:**

- 1.Failed to bind the model with the stream. The stm parameter cannot be the stream whose flag is %u.
- 2.Non-persistent stream cannot be bound to a model.
- 3.The stream is bound to more than one mdlRI. Size: %u
- 4.The stream is already bound.
- 5.The AI CPU stream is reused.
- 6.The number of models exceeds the upper limit 256.
- 7.The model has been bound to another stream.

**suggestion.Solution:**

- Unbind the stream from the already bound model and then rebind it to the current model.

---

## EE1009

**errTitle:** Execution_Error_Model

**new ErrMessage:** Failed to execute model with ID %s. Reason: %s.

**Arglist:** id, reason

**reason具体描述:**

- 1.The current stream cannot be the same as the model stream.
- 2.The stream whose flag is %u cannot be used for model execution.
- 3.The current aclgraph model running instance neither contains any executable task nor contains any executable stream.

---

## EE1011

**errTitle:** Invalid_Argument

**new ErrMessage:** %s failed. Value %s for parameter %s is invalid. Reason: %s.

**Arglist:** func, value, param, reason

**reason具体描述:**

- 1.Non-persistent stream %u does not support stream task clearance.
- 2.Stream %u must be bound to a model.
- 3.AI CPU stream %u does not support stream task clearance.
- 4.The count cannot exceed the maximum value destMax %" PRIu64 ".
- 5.memcpyAddrInfo is not 64-byte aligned.
- 6.The corresponding kernel cannot be found through stubFunc. The specified function address is invalid or the kernel status is abnormal.
- 7.The corresponding kernel cannot be found through tilingKey. The tilingKey is invalid or the kernel status is abnormal.
- 8.Stream %d is not in the current context.
- 9.%s failed. Value %s for parameter %s is invalid. Reason: The stream is not bound to a model.
- 10.Stream %d with the flag ACL_STREAM_DEVICE_USE_ONLY cannot be bound to a model.

**suggestion.Solution:**

- 1.Check the input parameter range of the function.
- 2.Check the function invocation relationship.

---

## EE1012

**errTitle:** Invalid_Argument

**new ErrMessage:** %s failed. Value %s for %s is invalid. Reason: %s.

**Arglist:** func, value, param, reason

**reason具体描述:**

- 1.The current device cannot deliver Notify Wait. The corresponding Notify Wait must be delivered on the device that creates the IPC Notify.

**suggestion.Possible Cause:**

The host memory is insufficient.

---

## EE1014

**errTitle:** File_Operation_Error_Parse

**new ErrMessage:** Failed to parse the binary file of the operator. Reason: %s.

**Arglist:** reason

**reason具体描述:**

- 1.The value %u of e_shentsize or the value %u of e_shnum in the operator binary ELF file header is incorrect. The expected value complies the following rule: both e_shentsize and e_shnum are not 0, and the product of the values of e_shnum and e_shentsize cannot be greater than the maximum value of uint64_t.
- 2.The value %u of e_shentsize in the operator binary ELF file header must be equal to the size %u of the ELF section header.
- 3.The ELF section header address in the operator binary ELF file header cannot be empty.
- 4.The offset %u of the section ranked %u exceeds the size %u of the ELF object.
- 5.The value %u of sh_link in the section ranked %u is invalid. The valid value range is [%u, %u].
- 6.The value %lu of section->sh_entsize is invalid. The valid value range is (0, %lu].
- 7.The value %zu of section->sh_entsize is invalid. The valid value must be greater than or equal to %u.
- 8.The offset %u of the sh_ent ranked %u exceeds the size %u of the ELF object.
- 9.The ELF file must be a 64-bit file.
- 10.Get meta section failed,kernelName=s%, meta type=%u

**suggestion.Possible Cause:**

- 1. The binary file of the operator is damaged.
- 2.The build parameter is incorrect.

**suggestion.Solution:**

- Rebuild and load the binary file of the operator.

---

## EE1015

**errTitle:** Package_Error_Incorrect_Driver_Version

**new ErrMessage:** %s failed. Reason: The driver version capacity is insufficient. %s

**Arglist:** func, reason

**reason具体描述:**

- 1.The current version %u is earlier than the required version %u.

**suggestion.Solution:**

- Upgrade the driver software version.

---

## EE1016

**errTitle:** Not_Supported

**new ErrMessage:** %s failed. Reason: %s.

**Arglist:** func, reason

**reason具体描述:**

- 1.Other threads of the current context are in the capture state. As a result, the current operation cannot be performed on the thread. To perform this operation in the current thread, call aclmdlRICaptureThreadExchangeMode to change the capture mode of the current thread. The mode set using the aclmdlRICaptureBegin API is %d, the capture mode of the current thread is %d, and the mode set using the aclmdlRICaptureThreadExchangeMode API is %d.
- 2.The current thread %d is in the capture mode and the current operation cannot be performed.  Check whether the mode set by the aclmdlRICaptureBegin API supports the current operation. This operation is supported only in the RELAXED mode. The mode set using the aclmdlRICaptureBegin API is %d, the capture mode of the current thread is %d, and the mode set using the aclmdlRICaptureThreadExchangeMode API is %d.
- 3.Other threads of the current context are in the capture mode. As a result, the current operation cannot be performed on the thread. contextCaptureMode=%d, threadCaptureMode=%d, exchangeCaptureMode=%d

**suggestion.Solution:**

- 1. Check whether the mode set by the aclmdlRICaptureBegin API supports the current operation in the current thread %d.

---

## EE1017

**errTitle:** Invalid_Argument

**new ErrMessage:** %s failed. Parameter %s is invalid. Reason: %s.

**Arglist:** func, param, reason

**reason具体描述:**

- 1.Model %u where stream %u is located has not been loaded. Clear stream tasks after the model is loaded.
- 2.The specified address must be a device address.
- 3.The corresponding task cannot be found through the device ID %d, stream ID %u, and task ID %u.
- 4.The device memory address %" PRIu64 " for storing the data to be updated in the configuration is inconsistent with the currently specified device memory address %" PRIu64 ". Ensure that the same device memory address is used for multiple task updates.
- 5.Stream %d associated with label [%u] is not in the current context.
- 6.Stream %d associated with label [%u] is not in the model. Call the rtLabelSet API to bind the stream to the model first.
- 7.The stream associated with label [%u] is not in the same model as that associated with label [0]. The stream associated with label [%u] belongs to model %u, and the stream associated with label [0] belongs to model %u.
- 8.Only the random number generation task supports this update operation.
- 9.The number (%u) of parameters whose para.type is place holder in argHandle must be less than %u.
- 10.Model %u bound to the stream is inconsistent with model %u to which the label belongs.
- 11.The current stream %u is inconsistent with the stream %u associated with the label.
- 12.The persistent stream does not support task execution status query.
- 13.The callback function fn has been registered and cannot be registered again.
- 14.The callback function fn has not been registered.
- 15.The current task type does not support this operation.

---

## EE1018

**errTitle:** Invalid_Argument_API_Call_Sequence

**new ErrMessage:** %s failed. Reason: %s.

**Arglist:** func, reason

**reason具体描述:**

- 1.Before setting the label using aclrtSetLabel, you need to call aclrtCreateLabelList to create a label list.
- 2.The task or stream %u on device %u is in abort state.This API does not need to be called again.
- 3.Before calling aclmdlRIBuildEnd, you must call aclmdlRIEndTask to mark the end of task delivery in the stream.
- 4.Before calling rtModelExecute, you must call rtEndGraph to deliver the endgraph flag to the stream of the model.
- 5.Before calling rtModelExecute, you must call rtEndGraph to deliver the endgraph flag to the stream of the model.
- 6.The model associated with the label has been destroyed.
- 7.The label cannot be set repeatedly.
- 8.The device has multiple computing power groups.You must call the rtSetGroup API to specify the computing power group to be used for the current operation.
- 9.The operator information cache function is not enabled.Call the rtSetStreamAttribute API to enable the operator information cache function first.
- 10.The rtModelLoadComplete or rtStreamEndCapture API can be called only once.
- 11.Stream %d is not bound to any thread. Call the rtSubscribeReport API to bind a thread to the stream.
- 12.Label [%u] is not associated with any stream. Call the rtSetLabel API to associate the label with a stream.

---

## EE9999

**errTitle:** 

**new ErrMessage:** 

**Arglist:** 

**reason具体描述:**

- 1.Failed to load the module because the program size (which should be greater than 0) is 0.
- 2.Failed to allocate device memory for the rtArgsEx_t.args parameter.
- 3.Failed to obtain the SO address based on the SO name.
- 4.The current stream status does not meet the conditions for sending the task.
- 5.Post-processing after task submission failed.
- 6.The same label already exists in the label list.
- 7.Failed to copy the label info from the host to the device.
- 8.Label ID %u is released repeatedly.
- 9.devDstAddr is set repeatedly.
- 10.The current thread is different from the thread that executes StreamBeginCapture.
- 11.Failed to set notify before model execution.
- 12.Failed to wait for all tasks in the stream to complete.
- 13.Failed to unbind the stream from the model.The specified stream is not bound to the current model.
- 14.The model does not contain any stream.
- 15.The length of str must be greater than 0.
- 16.The type of the last task in the stream is not event record.
- 17.The capture event has not been recorded.
- 18.The re-applied SQ, CQ, or logical CQ is inconsistent with the original value.
- 19.The SQ and CQ have been applied for the current stream and cannot be applied for again.
- 20.The remote SQ cannot be reused.
- 21.The number of threads subscribing to synchronous scheduling exceeds the maximum value %u.
- 22.The TS status is abnormal.
- 23.Device %u is faulty.
- 24.The stream status is %u.
- 25.The model stream is full.
- 26.Value %u of sendSqenum cannot be greater than the maximum number (%u) of SQEs allowed by the task.
- 27.The total number of SQEs (%u) cannot be greater than the SQ depth %u.
- 28.Device %u is unavailable.
- 29.The number of tasks cannot exceed the size of the task group.
- 30.During task cleaning, the SQ must be disabled.
- 31.The DQS stream cannot be created by using ts_id %u.Instead, it should be created by using ts_id %u.
- 32.The mbuf pool info corresponding to qid %u does not exist.Check the configuration process.
- 33.The depended program may have been released.
- 34.The current label has been set to another stream.
- 35.The abort status queried from the device is invalid.
- 36.Stream reclamation timed out.
- 37.Failed to reclaim the task.
- 38.The ACL graph model %u bound to the current stream %u does not meet the update condition.All ACL graph models in the running or capture state cannot be updated.
- 39.The stream that delivers the CmoAddr task is not in the model.
- 40.Stream %d of the specified DVPP group cannot be bound to a model.

---

## EH0009

**errTitle:** Invalid_Argument

**new ErrMessage:** %s failed. Value %s for parameter %s is invalid. Reason: %s.

**Arglist:** func, value, param, reason

**reason具体描述:**

- 1.The stream is not registered with any allocator.
- 2.The specified parameter %d is shorter than the length of the group computing power information. As a result, the computing power information cannot be saved.
- 3.The data type is currently not supported.
- 4.The current physical memory attribute is not supported.

**suggestion.Solution:**

- 1.Check the input parameter range of the function.
- 2.Check the function invocation relationship.

---

## EH0011

**errTitle:** Not_Supported

**new ErrMessage:** The current system or device does not support %s.

**Arglist:** func

**reason具体描述:**

- 1.Only Ascend 910 chips are supported.

---
