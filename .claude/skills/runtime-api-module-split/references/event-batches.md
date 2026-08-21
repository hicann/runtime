# Event 管理拆分批次与后续计划

官方模块入口示例：<https://www.hiascend.com/document/detail/zh/CANNCommunityEdition/latest/API/runtimeapi/aclcppdevg_03_0079.html>。该 URL 位于 Event 管理目录下。执行 Skill 时应沿父主题收集整个 Event 管理目录，并记录 `latest` 当时解析到的实际版本。仓库合并版接口清单 `docs/zh/api_ref/07_event_management.md` 只用于交叉核对。

本文记录可复用的 Event 基线。PR 状态、提交号和主线成员会变化，开始新任务前必须通过 GitCode 和最新 `origin/master` 重新确认。

## 1. 接口范围

当前基线中的 Event 管理包含 22 个 ACL 对外接口：

1. `aclrtCreateEvent`
2. `aclrtCreateEventWithFlag`
3. `aclrtCreateEventExWithFlag`
4. `aclrtDestroyEvent`
5. `aclrtRecordEvent`
6. `aclrtRecordEventWithFlag`
7. `aclrtResetEvent`
8. `aclrtQueryEvent`
9. `aclrtQueryEventStatus`
10. `aclrtQueryEventWaitStatus`
11. `aclrtSynchronizeEvent`
12. `aclrtSynchronizeEventWithTimeout`
13. `aclrtEventElapsedTime`
14. `aclrtStreamWaitEvent`
15. `aclrtStreamWaitEventWithFlag`
16. `aclrtStreamWaitEventWithTimeout`
17. `aclrtSetOpWaitTimeout`
18. `aclrtEventGetTimestamp`
19. `aclrtGetEventId`
20. `aclrtGetEventAvailNum`
21. `aclrtIpcGetEventHandle`
22. `aclrtIpcOpenEventHandle`

不要按 `Event` 关键词扩展范围。Runtime 内部的 `EventWorkModeSet`、`EventWorkModeGet` 没有直接包含在上述 22 个 ACL 接口中，应单独评估；`GetFaultEvent`、`Esched*Event`、`BufEventTrigger` 等名称也不能自动归入 Event 管理整改。

## 2. 批次划分依据

不要只按接口名称、`api.hpp` 中的注释分组或官方文档目录划分批次。每次从最新主线重新检查以下五项：

1. **资源所有权**：核心操作对象是 Event、Stream、Device/Driver，还是 Runtime 全局配置。
2. **平台实现**：主 `ApiImpl` 是否有 David、V201、standard_soc、tiny 或 arch5162 override/stub。
3. **横向依赖**：是否调用 ACL Graph capture、Soma、Context、Device、Driver 或其他 API 大类。
4. **内部调用方**：除 `api_c*.cc` 外，feature、对象和任务模块是否直接调用主 `ApiImpl` 成员。
5. **验证闭合**：能否在不迁移其他模块的情况下构造直接实现、路由、失败语义和多平台链接验证。

批次排序采用“先独立、后耦合”原则。这里的“独立”指 API 模块边界独立，而不是完全不使用 Runtime 基础设施：

- Context、Device、Driver、Event 对象和 `GlobalContainer` 是 Runtime 实现基础设施。通过稳定公开边界使用它们，且不要求另一个业务 API 大类存在时，可以纳入独立批次；
- `ApiSoma`、Stream/Graph capture、主 `ApiImpl` 的 capture helper 等是业务模块或业务编排依赖。只要 Event 成员的完整旧语义要求这些能力存在，就仍属于耦合成员；
- 在 Runtime 中增加转发函数或移动 include 只能隐藏编译依赖，不能消除语义依赖。例如 `Runtime::TryTrim...()` 若内部仍无条件要求 `ApiSoma` 存在，`ApiEvent` 仍与 Soma 能力绑定；
- 平台 override 本身不是其他业务模块耦合，但会扩大实现层次、构建面和验证面，应作为有条件拆分风险单独处理。

据此将成员分为三类：

| 类别 | 判定条件 | 处理方式 |
|---|---|---|
| 可独立拆分 | 不调用其他业务 API 大类或其私有 helper，完整行为能在 `ApiEvent` 内闭合，正式/UT 产品矩阵可独立编译链接 | 将职责内聚的独立成员优先归为一批，按扩展实现、路由、清理三阶段推进 |
| 有条件或暂缓拆分 | 属于 Event 所有权，但依赖 Soma、Stream/capture、其他模块副作用、平台 override 或内部调用方 | 记录耦合点和解耦前置条件，放到独立批次之后；前置条件未完成时保留旧链路 |
| 不迁移到 `ApiEvent` | 核心行为由 Stream、Device 或全局配置拥有 | 在 Event 模块清单中记录归属结论，留给对应 API 大类整改 |

对候选成员执行以下顺序，不按接口数量平均拆分：

1. 扫描成员实现、decorator、平台 override、非 C API 调用方和成功后副作用；
2. 先选出不依赖其他业务 API 模块的成员，并确认同批职责和验证边界内聚；
3. 将全部独立成员形成最早的后续业务批次；
4. 对其余成员逐项写明耦合对象、暂缓原因和可验证的解耦条件；
5. 每个耦合前置条件完成后，从最新主线重新扫描，不能直接沿用旧结论。

完成某个批次只表示该批成员完成迁移。只有 22 个 ACL Event 管理接口和额外 Runtime 内部成员都已有“迁移”或“明确保留”结论时，才能宣称 Event 模块归属分析完成。

## 3. 业务批次

### 批次一：IPC Event，已合入

本批只包含：

- `aclrtIpcGetEventHandle` -> `IpcGetEventHandle`
- `aclrtIpcOpenEventHandle` -> `IpcOpenEventHandle`

已合入流程：

| 阶段 | PR | 作用 |
|---|---:|---|
| 框架 | 4186 | 新增 `ApiEvent`/`ApiImplEvent`、Runtime 生命周期、构建接入和直接 UT，不切换 C API |
| 框架稳定化 | 4219 | 收敛头文件和具体实现依赖，不改变业务路由 |
| 路由 | 4205 | 两个 IPC Event C API 切到 `ApiEvent`，保留主 `Api` 旧链路并增加路由证明 |
| 清理 | 4206 | 删除主 `Api`、实现和 decorator 中的旧 IPC Event 链路，完成多平台验证 |

这 4 个 PR 仍归纳为三个业务阶段：框架阶段可包含合入后的窄范围稳定化整改，之后依次为路由和清理。

划分依据：

- 两个成员只操作 `IpcEvent`，资源所有权明确；
- 标准产品由 `api_impl_event.cc` 提供正式实现，tiny/arch5162 继续使用 `api_impl_stub.cc` 中的 not-support 桩；
- C API 路由可以独立切换，不要求同步迁移 Event 创建、Record 或 Stream wait；
- 风险主要集中在 Runtime 生命周期、IPC handle 校验和各产品构建源列表，可以形成闭合验证。

### 批次二：查询、时间和标识，待串行合入

本批包含 6 个内部成员及其 C API：

| 内部成员 | Runtime C API |
|---|---|
| `GetEventID` | `rtGetEventID` |
| `EventQuery` | `rtEventQuery` |
| `EventQueryStatus` | `rtEventQueryStatus` |
| `EventQueryWaitStatus` | `rtEventQueryWaitStatus` |
| `EventElapsedTime` | `rtEventElapsedTime` |
| `EventGetTimeStamp` | `rtEventGetTimeStamp` |

当前串行链路为：

| 阶段 | PR | 作用 |
|---|---:|---|
| 扩展实现 | 4258 | 向 `ApiEvent`/`ApiImplEvent` 增加 6 个成员，接入产品和 UT 构建，但不切换 C API |
| 路由 | 4260 | 只切换上述 6 个 C API 到 `ApiEvent`，保留主 `Api` 旧链路 |
| 清理 | 4259 | 删除主 `Api`、`ApiImpl`、decorator、平台实现和旧 UT 中对应的 6 个成员 |

三个 PR 有严格依赖：`4258 -> 4260 -> 4259`。在它们实际合入前，应表述为“查询批次进行中”或“待合入”，不得写成已完成。每个后续 PR 都要基于前一个 PR 实际合入后的最新主线刷新并重跑验证。

划分依据：

- 6 个成员都直接查询 Event 状态、时间或标识，不负责 Stream 任务下发和 Event 生命周期；
- 旧主链路没有 David/V201 等平台 override，参数检查和对象调用可完整迁入 `ApiImplEvent`；
- 通用实现进入 `api_impl_event_common.cc`，标准产品同时编译 IPC 正式实现，tiny/arch5162 则继续使用 IPC 桩；
- 新增虚函数定义必须进入标准、David/V201、cmodel、tiny、arch5162、910B 及对应 UT 源列表。只验证 common 目标不能证明其他平台不存在 vtable 未定义符号；
- 路由阶段可以通过隔离主 `Api` 实例证明 6 个 C API 确实进入 `ApiEvent`，清理阶段也能按确切符号扫描旧链残留。

### 批次三：剩余低耦合成员，优先整批推进

查询批次之后，先集中拆分当前剩余成员中不依赖其他业务 API 大类的 3 个成员：

| 范围 | Runtime C API | 内部成员 |
|---|---|---|
| 官方 Event 管理接口 | `rtGetAvailEventNum` / `rtsEventGetAvailNum` | `GetAvailEventNum` |
| Runtime 内部 Event 配置 | `rtEventWorkModeSet` | `EventWorkModeSet` |
| Runtime 内部 Event 配置 | `rtEventWorkModeGet` | `EventWorkModeGet` |

其中 `GetAvailEventNum` 对应 `aclrtGetEventAvailNum`。`EventWorkModeSet/Get` 不在 22 个 ACL Event 管理接口中，但属于主 `Api` 中剩余的 Event 所有权成员；本轮目标既包括对外 Event 接口，也包括清理 Event 相关主 `Api` 成员，因此将它们作为同一低耦合批次处理，并在 PR 描述中明确官方范围与内部扩展范围。

本批判定为 API 模块边界独立，依据如下：

- 三个成员都不调用 `ApiSoma`、`ApiStream`、其他 `ApiXxx` 或主 `ApiImpl` 的 capture 私有 helper；
- `GetAvailEventNum` 通过当前 Context、Device 和 Driver 查询 Event 资源数量。Context/Device/Driver 是 Runtime 基础设施，调用不会要求另一个业务 API 大类实例存在；
- ACL Graph 的 `capture_model_utils.cc` 直接调用 `Driver::GetAvailEventNum`，不是主 `Api::GetAvailEventNum` 的调用方，不需要随本批迁移；
- `EventWorkModeSet/Get` 只访问 `GlobalContainer` 中的 Event 工作模式、引用计数和互斥锁，不依赖 Stream、capture、Soma 或 Device API 大类；
- `GetAvailEventNum` 没有 David/V201 override；工作模式在 standard_soc 有正式实现，tiny/arch5162 通过 stub 返回 feature-not-support。该产品差异是构建和验证风险，不是业务模块耦合；
- 三个成员都属于 Event 资源容量或运行模式查询/配置，不涉及 Event 生命周期、任务下发和同步后的跨模块副作用，可以形成同一编译和验证闭环。

本批按三个串行 PR 推进：

1. **扩展实现**：向 `ApiEvent`/`ApiImplEvent` 增加 3 个成员和直接 UT，补齐 standard_soc、tiny/arch5162、910B 等源列表，不切 C API；
2. **切换路由**：只将 `rtGetAvailEventNum`、`rtEventWorkModeSet/Get` 切到 `ApiEvent`，保留主 `Api` 旧链路并增加路由证明；
3. **清理旧链路**：删除主 `Api`、`ApiImpl`、decorator、平台正式实现和 stub 中对应成员，执行多产品链接和残留扫描。

本批重点验证：

- `GetAvailEventNum` 的 Context null、Device/Driver null、静态 event count、动态 Driver 查询成功/失败和 feature gate；
- 工作模式非法值校验、首次设置、重复设置、获取空指针、standard_soc 成功语义和 tiny/arch5162 feature-not-support；
- 三个 C API 的参数校验、错误码、日志、线程环境和路由实例与旧链一致；
- common、standard_soc、910B、tiny、arch5162 的 vtable 定义和正式/UT 链接闭合。

### 批次四：Event 同步，依赖 Soma 解耦后再决策

本批候选为：

| ACL 接口 | Runtime C API | 内部成员 |
|---|---|---|
| `aclrtSynchronizeEvent` | `rtEventSynchronize` | `EventSynchronize` |
| `aclrtSynchronizeEventWithTimeout` | `rtEventSynchronizeWithTimeout` | `EventSynchronize` |

`EventSynchronize` 的 Event 同步核心行为本身内聚，但完整旧语义包含成功后的 Soma 隐式内存池回收：

- 核心行为是检查 Event 所属 Context 后调用 `Event::Synchronize` 或 `IpcEvent::IpcEventSync`，资源所有权属于 Event；
- 旧链路没有 David/V201 override，除 C API、decorator 和 profiling 外没有其他主 `Api` 成员调用方；
- 与 Record/Reset 不同，该成员不接收 Stream，也不参与 ACL Graph capture 任务下发；
- 同步成功后必须调用 `ApiSoma_()->MemPoolTrimImplicit(false)`，trim 失败只记录告警，不覆盖同步结果。这是既有可观察副作用和错误语义；
- 若把该调用直接搬入 `ApiEvent`，就会假设支持或初始化 `ApiEvent` 时必须同时支持并初始化 `ApiSoma`；
- 将调用包装到 Runtime 函数只能减少头文件依赖。只要该函数仍无条件访问 `ApiSoma`，Event 与 Soma 的能力和生命周期耦合仍然存在。

因此当前不把 `EventSynchronize` 纳入独立批次，默认继续保留在主 `Api`。只有满足以下任一条件后才重新评估：

1. **上层编排**：拆出只负责 Event/IPC Event 同步的核心操作，由不属于 `ApiEvent` 的上层调用链在同步成功后执行可选 Soma trim；
2. **可选能力边界**：建立真正可选的 post-sync hook/provider，未初始化 Soma 时为明确的 no-op，且 `ApiEvent` 不包含 `api_soma.hpp`、不持有 `ApiSoma`、不要求 Soma 生命周期存在；
3. **保留结论**：若 profiling、返回值和成功后 trim 无法在上层完整包裹并证明等价，则长期将复合操作保留在主 `Api`，只把纯 Event 核心能力留在对象层。

解耦后重点验证：

- `timeout=-1`、非法 timeout、普通 Event、IPC Event 和 Context abort；
- Event 同步失败时不触发成功语义；
- Soma trim 失败只记录告警，不覆盖 Event 同步返回值；
- Soma provider 缺失时 Event 同步能力仍可初始化和运行；
- profiling begin/end、timestamp 和错误码转换覆盖“同步 + 成功后处理”的完整旧语义。

### 批次五：Event 生命周期，有条件拆分

候选 ACL 接口共 4 个：

- `aclrtCreateEvent`
- `aclrtCreateEventWithFlag`
- `aclrtCreateEventExWithFlag`
- `aclrtDestroyEvent`

主要内部成员：

- `EventCreate`
- `EventCreateEx`
- `EventDestroy`
- `EventDestroySync`，Runtime 内部能力，需要确认调用方和对外生命周期关系

这 4 个 ACL 接口对应 `EventCreate`、`EventCreateEx`、`EventDestroy`；`EventDestroySync` 是额外的 Runtime 内部生命周期能力，也应在同一批明确归属。

这些成员属于 Event 生命周期，适合最终迁入 `ApiEvent`，但不能直接照搬查询批次：

- `ApiImplDavid` 对 `EventCreate`、`EventCreateEx`、`EventDestroy` 有平台 override，必须为 `ApiImplEvent` 建立等价的平台创建策略，或先提取能保持动态分派的稳定辅助边界；
- `api_impl_capture_event.cc` 和 `api_impl_david_capture_event.cc` 在创建 capture Event 时直接调用 `EventCreate`/`EventCreateEx`。删除主 `ApiImpl` 成员前，必须将这些非 C API 调用方改到新边界；
- 创建路径涉及 Context/Device、MC2 feature、`Event`/`IpcEvent` 对象选择、`GenEventId`、`Setup`、Device Event 列表和 embedded handle；
- 销毁路径涉及状态回调、IPC 特殊销毁、Event ID 回收、同步销毁 feature、失败回滚和 handle 恢复；
- create/destroy profiling 目前由主 decorator 链承担，迁移后必须保持 profile type、begin/end 和失败路径配对。

启动本批前必须先确定：

1. `ApiImplEvent` 的标准、David/V201 和不支持产品实例由谁创建；
2. ACL Graph capture 内部创建 Event 是调用 `ApiEvent`，还是调用独立生命周期 helper；
3. `EventDestroySync` 回退到普通 destroy 时是否仍走同一个新实现；
4. 各产品对象类型、错误码和回收顺序能否通过直接 UT 和失败注入证明等价。

上述边界闭合后，再按扩展实现、路由、清理三个 PR 推进。

### 批次六：Record 和 Reset，高耦合后续批次

本批包含 3 个 ACL 接口：

- `aclrtRecordEvent`
- `aclrtRecordEventWithFlag`
- `aclrtResetEvent`

主要内部成员为 `EventRecord`、`EventReset`。它们的资源所有权以 Event 为主，但实现同时承载 Stream 和 capture 行为：

- 两个成员都接收 Stream，并负责默认 Stream、Context 归属和 model stream 检查；
- external Event、IPC Event、capture Event 和普通 Event 进入不同路径；
- Record 的 flag 一致性由错误层维护，迁移时不能改变 `SetRecordFlag` 时机；
- `ApiImplDavid` override Record/Reset，`ApiImplV201` 还单独 override Record；
- ACL Graph 路径调用 `CaptureEventRecord`、`CaptureEventReset`、`TerminateCapture` 等主实现能力，平台任务下发也不同。

本批应在生命周期批次建立 `ApiImplEvent` 平台层次后再启动。若 capture helper 仍只能依赖主 `ApiImpl` 的私有能力，则继续保留在主 `Api`，不要为了接口数量强行迁移。

重点验证普通/default Stream、跨 Context Stream、model stream、external flag、IPC Event、capture 成功/终止、David/V201 任务下发和 Record flag 重复设置。

### 明确保留在其他 API 大类

| ACL 接口 | 当前成员 | 结论 | 依据 |
|---|---|---|---|
| `aclrtStreamWaitEvent*` 3 个接口 | `StreamWaitEvent` | 不迁入 `ApiEvent`，留给 Stream API 大类 | C API 位于 `api_c_stream.cc`；核心对象和默认资源是 Stream；David/V201 有 override；实现负责 model stream、capture 和任务下发 |
| `aclrtSetOpWaitTimeout` | `SetOpWaitTimeOut` | 与 Stream wait 配置共同保留，后续评估 ApiStream 或配置大类 | 配置写入 Runtime wait timeout 和 timeout config，直接影响后续 `StreamWaitEvent`，不操作 Event 对象 |

这 4 个 ACL 接口仍属于官方 Event 管理目录，但“官方目录归属”不等于“内部 `ApiEvent` 所有权”。把它们明确保留在 Stream/配置边界，也属于完成模块归属分析。

`GetFaultEvent`、`Esched*Event`、`QueueSubF2NFEvent` 和 `BufEventTrigger` 属于故障、调度、队列或通知机制，不纳入 Event 资源大类拆分。

## 4. 每批固定三阶段

首批是建立新模块，后续批次是在既有 `ApiEvent` 上扩展成员，但业务阶段保持一致：

1. **扩展实现**：增加目标抽象成员、实现、平台 stub、CMake 和直接 UT；不切现有 C API。
2. **切换路由**：只切本批 C API，保留主 `Api` 旧成员；增加路由证明及新旧行为等价 UT。
3. **清理旧链路**：路由稳定后删除主 `Api`、实现、decorator、平台 override 和旧 UT 残留。

每个阶段都要明确本批接口、不包含项、风险、实际验证结果和仍未整改的 Event 成员。框架或扩展实现合入后的高置信度检视问题，可以用窄范围稳定化 PR 处理，但不得夹带下一阶段业务改动。

## 5. 风险和验证重点

### 扩展实现

- 新增虚实现 `.cc` 是否进入标准产品、910B、tiny、arch5162 等全部正式和 UT 构建清单；
- 引入标准、David/V201 等 `ApiImplEvent` 派生实现后，创建器是否按产品返回正确动态类型；
- Runtime 生命周期、初始化失败回滚和析构是否保持正确；
- 不支持产品的 stub、错误码和 feature gate 是否不变；
- 直接实现 UT 是否覆盖成功、参数错误和底层失败。

### 路由

- C API 是否确实进入 `ApiEvent`，而不是通过残留路径回到主 `Api`；
- 参数校验顺序、handle 转换、默认值、返回码和 ErrMsg 是否一致；
- profiling begin/end、Context/Device 和线程环境副作用是否一致；
- 是否通过 Runtime 转发掩盖了对其他业务 API 实例或生命周期的实际依赖；
- 路由 UT 是否能隔离旧实例并证明参数、结果和输出写回。

### 清理

- 主 `Api`、`ApiImpl`、decorator、平台 override、stub、mock 和旧 UT 是否无残留；
- feature 和对象层的非 C API 调用方是否已迁到稳定边界，不能只扫描 `api_c*.cc`；
- 删除虚函数和 include 后，各产品是否均可编译并链接；
- 清理范围是否严格限制在本批成员；
- 设计文档和 PR 描述是否同步更新剩余成员与下一批计划。

测试数量会随主线变化。应记录当次实际命令和结果，不复用历史用例总数作为固定门槛。

## 6. 实现文件命名

查询批次完成后，`api_impl_event.cc` 仍只包含 IPC Event 正式实现，通用查询实现位于 `api_impl_event_common.cc`。将旧文件重命名为 `api_impl_event_ipc.cc` 可以提高可读性，但不是功能正确性或下一批拆分的前置条件。

默认不要在进行中的 4258/4260/4259 业务 PR 中追加该重命名，原因是它会同时修改多个正式产品和 UT CMake 清单，并放大串行 PR 的 rebase 冲突。确需统一命名时，在查询批次全部合入后提交独立机械清理 PR：

1. 只重命名文件并更新所有正式/UT 源列表，不改任何函数实现或符号；
2. 标准产品继续编译 common + IPC，tiny/arch5162 继续编译 common + `api_impl_stub.cc`；
3. 验证 common、910B、tiny、arch5162 和正式产品链接；
4. 该 PR 不计入 Event 业务接口迁移批次。

后续新增无平台差异的成员优先进入 common；有 David/V201 差异的成员应进入明确的平台实现文件，不要继续把所有 Event 实现堆入一个文件。

## 7. 下一步计划

1. 先按依赖顺序推动查询批次，逐个确认 PR 状态、基线和验证结果。
2. 查询批次全部合入后，从最新主线重新扫描 `Api`/`ApiImpl`/decorator 和所有平台实现，确认 6 个查询成员已无旧链残留。
3. 以查询清理后的主线为依赖基线，将 `GetAvailEventNum`、`EventWorkModeSet/Get` 作为同一个低耦合批次，依次提交扩展实现、路由、清理三个 PR；后一个 PR 仅在前一个实际合入后 rebase 并执行完整 CI。
4. `EventSynchronize` 暂留主 `Api`。先确定上层编排或真正可选的 Soma post-sync 能力边界，再决定拆分还是长期保留。
5. 设计并验证 `ApiImplEvent` 的平台实现策略和 ACL Graph 内部创建边界，再启动生命周期批次。
6. 生命周期批次稳定后评估 Record/Reset；capture 或平台依赖未闭合时继续暂缓。Stream wait 和 wait timeout 保留在 Stream/配置边界。

状态汇报应始终按以下口径：

```text
已合入：批次一 IPC Event
进行中：批次二查询、时间和标识
下一优先批次：批次三 GetAvailEventNum、EventWorkModeSet/Get（API 模块边界独立）
依赖解耦后决策：批次四 Event 同步（Soma 成功后副作用）
有条件推进：批次五生命周期
暂缓：批次六 Record/Reset
明确保留：StreamWaitEvent、SetOpWaitTimeOut
```
