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
#define private public
#include "config.h"
#include "runtime.hpp"
#include "kernel.h"
#include "rt_error_codes.h"
#include "api_impl.hpp"
#include "dev.h"
#include "binary_loader.hpp"
#undef private
#include "utils.h"
#include <fstream>
#include <iostream>
#include <string>
#include <sstream>
#include "thread_local_container.hpp"

using namespace testing;
using namespace cce::runtime;

static bool CreateFile(std::string &fileName, std::string content);
static void DeleteFile(std::string &fileName);

class ChipBinaryLoaderTest : public testing::Test
{
protected:
    static void SetUpTestCase()
    {
        Runtime *rtInstance = (Runtime *)Runtime::Instance();
        std::cout<<"BinaryLoaderTest test start start. disbale=%d. "<<rtInstance->GetDisableThread()<<std::endl;

        // Create GatherV3.o binary file 
        std::ifstream binaryTxtFile(binaryTxtFileName);
        if (!binaryTxtFile.is_open()) {
            std::cout << "Failed to open file: " << binaryTxtFileName << std::endl;
            return;
        }
        std::ofstream binaryFile(binaryFileName);
        if (!binaryFile.is_open()) {
            std::cout << "Failed to open file: " << binaryTxtFileName << std::endl;
            binaryTxtFile.close();
            return;
        }

        // read file to buffer
        std::stringstream txtBuffer;
        txtBuffer << binaryTxtFile.rdbuf();
        std::vector<char> charArray;
        std::string temp;

        // convert hex number to char
        while (std::getline(txtBuffer, temp, ',')) {
            if (temp.empty()) {
                continue;
            }
            binaryFile << static_cast<char>(std::stoi(temp, nullptr, 16));
        }
        binaryFile.close();
        binaryTxtFile.close();
    }

    static void TearDownTestCase()
    {
        std::cout<<"BinaryLoaderTest test start end. "<<std::endl;
        DeleteFile(binaryFileName);
    }

    virtual void SetUp()
    {
        (void)rtSetDevice(0);
    }

    virtual void TearDown()
    {
        GlobalMockObject::verify();
        rtDeviceReset(0);
    };

    static bool CreateFile(std::string &fileName, std::string content)
    {
        std::ofstream file(fileName);
        if (!file.is_open()) {
            std::cout << "Failed to open file: " << fileName << std::endl;
            return false;
        }

        if (content.empty()) {
            file.close();
            std::cout << "Create empty file success, file name: " << fileName << std::endl;
            return true;
        }

        // 写入一些内容到文件
        file << content << std::endl;
        std::cout << "Create and write file success, file name: " << fileName << std::endl;
        file.close();
        return true;
    }

    static void DeleteFile(std::string &fileName)
    {
        std::remove(fileName.c_str());
    } 
public:
    static std::string binaryTxtFileName;
    static std::string binaryFileName;
};

std::string ChipBinaryLoaderTest::binaryTxtFileName("llt/ace/npuruntime/runtime/ut/runtime/test/data/GatherV3_9e31943a1a48bf81ddff1fc6379e0be3_high_performance.txt");
std::string ChipBinaryLoaderTest::binaryFileName("llt/ace/npuruntime/runtime/ut/runtime/test/data/GatherV3_9e31943a1a48bf81ddff1fc6379e0be3_high_performance.o");
