<!-- ==================== HERO ==================== -->

<h1 align="center">CANN Runtime</h1>

<p align="center">
  <b>Lightweight runtime for Ascend AI processors · consistent across device and cloud · high-performance inference</b><br>
  CANN Runtime is the core runtime foundation of Ascend AI processors. It provides a unified API, so that upper-layer applications, AI frameworks, and acceleration libraries can efficiently use the hardware compute resources of Ascend AI processors.
</p>

---

<!-- ==================== DOCUMENTATION MAP ==================== -->
## 📚 Documentation map

| Document | Purpose and content | Entry |
|------|-----------|------|
| **⚡ Quick start** | For developers who are new to Runtime. Introduces Runtime and explains the programming model. Read these documents in order | [Runtime overview](quick_start/Runtime_overview.md) · [Programming model](quick_start/Runtime_programming_model.md) |
| **📖 Development guide** | In-depth development manual for developers who have completed the Hello CANN example and want to understand the principles. Explains the principles and provides sample code | [Development guide](dev_guide/README.md) |
| **📋 API reference** | Interface dictionary. Look up function definitions during development. Provides function signatures, parameter descriptions, and return values | [Header files](api_ref/01_overview.md) · [API reference](api_ref/README.md) |
| **📋 Log reference** | Explains how to set the log level and where to obtain log files when you troubleshoot issues. Also describes the log content format and log configuration | [Log reference](log_ref/README.md) |
| **📋 Error code reference** | Error code dictionary. Look up the error information, possible causes, and solutions for an error code during debugging | [Error code reference](error_code_ref/README.md) |
| **📋 Environment variable reference** | Environment variable dictionary. Look up the function, value range, configuration method, and usage constraints of environment variables during development and running | [Environment variable reference](env_vars/README.md) |
| **🏗️ Architecture guide** | Architecture documentation for contributors. Describes the overall Runtime architecture, module design, and core components | [Architecture guide](design/README.md) |
| **📝 Development specifications** | Specification guide for contributors, including design document templates, coding specifications, test specifications, and code review rules | [Development specifications and contribution guide](guidelines/README.md) |

---

<!-- ==================== LEARNING PATH ==================== -->
## 🗺️ Learning path

Follow this path step by step, from environment preparation to independent development:

### 🌱 Getting started

| Step | Description | Entry |
|---------|---------|------|
| **Environment preparation** | One-click CANN installation | [One-click CANN installation](https://www.hiascend.com/cann/download) |
| **Concepts and principles** | Core Runtime concepts and programming model: Host-Device architecture, Context, Stream, synchronous and asynchronous operations, and typical execution flow | [Runtime overview](quick_start/Runtime_overview.md) · [Programming model](quick_start/Runtime_programming_model.md) |
| **Hello CANN** | Your first runnable Runtime program, which completes a minimal compute loop | [Hello CANN](../../example/0_quickstart/0_hello_cann/README.md) |

---

### 🚀 Intermediate

| Topic | Key content | Sample |
|------|---------|---------|
| **Initialization** | Environment initialization, device resource configuration, log management, and so on | [device_normal](../../example/1_basic_features/device/0_device_normal/README.md) |
| **Memory management** | Host memory management, device memory management, multi-stream synchronized memory, memory copy (synchronous and asynchronous), physical memory sharing by PID, and so on | [h2d_sync_memory_copy](../../example/1_basic_features/memory/1_h2d_sync_memory_copy/README.md) |
| **Asynchronous tasks** | Stream management, event management, kernel loading and execution, memory semantic synchronization, and so on | [simple_stream](../../example/1_basic_features/stream/0_simple_stream/README.md) |

---

### 🔥 Advanced

| Topic | Key content | Sample |
|------|---------|---------|
| **ACL Graph** | Single-stream capture, cross-stream capture, task update, and so on | [model_update](../../example/2_advanced_features/model_ri/1_model_update/README.md) |
| **Multi-device programming** | Cross-device data exchange, P2P memory access, multi-card parallel scheduling, and so on | [device_P2P](../../example/1_basic_features/device/2_device_P2P/README.md) |
| **Inter-process communication** | IPC event synchronization, IPC memory sharing (with or without a specified PID), and so on | [ipc_event](../../example/2_advanced_features/ipcevent/0_ipcevent/README.md) · [ipc_memory](../../example/1_basic_features/memory/11_ipc_memory_withoutpid/README.md) |
| **Performance tuning** | Profiling collection and export, obtaining operator performance data of a network model, visualizing parsed raw performance data, and so on | [create_config](../../example/5_performance/profiling/0_create_config/README.md) |

---

<!-- ==================== FAQ ==================== -->
## ❓ FAQ

| Question type | Typical scenario | Entry |
|---------|---------|------|
| **Getting started** | Common questions about initialization failures, device configuration, version compatibility, and so on | [Version mismatch](FAQ/mismatch_version_between_Runtime_and_CANN.md) · [aclInit failure](FAQ/aclInit_initialization_failures.md) · [aclrtSetDevice failure](FAQ/aclrtSetDevice_call_failure.md) · [Long duration of the first aclrtSetDevice](FAQ/first_time_aclrtSetDevice_task_long_time.md) · [Default mechanisms](FAQ/understand_default_device_and_default_stream.md) |
| **Basic development** | Questions about basic APIs such as memory management, stream synchronization, and data copy | [Memory allocation failure](FAQ/aclrtMalloc_allocation_failures.md) · [Stream task delivery failure](FAQ/aclrtMemcpyAsync_fail_in_incorrect_stream.md) · [Memory policy](FAQ/select_proper_mem_allocation_policy.md) · [Synchronization mechanism](FAQ/diff_between_Stream_and_Event_sync.md) |
| **Advanced scenarios** | Questions about complex scenarios such as multi-device programming, ACL Graph, and inter-process communication | [Multi-device stream](FAQ/multi_devices_stream_tasks_deliver_fail.md) · [ACL Graph task submission](FAQ/ACLGraph_restrictions.md) · [IPC page table alignment](FAQ/inter_process_IPC_page_table_align_requirements.md) · [P2P configuration failure](FAQ/cross_device_data_interaction_configuration_fail.md) |
| **Troubleshooting** | Diagnostic methods such as error code interpretation, operator exceptions, and log-based troubleshooting | [Asynchronous error codes](FAQ/obtain_and_understand_Runtime_async_errCodes.md) · [EE1023 insufficient resources](FAQ/EE1023_insufficient_resource.md) · [Abnormal operator output](FAQ/all_zero_output_common_causes.md) · [Stop-on-error troubleshooting](FAQ/stop_on_error_locate_method.md) · [plog-based troubleshooting](FAQ/use_plog_locate_device_exceptions.md) |

---

## 📝 Notes

The Chinese version is the reference version for documents in the docs directory. A professional team translates and reviews the English version before release. Because of the translation and release cycle, the English version may lag behind the Chinese version. If the Chinese and English versions differ, the Chinese version takes precedence.

---

<!-- ==================== FOOTER ==================== -->
<p align="center">
  <b>Related resources</b><br>
  <a href="https://www.hiascend.com">Ascend Community</a> ·
  <a href="../../example/README.md">Runtime sample repository</a> ·
  <a href="https://www.hiascend.com/document">Complete documentation center</a>
</p>

<p align="center">
  <sub>CANN Runtime documentation | Ascend</sub>
</p>
