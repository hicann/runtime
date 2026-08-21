# ApiImplMbuf 隔离案例

本案例记录 PR4264、PR4265、PR4254 验证出的 Mbuf 模式。PR 状态和主线会变化，使用前重新查询。

## 1. 原调用链

```text
rtMbuf*/rtBuff* C API
  -> ApiMbuf::Instance()
  -> Runtime::ApiMbuf_()
  -> ApiImplMbuf
  -> NpuDriver::Mbuf*
  -> HAL Mbuf API
```

arch5162 不使用 Mbuf，但原构建仍编译通用 C API、具体实现和 driver 方法。

## 2. 第一步：PR4264

PR4264 将 `NpuDriver::Mbuf*` 方法从混合职责的 `npu_driver_queue.cc` 原样移动到
`npu_driver_mbuf.cc`，并把新文件加入所有原正式/UT target。

该步骤的目的只是让 Mbuf driver 成为可移除编译单元：

- 不修改 C API 路由；
- 不修改 Runtime 创建方式；
- arch5162 仍编译并支持 Mbuf；
- 可独立合入和回退。

这是 Mbuf 特有的第一步。其他组件若已有专属 provider 文件，应跳过或选择不同准备动作。

## 3. 第二步：PR4265

PR4265 解除公共 Runtime 对具体 `ApiImplMbuf` 的依赖：

- `runtime.cc` 移除 `api_impl_mbuf.hpp`；
- 增加 `IsImplMbufSupported()`；
- `CreateImplMbufAndGet()`、`new`、`sizeof(ApiImplMbuf)` 和日志移入 `api_impl_mbuf.cc`；
- 所有平台仍返回支持；
- 增加工厂分配失败和 Runtime 失败传播 UT。

该 PR 不引用 `npu_driver_mbuf.cc`，因此在 Mbuf 案例中与 PR4264 技术独立，可单独基于 `master` 编译和回退。

`ApiMbuf::Instance()` 继续留在 API 侧 `api.cc`。移动到具体实现文件会改变动态库
符号归属，并可能使普通 `api_c_mbuf.cc` 出现跨 SO 未解析引用。

## 4. 第三步：PR4254

PR4254 启用 arch5162 隔离：

- arch5162 能力入口返回不支持，不创建 `ApiImplMbuf`；
- 从 arch5162 正式/UT target 移除 `api_c_mbuf.cc`、`api_impl_mbuf.cc`、`npu_driver_mbuf.cc`；
- 在 `api_c_arch5162.cc` 提供不支持桩；
- 增加 arch5162 逐接口 UT；
- 支持产品继续走原链路。

公开 C API 共 17 个：15 个 `rtMbuf*`，以及历史命名的 `rtBuffGet`、`rtBuffPut`。符号比较不能只过滤 `^rtMbuf`。

## 5. 链接结论

`NpuDriver` 头文件保留 Mbuf 成员声明不会自动产生链接错误。arch5162 移除 C API、
`ApiImplMbuf` 和 driver 实现后，没有代码引用这些成员，因此
`-Wl,--no-undefined` 仍可通过。

必须同时证明：

- arch5162 链接输入不含三个 Mbuf 对象文件；
- `runtime.cc.o.d` 不依赖 `api_impl_mbuf.hpp`；
- `ldd -r libruntime.so` 无未定义符号；
- 普通与 arch5162 的 17 个公开符号集合一致。

## 6. 合入关系

```text
PR4264  Mbuf driver 编译单元准备  ---\
                                      -> PR4254 arch5162 隔离
PR4265  Runtime 工厂解耦          ---/
```

PR4264 与 PR4265 在本案例中可独立上库，推荐按 4264、4265 顺序便于检视。
PR4254 依赖两者；前两者合入后需重放 PR4254，使其最终 diff 只保留 arch5162
平台差异、ABI 桩、UT 和文档。

## 7. 可迁移与不可机械复用

可迁移到其他组件：

- 具体类型分配和 `sizeof` 下沉；
- Runtime 只依赖抽象工厂和能力入口；
- 目标产品通过 CMake 停止编译；
- 平台 API 桩保留 ABI；
- 对象缺失、符号、链接、失败 UT 和大小验证。

不可机械复用以下假设：

- “第一步一定拆 driver 文件”；
- “所有组件的第一步与第二步都技术独立”；
- “所有接口都使用 `rtMbuf*` 命名”；
- “Mbuf 的 17 个接口数和错误码可直接套用到其他模块”。
