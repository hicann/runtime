/**
 * Copyright (c) 2026 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "common_util_func.h"
#include <iostream>
#include <fstream>
namespace tsd {

bool WriteTmpFile(const std::string &filePath, const std::string &fileName)
{
    // ut工程只运行在tmp目录下写小文件，用完之后要及时删除
    const std::string dstFile = "/tmp/" + filePath + "/" + fileName;
    std::ofstream outFile(dstFile);
    if(!outFile) {
        std::cout<<"Can not creat file "<<dstFile<<std::endl;
        return false;
    }
    outFile << "this is tmp file"<<std::endl;
    outFile.close();
    return true;
}
}