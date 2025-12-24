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
#include "file_slice.h"
#include "file_ageing.h"
#include "message/prof_params.h"
#include "thread/thread_pool.h"
#include "config_manager.h"
#include "param_validation.h"

using namespace analysis::dvvp::common::thread;
using namespace analysis::dvvp::common::error;
using namespace analysis::dvvp::transport;

#define BYTE_TO_MB(byte)        (byte >> 20)
#define MB_TO_BYTE(mb)          (mb << 20)
#define STORAGE_LIMIT_DOWN_THD  200
#define STORAGE_RESERVED_VOLUME (MB_TO_BYTE(STORAGE_LIMIT_DOWN_THD / 10))

class COMMON_FILE_AGEING_TEST: public testing::Test {
protected:
    virtual void SetUp() {
    }
    virtual void TearDown() {
        GlobalMockObject::verify();
    }
private:
};

TEST_F(COMMON_FILE_AGEING_TEST, Init) {
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::MINI_TYPE))
        .then(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    MOCKER(analysis::dvvp::common::utils::Utils::GetVolumeSize)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS))
        .then(returnValue(PROFILING_FAILED))
        .then(returnValue(PROFILING_SUCCESS));

    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";

    FileAgeing ageingObj(storageDir, storageLimit);
    PROFILING_SUCCESS, ageingObj.Init();

    FileAgeing ageingObj0(storageDir, storageLimit);
    PROFILING_FAILED, ageingObj.Init();

    FileAgeing ageingObj1(storageDir, storageLimit);
    EXPECT_EQ(PROFILING_SUCCESS, ageingObj1.Init());

    storageLimit = "0MB";
    unsigned long long availVolume = 20856832; // 19MB
    FileAgeing ageingObj2(storageDir, storageLimit);
    EXPECT_EQ(PROFILING_FAILED, ageingObj2.Init());
}

TEST_F(COMMON_FILE_AGEING_TEST, Init2) {
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";

    FileAgeing ageingObj2(storageDir, storageLimit);
    EXPECT_EQ(PROFILING_SUCCESS, ageingObj2.Init());
    //
    MSPROF_LOGD("XXXXXXXXXXXX 11111");
    ageingObj2.AppendAgeingFile("111_hash_dic_222", "111_hash_dic_222", 1000, 1000);
}

TEST_F(COMMON_FILE_AGEING_TEST, GetStorageLimit) {
    std::string storageDir = "/tmp";

    FileAgeing ageingObj_1(storageDir, "");
    uint64_t ret = ageingObj_1.GetStorageLimit();
    EXPECT_EQ(0, ret);

    FileAgeing ageingObj_2(storageDir, "350MB");
    ret = ageingObj_2.GetStorageLimit();
    EXPECT_EQ(175*1024*1024, ret);
}

TEST_F(COMMON_FILE_AGEING_TEST, IsNeedAgeingFile) {
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));
    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";
    FileAgeing ageingObj(storageDir, storageLimit);
    bool ret = ageingObj.IsNeedAgeingFile();
    EXPECT_EQ(false, ret); // UINT32_MAX

    ageingObj.inited_ = true;
    ageingObj.storagedFileSize_ = 1001;
    ageingObj.storageVolumeUpThd_ = 1000;
    ret = ageingObj.IsNeedAgeingFile();
    EXPECT_EQ(true, ret); // UINT32_MAX

    MOCKER(analysis::dvvp::common::utils::Utils::GetVolumeSize)
        .stubs()
        .will(returnValue(PROFILING_SUCCESS));
    ageingObj.storageVolumeUpThd_ = 1002;
    ageingObj.storageVolumeDownThd_ = UINT64_MAX;
    ret = ageingObj.IsNeedAgeingFile();
    EXPECT_EQ(true, ret); // UINT32_MAX
}

TEST_F(COMMON_FILE_AGEING_TEST, AppendAgeingFile) {
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(1000));    
    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MBxxx";
    // empty
    FileAgeing ageingObj(storageDir, storageLimit);
    ageingObj.inited_ = true;
    // ageingObj.Init();
    ageingObj.AppendAgeingFile("", "doneFilePath", 1000, 1000);
    EXPECT_EQ(0, ageingObj.ageingFileList_.size());
    // IsCtrlFile
    ageingObj.AppendAgeingFile("/tmp/fileName", "doneFilePath", 1000, 1000);
    EXPECT_EQ(0, ageingObj.ageingFileList_.size());    
    ageingObj.AppendAgeingFile("/tmp/data/fileName-hash_dic", "/tmp/data/doneFilePath-hash_dic", 1000, 1000);
    EXPECT_EQ(0, ageingObj.ageingFileList_.size());    
    // IsNoAgeingFile
    ageingObj.AppendAgeingFile("/tmp/data/fileName", "/tmp/data/doneFilePath", 1000, 1000);
    EXPECT_EQ(0, ageingObj.ageingFileList_.size());        
    // CutSliceNum
    ageingObj.AppendAgeingFile("/tmp/data/fileName", "/tmp/data/doneFilePath", 1000, 1000);
    EXPECT_EQ(0, ageingObj.ageingFileList_.size());
    // normal , no need paired
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    EXPECT_EQ(1, ageingObj.ageingFileList_.size());  
    EXPECT_EQ(1, ageingObj.fileCount_.size()); 

    // append paired : hwts.data
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    EXPECT_EQ(4, ageingObj.ageingFileList_.size());
    EXPECT_EQ(2, ageingObj.fileCount_.size());
    EXPECT_EQ(ageingObj.ageingFileList_.back().fileName, "hwts.data.slice1");
    EXPECT_EQ(ageingObj.ageingFileList_.back().isPaired, false);

    // append paired : aicore.data
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice5", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(7, ageingObj.ageingFileList_.size());
    EXPECT_EQ(3, ageingObj.fileCount_.size());
    EXPECT_EQ(ageingObj.ageingFileList_.back().fileName, "fileName.slice5");
    auto iter = ageingObj.ageingFileList_.rbegin();
    iter++;
    iter++;
    EXPECT_EQ(iter->fileName, "aicore.data.slice1");
    EXPECT_EQ(iter->isPaired, true);
    iter++;
    EXPECT_EQ(iter->fileName, "hwts.data.slice1");
    EXPECT_EQ(iter->isPaired, true);

    // append paired : aicore.data, second
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(8, ageingObj.ageingFileList_.size());
    EXPECT_EQ(3, ageingObj.fileCount_.size());    
    EXPECT_EQ(ageingObj.ageingFileList_.back().fileName, "aicore.data.slice2");
    EXPECT_EQ(ageingObj.ageingFileList_.back().isPaired, false);
}

TEST_F(COMMON_FILE_AGEING_TEST, AppendAgeingFile2) {
    MOCKER_CPP(&Analysis::Dvvp::Common::Config::ConfigManager::GetPlatformType)
        .stubs()
        .will(returnValue(Analysis::Dvvp::Common::Config::PlatformType::DC_TYPE));      
    std::string storageDir = "/tmp";
    std::string storageLimit = "4294967296MB";
    uint64_t fileSize = (uint64_t)1 << 48;
    FileAgeing ageingObj(storageDir, storageLimit);
    ageingObj.Init();

    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice1", "/tmp/data/aicore.data.slice1.done", fileSize, fileSize);
    EXPECT_EQ(1, ageingObj.ageingFileList_.size());
    EXPECT_EQ(fileSize * 2, ageingObj.storagedFileSize_);

    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice2", "/tmp/data/aicore.data.slice1.done", fileSize, fileSize);
    EXPECT_EQ(2, ageingObj.ageingFileList_.size());
    EXPECT_EQ(fileSize * 4, ageingObj.storagedFileSize_);    

    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice3", "/tmp/data/aicore.data.slice1.done", fileSize, fileSize);
    EXPECT_EQ(2, ageingObj.ageingFileList_.size());
    EXPECT_EQ(fileSize * 4, ageingObj.storagedFileSize_);   
}

TEST_F(COMMON_FILE_AGEING_TEST, PairInsertList) 
{
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(1000));
 
    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";
    FileAgeing ageingObj(storageDir, storageLimit);
    ageingObj.inited_ = true;

    // ageingObj.Init();
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice0", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(ageingObj.ageingFileList_.back().fileName, "hwts.data.slice4");
    EXPECT_EQ(ageingObj.ageingFileList_.back().isPaired, false);
}

TEST_F(COMMON_FILE_AGEING_TEST, IsLastFile) 
{
    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";
    std::string fileName = "name1.xxx.slice1";
    FileAgeing ageingObj(storageDir, storageLimit);
    EXPECT_EQ(true, ageingObj.IsLastFile("name1.xxx"));
    ageingObj.fileCount_["name1.xxx"] = 1;
    EXPECT_EQ(true, ageingObj.IsLastFile("name1.xxx"));
    ageingObj.fileCount_["name1.xxx"] = 2;
    EXPECT_EQ(false, ageingObj.IsLastFile("name1.xxx"));
}

TEST_F(COMMON_FILE_AGEING_TEST, RemoveAgeingFile) 
{
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(1000));

    MOCKER(remove)
        .stubs()
        .will(returnValue(0));

    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";
    FileAgeing ageingObj(storageDir, storageLimit);
    ageingObj.inited_ = true;

    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice0", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.PrintAgeingFile();
    ageingObj.overThdSize_ = 2000;
    ageingObj.RemoveAgeingFile();
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(10, ageingObj.ageingFileList_.size());

    ageingObj.overThdSize_ = 3000;
    ageingObj.RemoveAgeingFile();
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(8, ageingObj.ageingFileList_.size());
    auto iter = ageingObj.ageingFileList_.begin();
    iter->isValid = false;
    ageingObj.RemoveAgeingFile();
}

TEST_F(COMMON_FILE_AGEING_TEST, RemoveAgeingFile2) 
{
    GlobalMockObject::verify();
    MOCKER(analysis::dvvp::common::utils::Utils::GetFileSize)
        .stubs()
        .will(returnValue(1000));

    MOCKER(remove)
        .stubs()
        .will(returnValue(0));

    std::string storageDir = "/tmp";
    std::string storageLimit = "1000MB";
    FileAgeing ageingObj(storageDir, storageLimit);
    ageingObj.inited_ = true;
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice5", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice6", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice7", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/hwts.data.slice8", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice5", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice6", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice7", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/fileName.slice8", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.PrintAgeingFile();
    ageingObj.overThdSize_ = 14000;
    ageingObj.RemoveAgeingFile();
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(16, ageingObj.ageingFileList_.size());
    EXPECT_EQ(false, ageingObj.ageingFileList_.begin()->isValid);

    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice1", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice2", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice3", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice4", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice5", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice6", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice7", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice8", "/tmp/data/doneFilePath", 1000, 1000);
    ageingObj.AppendAgeingFile("/tmp/data/aicore.data.slice9", "/tmp/data/doneFilePath", 1000, 1000);
    EXPECT_EQ(18, ageingObj.ageingFileList_.size());
    ageingObj.PrintAgeingFile();
    ageingObj.overThdSize_ = 10000;
    ageingObj.RemoveAgeingFile();
    ageingObj.PrintAgeingFile();
    EXPECT_EQ(13, ageingObj.ageingFileList_.size());
    EXPECT_EQ(true, ageingObj.ageingFileList_.begin()->isValid);
}