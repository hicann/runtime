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
#include <fstream>
#include "gtest/gtest.h"
#include "mockcpp/mockcpp.hpp"
#include "file_interface.h"
#include "file_transport.h"
#include "transport.h"
#include "errno/error_code.h"
#include "osal/osal_mem.h"
#include "utils/utils.h"

class FileManagerUtest: public testing::Test {
protected:
    virtual void SetUp()
    {
    }
    virtual void TearDown()
    {
        GlobalMockObject::verify();
    }
};

ProfFileChunk * CreateCFileChunk(uint8_t deviceId, uint32_t chunkSize, int32_t type)
{
    ProfFileChunk *chunk = (ProfFileChunk *)OsalMalloc(sizeof(ProfFileChunk));
    chunk->deviceId = deviceId;
    chunk->chunkSize = chunkSize;
    chunk->chunkType = type;
    chunk->isLastChunk = false;
    chunk->offset = -1;
    chunk->chunk = (uint8_t*)OsalMalloc(1048576); // 1*1024*1024
    (void)memset_s(chunk->fileName, sizeof(chunk->fileName), 0, sizeof(chunk->fileName));
    (void)sprintf_s(chunk->fileName, sizeof(chunk->fileName), "%s", "nano_stars_profile.data");
    return chunk;
}

TEST_F(FileManagerUtest, FileTransportBase)
{
    using namespace analysis::dvvp::transport;
    using namespace analysis::dvvp::common::error;
    std::string tmp = "/tmp/FileManagerUtest";
    SHARED_PTR_ALIA<ITransport> fileTransport_null;
    SHARED_PTR_ALIA<FILETransport> fileTransport = std::make_shared<FILETransport>(tmp, "200MB");
    (void)fileTransport->Init();
    SHARED_PTR_ALIA<ITransport> fileTransport_it = fileTransport;
    MOCKER_CPP(&FileTransportFactory::CreateFileTransport)
        .stubs()
        .will(returnValue(fileTransport_null))
        .then(returnValue(fileTransport_it));
    // Failed to create transport
    int32_t ret = ProfInitTransport(0, "/tmp/FileManagerUtest", "200MB");
    EXPECT_EQ(ret, PROFILING_FAILED);
    // Success to create transport for device 0
    ret = ProfInitTransport(0, "/tmp/FileManagerUtest", "200MB");
    EXPECT_EQ(ret, PROFILING_SUCCESS);
    // Failed to find transport in file manager, device: 1
    ret = ProfSendBuffer(CreateCFileChunk(1, 1, 3), "/tmp/FileManagerUtest");
    EXPECT_EQ(ret, PROFILING_FAILED);

    MOCKER_CPP(&FileSlice::SaveDataToLocalFiles)
        .stubs()
        .will(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));
    // Failed to send buffer by file manager, device: 0
    ret = ProfSendBuffer(CreateCFileChunk(0, 1, 3), "/tmp/FileManagerUtest");
    EXPECT_EQ(ret, PROFILING_FAILED);

    ret = ProfSendBuffer(CreateCFileChunk(0, 1, 3), "/tmp/FileManagerUtest");
    EXPECT_EQ(ret, PROFILING_SUCCESS);
}