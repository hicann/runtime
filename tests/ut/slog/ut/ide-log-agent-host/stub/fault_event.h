/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef FAULT_EVENT_H
#define FAULT_EVENT_H
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdint.h>
#include <fcntl.h>

#define EVENT_SPEC_SIZE_MAX 128

#ifdef __cplusplus
#include <functional>
#include <memory>
#define EXTERN_C extern "C"
#else
#define EXTERN_C
#endif

#ifdef __cplusplus
extern "C" {
#endif

struct FTENodeStatusInfo {
    uint32_t nodeId;
    uint32_t nodeStatus;
};

union FTESpec {
    char buf[EVENT_SPEC_SIZE_MAX];
    char procName[EVENT_SPEC_SIZE_MAX];
    struct FTENodeStatusInfo timeoutInfo;
    uint32_t errInfo;
};

struct FTEInfo {
    uint16_t eventId;
    uint8_t type;
    uint32_t nodeID;
    uint8_t faultLoc;
    union FTESpec eventPara;
};

struct FTEDidInfo {
    uint16_t didId;
    uint16_t didValueSize;
    uint8_t *didValue;
};

struct FTEUDSInfo {
    uint16_t totalSize;
    uint16_t didInfoSize;
    struct FTEDidInfo *didRec;
};

struct AntiFlash {
    uint32_t recoverWindow; // default 10s
};

struct FTEAttr {
    struct AntiFlash antiFlash;
};

int32_t FTEConfig(const struct FTEAttr *attr);

int32_t FTEReport(const struct FTEInfo *eventInfo, const struct FTEUDSInfo *udsInfo);

#ifdef __cplusplus
}
#endif

#ifdef __cplusplus
struct FTEDeserializedDid {
    uint16_t didId;
    uint16_t didValueSize;
    std::unique_ptr<uint8_t[]> didValue;
    int32_t DeSerializeDidInfo(const uint8_t* buf, uint32_t bufSize, uint32_t& offset);
private:
    template<typename T>
    void GetDidDataFromBuf(T &dest, uint32_t &offset, const uint8_t* buf, uint32_t srcSize);
};

struct FTEDeserializedUDS {
    uint16_t totalSize;
    uint16_t didInfoSize;
    std::unique_ptr<FTEDeserializedDid[]> didRec;
    int32_t DeSerialize(const uint8_t* buf, uint32_t bufSize);
private:
    template<typename T>
    void GetUdsDataFromBuf(T &dest, uint32_t &offset, const uint8_t* buf, uint32_t srcSize);
};

int32_t FTEDeSerialize(const uint8_t *buf, const uint32_t bufSize, FTEInfo &eventInfo,
                   FTEDeserializedUDS &udsInfo);

int32_t FTERegisterCallback(const std::function<int32_t (const uint8_t *, uint32_t)> &callBack);
int32_t FTEUnregisterCallback();
#endif

#endif

