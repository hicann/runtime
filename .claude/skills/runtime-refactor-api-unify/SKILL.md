---
name: runtime-refactor-api-unify
description: 对 Runtime 接口做"调用链归一 + 平台实现物理隔离"重构。当用户要求重构 Runtime 接口、归一 Runtime 接口、统一 Runtime 接口调用链，或运行 /runtime-refactor-api-unify 时触发。
disable-model-invocation: true
argument-hint: <模块名> <接口列表，逗号分隔>
---

# Runtime 接口归一重构（严格对齐 rtMemcpyAsync 模式）

## Role

你是一位精通 C++ / CMake 的 Runtime 架构重构工程师。任务是把 **$ARGUMENTS[0]** 模块的接口分层结构，严格收敛到 `rtMemcpyAsync` 已落地的架构模式。

---

## 术语口径

- `OBP` / `Stars` = Stars 路径（`ApiImpl`，编入 `libruntime_v100.so`）
- `David` = David 路径（`ApiImplDavid`，编入 `libruntime_v200.so` / `libruntime_v201.so`）
- 平台实现文件后缀：Stars = `*_stars.cc`，David = `*_starsv2.cc`，公共 = `*_common.cc`

---

## 调用链模板（硬约束）

以 `rtMemcpyAsync` 为唯一对齐模板：

```text
rtXxx(...)
  -> apiInstance->Xxx(...)
  -> ApiImpl::Xxx(...)            // Stars
     or ApiImplDavid::Xxx(...)    // David（仅已有差异时保留 override）
  -> UnifiedGlobalXxx(...)        // 同名统一全局函数（无平台后缀）
  -> 平台文件中的实现（由 CMake 选择 *_stars.cc / *_starsv2.cc / *_common.cc）
```

参考对齐对象（已落地）：

- `rtMemcpyAsync`：`ApiImpl/ApiImplDavid -> MemcopyAsync -> memcpy_stars.cc / memcpy_starsv2.cc`
- `rtStreamSwitchEx`（Cond&Label）：`ApiImpl/ApiImplDavid -> CondStreamSwitchEx -> cond_stars.cc / cond_starsv2.cc`
- `rtCmoTaskLaunch`（CMO&Barrier）：`ApiImpl/ApiImplDavid -> CmoTaskLaunch -> cmo_barrier_stars.cc / cmo_barrier_starsv2.cc`

---

## 执行步骤

### 步骤 1：现状分析

读取目标接口涉及的所有代码路径，产出以下两张表格：

#### 1a. 接口对比总表（NxM）

| 序号 | 接口名称 | 重构前 OBP 实现 | 重构前 David 实现 | 重构后 OBP 实现 | 重构后 David 实现 | 重构前是否使用了 Context | 实现是否一致 | 备注 | OBP 编入 `libruntime_v100.so` | David 编入 `libruntime_v200.so`/`libruntime_v201.so` |
|---|---|---|---|---|---|---|---|---|---|---|

每个接口一行。"重构后"列在分析阶段先填写目标设计，实施完成后更新为实际状态。

关键分析维度：
- 重构前调用链：`rtXxx -> ApiImpl::Xxx -> curCtx->Xxx -> Context::Xxx` 还是直接调用全局函数？
- David 是否有 override？若有，逻辑是否与基类一致？
- 是否存在 `ForStars` / `ForDavid` 后缀函数？

#### 1b. 接口声明对比表（含全部参数）

| 序号 | 接口名 | 重构前 OBP 接口声明（Context 级） | 重构前 David 接口声明（同级调用） | 重构后实现（统一函数声明，含完整参数） | 参数变化（相对重构前） |
|---|---|---|---|---|---|

关键分析维度：
- OBP 与 David 的参数差异（用于确定并集签名）
- 是否需要新增 `Context*` / `Device*` 等并集参数
- 哪些参数在某平台未使用（需标记 `UNUSED`）

#### 1c. 重构必要性判定（硬约束）

基于对比总表中的"重构前是否使用了 Context"列，逐接口判定是否需要重构：

- **需要重构**：重构前 OBP 的调用链经过 `Context` 成员函数（即 `curCtx->Xxx` / `Context::Xxx`）承载主逻辑的接口。David 侧不走 Context，不作为判定依据。
- **不需要重构**：重构前 OBP 已经直接调用统一全局函数、未经过 `Context` 的接口。这类接口保持现状，不做任何改动。
- **C API 行为保持**：若某接口的 C API 入口在重构前直接返回 `RT_ERROR_FEATURE_NOT_SUPPORT`（如 `rtLabelCreate`），重构后必须保持该行为不变，不得将其改为调用 `apiInstance->Xxx(...)`。此类接口的 C API 层不纳入重构范围，但其内部可执行路径（如通过 V2 接口进入）仍需按模板改造。

将不需要重构的接口从后续步骤的目标范围中排除。仅对"需要重构"的接口继续执行步骤 2 ~ 13。

### 步骤 2：统一函数设计

基于对比表确定：
- 统一全局函数名（禁止 `ForStars` / `ForDavid` 后缀）
- 参数并集签名（OBP + David 原有入参的超集）
- 头文件位置：`src/runtime/core/inc_c/<module>_c.hpp`

### 步骤 3：文件布局

确认或新增以下文件（部分文件可能已存在，如 David 侧已有 `*_starsv2.cc`，直接复用即可）：
- `src/runtime/core/inc_c/<module>_c.hpp`（统一函数声明）
- `src/runtime/core/src/launch/<module>_stars.cc`（Stars 差异化实现）
- `src/runtime/core/src/launch/<module>_starsv2.cc`（David 差异化实现）
- `src/runtime/core/src/launch/<module>_common.cc`（OBP/David 一致实现）

规则：
- 若某统一函数 OBP 与 David 实现完全一致 -> 放 `*_common.cc`
- 若实现有差异 -> 分别放 `*_stars.cc` 和 `*_starsv2.cc`
- 禁止在两个平台文件中重复定义同一函数

### 步骤 4：实现迁移

- 将 `Context` 成员函数中的主逻辑迁入对应平台文件的统一全局函数
- David 专有逻辑（如原 `stream_c.cc` 中的 `XxxForDavid`）迁入 `*_starsv2.cc`
- OBP 原 `Context::Xxx` 逻辑迁入 `*_stars.cc`
- 某平台未使用的并集参数，在函数开头显式 `UNUSED(xxx)`
- 若 David 侧已存在同名全局函数（如重构前 David 的 `ApiImplDavid::Xxx` 已直接调用该全局函数），则 OBP 重构后应复用同一函数名，但需检查其签名是否满足并集要求（OBP 可能需要额外的 `Context*` 等参数）；若不满足，需扩展签名并在 David 平台实现中补充 `UNUSED`

### 步骤 5：调用点改造（ApiImpl 层）

- `src/runtime/api/impl/api_impl.cc`（基类）：改为调用统一全局函数
- `src/runtime/api/impl/api_impl_david.cc`（David）：仅保留已有差异的 override，改为调用同名统一全局函数

继承关系约束：
- 若重构前 David 继承基类实现（未 override） -> 重构后必须保持继承，不新增 override
- 若重构前 David 有 override 但逻辑与基类一致 -> 删除 override，改为继承
- 若重构前 David 有 override 且逻辑有差异 -> 保留 override，但改为调用同名统一全局函数

目标形态：
```cpp
// 差异化接口
rtError_t ApiImpl::Xxx(...) { return ::UnifiedXxx(...); }
rtError_t ApiImplDavid::Xxx(...) { return ::UnifiedXxx(...); }

// 继承复用接口（禁止在 ApiImplDavid 中重写）
rtError_t ApiImpl::Yyy(...) { return ::UnifiedYyy(...); }
```

### 步骤 6：Context 清理

在 `core/inc/context/context.hpp` 与 `core/src/context/context.cc` 中**必须删除**目标接口对应的成员函数声明与实现，不允许保留空壳或转调。

### 步骤 7：CMake 适配

修改以下 cmake 文件，对齐 `memcpy_stars.cc` / `memcpy_starsv2.cc` 的选择策略：

- `src/runtime/cmake/v200.cmake`（David 构建）：包含 `*_starsv2.cc` + `*_common.cc`，不包含 `*_stars.cc`
- `src/runtime/cmake/tiny.cmake`（Stars 构建）：包含 `*_stars.cc` + `*_common.cc`，不包含 `*_starsv2.cc`
- `src/runtime/cmake/cmodel.cmake`（cmodel 双平台）：v100 列表含 `*_stars.cc`，v200 列表含 `*_starsv2.cc`，双方均含 `*_common.cc`
- `src/runtime/cmake/runtime.cmake`（若存在）：同 tiny 策略

补齐 include 路径：相关 target 需包含 `${CMAKE_CURRENT_SOURCE_DIR}/inc_c`

### 步骤 8：构建验收

代码改造完成后，必须立即执行构建验收，确认无编译/链接错误：

```bash
# 1. 构建
bash build.sh

# 2. link.txt 级别校验（确保正确源文件进入目标 so）
rg -n "<module>_common\\.cc\\.o|<module>_stars\\.cc\\.o" build/src/runtime/core/CMakeFiles/runtime_v100.dir/link.txt
rg -n "<module>_common\\.cc\\.o|<module>_starsv2\\.cc\\.o" build/src/runtime/core/CMakeFiles/runtime_v200.dir/link.txt
rg -n "<module>_common\\.cc\\.o|<module>_starsv2\\.cc\\.o" build/src/runtime/core/CMakeFiles/runtime_v201.dir/link.txt

# 3. nm 级别校验（必须是 defined symbol，而非 U）
nm --defined-only --demangle build/src/runtime/libruntime_v100.so | rg "cce::runtime::(<FuncA|FuncB>)\("
nm --defined-only --demangle build/src/runtime/libruntime_v200.so | rg "cce::runtime::(<FuncA|FuncB>)\("
nm --defined-only --demangle build/src/runtime/libruntime_v201.so | rg "cce::runtime::(<FuncA|FuncB>)\("
```

任一命令无命中或仅出现 `U`，必须先修复再继续。

### 步骤 9：UT 适配

- 更新 `tests/ut/runtime/runtime/stub/` 下的桩函数名
- 更新测试用例中对旧函数名的调用

### 步骤 10：LLT 验收

LLT 全量运行不稳定（易超时/coredump），因此采用**精准用例筛选 + 定向运行**策略，避免全量执行。

#### 10a. 筛选相关测试用例

从 UT 代码中筛选与本次重构接口相关的测试用例：

```bash
# 在 UT 目录中搜索涉及目标接口/统一函数名的测试用例
rg -n "(<rtXxx>|<UnifiedXxx>|<旧Context函数名>)" tests/ut/runtime/runtime/test/ --include="*.cc"
```

从搜索结果中提取相关的 TEST/TEST_F 用例名，汇总为 `gtest_filter` 表达式，格式如：
```
TestSuiteA.TestCase1:TestSuiteA.TestCase2:TestSuiteB.*
```

#### 10b. 运行相关用例

```bash
export ASAN_OPTIONS=handle_segv=0:detect_leaks=0
timeout 120s bash tests/build_ut.sh --ut runtime --target runtime_ut -- --gtest_filter='<筛选出的用例filter>'
```

异常处理：
- 若出现超时或 coredump，单独运行失败用例确认是否为偶发问题：
  ```bash
  timeout 60s bash tests/build_ut.sh --ut runtime --target runtime_ut -- --gtest_filter='<FailedTestCase>'
  ```
- 若单独运行通过，判定为偶发问题，LLT 验收通过。
- 若单独运行仍失败，需排查是否为本次重构引入的问题并修复。

### 步骤 11：静态检查

```bash
# 检查残留的 ForStars/ForDavid
rg "ForStars|ForDavid" src/runtime/core/src src/runtime/core/inc_c

# 检查残留的 curCtx->Xxx 调用
rg "curCtx->(<接口名1>|<接口名2>)" src/runtime/api/impl

# 检查 Context 中是否残留目标接口声明/实现
rg -n "Context::(<接口名1>|<接口名2>)" src/runtime/core/inc/context/context.hpp src/runtime/core/src/context/context.cc

# 检查统一函数声明与实现
rg -n "rtError_t (<统一函数名1>|<统一函数名2>)\(" src/runtime/core/inc_c/<module>_c.hpp src/runtime/core/src/launch/<module>_*.cc
```

### 步骤 12：代码 Review

对本次所有变更文件逐一 review，检查以下维度：

#### 12a. 正确性

- 调用链是否完整：`rtXxx -> ApiImpl/ApiImplDavid -> 统一全局函数 -> 平台实现`，有无断链或多余中间层
- 参数传递是否正确：并集签名中每个参数是否从 C API 层正确透传到统一函数，有无遗漏或错位
- 返回值是否正确透传，有无吞掉错误码
- 继承关系是否符合预期：该继承的未多写 override，该保留 override 的未误删
- `UNUSED(xxx)` 是否覆盖了所有单平台未使用的并集参数

#### 12b. 一致性

- 统一函数命名是否严格遵循约定（无 `ForStars`/`ForDavid` 后缀，无无前缀旧命名残留）
- 头文件声明与实现文件中的函数签名是否完全一致（参数类型、const 修饰、默认值）
- `*_common.cc` 中的函数是否确实在 `*_stars.cc` / `*_starsv2.cc` 中无重复定义
- CMake 文件中新增源文件的路径与实际文件路径是否匹配

#### 12c. 清理完整性

- `Context` 中目标接口的声明与实现是否已彻底删除（不留空壳/注释残留）
- `ApiImplDavid` 中应删除的 override 是否已彻底删除（`.hpp` 声明 + `.cc` 实现）
- 旧的全局函数（如 `XxxForStars`、`XxxForDavid`）是否已删除
- 旧的 `#include` 是否已清理（不再需要的头文件引用）

#### 12d. 冗余收敛（重构后二次归一）

重构改造完成后，必须对以下两个层面做冗余检测，发现冗余必须立即合并：

**ApiImpl 层冗余收敛：**
- 逐一对比 `ApiImpl::Xxx` 与 `ApiImplDavid::Xxx` 的实现体（即 override 中的代码）
- 若两者实现完全一致（调用同一统一全局函数、传参相同、无额外逻辑差异），则：
  - 删除 `ApiImplDavid::Xxx` 的 override（`.hpp` 声明 + `.cc` 实现）
  - David 侧改为继承 `ApiImpl::Xxx` 基类实现
- 判定标准：函数体逻辑等价即视为一致，不因变量名、空行、注释差异而保留 override

**平台实现层冗余收敛：**
- 逐一对比 `*_stars.cc` 与 `*_starsv2.cc` 中同名统一函数的实现体
- 若两者实现完全一致，则：
  - 将该函数迁移到 `*_common.cc`
  - 从 `*_stars.cc` 和 `*_starsv2.cc` 中删除该函数定义
  - 确认 CMake 中 `*_common.cc` 已加入双平台 target
- 判定标准：函数体逻辑等价即视为一致，仅 `UNUSED(xxx)` 差异也视为不一致（不合并）

#### 12e. 副作用风险

- 是否有非目标接口被意外修改
- 公共文件（`*_common.cc`）是否引入了平台相关的头文件或符号
- UT 桩函数签名是否与统一函数签名保持一致

发现问题必须当场修复后再继续，不允许带着已知问题输出报告。

#### 修改即重验（硬约束）

步骤 8（构建验收）至步骤 12（代码 Review）中，**任何步骤只要产生了代码修改**（包括但不限于：冗余收敛合并、Review 问题修复、代码格式化、UT 适配修正），都必须从步骤 8 开始重新执行完整验收链：

```text
步骤 8（构建验收） -> 步骤 9（UT 适配） -> 步骤 10（LLT 验收） -> 步骤 11（静态检查） -> 步骤 12（代码 Review）
```

循环终止条件：步骤 12 完成后无任何代码修改产生。只有在该循环收敛后，才允许进入步骤 13 输出报告。

### 步骤 13：输出重构报告

所有验收通过后，输出 `docs/<module>_refactor_report.md` 重构报告，必须包含以下章节：

#### 章节 1：总体架构变化

概述重构前后的架构差异（Context 迁出、统一函数入口、公共实现收敛等）。

#### 章节 2：接口对比总表

将步骤 1a 的表格更新为最终实际状态（"重构后"列填写实际落地结果）：

| 序号 | 接口名称 | 重构前 OBP 实现 | 重构前 David 实现 | 重构后 OBP 实现 | 重构后 David 实现 | 重构前是否使用了 Context | 实现是否一致 | 备注 | OBP 编入 `libruntime_v100.so` | David 编入 `libruntime_v200.so`/`libruntime_v201.so` |
|---|---|---|---|---|---|---|---|---|---|---|

#### 章节 3：接口声明对比表

将步骤 1b 的表格更新为最终实际状态：

| 序号 | 接口名 | 重构前 OBP 接口声明（Context 级） | 重构前 David 接口声明（同级调用） | 重构后实现（统一函数声明，含完整参数） | 参数变化（相对重构前） |
|---|---|---|---|---|---|

#### 章节 4：逐接口详细变更

对每个重构接口逐一说明：重构前 OBP/David 调用链、重构后 OBP/David 调用链、实现文件位置。

#### 章节 5：补充变更

记录本次重构中附带产生的非目标接口改动（如函数归属迁移、命名空间清理、UT 适配等）。

#### 章节 6：关键文件变更归档

列出本次所有变更文件清单。

---

## 禁止项（出现任一项视为不达标）

1. 新增或保留 `ForStars` / `ForDavid` 后缀函数名
2. `ApiImpl` / `ApiImplDavid` 继续通过 `curCtx->Xxx` 承载目标接口主逻辑
3. 同一目标库同时编译 `*_stars.cc` 和 `*_starsv2.cc` 中的同名实现
4. 为规避同名冲突而人为改函数名（如加 `_StarsImpl` / `_DavidImpl`）
5. OBP 与 David 逻辑完全一致时，仍在 `*_stars.cc` 与 `*_starsv2.cc` 重复实现，而不抽到 `*_common.cc`
6. 统一函数签名未覆盖 Stars 与 David 原有入参并集，或通过删参改变语义
7. 在 `ApiImplDavid` 新增或保留重构前不存在的 override
8. 在 `ApiImplDavid` 保留与 `ApiImpl` 同逻辑的 override（应删除，改为继承）
9. 统一函数未按平台要求编入目标 so
10. Context 中目标接口的成员函数声明或实现仍然存在
11. 将重构前 C API 直接返回 `RT_ERROR_FEATURE_NOT_SUPPORT` 的接口改为可执行路径（如改为调用 `apiInstance->Xxx(...)`）

---

## 架构验收清单（Definition of Done）

构建、LLT、静态检查的具体命令已在步骤 8/10/11 中给出，此处仅列出架构层面的验收要点：

1. 目标接口满足 `rtXxx -> apiInstance -> ApiImpl/ApiImplDavid -> 同名全局函数` 调用链
2. 代码中不再存在 `ForStars` / `ForDavid` 命名
3. `ApiImpl` / `ApiImplDavid` 不再通过 `curCtx->Xxx` 承载目标接口主逻辑
4. `Context` 中目标接口的成员函数声明与实现已删除
5. OBP/David 一致逻辑已收敛到 `*_common.cc`，不存在重复实现
6. 统一函数签名已覆盖 Stars + David 的原始入参并集；单平台未使用参数均 `UNUSED(xxx)`
7. 继承关系正确：重构前继承的仍继承；重构后 override 与基类逻辑一致的已合并为继承（参见步骤 12d 冗余收敛）

---

## 代码格式化约束

- 使用仓库根目录 `.clang-format` 格式化（`clang-format -style=file`）
- 只格式化本次修改过的代码行/代码块，不得全文件格式化
- 若文件属于重命名文件（`git diff --name-status` 显示 `Rxx`），禁止格式化
- 禁止引入纯格式化噪声
- 严禁修改行尾符号（CRLF/LF）

## Copyright 约束

- 本次**新增文件**：Copyright 年份使用当前年份
- 本次**修改的已有文件**：Copyright 年份保持原值

---

## 已完成的重构范例（供参考）

- Cond & Label 重构 Prompt：`docs/cond_label_refactor_prompt.md`
- CMO & Barrier 重构 Prompt：`docs/cmo_barrier_refactor_prompt.md`
