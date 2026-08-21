# 风险与验证矩阵

## 1. 风险矩阵

| 风险域 | 典型问题 | 必查证据 |
|---|---|---|
| 能力判断 | 仍创建被裁剪实现，或支持产品误返回不支持 | 平台工厂定义、初始化 UT、产品矩阵 |
| ABI | 删除 C API 源文件后导出符号缺失 | 裁剪前后 `nm -D` 集合差分、API Check |
| 调用链 | 支持产品路由、参数或错误语义变化 | 普通产品原 UT、成功/失败路径对比 |
| 具体依赖 | `runtime.cc` 仍有 include、`sizeof`、`new` | 源码扫描、依赖 `.d` 文件、编译结果 |
| 链接 | vtable、工厂或 driver 方法未定义 | `link.txt`、`nm -C -u`、`ldd -r` |
| CMake | 正式 target 已移除但 UT/其他产品遗漏新增源文件 | 全产品源文件矩阵、目标编译 |
| 生命周期 | 工厂失败未传播，部分初始化对象泄漏 | 分配失败注入、Runtime 回滚/析构 UT |
| 平台桩 | 签名、可见性或错误码不一致 | 头文件对照、逐接口 not-support UT |
| 静态副作用 | 组件对象虽未调用但静态注册仍执行 | 对象缺失证明、初始化行为检查 |
| 体积 | 统计条件不同或 debug 信息掩盖收益 | 同基线构建、`stat`、`size`、strip 状态 |
| 覆盖率 | 新能力分支和失败路径未覆盖 | 增量覆盖率报告、定向失败 UT |
| 回退 | 聚合提交无法单独恢复目标产品能力 | 分阶段提交与反向回退演练 |

## 2. 第一步验证：按模块适配

若第一步有代码改动：

- 比较移动前后函数集合和实现内容，确认仅调整编译单元归属。
- 所有原先获得定义的正式/UT target 都加入新源文件。
- 支持产品和目标产品仍走原调用链并通过原 UT。
- 若提取公共能力，验证没有扩大公共层职责。

若跳过第一步：保存专属源文件、依赖闭合和 target 可单独移除的证据。

## 3. 第二步验证：工厂解耦

- 普通产品、目标产品均编译并创建原组件实现。
- `runtime.cc` 不包含具体实现头文件，依赖文件中也无该头文件。
- 工厂成功、具体对象分配失败、Runtime 失败传播均有 UT。
- 普通动态库 `ldd -r` 无未定义符号。
- API 单例或入口符号仍由原动态库提供。
- 本阶段不改变任何平台的 feature-not-support 行为。

## 4. 第三步验证：目标隔离

- 目标正式库与目标 UT target 均不编译组件三个层次的源文件。
- 目标 Runtime 初始化跳过组件创建且其他组件正常初始化。
- 所有公开接口逐一返回约定的不支持错误码。
- 支持产品原功能 UT 保持通过。
- 目标和基线公开符号集合一致。
- `-Wl,--no-undefined` 构建和 `ldd -r` 均通过。
- cmodel/camodel、关键芯片目标、API Check 和 PreSmoke 均执行并通过。

## 5. 常用证据命令

以仓库当前 target 和构建目录为准调整路径：

```bash
git diff --check origin/master...HEAD
git diff --stat origin/master...HEAD
git log --oneline origin/master..HEAD

rg -n 'api_impl_xxx|ApiImplXxx|CreateImplXxx|IsImplXxxSupported' src tests
find <target-build> -type f \
  \( -name 'api_c_xxx.cc.o' \
  -o -name 'api_impl_xxx.cc.o' \
  -o -name 'provider_xxx.cc.o' \)

rg -n 'api_impl_xxx.hpp' <target-build>/**/runtime.cc.o.d
ldd -r <target-build>/src/runtime/libruntime.so
nm -D --defined-only <baseline-lib> | awk '{print $3}' | sort > <baseline-symbols>
nm -D --defined-only <target-lib> | awk '{print $3}' | sort > <target-symbols>
comm -3 <baseline-symbols> <target-symbols>

stat -c '%s' <baseline-lib> <target-lib>
size <baseline-lib> <target-lib>
```

符号基线应按公开头文件和裁剪前库确定；不要只使用名称前缀过滤。`find` 无输出只能证明指定对象文件不存在，还需结合链接和行为检查。

## 6. 测试要求

至少覆盖：

1. 支持产品组件 API 正常和底层失败路径。
2. 工厂 `new (std::nothrow)` 返回空。
3. Runtime 收到空工厂结果并返回初始化错误。
4. 目标产品每个公开 C API 的 not-support 路径。
5. 目标产品 Runtime 初始化时组件指针保持为空。
6. 其他 Runtime 组件不受影响。

运行定向用例后，再运行承载改动源文件的完整测试 binary。用例数量不是唯一证据；同时记录命令、target、过滤器和结果。

## 7. CI 判定

创建或更新每个 PR 后读取线上任务表。重点核对：

- 正式 X86/ARM 编译；
- Runtime common、910B、v201、David 等 UT；
- `UT_Test_camodel_check`；
- 增量覆盖率报告；
- API Check、PreSmoke；
- pre-commit、codespell、markdownlint 和链接检查。

若 `UT_Test_camodel_check` 失败，进入 OpenLibing 流水线对应任务读取日志，
不根据总状态猜测原因。覆盖率失败时下载报告，定位新增未覆盖行后补异常路径 UT。

只把实际结束且目标任务成功的流水线写成通过。警告、跳过和不可读日志单独记录。
