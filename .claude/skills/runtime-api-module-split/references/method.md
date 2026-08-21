# Runtime API 模块拆分方法

## 1. 范围来源

模块边界首先来自用户指定的官方对外接口文档，而不是内部文件名或 `Api` 中的注释分组。

1. 打开用户提供的页面。
2. 记录页面实际解析到的 CANN 版本和 canonical URL；`latest` 可能随时间变化。
3. 若页面是单个接口，读取父主题/面包屑，定位模块目录。
4. 收集该模块目录中的完整接口清单、废弃标记、推荐替代接口、产品支持和约束。
5. 用仓库 `docs/zh/api_ref/`、ACL wrapper 和导出头文件交叉检查，标记文档与代码版本差异。

官方模块是产品和用户视角的功能域。内部 API 大类是代码所有权和调用链边界，两者不要求一一对应。

## 2. 端到端追踪

### 2.1 ACL 到 Runtime C API

优先检查：

- `src/acl/aclrt_impl/acl_rt_wrapper.h`
- `src/acl/aclrt_impl/<module>.cpp`
- `src/acl/aclrt_impl/stream.cpp` 等跨模块包装文件

记录每个 `aclrtXxx` 实际调用的 `rtXxx` 或 `rtsXxx`。同一官方模块的接口可能位于不同 ACL 源文件，也可能通过兼容接口转调。

### 2.2 Runtime C API 到内部 API 大类

在以下目录按确切符号追踪：

- `src/runtime/api/api_c*.cc`
- `src/runtime/api/api.hpp`
- `src/runtime/api/api_<module>.hpp`

记录入口调用的是 `Api::Instance()`、现有 `ApiXxx::Instance()`、`Runtime` 直接能力还是独立全局函数。不要只看 `api.hpp` 的注释分区；实际成员可能出现在 stream、inquire information、configuration 等不同分组。

### 2.3 实现、装饰器和平台差异

继续检查：

- `ApiImpl` 和平台派生类；
- `ApiDecorator`、`ApiErrorDecorator`、`ApiProfileDecorator`；
- Context、Device、Stream、Event 等对象成员；
- 标准实现、David/V201、tiny/arch5162 stub；
- `src/runtime/cmake/*.cmake` 与各平台 UT `CMakeLists.txt`。

对每个接口形成以下记录：

| 字段 | 内容 |
|---|---|
| 对外接口 | 官方文档中的 `aclrtXxx` |
| ACL 实现 | wrapper 和实现文件 |
| Runtime 入口 | `rtXxx`/`rtsXxx` 与 `api_c*.cc` |
| 当前 API 所有者 | `Api`、`ApiXxx`、Runtime 或其他 |
| 当前成员 | 完整函数名和签名 |
| 真实实现 | ApiImpl、平台 override、对象/全局函数 |
| 横向能力 | error、log、profiling、Context、handle guard |
| 构建面 | v100/v200/v201/cmodel/tiny/arch5162/910B |
| 依赖 | 与其他模块的类型或行为依赖 |
| 决策 | 本批/后续/暂缓/无需整改 |

## 3. 划分 API 大类

按以下顺序判断目标归属：

1. **业务内聚**：接口是否共同管理同一种资源、状态和生命周期。
2. **调用链内聚**：接口是否复用同一实现对象、feature gate、profiling 类型和错误处理。
3. **平台内聚**：接口是否具有相近的产品支持、stub 和 CMake 选择规则。
4. **依赖闭合**：拆出后是否仍需频繁调用主 `Api` 或另一个待拆模块的私有能力。
5. **验证闭合**：能否为该子集构造独立的路由证明、成功/失败 UT 和多平台链接验证。

满足业务模块口径但依赖不闭合的接口可以暂缓。不要为了让接口清单看起来完整而同时拆多个强耦合模块。

一个模块下出现多个 API 大类成员是正常结果。例如 Event 管理中的 stream wait、资源查询、超时配置和 IPC handle 操作在内部具有不同所有权；先拆 IPC 子集并保留其他接口，是可接受的渐进方案。

## 4. 选择当前批次

优先纳入：

- 资源类型和职责明确的一组接口；
- 新实现可复用现有 Runtime 公共能力；
- 参数校验、错误码和 profiling 可完整迁移；
- 多平台实现和 stub 边界清楚；
- 不需要同步迁移另一个业务模块。

优先暂缓：

- 成员函数同时承载其他模块的核心行为；
- 必须先重构 Context/Device/Stream 等基础设施才能迁移；
- 平台实现差异尚未梳理清楚；
- 缺少稳定的成功/失败验证入口；
- 迁移会迫使一个 PR 同时修改多个 API 大类。

输出暂缓原因和前置条件。后续批次重新分析最新主线，不能直接照搬旧计划。

## 5. 行为等价基线

逐接口保存拆分前契约：

| 维度 | 必查项 |
|---|---|
| 对外接口 | 签名、符号、可见性、调用约束 |
| 参数处理 | 判空顺序、handle unwrap/cast、默认值、透传 |
| 返回行为 | 成功码、错误码转换、not support、timeout |
| 错误与日志 | ErrMsg 模板、日志级别、错误发生位置 |
| Profiling | profile type、begin/end 配对、data size、device id |
| 隐式环境 | CurrentContext、SetDevice、TSD/线程 flags |
| 生命周期 | 创建、初始化失败回滚、销毁、重复释放 |
| 布局 | Runtime 新成员位置、虚函数变化、内部 ABI 风险 |
| 产品矩阵 | 标准、David/V201、tiny、arch5162、cmodel、910B |

任何无法证明等价的变化都应从结构拆分 PR 中移出，单独作为功能变更评审。

## 6. 三阶段边界

### 阶段一：框架

包含：

- `ApiXxx` 抽象和 `ApiImplXxx` 实现；
- 创建器、Runtime 指针、初始化/回滚/析构；
- 标准实现与不支持产品 stub；
- 正式构建和 UT 构建源文件清单；
- 直接实现 UT、生命周期 UT、stub UT。

不包含：C API 路由切换、主 `Api` 旧方法删除、无关头文件清理。

阶段一合入后如检视提出确定的依赖收敛意见，可用窄补丁修复。该补丁仍属于框架稳定化，不改变三阶段业务主线。

### 阶段二：路由

包含：

- 仅切换本批选中 C API；
- 保留旧主 `Api` 方法；
- 路由证明 UT；
- 新旧参数、返回码、profiling 和环境语义对比。

不包含：旧虚函数、decorator 和平台实现清理。

### 阶段三：清理

包含：

- 删除主 `Api`、`ApiImpl`、decorator 和平台旧实现；
- 删除或迁移只覆盖旧链路的 UT；
- 清理残留 include、构建项和符号；
- 更新设计文档和剩余接口清单；
- 执行完整验证矩阵。

不包含：继续扩展到未在当前批次选中的接口。

## 7. 方案输出模板

### 模块输入

| 项目 | 取值 |
|---|---|
| 模块 | `<module>` |
| 官方页面 | `<url>` |
| 实际文档版本 | `<version>` |
| 当前整改建议 | `<suggestion>` |

### 接口决策

| 对外接口 | Runtime 入口 | 当前大类/成员 | 依赖 | 决策 | 原因 |
|---|---|---|---|---|---|

### 分阶段计划

| 阶段 | 包含 | 不包含 | 主要风险 | 最小验证 | 依赖基线 |
|---|---|---|---|---|---|

### 剩余接口

明确列出本批完成后仍留在主 `Api` 或其他 API 大类中的模块接口、暂缓原因和下一批前置条件。
