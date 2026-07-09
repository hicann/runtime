# 测试框架指南

> 返回 [Runtime DT用例开发总纲](README.md)

Runtime 仓测试主要基于 gtest，结合 gmock、mockcpp、公共桩和模块内 stub/data 组织用例。本文介绍现有测试框架能力，帮助开发者优先复用已有设施，而不是重复造轮子。

## 测试基类

绝大多数用例直接继承 `testing::Test`，并在 `SetUp` / `TearDown` 中完成公共初始化与清理。

常见职责包括：

* 恢复默认 mock 行为
* 创建和销毁模拟器
* 设置和恢复全局芯片类型、device、环境变量
* 校验并清理 mock 对象

如果多个用例共享同一套初始化逻辑，建议抽出统一 fixture，避免重复代码。

## mock 框架

### gmock

适用于已有 mock 类或接口期望校验场景，常见用法包括：

* `EXPECT_CALL(...)`
* `Mock::VerifyAndClear(...)`

典型场景：

* ACL 相关接口测试
* 需要验证某个 mock 对象被调用次数和参数的场景

### mockcpp

适用于全局函数、静态函数、成员函数替换场景，仓内使用非常普遍。常见接口包括：

* `MOCKER(...)`
* `MOCKER_CPP(...)`
* `MOCKER_CPP_VIRTUAL(...)`
* `GlobalMockObject::verify()`

典型场景：

* 打桩 `dlopen` / `dlsym` / `access` 等系统接口
* 打桩 driver、runtime、device 相关函数
* 替换单例内部调用链

## 公共桩与测试资产

### `tests/depends/`

`tests/depends/` 提供跨模块复用的公共桩，新增测试前应优先检查这里是否已有可复用能力。当前主要包含：

* `ge/`
* `mmpa/`
* `profiling/`
* `runtime/`
* `slog/`
* `tdt/`
* `toolchain/`

### 模块内 `stub/`、`data/`、`json/`

很多模块会在自己的测试目录下维护专用测试资产，例如：

* `tests/ut/msprof/st/stub/`
* `tests/ut/msprof/st/data/`
* `tests/ut/acl/json/`
* `tests/ut/runtime/runtime_c/stub/`

如果某个 stub 或数据只服务于一个模块，应优先放在模块内，避免污染公共目录。

## 模拟器与辅助能力

部分 ST/UT 会使用模块内现成的模拟器和数据管理能力，例如：

* `SimulatorMgr()` 创建/销毁平台模拟器
* `DataMgr()` 初始化和校验场景数据

这类能力通常已经和模块场景耦合，新增用例时应优先复用现有 helper，不要重复实现一套新的模拟逻辑。

## 构建接入

新增测试代码后，通常需要修改对应模块的 `CMakeLists.txt`。常见接入方式包括：

* 将新文件加入 `UT_FILES`
* 将新目录加入 `add_subdirectory(...)`
* 为新可执行目标补充依赖的 stub、头文件和链接库

如果新增了可通过 `bash tests/build_ut.sh -u <target>` 直接执行的模块，还需要同步更新 `tests/build_ut.sh` 中的 target 映射。

## 覆盖率与 Sanitizer

仓内统一入口为 `tests/build_ut.sh`：

```bash
# 覆盖率
bash tests/build_ut.sh -c

# AddressSanitizer
bash tests/build_ut.sh --asan -u runtime
```

如果新增测试会创建大量临时文件或目录，建议在本地同时跑一遍覆盖率或 sanitizer，尽早暴露泄漏和残留状态问题。
