/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "runtime/rt.h"
#include "error_code.h"
#include "errcode_manage.hpp"
#include "runtime.hpp"
#include "rt_log.h"
#include "runtime_handle_guard.h"
using namespace testing;
using namespace cce::runtime;
class RtErrorCodeTest : public Test {
protected:
    static void SetUpTestCase()
    {}

    static void TearDownTestCase()
    {}

    virtual void SetUp()
    {}

    virtual void TearDown()
    {}
};

TEST_F(RtErrorCodeTest, RtFmtMsgNullPtr)
{
    EXPECT_EQ(RtFmtMsg(nullptr), "");
}

TEST_F(RtErrorCodeTest, RtFmtMsgBasic)
{
    std::string result = RtFmtMsg("test %d %s", 42, "hello");
    EXPECT_EQ(result, "test 42 hello");
}

TEST_F(RtErrorCodeTest, RtFmtMsgPointer)
{
    void *ptr = reinterpret_cast<void *>(0x1234);
    std::string result = RtFmtMsg("ptr=%p", ptr);
    EXPECT_TRUE(result.find("0x1234") != std::string::npos);
}

TEST_F(RtErrorCodeTest, GetTsErrModuleType)
{
    EXPECT_EQ(GetTsErrModuleType(TS_SUCCESS), ERR_MODULE_RTS);
}

TEST_F(RtErrorCodeTest, GetTsErrModuleTypeNotFind)
{
    EXPECT_EQ(GetTsErrModuleType(TS_ERROR_RESERVED + 1), ERR_MODULE_RTS);
}

TEST_F(RtErrorCodeTest, GetTsErrCodeDescNotFind)
{
    RecordErrorLog(__FILE__, __LINE__, __FUNCTION__,  "%s", "unknown error");
    RecordLog(DLOG_DEBUG, __FILE__, __LINE__, __FUNCTION__,  "%s", "unknown error");
    EXPECT_EQ(strcmp(GetTsErrCodeDesc(TS_ERROR_RESERVED + 1), "unknown error"), 0);
}

TEST_F(RtErrorCodeTest, GetTsErrDescByRtErr)
{
    RecordErrorLog(__FILE__, __LINE__, __FUNCTION__, nullptr);
    RecordLog(DLOG_DEBUG, __FILE__, __LINE__, __FUNCTION__,  nullptr);
    EXPECT_EQ(strcmp(GetTsErrDescByRtErr(RT_ERROR_NONE), "success"), 0);
}

TEST_F(RtErrorCodeTest, PrintErrMsgToLog)
{
    std::vector<std::string> values1001 = {"The argument is invalid"};
    PrintErrMsgToLog(ErrorCode::EE1001, "file", 1000, "func", values1001);
 
    std::vector<std::string> values1002 = {"Stream synchronize timeout"};
    PrintErrMsgToLog(ErrorCode::EE1002, "file", 1000, "func", values1002);
 
    std::vector<std::string> values1 = {"rtMemCpy", "0", "size", "[0, 255]"};
    PrintErrMsgToLog(ErrorCode::EE1003, "file", 1000, "func", values1);
 
    std::vector<std::string> values2 = {"rtMemCpy", "src"};
    PrintErrMsgToLog(ErrorCode::EE1004, "file", 1000, "func", values2);
 
    std::vector<std::string> values3 = {"rtMemCpy"};
    PrintErrMsgToLog(ErrorCode::EE1005, "file", 1000, "func", values3);

    std::vector<std::string> values101 = {"set the saturation mode", "only the Inf/NaN mode can be set and the saturation mode"};
    PrintErrMsgToLog(ErrorCode::WE0001, "file", 1000, "func", values101);
 
    std::vector<std::string> values4 = {"rtMemCpy", "d2d", "The current device does not support d2d memory copy"};
    PrintErrMsgToLog(ErrorCode::EE1006, "file", 1000, "func", values4);
 
    std::vector<std::string> values5 = {"10", "repeat bind"};
    PrintErrMsgToLog(ErrorCode::EE1007, "file", 1000, "func", values5);
 
    std::vector<std::string> values7 = {"10", "model invalid"};
    PrintErrMsgToLog(ErrorCode::EE1009, "file", 1000, "func", values7);
 
    std::vector<std::string> values8 = {"rtModelExecute", "stream",
        "stream_id=123, stream_ctx=0x7f8a0001, cur_ctx=0x7f8a0002."};
    PrintErrMsgToLog(ErrorCode::EE1010, "file", 1000, "func", values8);

    std::vector<std::string> values1011 = {"rtMemCpy", "0", "size", "size is not 0"};
    PrintErrMsgToLog(ErrorCode::EE1011, "file", 1000, "func", values1011);
}

TEST_F(RtErrorCodeTest, PrintErrMsgToLog2)
{
    std::vector<std::string> values1012 = {"NotifyWait", "0", "current deviceId", "The current device cannot deliver Notify Wait"};
    PrintErrMsgToLog(ErrorCode::EE1012, "file", 1000, "func", values1012);

    std::vector<std::string> values1013 = {"100"};
    PrintErrMsgToLog(ErrorCode::EE1013, "file", 1000, "func", values1013);

    std::vector<std::string> values1014 = {"The ELF section header address in the operator binary ELF file header cannot be empty"};
    PrintErrMsgToLog(ErrorCode::EE1014, "file", 1000, "func", values1014);

    std::vector<std::string> values1015 = {"rtsIpcMemImportByKey", "The driver interface halShmemInfoGet does not exist."};
    PrintErrMsgToLog(ErrorCode::EE1015, "file", 1000, "func", values1015);

    std::vector<std::string> values1016 = {"MemCopySync", "Other threads of the current context are in the capture state"};
    PrintErrMsgToLog(ErrorCode::EE1016, "file", 1000, "func", values1016);

    std::vector<std::string> values1017 = {"rtMemCpy", "size", "size is not 0"};
    PrintErrMsgToLog(ErrorCode::EE1017, "file", 1000, "func", values1017);

    std::vector<std::string> values1018 = {"aclrtSetLabel", "Before setting the label using aclrtSetLabel, you need to call aclrtCreateLabelList to create a label list"};
    PrintErrMsgToLog(ErrorCode::EE1018, "file", 1000, "func", values1018);

    std::vector<std::string> values1019 = {"AddTaskToList", "stream task public buffer is full"};
    PrintErrMsgToLog(ErrorCode::EE1019, "file", 1000, "func", values1019);

    std::vector<std::string> values1020 = {"rtGetSocVersion", "memcpy_s", "1", "count is greater than dest_max",
        "src=0x1, dest=0x2, dest_max=10, count=11."};
    PrintErrMsgToLog(ErrorCode::EE1020, "file", 1000, "func", values1020);

    std::vector<std::string> values1021 = {"semaphore", "aclrtCreateStream"};
    PrintErrMsgToLog(ErrorCode::EE1021, "file", 1000, "func", values1021);

    std::vector<std::string> values1022 = {"rtUbDbSend", "nullptr and nullptr", "pbase and psize",
        "Parameters pbase and psize cannot both be nullptr"};
    PrintErrMsgToLog(ErrorCode::EE1022, "file", 1000, "func", values1022);

    std::vector<std::string> values9 = {"1, 2, 2", "SetVisible", "not repeat"};
    PrintErrMsgToLog(ErrorCode::EE2002, "file", 1000, "func", values9);

    PrintErrMsgToLog(ErrorCode::EE_NO_ERROR, "file", 1000, "func", values9);
    PrintErrMsgToLog(ErrorCode::EE_NO_ERROR, "file", 1000, "func", {});
    ProcessErrorCodeImpl(ErrorCode::EE_NO_ERROR,  "file", 1000, "func", std::move(values9));
}

TEST_F(RtErrorCodeTest, RePortErrCode)
{
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1001, "The argument is invalid");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1002, "Stream synchronize timeout");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1003, "rtMemCpy", "0", "size", "[0, 255]");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1004, "rtMemCpy", "src");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1005, "rtMemCpy");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1006, "rtMemCpy", "d2d", "The current device does not support d2d memory copy");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1007, "10", "repeat bind");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1009, "10", "model invalid");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1010, "rtModelExecute", "stream",
        "stream_id=123, stream_ctx=0x7f8a0001, cur_ctx=0x7f8a0002.");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1011, "rtMemCpy", "0", "size", "size is not 0");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1012, "NotifyWait", "0", "current deviceId", "The current device cannot deliver Notify Wait");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1013, "100");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1014, "The ELF section header address in the operator binary ELF file header cannot be empty");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1015, "rtsIpcMemImportByKey", "The driver interface halShmemInfoGet does not exist.");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1016, "MemCopySync", "Other threads of the current context are in the capture state");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1017, "rtMemCpy", "size", "size is not 0");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1018, "aclrtSetLabel", "Before setting the label using aclrtSetLabel, you need to call aclrtCreateLabelList to create a label list");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1019, "Adding task to stream", "stream task public buffer is full");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1020, "rtGetSocVersion", "memcpy_s", "1", "count is greater than dest_max", "src=0x1, dest=0x2, dest_max=10, count=11.");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1021, "semaphore", "aclrtCreateStream");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE1022, "rtUbDbSend", "nullptr and nullptr", "pbase and psize", "Parameters pbase and psize cannot both be nullptr");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::EE2002, "1, 2, 2", "SetVisible", "not repeat");
    RT_LOG_OUTER_MSG_IMPL(ErrorCode::WE0001, "set the saturation mode", "only the Inf/NaN mode can be set and the saturation mode");
}

TEST_F(RtErrorCodeTest, CheckErrCodeParams)
{
    auto names = GetParamNames(ErrorCode::EE1001);
    EXPECT_EQ(names, (std::vector<std::string>{"extend_info"}));
    names = GetParamNames(ErrorCode::EE1002);
    EXPECT_EQ(names, (std::vector<std::string>{"extend_info"}));
    names = GetParamNames(ErrorCode::EE1003);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "value", "param", "expect"}));
    names = GetParamNames(ErrorCode::EE1004);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "param"}));
    names = GetParamNames(ErrorCode::EE1005);
    EXPECT_EQ(names, (std::vector<std::string>{"func"}));
    names = GetParamNames(ErrorCode::EE1006);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "type", "reason"}));
    names = GetParamNames(ErrorCode::EE1007);
    EXPECT_EQ(names, (std::vector<std::string>{"id", "reason"}));
    names = GetParamNames(ErrorCode::EE1009);
    EXPECT_EQ(names, (std::vector<std::string>{"id", "reason"}));
    names = GetParamNames(ErrorCode::EE1010);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "object", "extend_info"}));
    names = GetParamNames(ErrorCode::EE1011);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "value", "param", "reason"}));
}

TEST_F(RtErrorCodeTest, CheckErrCodeParams2)
{
    auto names = GetParamNames(ErrorCode::EE1012);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "value", "param", "reason"}));
    names = GetParamNames(ErrorCode::EE1013);
    EXPECT_EQ(names, (std::vector<std::string>{"buf_size"}));
    names = GetParamNames(ErrorCode::EE1014);
    EXPECT_EQ(names, (std::vector<std::string>{"reason"}));
    names = GetParamNames(ErrorCode::EE1015);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "reason"}));
    names = GetParamNames(ErrorCode::EE1016);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "reason"}));
    names = GetParamNames(ErrorCode::EE1017);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "param", "reason"}));
    names = GetParamNames(ErrorCode::EE1018);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "reason"}));
    names = GetParamNames(ErrorCode::EE1019);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "reason"}));
    names = GetParamNames(ErrorCode::EE1020);
    EXPECT_EQ(names, (std::vector<std::string>{"func1", "func2", "ret_code", "reason", "extend_info"}));
    names = GetParamNames(ErrorCode::EE1021);
    EXPECT_EQ(names, (std::vector<std::string>{"resource_type", "api"}));
    names = GetParamNames(ErrorCode::EE1022);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "values", "params", "reason"}));
    names = GetParamNames(ErrorCode::EE2002);
    EXPECT_EQ(names, (std::vector<std::string>{"value", "env", "expect"}));
    names = GetParamNames(ErrorCode::EE_NO_ERROR);
    EXPECT_EQ(names, (std::vector<std::string>{}));
    names = GetParamNames(ErrorCode::WE0001);
    EXPECT_EQ(names, (std::vector<std::string>{"function", "type"}));
    names = GetParamNames(ErrorCode::EE1012);
    EXPECT_EQ(names, (std::vector<std::string>{"func", "value", "param", "reason"}));
}

TEST_F(RtErrorCodeTest, ErrorCodeTableParamCountMatchesMessageFormat)
{
    struct CodeInfo {
        ErrorCode code;
        size_t expectedParamCount;
    };
    std::vector<CodeInfo> allCodes = {
        {ErrorCode::EE1001, 1}, {ErrorCode::EE1002, 1}, {ErrorCode::EE1003, 4},
        {ErrorCode::EE1004, 2}, {ErrorCode::EE1005, 1}, {ErrorCode::EE1006, 3},
        {ErrorCode::EE1007, 2}, {ErrorCode::EE1009, 2},
        {ErrorCode::EE1010, 3}, {ErrorCode::EE1011, 4}, {ErrorCode::EE1012, 4},
        {ErrorCode::EE1013, 1}, {ErrorCode::EE1014, 1}, {ErrorCode::EE1015, 2},
        {ErrorCode::EE1016, 2}, {ErrorCode::EE1017, 3}, {ErrorCode::EE1018, 2},
        {ErrorCode::EE1019, 2}, {ErrorCode::EE1020, 5}, {ErrorCode::EE1021, 2},
        {ErrorCode::EE1022, 4}, {ErrorCode::EE2002, 3}, {ErrorCode::WE0001, 2},
    };
    for (const auto& info : allCodes) {
        auto names = GetParamNames(info.code);
        EXPECT_EQ(names.size(), info.expectedParamCount)
            << "Param count mismatch for code " << static_cast<int>(info.code);
    }
}

// DispatchErrMsg: 所有参数数量 + DLOG_ERROR 路径
TEST_F(RtErrorCodeTest, DispatchErrMsgAllParamSizesErrorLevel)
{
    // 1 参数
    std::vector<std::string> v1 = {"x"};
    PrintErrMsgToLog(ErrorCode::EE1001, "f", 1, "g", v1);
    // 2 参数
    std::vector<std::string> v2 = {"x", "y", "z"};
    PrintErrMsgToLog(ErrorCode::EE1006, "f", 1, "g", v2);
    // 3 参数
    std::vector<std::string> v3 = {"x", "y", "z"};
    PrintErrMsgToLog(ErrorCode::EE1017, "f", 1, "g", v3);
    // 4 参数
    std::vector<std::string> v4 = {"x", "y", "z", "w"};
    PrintErrMsgToLog(ErrorCode::EE1011, "f", 1, "g", v4);
    // 5 参数
    std::vector<std::string> v5 = {"a", "b", "c", "d", "e"};
    PrintErrMsgToLog(ErrorCode::EE1020, "f", 1, "g", v5);
}

// DispatchErrMsg: DLOG_WARN 路径（仅 WE0001）
TEST_F(RtErrorCodeTest, DispatchErrMsgDlogWarnPath)
{
    std::vector<std::string> v = {"functionName", "reasonText"};
    PrintErrMsgToLog(ErrorCode::WE0001, "f", 1, "g", v);
}

// DispatchErrMsg: 参数个数不匹配 → 走 mismatch 分支
TEST_F(RtErrorCodeTest, DispatchErrMsgParamCountMismatch)
{
    // EE1003 需要 4 个参数，只给 3 个
    std::vector<std::string> tooFew = {"rtMemCpy", "0", "size"};
    PrintErrMsgToLog(ErrorCode::EE1003, "f", 1, "g", tooFew);
    // EE1005 需要 1 个参数，给 5 个
    std::vector<std::string> tooMany = {"a", "b", "c", "d", "e"};
    PrintErrMsgToLog(ErrorCode::EE1005, "f", 1, "g", tooMany);
}

// DispatchErrMsg: 未知错误码 → switch default 打印 "Unknown error code"
TEST_F(RtErrorCodeTest, DispatchErrMsgUnknownCodeDefaultPath)
{
    std::vector<std::string> v;
    PrintErrMsgToLog(ErrorCode::EE_NO_ERROR, "f", 1, "g", v);
}

// X-Macro 表自动校验：格式串 % 个数 == 参数个数
// 新增错误码后自动生效，格式写错直接报错
namespace {
static int CountFormatSpec(const char* msg)
{
    int count = 0;
    for (const char* p = msg; *p != '\0'; p++) {
        if (*p == '%' && *(p + 1) != '\0' && *(p + 1) != '%') {
            count++;
        }
    }
    return count;
}
}

#define RT_UNPAREN(...) __VA_ARGS__
#define RT_COUNT(...)   RT_COUNT_IMPL(__VA_ARGS__, 6, 5, 4, 3, 2, 1, 0)
#define RT_COUNT_IMPL(_1, _2, _3, _4, _5, _6, N, ...) N

TEST_F(RtErrorCodeTest, XMacroTableFormatSelfCheck)
{
#undef RT_CHECK
#define RT_CHECK(code, name, params, msg, level) \
    {name, msg, RT_COUNT(RT_UNPAREN params)},

    struct Entry {
        const char* name;
        const char* msg;
        int paramCount;
    };
    static const Entry kEntries[] = {
        RUNTIME_ERROR_CODE_TABLE(RT_CHECK)
    };
#undef RT_CHECK

    int total = static_cast<int>(sizeof(kEntries) / sizeof(kEntries[0]));
    for (int i = 0; i < total; i++) {
        int fmtCount = CountFormatSpec(kEntries[i].msg);
        EXPECT_EQ(fmtCount, kEntries[i].paramCount)
            << "[" << kEntries[i].name << "] message has " << fmtCount
            << " format specifiers but param list has " << kEntries[i].paramCount
            << " entries";
    }
}
#undef RT_COUNT_IMPL
#undef RT_COUNT
#undef RT_UNPAREN

// 覆盖 runtime_handle_guard.cc：magic 不匹配分支，经 ValidateInnerObject
// 触发 BuildInvalidHandleReason 与 GetResourceNameByMagic，并上报 EE1017
TEST_F(RtErrorCodeTest, ValidateInnerObjectMagicMismatch)
{
    rtInnerObject inner;
    int dummyObj = 0;
    InitializeInnerObject(inner, RT_STREAM_MAGIC, &dummyObj);

    void *out = nullptr;
    // 期望 EVENT，实际是 STREAM -> magic 不匹配 -> 上报 EE1017
    EXPECT_EQ(GetValidatedObjectImpl(&inner, RT_EVENT_MAGIC, out), RT_ERROR_INVALID_HANDLE);
    EXPECT_EQ(out, nullptr);
}

// 覆盖 ValidateInnerObject 的“已销毁”分支（actualMagic == 0）
TEST_F(RtErrorCodeTest, ValidateInnerObjectDestroyed)
{
    rtInnerObject inner;
    int dummyObj = 0;
    InitializeInnerObject(inner, RT_STREAM_MAGIC, &dummyObj);
    ResetInnerObject(inner); // magic 置 0 -> 已销毁

    void *out = nullptr;
    EXPECT_EQ(GetValidatedObjectImpl(&inner, RT_STREAM_MAGIC, out), RT_ERROR_INVALID_HANDLE);
}

// 覆盖 GetResourceNameByMagic 的所有资源类型分支 + unknown 默认分支
// 每次都构造与 expected 不同的实际 magic，确保走进 BuildInvalidHandleReason
TEST_F(RtErrorCodeTest, ValidateInnerObjectAllResourceNames)
{
    const uint64_t expectedMagics[] = {
        RT_MODEL_MAGIC, RT_LABEL_MAGIC, RT_STREAM_MAGIC, RT_EVENT_MAGIC,
        RT_NOTIFY_MAGIC, RT_CNTNOTIFY_MAGIC, 0xDEADBEEFull /* unknown */,
    };
    for (uint64_t expected : expectedMagics) {
        rtInnerObject inner;
        int dummyObj = 0;
        InitializeInnerObject(inner, expected + 1U, &dummyObj); // 实际 magic 必不匹配
        void *out = nullptr;
        EXPECT_EQ(GetValidatedObjectImpl(&inner, expected, out), RT_ERROR_INVALID_HANDLE);
    }
}

// 覆盖 GetValidatedObjectImpl 的成功路径与空句柄契约
TEST_F(RtErrorCodeTest, ValidateInnerObjectSuccessAndNull)
{
    rtInnerObject inner;
    int dummyObj = 0;
    InitializeInnerObject(inner, RT_STREAM_MAGIC, &dummyObj);

    void *out = nullptr;
    EXPECT_EQ(GetValidatedObjectImpl(&inner, RT_STREAM_MAGIC, out), RT_ERROR_NONE);
    EXPECT_EQ(out, &dummyObj);

    // 空句柄 -> 直接返回 NONE 且出参置空
    void *outNull = reinterpret_cast<void *>(0x1);
    EXPECT_EQ(GetValidatedObjectImpl(nullptr, RT_STREAM_MAGIC, outNull), RT_ERROR_NONE);
    EXPECT_EQ(outNull, nullptr);
}
