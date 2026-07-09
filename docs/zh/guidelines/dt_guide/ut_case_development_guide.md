# UT用例开发指导

> 返回 [Runtime DT用例开发总纲](README.md)

UT 的测试范围通常是一个文件、一个类，或者一个边界清晰的函数集合。UT 的重点是隔离被测对象，验证其对外可观察行为，而不是顺带验证整条链路上的所有模块。

## UT 用例设计 checklist

为某个接口设计测试点时，建议优先检查以下内容：

* 外部输入校验
  * 空指针
  * 非法枚举值
  * 越界长度、容量、索引
  * 不满足前置条件的句柄或状态
* 边界值
  * 空容器、零长度、最小/最大合法值
  * 单元素与多元素场景
* 资源生命周期
  * 申请和释放是否配对
  * 失败路径是否有泄漏
  * 重复创建、重复释放是否安全
* 全局状态与单例
  * `rtSetSocVersion`、`SetChipType`、`rtSetDevice` 等全局状态切换
  * 环境变量、配置开关、静态缓存是否需要恢复
* 平台/芯片分支
  * 同一接口在不同 SoC、不同 driver 能力下是否有分支行为
* 回调与副作用
  * 回调是否注册/触发
  * 文件、目录、日志、统计信息是否正确产生

如果某个检查项与当前接口无关，可以不为其强行设计用例。

## 如何校验

### 做完整校验

UT 用例应根据设计，对调用结果做完整校验。常见校验点包括：

* 返回值或错误码是否准确
* 出参是否被正确填写
* 被测对象状态是否按预期变化
* mock 是否以正确参数被调用，以及调用次数是否符合预期
* 失败路径上的清理逻辑是否执行

一个常见问题是“只校验返回码，不校验副作用”。这类用例很难防住行为回归，应避免。

### 避免重复校验

同一类校验尽量只在一个最贴近场景的用例里完成。重复校验过多会让后续改动引发大量无效失败，降低用例可维护性。

## Runtime 仓常见注意事项

### 1. mock 与全局状态必须在 TearDown 中收口

Runtime 仓大量用例依赖 gmock 或 mockcpp。无论使用哪一种框架，都需要在测试结束时完成校验和清理，避免污染后续用例。

常见模式如下：

```c++
class QueueTest : public testing::Test {
 protected:
  void SetUp() override {
    MockFunctionTest::aclStubInstance().ResetToDefaultMock();
  }

  void TearDown() override {
    Mock::VerifyAndClear((void *)(&MockFunctionTest::aclStubInstance()));
  }
};
```

或者：

```c++
class PackageProcessConfigTest : public testing::Test {
 protected:
  void TearDown() override {
    GlobalMockObject::verify();
  }
};
```

如果测试过程中修改了芯片类型、device、环境变量、静态标志位或单例内部状态，也必须在 `TearDown` / `TearDownTestCase` 中恢复。

### 2. 谨慎访问私有成员

仓内现有代码中存在 `#define private public` / `#define protected public` 的做法，但这只能作为受限场景下的补充手段，不应成为默认方案。

建议优先顺序如下：

1. 优先校验公开接口暴露出来的行为
2. 若必须观察内部状态，优先复用现有 helper、stub 或 accessor
3. 只有在确实没有更好办法时，才临时使用 `#define private public`

### 3. 文件系统场景要保证隔离和清理

很多 Runtime 测试会读写 `/tmp`、相对路径目录或临时文件。新增此类用例时：

* 路径命名应带上模块或用例特征，避免与其他用例冲突
* 测试完成后要清理临时文件和目录
* 不要依赖其他用例预先创建目录或文件

### 4. 兼容性变更要补对应测试

如果修改了 ACL 对外结构体、枚举、常量、接口签名或 ABI 相关内容，应同步检查是否需要补充或更新兼容性测试，例如：

* `tests/ut/acl/testcase/compatibility/`
* 对应模块已有的 ABI/接口回归用例

## 不推荐的 UT 设计

以下几类用例需要谨慎：

* 只验证“调用成功/失败”，不验证任何结果
* 在一个用例里串多个弱相关场景
* 为了覆盖率而硬测不真实的异常组合
* 用例依赖前一个用例执行后的残留状态

如果某个场景已经跨越模块边界，需要启动模拟器、设备环境或完整流程，通常更适合放到 ST，而不是继续堆在 UT 中。
