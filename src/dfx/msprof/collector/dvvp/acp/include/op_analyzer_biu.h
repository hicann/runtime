/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef DVVP_ACP_ANALYZE_OP_ANALYZER_BIU_H
#define DVVP_ACP_ANALYZE_OP_ANALYZER_BIU_H

#include "utils/utils.h"
#include "op_analyzer_base.h"

namespace Dvvp {
namespace Acp {
namespace Analyze {

constexpr uint32_t BLOCK_ID_TIMES = 2;
constexpr uint32_t GROUP_TYPE_NUM_MAX = 3;
constexpr uint32_t BIU_DATA_SIZE = 4;
constexpr uint32_t SYSCNT_DATA_TIMES = 4;
constexpr uint32_t GROUP_NUM_MAX = 6;
constexpr uint32_t INSTR_FIXP_TYPE_NUM = 6;
constexpr uint32_t INSTR_TYPE_NUM_MAX = 7;
constexpr uint32_t INSTR_FIXP_CTRL_TYPE_NUM = 10;
constexpr uint32_t EVENT_BIT_WIDTH_NUM = 12;
constexpr uint32_t GROUP_STR_LEN = 14;
constexpr uint32_t US_CONVERT_NS = 1000;
constexpr uint32_t S_CONVERT_US = 1000000;

enum class CtrlType {
    CTRL_SU = 0,
    CTRL_VEC = 1,
    CTRL_CUBE = 2,
    CTRL_MTE1 = 3,
    CTRL_MTE2 = 4,
    CTRL_MTE3 = 5,
    CTRL_FIXP = 10,
    CTRL_START_STAMP = 14,
    CTRL_STATE = 15,
};

struct InstructionMap {
    double timeStart = 0; // "ts" in json file
    bool isBusy = false;
};

struct BiuDataCollection {
    uint32_t initTimes = 0; // each channel need 4 data to combine syscnt
    uint64_t sysCnt = 0;
    double baseTime = 0; // Base time(us) when channel starts to run.
    uint16_t blockId = 0;
    InstructionMap instrMap[INSTR_TYPE_NUM_MAX]; // Status set of 7 instructions, busy or idle
    std::string data; // Collection of character strings in JSON format.
};

class OpAnalyzerBiu : public OpAnalyzerBase {
public:
    OpAnalyzerBiu();
    ~OpAnalyzerBiu(){};

public:
    bool IsBiuPerfData(const std::string &fileName) const;
    void ParseBiuData(SHARED_PTR_ALIA<analysis::dvvp::ProfileFileChunk> fileChunkReq);
    void PrintStats() const;
    void SetDeviceInfo(uint32_t deviceId, double freq, double aicFreq);
    void SaveDataToFile(std::string path);
    bool IsBiuMode() const;

private:
    uint16_t ConvCtrlToInstr(uint16_t ctrlType) const;
    void HandleSyscnt(const BiuPerfProfile *data);
    void HandleStatusData(const BiuPerfProfile *data);
    void HandleStampData(const BiuPerfProfile *data);
    bool CheckNumberExist(std::vector<uint16_t> checkList, uint16_t num) const;
    std::vector<uint16_t> CheckBits(uint16_t instrStatus) const;
    bool SplitFileName(const std::string &fileName);
    void SaveCntData();
    void HandleInstrStart(uint32_t idx);
    void HandleInstrStop(uint32_t idx);

private:
    std::map<uint16_t, std::string> instructionMap_;
    std::map<std::string, uint32_t> mappingList_;
    BiuDataCollection biuData_[GROUP_NUM_MAX][GROUP_TYPE_NUM_MAX];
    bool inited_;
    uint64_t countTimes_;
    uint32_t group_;
    uint32_t groupTag_;
    double aicFreq_;
    double aivFreq_;
};

}
}
}

#endif