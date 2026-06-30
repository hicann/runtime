---
name: hlt-to-sample-generator
description: 将 CANN Runtime HLT（高层测试）代码转换为可运行的 example 样例。当用户要求基于 HLT 生成 sample、回复 issue 样例请求、说"生成样例"、"从 HLT 转 sample"、"新增 example"、"写个 sample"、"样例开发"时使用此 skill。也适用于"参照测试代码写样例"、"把测试改成 example"等场景。
---

# HLT → Sample 生成器

将 HLT 测试代码转换为 CANN Runtime example 目录下的可运行样例，遵循现有样例的格式规范和构建模式。

## 工作流程

### Step 1: 分析 HLT 源码

获取用户提供的 HLT 测试代码（URL 或本地路径），提取：

- 核心 Runtime API 调用链（哪些 acl/aclrt 接口，调用顺序）
- 场景拆分（HLT 可能包含多个测试函数，每个对应一个场景）
- 使用的算子类型（自定义 AscendC kernel 还是 aclnn 预置算子）
- 数据规模和形状
- 构建模式线索（Capture 模式 vs Build 模式）

输出：**HLT 分析摘要**，包含上述信息，呈现给用户确认。

### Step 2: 交互确认

与用户确认以下关键决策点，不要假设：

1. **是否简化自定义算子？** HLT 常用自定义 AscendC kernel（如 VectorAddDo），sample 可选择：
   - 用 aclnn 预置算子替代（减少依赖，降低复杂度）— 推荐
   - 保留自定义 kernel（需要 kernel_func/ 目录和 ascendc.cmake 构建链）
   
2. **目标平台？** 不同的 SoC 对特性支持不同，影响：
   - README 中产品支持情况表
   - 是否需要平台检测和优雅降级
   - CANN 版本要求
   
3. **构建模式？** 如果涉及 model RI：
   - Capture 模式（`aclmdlRICaptureBegin/End`）— 录制后回放
   - Build 模式（`aclmdlRIBuildBegin/End`）— 即时构建
   
4. **场景选择？** HLT 可能包含多个场景（IF/WHILE/SWITCH 及嵌套组合），确认保留哪些

5. **结果验证？** sample 通常只打印输出数据，不做严格数值验证，确认用户期望

### Step 3: 确定样例目录位置

根据功能类别，确定样例应放在哪个目录下：

| 功能类别 | 目录 |
|---------|------|
| 快速入门 | `example/0_quickstart/` |
| 基础功能（Device/Stream/Event/内存） | `example/1_basic_features/` |
| 高级功能（model_ri/kernel/callback/label/notify/tdt） | `example/2_advanced_features/` |
| 内存进阶（allocator/cache/host_register） | `example/3_memory_advanced/` |
| 可靠性（overflow_detection/error_recovery） | `example/4_reliability/` |
| 性能（adump/profiling） | `example/5_performance/` |
| 场景化 | `example/6_scenarios/` |

在每个类别下创建新的子目录，编号顺延现有目录（如已有 0_simple_model、1_model_update、2_model_switch，则新建 3_xxx）。

### Step 4: 选择构建模式

根据 Step 2 的确认结果，从 `references/sample-build-patterns.md` 中选择匹配的 CMake 构建模式和 run.sh 模式。关键决策因素：

- 是否需要 AscendC kernel → 用 ascendc.cmake 构建链
- 是否需要 aclnn 算子 → 链接 libnnopbase.so + libopapi.so，include aclnn 目录
- 是否需要 repo 未发布 API → include repo include/external 目录（优先于 CANN 包头文件）
- 是否是 profiling/adump → 链接特定库（libmsprofiler.so / libascend_dump.so）

**自定义 kernel 选择指南**（当用户选择保留自定义 kernel 时）：

- `ascendc_library(kernels STATIC xxx.cpp)` — 用于简单 kernel（不需要 <<<>>> 调用语法），生成静态库。适用于大多数 model_ri / callback / label 场景中的 kernel stub
- `ascendc_fatbin_library(name xxx.cpp)` — 用于 kernel launch 场景（需要 <<<>>> 调用语法），生成 fatbin 库。适用于 `2_advanced_features/kernel/` 下的样例

自定义 kernel 集成流程：
1. 将 kernel 源文件放在 `example/kernel_func/` 目录下
2. 在 CMakeLists.txt 中通过相对路径引用（如 `../../../kernel_func/easy_OP.cpp`）
3. 如果是新 kernel，需要在 `kernel_func/` 下新增 `.cpp` 和 `.h` 文件
4. **选择参考模板**（需与用户交互确认，用户也可自行指定其他模板）：
   - `2_advanced_features/kernel/0_launch_kernel` — kernel launch 场景（<<<>>> 调用语法，ascendc_fatbin_library）
   - `2_advanced_features/model_ri/3_cond_model` — model RI 场景中使用 kernel stub（ascendc_library）
   - `2_advanced_features/built_in_task/0_reduce_task` — built-in task 场景中使用 kernel stub
   - 用户可自行指定其他已有样例作为参考模板

### Step 5: 编写代码

#### main.cpp 编写要点

1. **遵循现有样例代码风格**：参考同类别下已有样例的命名、结构、注释风格。特别注意：
   - 函数左大括号不换行（Google 风格）
   - 指针声明：`void* ptr` 而非 `void *ptr`
   - 常量命名用 `kXxx` 前缀
2. **使用共享工具**：
   - `utils.h`（INFO_LOG/WARN_LOG/ERROR_LOG/CHECK_ERROR）
   - 同类别下的 `*_utils.h/cpp`（如 model_utils.h, kernel_utils.h）
3. **注意 Capture/Build 模式陷阱**（详见 `references/hlt-to-sample-pitfalls.md`）：
   - Capture 模式：`ACL_MEMCPY_HOST_TO_DEVICE` **不能**在 capture 上下文中使用，所有 H2D memcpy 必须在 `aclmdlRICaptureBegin` 之前完成
   - Build 模式：H2D memcpy 可在绑定 stream 上使用，建议使用独立的 copyStream 做 H2D/H2D 拷贝
4. **CHECK_ERROR 兼容性**：该宏使用 `return -1`，void 函数不兼容，函数应返回 `int32_t`
5. **资源释放完整**：所有 malloc/create 的资源都要有对应的 free/destroy，workspace 地址需判空后再 free
6. **版权头**：使用 CANN Open Software License 标准版权头
7. **流创建模式选择**：
   - 普通样例 / Capture 模式：用 `aclrtCreateStream` 即可
   - Build 模式：用 `aclrtCreateStreamWithConfig(&stream, 0x00U, ACL_STREAM_PERSISTENT)` 创建持久流（参考 `2_model_switch`）
   - Build 模式中，建议额外创建独立的 `copyStream`（用 `aclrtCreateStream`），专门用于 H2D/H2D 拷贝，避免与模型绑定流冲突
8. **Build 模式代码结构**（参考 `2_model_switch`）：
   ```cpp
   // Build 模式典型流程：
   aclrtCreateStreamWithConfig(&stream1, 0x00U, ACL_STREAM_PERSISTENT);  // 持久流
   aclrtCreateStream(&copyStream);  // 独立拷贝流
   aclmdlRIBuildBegin(&modelRI, 0x00U);
   aclmdlRIBindStream(modelRI, stream1, ACL_MODEL_STREAM_FLAG_HEAD);
   // 在绑定流上下文中可以做 H2D memcpy + 算子调用
   aclrtMemcpyAsync(selfDev, size, selfHost.data(), size, ACL_MEMCPY_HOST_TO_DEVICE, stream1);
   aclnnAdd(wsAddr, wsSize, executor, stream1);
   aclmdlRIEndTask(modelRI, endStream);
   aclmdlRIBuildEnd(modelRI, NULL);
   // 执行后用 copyStream 拷回结果
   aclrtMemcpyAsync(outHost.data(), size, outDev, size, ACL_MEMCPY_DEVICE_TO_HOST, copyStream);
   ```
9. **HLT 测试框架翻译**：
   - `TEST_F(AclGraphTest, Xxx)` → `int32_t TestXxx()` 函数
   - `ASSERT_EQ(expr, ACL_SUCCESS)` → `CHECK_ERROR(expr)`
   - `EXPECT_TRUE(condition)` → `INFO_LOG("result:")` + `ModelUtils::PrintArray()` （只打印不验证）
   - `printf("xxx passed!\n")` → `INFO_LOG("Xxx PASSED")`

#### CMakeLists.txt 编写要点

从 `references/sample-build-patterns.md` 选择对应模板，注意：
- `include_directories` 中 repo `include/external` 需放在 CANN 包路径之前（如果用到未发布 API）
- 共享工具源文件（如 `../model_utils.cpp`）需加入 `add_executable`
- 链接库按构建模式选择

#### run.sh 编写要点

从 `references/sample-build-patterns.md` 选择对应 run.sh 模式。

#### README.md 编写要点

与现有样例 README 格式保持一致，包含：

1. **描述**：一句话说明本样例展示了什么功能
2. **产品支持情况**：列出关键接口在不同产品上的支持情况（表格形式）
3. **编译运行**：环境准备 + 运行步骤（bash run.sh）
4. **CANN RUNTIME API**：按功能分类列出样例涉及的关键接口（初始化、Device、Stream、内存、数据传输、model管理等）
5. **已知issue**：如 CANN 版本要求、平台限制等

### Step 6: 更新类别 README

更新所属类别目录下的 README.md，添加新样例条目。

### Step 7: 验证

验证分为两个层级，**编译验证为必选项，硬件执行验证为可选项（取决于当前环境是否有 NPU 硬件）**：

#### 编译验证（必选）

- 执行 `bash run.sh` 到 make 阶段，确认编译通过无报错
- 检查所有文件版权头正确
- 检查 CMakeLists.txt 和 run.sh 与构建模式匹配
- 检查 README 格式与同类别现有样例一致

#### 硬件执行验证（可选，有 NPU 硬件时必做）

如果当前环境有 NPU 硬件（可通过 `npu-smi info` 检测），则必须在硬件上实际执行样例：

- 执行完整的 `bash run.sh`，确认样例在 NPU 上运行成功（输出包含 PASSED 或预期结果）
- 如果运行失败，需根据错误日志定位问题并修复，直到运行通过
- 如果运行环境无 NPU 硬件，跳过此步骤，但需在提交信息或 PR 描述中标注"仅编译验证，未做硬件执行验证"

## 关键参考资料

- `references/hlt-to-sample-pitfalls.md` — 技术陷阱清单（必读，避免常见错误）
- `references/sample-build-patterns.md` — 5 种构建模式 + run.sh 模式（选择构建方案时参考）
