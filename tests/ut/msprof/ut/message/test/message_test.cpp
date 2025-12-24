/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <iostream>
#include <stdexcept>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "message/prof_params.h"

using namespace analysis::dvvp::message;

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_STATUSINFO_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, ToObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);

    NanoJson::Json object;
    status.ToObject(object);

    EXPECT_NE(std::string::npos, object.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, FromObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);

    NanoJson::Json object;
    status.ToObject(object);

    StatusInfo status1;
    status1.FromObject(object);

    EXPECT_EQ(status.dev_id, status1.dev_id);
    EXPECT_EQ(status.status, status1.status);
}

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, ToString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);

    EXPECT_NE(std::string::npos, status.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, status.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, status.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUSINFO_TEST, FromString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status("1", ERR, info);
    StatusInfo status1;
    EXPECT_FALSE(status1.FromString("{"));
    EXPECT_FALSE(status1.FromString(""));
    EXPECT_TRUE(status1.FromString(status.ToString()));
}

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_STATUS_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, ToObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);

    NanoJson::Json object;
    status.ToObject(object);
    std::string str = "{\"info\":[{\"info\":\"this is test\",\"status\":1,\"dev_id\":\"1\"}],\"status\":1}";

    EXPECT_NE(std::string::npos, object.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, FromObject) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);

    NanoJson::Json object;
    status.ToObject(object);

    Status status1;
    status1.FromObject(object);

    EXPECT_EQ(status.status, status1.status);
}

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, ToString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);
    std::string str = "{\"info\":[{\"info\":\"this is test\",\"status\":1,\"dev_id\":\"1\"}],\"status\":1}";
    EXPECT_NE(std::string::npos, status.ToString().find("\"info\":\"this is test\""));
    EXPECT_NE(std::string::npos, status.ToString().find("\"status\":1"));
    EXPECT_NE(std::string::npos, status.ToString().find("\"dev_id\":\"1\""));
}

TEST_F(MESSAGE_MESSAGE_STATUS_TEST, FromString) {
    GlobalMockObject::verify();

    std::string info = "this is test";
    StatusInfo status_info("1", ERR, info);

    Status status;
    status.AddStatusInfo(status_info);

    Status status1;
    EXPECT_FALSE(status1.FromString("{"));
    EXPECT_FALSE(status1.FromString(""));
    EXPECT_TRUE(status1.FromString(status.ToString()));
}

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_PROFILEPARAMS_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_PROFILEPARAMS_TEST, FromString) {
    GlobalMockObject::verify();

    ProfileParams params;

    ProfileParams params1;
    EXPECT_FALSE(params1.FromString("{"));
    EXPECT_FALSE(params1.FromString(""));
    EXPECT_TRUE(params1.FromString(params.ToString()));
}

///////////////////////////////////////////////////////////////////
class MESSAGE_MESSAGE_JOBCONTEXT_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
    }
};

TEST_F(MESSAGE_MESSAGE_JOBCONTEXT_TEST, ToObject) {
    GlobalMockObject::verify();

    JobContext ctx;

    NanoJson::Json object;
    ctx.ToObject(object);

    EXPECT_NE(std::string::npos, object.ToString().find("\"dataModule\":0"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"chunkEndTime\":0"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"stream_enabled\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"chunkStartTime\":0"));
    EXPECT_NE(std::string::npos, object.ToString().find("\"dev_id\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"tag\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"module\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"job_id\":\"\""));
    EXPECT_NE(std::string::npos, object.ToString().find("\"result_dir\":\"\""));
}

TEST_F(MESSAGE_MESSAGE_JOBCONTEXT_TEST, ToString) {
    GlobalMockObject::verify();

    JobContext ctx;

    EXPECT_NE(std::string::npos, ctx.ToString().find("\"dataModule\":0"));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"chunkEndTime\":0"));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"stream_enabled\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"chunkStartTime\":0"));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"dev_id\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"tag\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"module\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"job_id\":\"\""));
    EXPECT_NE(std::string::npos, ctx.ToString().find("\"result_dir\":\"\""));
}

TEST_F(MESSAGE_MESSAGE_JOBCONTEXT_TEST, FromString) {
    GlobalMockObject::verify();

    JobContext ctx;

    JobContext ctx1;
    EXPECT_FALSE(ctx1.FromString("{"));
    EXPECT_FALSE(ctx1.FromString(""));
    EXPECT_TRUE(ctx1.FromString(ctx.ToString()));
}
