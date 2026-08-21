# 风险与验证矩阵

## 1. 风险分析

为每个本批接口填写以下矩阵，不允许只写“纯重构、无风险”。

| 风险域 | 典型问题 | 必查证据 |
|---|---|---|
| 路由 | C API 仍走旧 `Api`，或某产品走不同入口 | 路由 UT、调用点 diff、符号/实例隔离证明 |
| 参数与 handle | 判空顺序、unwrap/cast、输出写回变化 | 成功/空指针/错误类型/非法 handle UT |
| 返回码与 ErrMsg | decorator 移除后错误转换或日志丢失 | 新旧错误码表、错误路径 UT、日志检查 |
| Profiling | begin/end 不配对，异常路径漏 end | 成功与每个失败分支 UT，必要时 coverage |
| Context/环境 | overload 变化导致 mock 未命中，隐式 SetDevice 或线程 flag 改变 | 精确函数签名 mock、Context null/device null、环境 flag UT |
| 生命周期 | Runtime 初始化失败泄漏，析构重复释放 | 创建失败注入、回滚、析构和重复初始化 UT |
| 内部布局 | 新 Runtime 成员或虚函数影响布局 | 成员放置理由、ABI/API check、相关静态检查 |
| 平台实现 | 标准实现误进 tiny，或 David/V201 override 遗漏 | 各产品 CMake 源列表和链接结果 |
| 链接 | 新虚实现文件漏进 910B/平台 UT，出现 vtable undefined | 目标编译、link.txt/符号检查 |
| 头文件 | 移除传递 include 后暴露广泛依赖 | 改动文件编译；采用最小直接 include 修复 |
| 清理 | 旧 override、decorator、stub、UT 或调用点残留 | `rg` 残留扫描、构建和全量目标 |
| 跨模块依赖 | 为拆一个模块同时改变 Stream/Device/Context 行为 | 依赖图、暂缓清单、PR 不包含项 |

## 2. 分阶段验证

### 阶段一：框架

最小验证：

- 新 `ApiXxx`/`ApiImplXxx` 直接 UT；
- Runtime 正常初始化、失败回滚和析构 UT；
- 标准 `runtime_utest_api` 构建和相关用例；
- `runtime_utest_api_910B` 目标编译及相关用例；
- tiny/arch5162 stub 目标编译及 not-support 语义；
- 正式构建中所有目标产品源文件清单核对。

重点证明：现有 C API 仍走旧路径，对外行为没有切换。

### 阶段二：路由

最小验证：

- 每个本批 C API 至少一个路由证明用例；
- 参数透传和输出 handle/对象写回；
- 成功、参数错误、Context/Device 错误、底层失败路径；
- profiling 和线程环境状态；
- 标准与关键平台目标编译。

重点证明：新路径与旧路径行为等价，且旧主 `Api` 方法尚未删除。

### 阶段三：清理

最小验证：

- 扫描主 `Api`、ApiImpl、decorator、平台 override/stub 和 UT 的旧符号残留；
- `runtime_utest_api`；
- `runtime_utest_api_910B`；
- `runtime_utest_tiny_stub`；
- `runtime_utest_arch5162`；
- `bash build.sh` 或仓库当前等价正式构建；
- API Check、PreSmoke、静态检查和 `git diff --check`；
- 最终文档与当前代码一致性检查。

重点证明：没有双路径、链接缺口或未说明的剩余接口。

## 3. 命令选择

以仓库当前 Skill 和构建帮助为准，不盲目复用旧参数。常用入口包括：

```bash
bash build.sh
bash tests/build_ut.sh --ut=runtime --target=runtime_utest_api
bash tests/build_ut.sh --ut=runtime --target=runtime_utest_api_910B
pre-commit run --from-ref origin/master --to-ref HEAD
git diff --check origin/master...HEAD
```

tiny、arch5162 或定向 gtest 的实际命令应从当前 CMake target、已有构建目录或 `runtime-llt-run` Skill 获取。

不要用测试用例总数作为唯一证据。保存命令、目标、过滤器、通过/失败数、失败原因和是否为改动前既有问题。

## 4. 行为对比记录

每个接口在路由阶段至少填写：

| 场景 | 旧路径 | 新路径 | 是否一致 | 证据 |
|---|---|---|---|---|
| 正常成功 |  |  |  |  |
| 空入参 |  |  |  |  |
| 非法 handle/type |  |  |  |  |
| Context/Device 异常 |  |  |  |  |
| 底层失败 |  |  |  |  |
| feature not support |  |  |  |  |
| profiling |  |  |  |  |
| 线程环境/隐式状态 |  |  |  |  |

若结果不一致，先判断是旧行为缺陷还是重构回归。结构拆分默认保持旧行为；需要修正功能时另建 PR 并补充需求依据。

## 5. 验收结论

结论必须区分：

- 已本地验证；
- 已由线上流水线验证；
- 线上 CI 编译任务已通过；
- 因环境或权限未验证；
- 与本次改动无关的既有失败；
- 本批未覆盖、留待后续的接口。

每个 PR 提交后都要核对线上 CI。三个代码 PR 的 CI 编译任务必须实际执行并通过；CI 产物无法读取、任务仍在运行或目标未执行时，明确写成证据缺口，不能写“CI 全部通过”或“可合入”。
