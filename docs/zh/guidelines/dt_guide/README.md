# Runtime DT用例开发总纲

本文面向 Runtime 仓的 UT/ST 开发，重点说明用例该写在哪里、如何接入构建，以及设计用例时需要遵守的基本约束。本文默认读者已经具备 gtest 基础能力，因此不展开介绍测试框架语法。

> 本文聚焦用例规范；编译和执行请优先使用 `bash tests/build_ut.sh`。

## 详细指导

| 文档 | 内容 | 适用场景 |
|------|------|---------|
| [测试框架指南](test_framework_guide.md) | gtest、gmock/mockcpp、公共桩、模块内 stub/data、构建接入方式 | 构造输入、打桩、组织测试资产时查阅 |
| [UT用例开发指导](ut_case_development_guide.md) | UT 设计 checklist、完整校验、全局状态恢复、兼容性测试建议 | 编写或补充 UT 时查阅 |

## 基础知识

### 何时新增 DT 测试用例

一般来说，在以下两种情况下需要补充 DT 用例：

1. 新需求、新接口或新平台分支开发时，需要为新增行为补充 UT，必要时补充 ST。
2. 修复问题时，只要问题可以通过测试稳定复现，就应补充对应的回归用例。建议的流程是：先用 UT/ST 复现问题，再修复代码，最后确认回归用例稳定通过。

### Runtime DT 测试工程

Runtime 仓测试工程位于 `tests/` 目录，核心结构如下：

```yaml
tests
 - build_ut.sh: 测试构建、执行、覆盖率统计入口
 - depends: 公共桩和依赖替身
   - ge: 依赖组件相关桩
   - mmpa: 平台抽象层桩
   - profiling: profiling 相关桩
   - runtime: runtime/drv 接口桩
   - slog: 日志桩
   - tdt: 数据传输相关桩
   - toolchain: 工具链相关桩
 - ut
   - acl: ACL 接口测试，含 `testcase/`、`testcase_c/`
   - runtime: Runtime 核心与 C 接口测试
   - adump: Dump 相关 UT/ST
   - msprof: Profiling 相关 UT/ST
   - platform: 平台能力相关 UT/ST
   - queue_schedule: 队列调度相关 UT/ST
   - aicpu_sched: AICPU 调度相关 UT/ST
   - atrace: trace 相关测试
   - tsd: TSD 相关测试
   - error_manager: 错误管理测试
   - mmpa: 平台抽象层测试
   - slog: 日志模块测试
```

Runtime 仓没有单独的 `tests/st` 目录，ST 往往与对应模块放在同一棵 `tests/ut/**` 目录树下，常见位置如 `tests/ut/msprof/st`、`tests/ut/platform/st`、`tests/ut/adump/st`。

### 常用执行命令

```bash
# 构建并执行全部测试
bash tests/build_ut.sh -u

# 构建并执行指定模块
bash tests/build_ut.sh -u runtime
bash tests/build_ut.sh -u acl
bash tests/build_ut.sh -u msprof

# 使能覆盖率
bash tests/build_ut.sh -c

# 使能 AddressSanitizer
bash tests/build_ut.sh --asan -u runtime
```

`tests/build_ut.sh` 当前支持的常用 target 包括：`full`、`acl`、`runtime`、`runtime_c`、`platform`、`queue_schedule`、`aicpu_sched`、`slog`、`atrace`、`msprof`、`adump`、`tsd`、`error_manager`、`mmpa`。如需新增顶层测试 target，需要同步更新 `tests/build_ut.sh` 中的 `ut_path_map`。

## 新用例文件加入构建系统

Runtime 测试工程使用 CMake 构建。新增用例后，至少需要检查以下接入点：

1. 将新文件加入对应模块的 `CMakeLists.txt`，例如 `UT_FILES` 或 `add_executable(...)` 的源文件列表。
2. 如果新增了测试子目录，需要在父级 `CMakeLists.txt` 中补充 `add_subdirectory(...)`。
3. 如果希望通过 `bash tests/build_ut.sh -u <target>` 直接执行新的模块或子模块，需要同步更新 `tests/build_ut.sh` 中的 `ut_path_map`。

示例：

```cmake
set(UT_FILES
    "acl_queue_unittest.cpp"
    "acl_new_feature_unittest.cpp"
)
```

## 用例规范

### 规范1：文件命名优先与所在目录既有风格保持一致

Runtime 仓现有 UT 命名并不完全统一，常见后缀包括：

* `*_unittest.cpp` / `*_unittest.cc`
* `*_utest.cpp` / `*_utest.cc`

例如：

* `tests/ut/acl/testcase/acl_queue_unittest.cpp`
* `tests/ut/runtime/runtime/test/rt_utest_api.cc`
* `tests/ut/tsd/tsdclient/test/package_process_config_utest.cpp`

新增文件时应遵循“**同目录保持同风格**”原则，不要在一个已有明确命名习惯的目录中再引入新的后缀风格。

ST 文件建议统一使用 `*_stest.cpp` / `*_stest.cc`，并放在对应模块的 `st/` 目录或平台场景目录中，例如：

* `tests/ut/msprof/st/api/testcase/api_dc_stest.cpp`
* `tests/ut/msprof/st/msprofbin/test/running_mode_stest.cpp`

### 规范2：一个用例只校验一个明确场景

无论是 UT 还是 ST，一个测试用例都应围绕一个场景展开，并完成该场景的完整校验。不要在一个用例里串联多个弱相关场景，否则问题定位和后续维护成本都会上升。

### 规范3：用例名要能表达被测对象、预期行为和触发场景

Runtime 仓历史用例命名风格也存在差异，但新用例至少应满足以下要求：

* 能看出测试的是哪个接口、类方法或特性
* 能看出期望结果是成功、失败还是某种状态变化
* 能看出触发该行为的关键场景

如果同一文件已经有稳定的命名风格，优先保持一致。

### 规范4：必须做完整校验，不能只看返回值

除了返回值外，还应校验与场景直接相关的可观察结果，例如：

* 出参内容
* 成员状态变化
* mock 调用次数和参数
* 文件、目录、日志、回调、副作用
* 全局状态是否恢复

仅校验“返回成功/失败”的用例价值有限，应尽量避免。
