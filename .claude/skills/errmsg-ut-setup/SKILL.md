# ErrMsg UT 验证框架快速搭建 Skill

## 触发场景

当用户提出以下需求时触发此 Skill：
- "验证 ErrMsg 上报整改效果"
- "写 UT 让 ErrMsg 真实打印出来"
- "测试 ErrorManager::ATCReportErrMessage 的真实实现"
- "ErrMsg 格式化输出验证"
- "运行 ErrMsg UT 验证"

## 用途

搭建一个 UT 测试框架，让 `ErrorManager::ATCReportErrMessage` 调用真实实现（而非 stub），从而验证 PR 中的 ErrMsg 上报整改效果，打印格式化后的 ErrMsg 内容。

## 核心原理

1. **问题根源**：UT 默认定义 `CFG_DEV_PLATFORM_PC`，导致 ErrMsg 上报宏（如 `COND_RETURN_AND_MSG_OUTER`）在展开后被跳过
2. **解决方案**：取消定义 `CFG_DEV_PLATFORM_PC`，让宏调用真实 `ErrorManager`
3. **冲突处理**：stub `ErrorManager` 与真实 `ErrorManager` 类名冲突，用条件编译解决

## 实施步骤

### Step 1: 修改 CMakeLists.txt

在 `tests/ut/runtime/runtime/CMakeLists.txt` 末尾追加测试目标配置。

**关键配置**：
- 添加真实 `error_manager.cc` 源文件
- 排除 `error_manager_stub.cc`
- 使用 `target_compile_options(... -UCFG_DEV_PLATFORM_PC)` 取消定义

详见附录 A。

### Step 2: 修改 stub 头文件

修改 `tests/ut/runtime/runtime/stub/rt_utest_stub.h`，将 stub `ErrorManager` 类用条件编译包裹。

详见附录 B。

### Step 3: 创建测试文件

创建 `tests/ut/runtime/runtime/test/rt_errmsg_real_test.cc`，编写测试用例。

**关键技巧**：
- 使用 lambda 包装宏调用（解决 void 函数 return value 问题）
- 调用实际代码中的宏（如 `COND_RETURN_AND_MSG_OUTER`）

详见附录 C。

### Step 4: 准备 error_code.json

```bash
mkdir -p src/conf/error_manager
cp src/dfx/error_manager/error_code.json src/conf/error_manager/
```

### Step 5: 编译运行

```bash
# 编译
cd build && make -j8 runtime_utest_errmsg_real && cd ..

# 运行
./build/tests/ut/runtime/runtime/runtime_utest_errmsg_real --gtest_filter="ErrMsgRealTest*"

# 单个测试
./build/tests/ut/runtime/runtime/runtime_utest_errmsg_real --gtest_filter="ErrMsgRealTest.EE1013*"
```

## 常见错误码测试示例

| 错误码 | 源文件位置 | 宏名称 |
|--------|-----------|--------|
| EE1013 | uma_arg_loader.cc:62 | `COND_RETURN_AND_MSG_OUTER` |
| EE1003 | kernel_utils.cc:198-200 | `COND_RETURN_AND_MSG_OUTER` |
| EE1004 | para_convertor.cc:136 | `NULL_PTR_RETURN_MSG_OUTER` |
| EE1017 | para_convertor.cc:35-37 | `COND_RETURN_AND_MSG_OUTER` |
| EE1018 | model.cc:874-876 | `COND_RETURN_AND_MSG_OUTER` |
| EE1006 | kernel_utils.cc:229-230 | `COND_RETURN_AND_MSG_OUTER` |
| EE9999 | capture_model.cc:719 | `RT_LOG_INNER_MSG` |

## 输出验证

测试运行后会输出两种 ErrMsg：
1. **日志输出**（console 直接打印）：来自 `PrintErrMsgToLog`
2. **ErrorManager 输出**（`========== ErrMsg Output ========== 区块）：来自 `ErrorManager::GetErrorMessage()`

示例输出：
```
[PID: 12345] 2025-04-28-15:38:53.922.974 Resource_Error_Insufficient_Host_Memory(EE1013): 
Failed to allocate 1024 bytes host memory for Runtime.
        Possible Cause: Allocation failed due to insufficient host memory.
        Solution: Stop unnecessary processes and ensure that the required memory is available.
```

## 附录文件

- **附录 A**：`appendix_a_cmake.txt` - CMakeLists.txt 追加内容
- **附录 B**：`appendix_b_stub.txt` - stub 头文件条件编译修改
- **附录 C**：`appendix_c_test.txt` - 测试文件完整模板

## 注意事项

1. 此测试目标仅用于本地验证，不提交到仓库
2. 测试完成后可恢复 stub 文件原始状态
3. 如需新增错误码测试，参考附录 C 中已有测试用例格式