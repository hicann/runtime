/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef ANALYSIS_DVVP_MESSAGE_MESSAGE_H
#define ANALYSIS_DVVP_MESSAGE_MESSAGE_H

#include <iostream>
#include <sstream>
#include "msprof_dlog.h"
#include "json/json.h"
#include "utils/utils.h"
#include "config/config.h"

namespace analysis {
namespace dvvp {
namespace message {

#define MSG_STR(s) #s

#define SET_VALUE(root, value)                        \
    do {                                              \
        (root)[MSG_STR(value)] = (value);             \
    } while (0)

#define SET_ARRAY_VALUE(root, vector)                 \
    do {                                              \
        (root)[MSG_STR(vector)] = (vector);          \
    } while (0)

#define FROM_STRING_VALUE(root, field)            \
    do {                                          \
        if ((root)[MSG_STR(field)].type != NanoJson::JsonValueType::INVALID) {     \
            field = (root)[MSG_STR(field)].GetValue<std::string>(); \
        }       \
    } while (0)

#define FROM_INT_VALUE(root, field, def)           \
    do {                                           \
        if ((root)[MSG_STR(field)].type != NanoJson::JsonValueType::INVALID) {     \
            field = (root)[MSG_STR(field)].GetValue<int32_t>(); \
        }       \
    } while (0)

#define FROM_UINT64_VALUE(root, field, def)         \
    do {                                            \
        if ((root)[MSG_STR(field)].type != NanoJson::JsonValueType::INVALID) {     \
            field = (root)[MSG_STR(field)].GetValue<uint64_t>(); \
        }       \
    } while (0)


#define FROM_BOOL_VALUE(root, field)                 \
    do {                                             \
        if ((root)[MSG_STR(field)].type != NanoJson::JsonValueType::INVALID) {     \
            field = (root)[MSG_STR(field)].GetValue<bool>(); \
        }       \
    } while (0)

enum COLLECTON_STATUS {
    SUCCESS = 0,
    ERR = 1
};

struct BaseInfo {
    virtual ~BaseInfo() {}
    std::string ToString()
    {
        std::string result;

        NanoJson::Json root;
        ToObject(root);
        result = root.ToString();

        return result;
    }

    virtual void ToObject(NanoJson::Json &object) = 0;

    virtual void FromObject(NanoJson::Json &object) = 0;

    virtual std::string GetStructName()
    {
        return "BaseInfo";
    }

    bool FromString(const std::string &value)
    {
        if (value.empty()) {
            return false;
        }

        bool ok = false;

        try {
            NanoJson::Json root;
            root.Parse(value);
            FromObject(root);
            ok = true;
        } catch (std::exception &e) {
            MSPROF_LOGE("%s ::FromString(): %s", GetStructName().c_str(), e.what());
        }
        return ok;
    }
};

struct StatusInfo : public BaseInfo {
    std::string dev_id;
    int32_t status;
    std::string info;
    explicit StatusInfo(const std::string id, int32_t sta = static_cast<int32_t>(ERR),
        const std::string &inf = "")
        : dev_id(id),
          status(sta),
          info(inf)
        {
    }

    StatusInfo()
        : dev_id("-1"),
          status(ERR)
        {
    }
    ~StatusInfo() override {}

    std::string GetStructName() override
    {
        return "StatusInfo";
    }

    void ToObject(NanoJson::Json &object) override
    {
        SET_VALUE(object, dev_id);
        SET_VALUE(object, status);
        SET_VALUE(object, info);
    }

    void FromObject(NanoJson::Json &object) override
    {
        FROM_STRING_VALUE(object, dev_id);
        FROM_INT_VALUE(object, status, static_cast<int32_t>(ERR));
        FROM_STRING_VALUE(object, info);
    }
};

struct Status : public BaseInfo {
    int32_t status;
    std::vector<StatusInfo> info;

    Status() : status(ERR) {}
    ~Status() override {}

    std::string GetStructName() override
    {
        return "Status";
    }

    void AddStatusInfo(const StatusInfo &statusInfo)
    {
        info.push_back(statusInfo);
    }

    void ToObject(NanoJson::Json &object) override
    {
        object["status"] = status;
        const size_t size = info.size();
        object["info"].SetArraySize(size);
        for (size_t i = 0; i < size; ++i) {
            object["info"][i]["dev_id"] = info[i].dev_id;
            object["info"][i]["status"] = info[i].status;
            object["info"][i]["info"] = info[i].info;
        }
    }

    void FromObject(NanoJson::Json &object) override
    {
        FROM_INT_VALUE(object, status, static_cast<int32_t>(ERR));

        info.clear();
        NanoJson::JsonArray jarray = object[MSG_STR(info)].GetValue<NanoJson::JsonArray>();
        for (auto iter = jarray.begin(); iter != jarray.end(); ++iter) {
            StatusInfo value;
            value.dev_id = (*iter)["dev_id"].GetValue<std::string>();
            value.status = static_cast<int32_t>((*iter)["status"].GetValue<int64_t>());
            value.info = (*iter)["info"].GetValue<std::string>();
            info.push_back(value);
        }
    }
};

// Attention:
// intervals of ProfileParams maybe large,
// remember to cast to long long before calculation (for example, convert ms to ns)
struct JobContext : public BaseInfo {
    std::string result_dir;  // result_dir
    std::string module;  // module: runtime,Framework
    std::string tag;  // tag: module tag
    std::string dev_id;  // dev_id
    std::string job_id;  // job_id
    uint64_t chunkStartTime;
    uint64_t chunkEndTime;
    int32_t dataModule;

    // for debug purpose
    std::string stream_enabled;

    JobContext() : chunkStartTime(0), chunkEndTime(0), dataModule(0)
    {
    }
    ~JobContext() override {}

    std::string GetStructName() override
    {
        return "JobContext";
    }

    void ToObject(NanoJson::Json &object) override
    {
        SET_VALUE(object, result_dir);
        SET_VALUE(object, module);
        SET_VALUE(object, tag);
        SET_VALUE(object, dev_id);
        SET_VALUE(object, job_id);
        SET_VALUE(object, chunkStartTime);
        SET_VALUE(object, chunkEndTime);
        SET_VALUE(object, dataModule);
        SET_VALUE(object, stream_enabled);
    }

    void FromObject(NanoJson::Json &object) override
    {
        FROM_STRING_VALUE(object, result_dir);
        FROM_STRING_VALUE(object, module);
        FROM_STRING_VALUE(object, tag);
        FROM_STRING_VALUE(object, dev_id);
        FROM_STRING_VALUE(object, job_id);
        FROM_UINT64_VALUE(object, chunkStartTime, 0);
        FROM_UINT64_VALUE(object, chunkEndTime, 0);
        FROM_INT_VALUE(object, dataModule, 0);
        FROM_STRING_VALUE(object, stream_enabled);
    }
};
}  // namespace message
}  // namespace dvvp
}  // namespace analysis
#endif

