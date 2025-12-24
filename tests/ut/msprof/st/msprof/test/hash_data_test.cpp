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
#include "securec.h"
#include <sys/wait.h>
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libgen.h>
#include <sys/stat.h>
#include <sys/utsname.h>
#include <dirent.h>
#include <sys/time.h>
#include <sys/vfs.h>
#include <locale>
#include <errno.h>
#include <algorithm>
#include <fstream>
//mac
#include <net/if.h>
#include <sys/prctl.h>
#define protected public
#define private public
#include "message/message.h"
#include "thread/thread_pool.h"
#include "config/config_manager.h"
#include "param_validation.h"
#include "transport/hash_data.h"
#include "uploader_mgr.h"

using namespace analysis::dvvp::common::thread;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;


class COMMON_HASH_DATA_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
        HashData::instance()->Uninit();
    }
private:
};

TEST_F(COMMON_HASH_DATA_TEST, Init) {
    int32_t ret  = HashData::instance()->Init();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    ret  = HashData::instance()->Init();
    EXPECT_EQ(PROFILING_SUCCESS, ret);

    auto iter = HashData::instance()->hashMapMutex_.find("DATA_PREPROCESS");
    EXPECT_NE(HashData::instance()->hashMapMutex_.end(), iter);
    HashData::instance()->Uninit();
}

TEST_F(COMMON_HASH_DATA_TEST, Uninit) {
    int32_t ret  = HashData::instance()->Uninit();
    EXPECT_EQ(PROFILING_SUCCESS, ret);
}

TEST_F(COMMON_HASH_DATA_TEST, IsInit) {
    HashData::instance()->Init();
    EXPECT_EQ(true, HashData::instance()->IsInit());
    HashData::instance()->Uninit();
    EXPECT_EQ(false, HashData::instance()->IsInit());    
}

TEST_F(COMMON_HASH_DATA_TEST, GenHashId) {
    HashData::instance()->Init();

    EXPECT_EQ(0, HashData::instance()->GenHashId("xxx", nullptr, 0));

    const char *data = "ABCDEFGHIJK";
    uint64_t hashId = 4667050837169873462;
    EXPECT_EQ(hashId, HashData::instance()->GenHashId("DATA_PREPROCESS", data, strlen(data)));

    hashId = HashData::instance()->GenHashId("DATA_PREPROCESS", data, strlen(data));
    EXPECT_EQ(4667050837169873462, hashId);
    std::string empty;
    hashId = HashData::instance()->GenHashId(empty);
    EXPECT_EQ(std::numeric_limits<uint64_t>::max(), hashId);
    HashData::instance()->Uninit();
}

TEST_F(COMMON_HASH_DATA_TEST, SaveHashData) {
    GlobalMockObject::verify();
    MOCKER_CPP(&analysis::dvvp::transport::UploaderMgr::UploadData,
        int(analysis::dvvp::transport::UploaderMgr::*)(const std::string &, const void *, uint32_t))
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    
    HashData::instance()->SaveHashData(0);
    HashData::instance()->Init();
    const char *data = "ABCDEFGHIJK";
    HashData::instance()->GenHashId("DATA_PREPROCESS", data, strlen(data));
    HashData::instance()->GenHashId("AclModule", data, strlen(data));
    HashData::instance()->SaveHashData(0);
    HashData::instance()->SaveHashData(64);
    HashData::instance()->SaveHashData(-1);
    EXPECT_EQ(HashData::instance()->Uninit(), PROFILING_SUCCESS);
}