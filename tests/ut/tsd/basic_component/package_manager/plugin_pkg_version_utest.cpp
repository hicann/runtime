/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include "package_manager_test_common.h"

using namespace tsd;
using namespace tsdtest;
using namespace std;

class PluginPkgVersionComponentTest : public PackageManagerComponentTest {};

namespace {
class TempIniFile {
public:
    explicit TempIniFile(const std::string& content)
    {
        char path[] = "/tmp/plugin_pkg_ut_XXXXXX";
        const int fd = mkstemp(path);
        if (fd < 0) {
            return;
        }
        path_ = path;
        if (!content.empty()) {
            (void)write(fd, content.data(), content.size());
        }
        (void)close(fd);
    }
    ~TempIniFile()
    {
        if (!path_.empty()) {
            (void)remove(path_.c_str());
        }
    }
    const std::string& Path() const { return path_; }
    bool Remove() { return !path_.empty() && (remove(path_.c_str()) == 0); }

private:
    std::string path_;
};
} // namespace

TEST_F(PluginPkgVersionComponentTest, CompareVersion_NumericSegments_ReturnExpectedOrdering)
{
    using tsd::PluginPkgVersionUtil;
    EXPECT_EQ(PluginPkgVersionUtil::CompareVersion("8.5.0", "8.5.0"), 0);
    EXPECT_LT(PluginPkgVersionUtil::CompareVersion("8.5.0", "8.5.1"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareVersion("8.10.0", "8.5.0"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareVersion("9.0.0", "8.99.99"), 0);
    // 长度不同：8.5 vs 8.5.0 等价
    EXPECT_EQ(PluginPkgVersionUtil::CompareVersion("8.5", "8.5.0"), 0);
}

TEST_F(PluginPkgVersionComponentTest, CompareVersion_NonNumericSegments_UsesLexicalOrdering)
{
    using tsd::PluginPkgVersionUtil;
    // 非纯数字段降级为字典序
    EXPECT_LT(PluginPkgVersionUtil::CompareVersion("8.a", "8.b"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareVersion("8.b", "8.a"), 0);
    EXPECT_EQ(PluginPkgVersionUtil::CompareVersion("8.a", "8.a"), 0);
}

TEST_F(PluginPkgVersionComponentTest, CompareTimestamp_DifferentValues_ReturnExpectedOrdering)
{
    using tsd::PluginPkgVersionUtil;
    EXPECT_EQ(PluginPkgVersionUtil::CompareTimestamp("20260114_115609804", "20260114_115609804"), 0);
    EXPECT_LT(PluginPkgVersionUtil::CompareTimestamp("20260114_115609804", "20260115_115609804"), 0);
    EXPECT_GT(PluginPkgVersionUtil::CompareTimestamp("20260114_115609805", "20260114_115609804"), 0);
}

TEST_F(PluginPkgVersionComponentTest, Compare_VersionThenTimestamp_ReturnExpectedOrdering)
{
    using tsd::PluginPkgVersionUtil;
    tsd::PluginPkgVersion a{"8.5.0", "20260114_115609804"};
    tsd::PluginPkgVersion b{"8.5.0", "20260114_115609804"};
    EXPECT_EQ(PluginPkgVersionUtil::Compare(a, b), 0);

    tsd::PluginPkgVersion newerV{"8.5.1", "20260101_000000000"};
    EXPECT_GT(PluginPkgVersionUtil::Compare(newerV, a), 0);
    EXPECT_LT(PluginPkgVersionUtil::Compare(a, newerV), 0);

    tsd::PluginPkgVersion newerTs{"8.5.0", "20270101_000000000"};
    EXPECT_GT(PluginPkgVersionUtil::Compare(newerTs, a), 0);
}

TEST_F(PluginPkgVersionComponentTest, ParseLine_ValidAndInvalidLines_ReturnParsedFieldsOrFalse)
{
    using tsd::PluginPkgVersionUtil;
    std::string k, v;
    EXPECT_TRUE(PluginPkgVersionUtil::ParseLine("version=8.5.0", k, v));
    EXPECT_EQ(k, "version");
    EXPECT_EQ(v, "8.5.0");
    EXPECT_TRUE(PluginPkgVersionUtil::ParseLine("  timestamp = 20260114_115609804  ", k, v));
    EXPECT_EQ(k, "timestamp");
    EXPECT_EQ(v, "20260114_115609804");
    // 注释 / 空行 / 非法行
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("# comment", k, v));
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("", k, v));
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("no_equal_sign", k, v));
    EXPECT_FALSE(PluginPkgVersionUtil::ParseLine("=onlyvalue", k, v));
}

TEST_F(PluginPkgVersionComponentTest, ParseIniFile_VersionAndTimestampPresent_ReturnsParsedValues)
{
    using tsd::PluginPkgVersionUtil;
    TempIniFile file("# header comment\nversion=8.5.0\ntimestamp=20260114_115609804\n");
    ASSERT_FALSE(file.Path().empty());
    tsd::PluginPkgVersion info;
    EXPECT_TRUE(PluginPkgVersionUtil::ParseIniFile(file.Path(), info));
    EXPECT_EQ(info.version, "8.5.0");
    EXPECT_EQ(info.timestamp, "20260114_115609804");
    EXPECT_FALSE(info.Empty());
}

TEST_F(PluginPkgVersionComponentTest, ParseIniFile_VersionMissing_ReturnsFalse)
{
    using tsd::PluginPkgVersionUtil;
    TempIniFile file("timestamp=20260114_115609804\n");
    ASSERT_FALSE(file.Path().empty());
    tsd::PluginPkgVersion info;
    EXPECT_FALSE(PluginPkgVersionUtil::ParseIniFile(file.Path(), info));
}

TEST_F(PluginPkgVersionComponentTest, ParseIniFile_FileMissing_ReturnsFalse)
{
    using tsd::PluginPkgVersionUtil;
    TempIniFile file("");
    ASSERT_FALSE(file.Path().empty());
    ASSERT_TRUE(file.Remove());
    tsd::PluginPkgVersion info;
    EXPECT_FALSE(PluginPkgVersionUtil::ParseIniFile(file.Path(), info));
}

TEST_F(PluginPkgVersionComponentTest, ParseIniFile_MixedCaseKeys_ReturnsParsedValues)
{
    using tsd::PluginPkgVersionUtil;
    // Version / TIMESTAMP / 混合大小写均应被识别
    TempIniFile file("Version=8.5.0\nTIMESTAMP=20260114_115609804\n");
    ASSERT_FALSE(file.Path().empty());
    tsd::PluginPkgVersion info;
    EXPECT_TRUE(PluginPkgVersionUtil::ParseIniFile(file.Path(), info));
    EXPECT_EQ(info.version, "8.5.0");
    EXPECT_EQ(info.timestamp, "20260114_115609804");
}
