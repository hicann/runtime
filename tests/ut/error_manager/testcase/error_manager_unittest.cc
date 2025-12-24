/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <gtest/gtest.h>
#include <memory>
#include <fstream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <nlohmann/json.hpp>
#include "mmpa/mmpa_api.h"
#include "tests/depends/mmpa/src/mmpa_stub.h"
#include "base/err_msg.h"
#include "base/err_mgr.h"
#include "graph/def_types.h"
#include "common/util/error_manager/error_manager.h"

namespace ge
{
namespace {
  int32_t system_time_ret = 0;
  int32_t time_of_day_ret = 0;
  class MockMmpa : public ge::MmpaStubApi {
    public:
      INT32 mmGetSystemTime(mmSystemTime_t *sysTime) override {
        if (system_time_ret == -1) {
          return EN_ERR;
        }
        sysTime->wYear = 2023;
        sysTime->wMonth = 8;
        sysTime->wDay = 8;
        sysTime->wHour = 20;
        sysTime->wMinute = 8;
        sysTime->wSecond = 0;
        return EN_OK;
      }
      INT32 mmGetTimeOfDay(mmTimeval *timeVal, mmTimezone *timeZone) override {
        if (time_of_day_ret == -1) {
          return EN_ERR;
        }
        timeVal->tv_usec = 1001;
        timeVal->tv_sec = 1001;
        return EN_OK;
      }
  };
  std::string g_msg1 = R"(
{
  "error_info_list": [
    {
      "errClass": "GE Errors",
      "errTitle": "Invalid_Argument",
      "ErrCode": "E10021",
      "ErrMessage": "Path for parameter [--%s] is too long. Keep the length within %s",
      "Arglist": "parameter,size",
      "suggestion": {
        "Possible Cause": "N/A",
        "Solution": "The path name exceeds the maximum length. Specify a valid path name."
      }
    },
    {
      "errClass": "GE Errors",
      "errTitle": "Invalid_Argument",
      "ErrCode": "E10022",
      "ErrMessage": "Path [%s] for parameter [--%s] does not include the file name.",
      "Arglist": "filename,parameter",
      "suggestion": {
        "Possible Cause": "N/A",
        "Solution": "Add the file name to the path."
      }
    }
  ]
}
)";
  std::string g_msg2 = R"(
{
  "error_info_list": [
    {
      "errClass": "GE Errors",
      "errTitle": "Invalid_Argument",
      "ErrCode": "E10023",
      "ErrMessage": "Value [%s] for parameter [--singleop] is invalid.",
      "Arglist": "value",
      "suggestion": {
        "Possible Cause": "The path does not exist or the file name is incorrect.",
        "Solution": "Check whether the input file exists."
      }
    },
    {
      "errClass": "GE Errors",
      "errTitle": "Invalid_Argument",
      "ErrCode": "E10024",
      "ErrMessage": "Failed to open file [%s] specified by [--singleop].",
      "Arglist": "value",
      "suggestion": {
        "Possible Cause": "N/A",
        "Solution": "Check the owner group and permission settings and ensure that the user who runs the ATC command has enough permission to open the file."
      }
    }
  ]
}
)";
REG_FORMAT_ERROR_MSG(g_msg1.c_str(), g_msg1.size());
REG_FORMAT_ERROR_MSG(g_msg2.c_str(), g_msg2.size());
}

  class UtestErrorManager : public testing::Test {
    protected:
    void SetUp() {
      MmpaStub::GetInstance().SetImpl(std::make_shared<MockMmpa>());
      auto &instance = ErrorManager::GetInstance();
      EXPECT_FALSE(instance.is_init_);
      std::string error_code_json_path = METADEF_DIR + std::string("/error_manager/error_code.json");
      nlohmann::json json_file;
      EXPECT_EQ(instance.ReadJsonFile(error_code_json_path, &json_file), 0);
      EXPECT_EQ(instance.ParseJsonFormatString(ge::PtrToPtr<nlohmann::json, void>(&json_file)), 0);
      instance.is_init_ = true;
    }
    void TearDown() {
        ErrorManager::GetInstance().is_init_ = false;
        ErrorManager::GetInstance().compile_failed_msg_map_.clear();
        ErrorManager::GetInstance().compile_failed_msg_map_.clear();
        ErrorManager::GetInstance().error_message_per_work_id_.clear();
        ErrorManager::GetInstance().warning_messages_per_work_id_.clear();
        MmpaStub::GetInstance().Reset();
    }
  };

TEST_F(UtestErrorManager, Init_faild) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.Init(""), -1);
  instance.is_init_ = true;
  EXPECT_EQ(instance.Init(""), -1);
  EXPECT_EQ(instance.Init(), -1);
  EXPECT_EQ(error_message::ErrMgrInit(error_message::ErrorMessageMode::ERR_MSG_MODE_MAX), -1);
}

TEST_F(UtestErrorManager, FormatErrorMessage) {
  char buf[10] = {0};
  EXPECT_TRUE(error_message::FormatErrorMessage(buf, 10, "test") > 0);
}

TEST_F(UtestErrorManager, TrimPath) {
  std::string file = "error_manager_unittest.cc";
  EXPECT_EQ(error_message::TrimPath(file), file);
}

TEST_F(UtestErrorManager, GetInstance) {
  EXPECT_NO_THROW(ErrorManager::GetInstance());
}

TEST_F(UtestErrorManager, ReportInterErrMessage) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_context_.work_stream_id = 0;
  EXPECT_EQ(instance.ReportInterErrMessage("errcode", "errmsg"), -1);
  instance.is_init_ = true;
  EXPECT_EQ(instance.ReportInterErrMessage("600000", "errmsg"), -1);
}

TEST_F(UtestErrorManager, ReportInterErrMessage_WorkStreamId) {
  auto &instance = ErrorManager::GetInstance();
  instance.is_init_ = true;
  auto id = instance.error_context_.work_stream_id;
  instance.error_context_.work_stream_id = 0;
  EXPECT_EQ(instance.ReportInterErrMessage("609999", "errmsg"), 0);

  // error_messages.size() > kMaxWorkSize
  instance.error_message_per_work_id_[instance.error_context_.work_stream_id].resize(1010U);
  EXPECT_EQ(instance.ReportInterErrMessage("609999", "errmsg"), -1);

  // error_message_per_work_id_.size() > kMaxWorkSize
  instance.error_context_.work_stream_id = id;
  for (int i = 0; i < 1002; i++){
    instance.error_message_per_work_id_[i] = std::vector<ErrorManager::ErrorItem>();
  }
  EXPECT_EQ(instance.ReportInterErrMessage("609999", "errmsg"), -1);
}

TEST_F(UtestErrorManager, ReportErrMessage) {
  auto &instance = ErrorManager::GetInstance();
  std::string error_code = "error";
  std::map<std::string, std::string> args_map;
  system_time_ret = -1;
  EXPECT_EQ(instance.ReportErrMessage(error_code, args_map), -1);
  system_time_ret = 0;
  instance.is_init_ = true;
  time_of_day_ret = -1;
  EXPECT_EQ(instance.ReportErrMessage(error_code, args_map), -1);
  time_of_day_ret = 0;
}

TEST_F(UtestErrorManager, ReportErrMessage_Normal) {
  auto &instance = ErrorManager::GetInstance();
  instance.is_init_ = true;
  std::string error_code = "error";
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "val1";
  auto conf = ErrorManager::ErrorInfoConfig();
  instance.error_map_[error_code] = conf;
  EXPECT_EQ(instance.ReportErrMessage(error_code, args_map), 0);
  instance.error_map_[error_code].arg_list.push_back("argv1");
  EXPECT_EQ(instance.ReportErrMessage(error_code, args_map), -1);
  instance.error_map_[error_code].arg_list.clear();
  instance.error_map_[error_code].arg_list.push_back("");
  EXPECT_EQ(instance.ReportErrMessage(error_code, args_map), 0);
}

TEST_F(UtestErrorManager, SetRawErrorMessages) {
  auto &instance = ErrorManager::GetInstance();
  std::vector<ErrorManager::ErrorItem> vec;
  vec.push_back(ErrorManager::ErrorItem());
  instance.error_context_.work_stream_id = 0;
  EXPECT_EQ(instance.SetRawErrorMessages(vec), 0);
  EXPECT_NE(instance.GetErrorMessage(), "");
}

TEST_F(UtestErrorManager, GetErrorMessage) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.GetErrorMessage(), "");
  std::vector<ErrorManager::ErrorItem> vec;
  vec.push_back(ErrorManager::ErrorItem());
  instance.error_message_per_work_id_[0] = vec;
  instance.error_context_.work_stream_id = 0;
  EXPECT_NE(instance.GetErrorMessage(), "");
  vec.push_back(ErrorManager::ErrorItem());
  instance.error_message_per_work_id_[1] = vec;
  instance.error_context_.work_stream_id = 1;
  EXPECT_NE(instance.GetErrorMessage(), "");
}

TEST_F(UtestErrorManager, GetErrorMessageOk) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.GetErrorMessage(), "");
  std::vector<ErrorManager::ErrorItem> vec;
  vec.push_back(ErrorManager::ErrorItem());
  vec[0].error_id = "E10001";
  vec[0].error_message = "Device id was not set";
  vec.push_back(ErrorManager::ErrorItem());
  vec[1].error_id = "E10002";
  vec[1].error_message = "Device id was not set";
  instance.error_message_per_work_id_[0] = vec;
  instance.error_context_.work_stream_id = 0;
  EXPECT_NE(instance.GetErrorMessage(), "");
}

TEST_F(UtestErrorManager, GetErrorOtherMessage) {
  auto &instance = ErrorManager::GetInstance();
  std::vector<ErrorManager::ErrorItem> vec;
  ErrorManager::ErrorItem item;
  item.error_id = "E18888";
  item.error_message = "ERROR";
  vec.push_back(item);
  ErrorManager::ErrorItem item1;
  item1.error_id = "E19999";
  item1.error_message = "ERROR";
  vec.push_back(item1);
  instance.error_message_per_work_id_[0] = vec;
  instance.error_context_.work_stream_id = 0;
  EXPECT_NE(instance.GetErrorMessage(), "");
}

TEST_F(UtestErrorManager, GetWarningMessage) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.GetWarningMessage(), "");
  auto warn_msg = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(warn_msg, nullptr);
  EXPECT_EQ(std::string(warn_msg.get()), "");
}

TEST_F(UtestErrorManager, OutputErrMessage) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.OutputErrMessage(1), 0);
  EXPECT_EQ(instance.OutputErrMessage(10000), -1);
}

TEST_F(UtestErrorManager, OutputMessage) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.OutputMessage(1), 0);
}

TEST_F(UtestErrorManager, ATCReportErrMessage) {
  auto &instance = ErrorManager::GetInstance();
  std::vector<std::string> key;
  std::vector<std::string> value;
  EXPECT_NO_THROW(instance.ATCReportErrMessage("error", key, value));
  instance.is_init_ = true;
  EXPECT_NO_THROW(instance.ATCReportErrMessage("error", key, value));
  key.push_back("key");
  EXPECT_NO_THROW(instance.ATCReportErrMessage("error", key, value));
  value.push_back("123");
  EXPECT_NO_THROW(instance.ATCReportErrMessage("error", key, value));
}

TEST_F(UtestErrorManager, ClassifyCompileFailedMsg) {
  auto &instance = ErrorManager::GetInstance();
  std::map<std::string, std::string> msg;
  std::map<std::string, std::vector<std::string>> classified_msg;
  msg["code"] = "error";
  EXPECT_NO_THROW(instance.ClassifyCompileFailedMsg(msg, classified_msg));
  classified_msg["code"] = std::vector<std::string>();
  EXPECT_NO_THROW(instance.ClassifyCompileFailedMsg(msg, classified_msg));
}

TEST_F(UtestErrorManager, Context) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_context_.work_stream_id = 0;
  auto context = instance.GetErrorManagerContext();
  EXPECT_NE(instance.error_context_.work_stream_id, 0);
  instance.SetErrorContext(context);
}

TEST_F(UtestErrorManager, GenWorkStreamIdBySessionGraph) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_NO_THROW(instance.GenWorkStreamIdBySessionGraph(1, 2));
}

TEST_F(UtestErrorManager, GenWorkStreamIdWithSessionIdGraphId) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_NO_THROW(instance.GenWorkStreamIdWithSessionIdGraphId(1, 2));
}

TEST_F(UtestErrorManager, GetMstuneCompileFailedMsg) {
  auto &instance = ErrorManager::GetInstance();
  std::string graph_name = "graph";
  std::map<std::string, std::vector<std::string>> msg_map;
  EXPECT_EQ(instance.GetMstuneCompileFailedMsg(graph_name, msg_map), -1);
  msg_map["msg"] = std::vector<std::string>();
  EXPECT_EQ(instance.GetMstuneCompileFailedMsg(graph_name, msg_map), -1);
  instance.is_init_ = true;
  EXPECT_EQ(instance.GetMstuneCompileFailedMsg(graph_name, msg_map), -1);
  msg_map.clear();
  instance.compile_failed_msg_map_["graph"] = std::map<std::string, std::vector<std::string>>();
  EXPECT_EQ(instance.GetMstuneCompileFailedMsg(graph_name, msg_map), 0);
}

TEST_F(UtestErrorManager, ReportMstuneCompileFailedMsg) {
  auto &instance = ErrorManager::GetInstance();
  std::string root_graph_name = "root_graph";
  std::map<std::string, std::string> msg;
  EXPECT_EQ(instance.ReportMstuneCompileFailedMsg(root_graph_name, msg), -1);
  instance.is_init_ = true;
  EXPECT_EQ(instance.ReportMstuneCompileFailedMsg(root_graph_name, msg), -1);
}

TEST_F(UtestErrorManager, ReportMstuneCompileFailedMsg_Success) {
  auto &instance = ErrorManager::GetInstance();
  instance.is_init_ = true;
  std::string root_graph_name = "root_graph_name";
  std::map<std::string, std::string> msg;
  msg["root_graph_name"] = "message";
  EXPECT_EQ(instance.ReportMstuneCompileFailedMsg(root_graph_name, msg), 0);
  instance.compile_failed_msg_map_["root_graph_name"] = std::map<std::string, std::vector<std::string>>();
  EXPECT_EQ(instance.ReportMstuneCompileFailedMsg(root_graph_name, msg), 0);
}

TEST_F(UtestErrorManager, ReadJsonFile) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.ReadJsonFile("", nullptr), -1);
  EXPECT_EQ(instance.ReadJsonFile("json", nullptr), -1);
  std::ofstream out("out.json");
  if (out.is_open()){
    out << "{\"name\":\"value\"}\n";
    out.close();
  }
  nlohmann::json json_file;
  EXPECT_EQ(instance.ReadJsonFile("out.json", &json_file), 0);
}

TEST_F(UtestErrorManager, ParseJsonFile) {
  auto &instance = ErrorManager::GetInstance();
  std::ofstream out("out.json");
  if (out.is_open()){
    out << "{\"name\":\"value\"}\n";
    out.close();
  }
  nlohmann::json json_file;
  EXPECT_EQ(instance.ReadJsonFile("out.json", &json_file), 0);
  EXPECT_EQ(instance.ParseJsonFormatString(ge::PtrToPtr<nlohmann::json, void>(&json_file)), -1);

  std::ofstream out1("out1.json");
  if (out1.is_open()){
    out1 << "{\"error_info_list\":[\"err1\"]}";
    out1.close();
  }
  EXPECT_EQ(instance.ReadJsonFile("out1.json", &json_file), 0);
  EXPECT_EQ(instance.ParseJsonFormatString(ge::PtrToPtr<nlohmann::json, void>(&json_file)), -1);
  std::ofstream out2("out2.json");
  if (out2.is_open()){
    out2 << "{\"error_info_list\":\"err1\"}";
    out2.close();
  }
  EXPECT_EQ(instance.ReadJsonFile("out2.json", &json_file), 0);
  EXPECT_EQ(instance.ParseJsonFormatString(ge::PtrToPtr<nlohmann::json, void>(&json_file)), -1);
  std::ofstream out3("out3.json");
  if (out3.is_open()){
    out3 << "{\"error_info_list\":[{\"ErrCode\":\"1\", \"ErrMessage\":\"message\", \"Arglist\":\"1,2,3\"}]}";
    out3.close();
  }
  EXPECT_EQ(instance.ReadJsonFile("out3.json", &json_file), 0);
  EXPECT_EQ(instance.ParseJsonFormatString(ge::PtrToPtr<nlohmann::json, void>(&json_file)), 0);
  instance.error_map_["1"] = ErrorManager::ErrorInfoConfig();

  EXPECT_EQ(instance.ReadJsonFile("out3.json", &json_file), 0);
  EXPECT_EQ(instance.ParseJsonFormatString(ge::PtrToPtr<nlohmann::json, void>(&json_file)), 0);
}

TEST_F(UtestErrorManager, ParseJsonFileSuccess) {
  std::string error_code_json_path = METADEF_DIR + std::string("/error_manager/error_code.json");
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.ParseJsonFile(error_code_json_path), 0);
}

TEST_F(UtestErrorManager, ClearErrorMsgContainerByWorkId) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_message_per_work_id_[0] = std::vector<ErrorManager::ErrorItem>();
  EXPECT_NO_THROW(instance.ClearErrorMsgContainerByWorkId(0));
}

TEST_F(UtestErrorManager, GetErrorMsgContainerByWorkId) {
  auto &instance = ErrorManager::GetInstance();
  std::vector<ErrorManager::ErrorItem> vec;
  vec.push_back(ErrorManager::ErrorItem());
  instance.error_message_per_work_id_[0] = vec;
  EXPECT_EQ(instance.GetErrorMsgContainerByWorkId(0).size(), 1);
}

TEST_F(UtestErrorManager, TestReportInnerErrorFail) {
  std::shared_ptr<char[]> msg(new (std::nothrow) char[LIMIT_PER_MESSAGE]());
  std::fill_n(msg.get(), LIMIT_PER_MESSAGE, 'T');
  msg[LIMIT_PER_MESSAGE - 1U] = '\0';
  EXPECT_NO_THROW(REPORT_INNER_ERR_MSG("E19999", "error is %s", msg.get()));

  msg[LIMIT_PER_MESSAGE - 15U] = '\0';
  EXPECT_NO_THROW(REPORT_INNER_ERR_MSG("E19999", "error is %s", msg.get()));
}

std::mutex mu;
std::condition_variable cv;
bool done = false;

void thread1()
{
  auto &instance = ErrorManager::GetInstance();
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread1";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_1"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_1"), 0);
}
void thread2()
{
  auto &instance = ErrorManager::GetInstance();
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread2";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_2"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_2"), 0);
}

void thread3()
{
  std::unique_lock<std::mutex> lck(mu);
  auto &instance = ErrorManager::GetInstance();
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread1";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_1"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_1"), 0);
  cv.wait(lck, []{return done;});

  EXPECT_EQ(instance.error_message_process_.size(), 4);
  EXPECT_EQ(instance.warning_messages_process_.size(), 4);
  auto err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  auto error_str = std::string(err.get());
  EXPECT_NE(error_str.find("thread1"), std::string::npos);
  EXPECT_NE(error_str.find("thread2"), std::string::npos);
  EXPECT_NE(error_str.find("thread_1"), std::string::npos);
  EXPECT_NE(error_str.find("thread_2"), std::string::npos);
  EXPECT_NE(error_str.find(std::to_string(mmGetTid())), std::string::npos);

  auto war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  auto warnig_str = std::string(war.get());
  EXPECT_NE(warnig_str.find("thread1"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread2"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_2"), std::string::npos);
  EXPECT_NE(warnig_str.find(std::to_string(mmGetTid()).c_str()), std::string::npos);
  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
  lck.unlock();
}

void thread4()
{
  std::lock_guard<std::mutex> lck(mu);
  auto &instance = ErrorManager::GetInstance();
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread2";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_2"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_2"), 0);
  done = true;
  cv.notify_one();
}

void thread5()
{
  std::unique_lock<std::mutex> lck(mu);
  auto &instance = ErrorManager::GetInstance();
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread1";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_1"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_1"), 0);
  cv.wait(lck, []{return done;});

  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
  auto err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  auto error_str = std::string(err.get());
  EXPECT_NE(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_NE(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  auto war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  auto warnig_str = std::string(war.get());
  EXPECT_NE(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);

  // 读清
  err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  error_str = std::string(err.get());
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  warnig_str = std::string(war.get());
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  lck.unlock();
}

void thread6()
{
  std::lock_guard<std::mutex> lck(mu);
  auto &instance = ErrorManager::GetInstance();
  instance.error_context_.work_stream_id = 10000;
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread2";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_2"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_2"), 0);
  done = true;
  cv.notify_one();
}

void thread7()
{
  std::unique_lock<std::mutex> lck(mu);
  auto &instance = ErrorManager::GetInstance();
  instance.error_context_.work_stream_id = 10000;
  std::map<std::string, std::string> args_map;
  args_map["argv1"] = "thread1";
  EXPECT_EQ(instance.ReportErrMessage("E13000", args_map), 0);
  EXPECT_EQ(instance.ReportErrMessage("W14000", args_map), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("E18888", "InterErr is thread_1"), 0);
  EXPECT_EQ(instance.ReportInterErrMessage("W18888", "InterWarning is thread_1"), 0);
  cv.wait(lck, []{return done;});

  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
  auto err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  auto error_str = std::string(err.get());
  EXPECT_NE(error_str.find("thread1"), std::string::npos);
  EXPECT_NE(error_str.find("thread2"), std::string::npos);
  EXPECT_NE(error_str.find("thread_1"), std::string::npos);
  EXPECT_NE(error_str.find("thread_2"), std::string::npos);
  auto war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  auto warnig_str = std::string(war.get());
  EXPECT_NE(warnig_str.find("thread1"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread2"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_2"), std::string::npos);

  // 读清
  err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  error_str = std::string(err.get());
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  warnig_str = std::string(war.get());
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  lck.unlock();
}

TEST_F(UtestErrorManager, ProcessModeTest01) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_mode_ = error_message::ErrorMsgMode::PROCESS_MODE;
  EXPECT_NE(instance.Init(error_message::ErrorMsgMode::ERR_MSG_MODE_MAX), 0);
  instance.Init(error_message::ErrorMsgMode::PROCESS_MODE);
  auto conf = ErrorManager::ErrorInfoConfig();
  conf.error_id = "E13000";
  conf.error_message = "error happend, thread=%s.";
  conf.arg_list.push_back("argv1");
  instance.error_map_["E13000"] = conf;
  conf.error_id = "W14000";
  conf.error_message = "warning happend, thread=%s.";
  instance.error_map_["W14000"] = conf;
  instance.is_init_ = true;

  std::thread td1(thread1);
  std::thread td2(thread2);

  td1.join();
  td2.join();
  EXPECT_EQ(instance.error_message_process_.size(), 4);
  EXPECT_EQ(instance.warning_messages_process_.size(), 4);
  auto err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  auto error_str = std::string(err.get());
  EXPECT_NE(error_str.find("thread1"), std::string::npos);
  EXPECT_NE(error_str.find("thread2"), std::string::npos);
  EXPECT_NE(error_str.find("thread_1"), std::string::npos);
  EXPECT_NE(error_str.find("thread_2"), std::string::npos);
  auto war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  auto warnig_str = std::string(war.get());
  EXPECT_NE(warnig_str.find("thread1"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread2"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_NE(warnig_str.find("thread_2"), std::string::npos);

  // 读清测试
  error_str = instance.GetErrorMessage();
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  warnig_str = instance.GetWarningMessage();
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);

}

TEST_F(UtestErrorManager, ProcessModeTest02) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_mode_ = error_message::ErrorMsgMode::PROCESS_MODE;
  auto conf = ErrorManager::ErrorInfoConfig();
  conf.error_id = "E13000";
  conf.error_message = "error happend, thread=%s.";
  conf.arg_list.push_back("argv1");
  instance.error_map_["E13000"] = conf;
  conf.error_id = "W14000";
  conf.error_message = "warning happend, thread=%s.";
  instance.error_map_["W14000"] = conf;
  instance.is_init_ = true;

  std::thread td3(thread3);
  std::thread td4(thread4);

  td3.join();
  td4.join();

  // 读清测试
  std::string error_str = instance.GetErrorMessage();
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  std::string warnig_str = instance.GetWarningMessage();
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
}

TEST_F(UtestErrorManager, ProcessModeTest03) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_mode_ = error_message::ErrorMsgMode::INTERNAL_MODE;
  auto conf = ErrorManager::ErrorInfoConfig();
  conf.error_id = "E13000";
  conf.error_message = "error happend, thread=%s.";
  conf.arg_list.push_back("argv1");
  instance.error_map_["E13000"] = conf;
  conf.error_id = "W14000";
  conf.error_message = "warning happend, thread=%s.";
  instance.error_map_["W14000"] = conf;
  instance.is_init_ = true;

  std::thread td1(thread1);
  std::thread td2(thread2);

  td1.join();
  td2.join();

  auto err = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err, nullptr);
  std::string error_str(err.get());
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  auto war = error_message::GetErrMgrWarningMessage();
  EXPECT_NE(war, nullptr);
  std::string warnig_str(war.get());
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
}

TEST_F(UtestErrorManager, InternalModeTest04) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_mode_ = error_message::ErrorMsgMode::INTERNAL_MODE;
  auto conf = ErrorManager::ErrorInfoConfig();
  conf.error_id = "E13000";
  conf.error_message = "error happend, thread=%s.";
  conf.arg_list.push_back("argv1");
  instance.error_map_["E13000"] = conf;
  conf.error_id = "W14000";
  conf.error_message = "warning happend, thread=%s.";
  instance.error_map_["W14000"] = conf;
  instance.is_init_ = true;

  std::thread td1(thread4);
  std::thread td2(thread5);

  td1.join();
  td2.join();

  std::string error_str = instance.GetErrorMessage();
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  std::string warnig_str = instance.GetWarningMessage();
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
}

TEST_F(UtestErrorManager, InternalModeTest05) {
  auto &instance = ErrorManager::GetInstance();
  instance.error_mode_ = error_message::ErrorMsgMode::INTERNAL_MODE;
  auto conf = ErrorManager::ErrorInfoConfig();
  conf.error_id = "E13000";
  conf.error_message = "error happend, thread=%s.";
  conf.arg_list.push_back("argv1");
  instance.error_map_["E13000"] = conf;
  conf.error_id = "W14000";
  conf.error_message = "warning happend, thread=%s.";
  instance.error_map_["W14000"] = conf;
  instance.is_init_ = true;

  std::thread td1(thread6);
  std::thread td2(thread7);

  td1.join();
  td2.join();

  std::string error_str = instance.GetErrorMessage();
  EXPECT_EQ(error_str.find("thread1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread2"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(error_str.find("thread_2"), std::string::npos);
  std::string warnig_str = instance.GetWarningMessage();
  EXPECT_EQ(warnig_str.find("thread1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread2"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_1"), std::string::npos);
  EXPECT_EQ(warnig_str.find("thread_2"), std::string::npos);
  EXPECT_EQ(instance.error_message_process_.size(), 0);
  EXPECT_EQ(instance.warning_messages_process_.size(), 0);
}

TEST_F(UtestErrorManager, IsUserDefinedErrorCode_Failed_invalid_error_code) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_FALSE(instance.IsUserDefinedErrorCode("E10001"));
  EXPECT_FALSE(instance.IsUserDefinedErrorCode("E1000"));
  EXPECT_FALSE(instance.IsUserDefinedErrorCode("E18888"));
  EXPECT_FALSE(instance.IsUserDefinedErrorCode("E19999"));
}

TEST_F(UtestErrorManager, IsUserDefinedErrorCode_Success) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_TRUE(instance.IsUserDefinedErrorCode("EU0001"));
}

TEST_F(UtestErrorManager, ReportUserDefinedErrMsg_Failed_MessageLengthExceedsLimits_1024) {
  auto ret = error_message::ReportUserDefinedErrMsg("EU0001", "errmsg is %s.", std::string(1025, 'a').c_str());
  EXPECT_EQ(ret, -1);
  EXPECT_TRUE(std::string(error_message::GetErrMgrErrorMessage().get()).empty());
}

TEST_F(UtestErrorManager, ReportUserDefinedErrMsg_Success_empty_error_code) {
  error_message::ErrorManagerContext ctx;
  ctx.work_stream_id = 0;
  error_message::SetErrMgrContext(ctx);
  const std::string errmsg = "Report error code is empty!";
  auto ret = error_message::ReportUserDefinedErrMsg("", "%s", errmsg.c_str());
  EXPECT_EQ(ret, 0);
  EXPECT_TRUE(std::string(error_message::GetErrMgrErrorMessage().get()).find(errmsg) != std::string::npos);
}

TEST_F(UtestErrorManager, ReportUserDefinedErrMsg_Success_not_support_error_code) {
  const std::string errmsg_1 = "Report 8888 error code!";
  auto ret = error_message::ReportUserDefinedErrMsg("EU8888", "%s", errmsg_1.c_str());
  EXPECT_EQ(ret, 0);
  const std::string errmsg_2 = "Report 9999 error code!";
  ret = error_message::ReportUserDefinedErrMsg("EU9999", "%s", errmsg_2.c_str());
  EXPECT_EQ(ret, 0);
  const std::string errmsg_3 = "Report predefined error code!";
  ret = error_message::ReportUserDefinedErrMsg("E10001", "%s", errmsg_3.c_str());
  EXPECT_EQ(ret, 0);
  const std::string errmsg_4 = "Report user defined invalid error code!";
  ret = error_message::ReportUserDefinedErrMsg("EU001", "%s", errmsg_4.c_str());
  EXPECT_EQ(ret, 0);
  auto err_msg = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err_msg, nullptr);
  auto error_message = std::string(err_msg.get());
  EXPECT_TRUE(error_message.find("EU0000") != std::string::npos);
  EXPECT_TRUE(error_message.find(errmsg_1) != std::string::npos);
  EXPECT_TRUE(error_message.find(errmsg_2) != std::string::npos);
  EXPECT_TRUE(error_message.find(errmsg_3) != std::string::npos);
  EXPECT_TRUE(error_message.find(errmsg_4) != std::string::npos);
}

TEST_F(UtestErrorManager, ReportUserDefinedErrMsg_Success) {
  const std::string errmsg = "Report user defined U error code!";
  auto ret = error_message::ReportUserDefinedErrMsg("EU0001", "%s", errmsg.c_str());
  EXPECT_EQ(ret, 0);
  auto err_msg = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err_msg, nullptr);
  auto error_message = std::string(err_msg.get());
  EXPECT_TRUE(error_message.find("EU0001") != std::string::npos);
  EXPECT_TRUE(error_message.find(errmsg) != std::string::npos);
}

TEST_F(UtestErrorManager, GetErrMgrRawErrorMessages_Success) {
  auto ret = error_message::ReportPredefinedErrMsg("E10001", {"value", "parameter", "reason"}, {"1", "2", "le 0"});
  EXPECT_EQ(ret, 0);
  auto error_message_item = error_message::GetErrMgrRawErrorMessages();
  EXPECT_EQ(error_message_item.empty(), false);
  EXPECT_NE(error_message_item[0].error_id, nullptr);
  EXPECT_NE(error_message_item[0].error_title, nullptr);
  EXPECT_NE(error_message_item[0].error_message, nullptr);
  EXPECT_NE(error_message_item[0].possible_cause, nullptr);
  EXPECT_NE(error_message_item[0].solution, nullptr);

  EXPECT_EQ(std::string(error_message_item[0].error_id.get()), "E10001");
  EXPECT_TRUE(std::string(error_message_item[0].error_title.get()).find("Invalid_Argument") != std::string::npos);
  EXPECT_TRUE(std::string(error_message_item[0].solution.get()).find("Try again with a valid argument") != std::string::npos);

  EXPECT_EQ(error_message_item[0].args_key.size(), 3);
  EXPECT_EQ(error_message_item[0].args_value.size(), 3);

  EXPECT_EQ(std::string(error_message_item[0].args_key[0].get()), "parameter");
  EXPECT_EQ(std::string(error_message_item[0].args_key[1].get()), "reason");
  EXPECT_EQ(std::string(error_message_item[0].args_key[2].get()), "value");

  EXPECT_EQ(std::string(error_message_item[0].args_value[0].get()), "2");
  EXPECT_EQ(std::string(error_message_item[0].args_value[1].get()), "le 0");
  EXPECT_EQ(std::string(error_message_item[0].args_value[2].get()), "1");

  EXPECT_TRUE(std::string(error_message_item[0].error_title.get()).find("Invalid_Argument") != std::string::npos);
  EXPECT_TRUE(std::string(error_message_item[0].error_title.get()).find("Invalid_Argument") != std::string::npos);
}


TEST_F(UtestErrorManager, ReportPredefinedErrMsg_Failed_vector_size_unequal) {
  auto ret = error_message::ReportPredefinedErrMsg("E10001", {"value", "parameter", "reason"}, {"", ""});
  EXPECT_EQ(ret, -1);
  auto err_msg = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err_msg, nullptr);
  EXPECT_TRUE(std::string(err_msg.get()).empty());
}

TEST_F(UtestErrorManager, ReportPredefinedErrMsg_Success) {
  auto ret = error_message::ReportPredefinedErrMsg("E10001", {"value", "parameter", "reason"}, {"1", "2", "le 0"});
  EXPECT_EQ(ret, 0);
  auto err_msg = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err_msg, nullptr);
  EXPECT_TRUE(std::string(err_msg.get()).find("E10001") != std::string::npos);
}

TEST_F(UtestErrorManager, ReportInnerErrMsg_Failed_MessageLengthExceedsLimits_1024) {
  REPORT_INNER_ERR_MSG("E18888", "errmsg:%s", std::string(1025U, 'a').c_str());
  EXPECT_TRUE(std::string(error_message::GetErrMgrErrorMessage().get()).empty());
}

TEST_F(UtestErrorManager, ReportInnerErrMsg_Success) {
  std::string errmsg = "Report Inner Err msg!";
  REPORT_INNER_ERR_MSG("E18888", "%s", errmsg.c_str());
  ge::ReportInnerErrMsg(__FILE__, __FUNCTION__, __LINE__, "E18888", "%s", errmsg.c_str());
  auto err_msg = error_message::GetErrMgrErrorMessage();
  EXPECT_NE(err_msg, nullptr);
  EXPECT_TRUE(std::string(err_msg.get()).find("E18888") != std::string::npos);
  EXPECT_TRUE(std::string(err_msg.get()).find(errmsg) != std::string::npos);
}

TEST_F(UtestErrorManager, RegisterFormatErrorMessage_Success_WithPriority) {
  std::string msg1 = R"(
{
  "error_info_list": [
    {
      "errClass": "GE Errors",
      "errTitle": "Invalid --singleop Argument",
      "ErrCode": "E10025",
      "ErrMessage": "File [%s] specified by [--singleop] is not a valid JSON file. Reason: %s",
      "Arglist": "realpath,errmsg",
      "suggestion": {
        "Possible Cause": "N/A",
        "Solution": "Test register priority."
      }
    }
  ]
}
)";
  EXPECT_EQ(error_message::RegisterFormatErrorMessage(msg1.c_str(), msg1.size()), 0);
  std::string errmsg = "Report Inner Err msg!";
  EXPECT_EQ(error_message::ReportPredefinedErrMsg("E10025", {"realpath", "errmsg"}, {"11", "22"}), 0);

  REPORT_PREDEFINED_ERR_MSG("E10025", std::vector<const char *>({"realpath", "errmsg"}), std::vector<const char *>({"11", "22"}));
  REPORT_PREDEFINED_ERR_MSG("E10025");
  auto err_msg = error_message::GetErrMgrErrorMessage();
  EXPECT_TRUE(std::string(err_msg.get()).find("Test register priority")!= std::string::npos);
}

TEST_F(UtestErrorManager, RegisterFormatErrorMessage_Failed) {
  // 没有按照json格式注册
  std::string msg1 = R"(
{
    123,
    "errClass": "GE Errors",
    "errTitle": "Invalid --singleop Argument",
    "ErrCode": "E10025",
    "ErrMessage": "File [%s] specified by [--singleop] is not a valid JSON file. Reason: %s",
    "Arglist": "realpath,errmsg",
    "suggestion": {
      "Possible Cause": "N/A",
      "Solution": "Check that the file is in valid JSON format."
    },
}
)";
  EXPECT_EQ(error_message::RegisterFormatErrorMessage(msg1.c_str(), msg1.size()), -1);
  // 没有error_info_list
  std::string msg2 = R"(
{
      "errClass": "GE Errors",
      "errTitle": "Invalid --singleop Argument",
      "ErrCode": "E10025",
      "ErrMessage": "File [%s] specified by [--singleop] is not a valid JSON file. Reason: %s",
      "Arglist": "realpath,errmsg",
      "suggestion": {
        "Possible Cause": "N/A",
        "Solution": "Check that the file is in valid JSON format."
      }
}
)";
  EXPECT_EQ(error_message::RegisterFormatErrorMessage(msg2.c_str(), msg2.size()), -1);
}

TEST_F(UtestErrorManager, GetSetErrorManagerContext) {
  auto ori_ctx = error_message::GetErrMgrContext();
  ori_ctx.work_stream_id = 11;
  error_message::SetErrMgrContext(ori_ctx);
  auto &instance = ErrorManager::GetInstance();
  EXPECT_EQ(instance.GetErrorManagerContext().work_stream_id, ori_ctx.work_stream_id);
  SetErrMgrContext(ori_ctx);
}

TEST_F(UtestErrorManager, ReportFormatErrorMessage_Success) {
  // 上报预定义错误码
  EXPECT_EQ(error_message::ReportPredefinedErrMsg("E10023", {"value"}, {"11"}), 0);
  std::string res(error_message::GetErrMgrErrorMessage().get());
  EXPECT_EQ(res.find("Invalid_Argument(E10023): ") != std::string::npos, true);
  // 上报预定义告警码
  EXPECT_EQ(error_message::ReportPredefinedErrMsg("W11002", {"filename", "opnames"}, {"test.json", "add_0_1"}), 0);
  res = error_message::GetErrMgrWarningMessage().get();
  EXPECT_EQ(res.find("Config_Error_Weight_Configuration(W11002): ") != std::string::npos, true);
  // 上报内部错误码
  std::string errmsg = "Report Inner Error messsage!";
  REPORT_INNER_ERR_MSG("E19999", "%s", errmsg.c_str());
  res = error_message::GetErrMgrErrorMessage().get();
  EXPECT_EQ(res.find("(E19999):") != std::string::npos, true);
  // 上报用户定义错误码
  errmsg = "Report user defined U error code!";
  auto ret = error_message::ReportUserDefinedErrMsg("EU0001", "%s", errmsg.c_str());
  EXPECT_EQ(ret, 0);
  res = error_message::GetErrMgrErrorMessage().get();
  EXPECT_EQ(res.find("(EU0001):") != std::string::npos, true);
}

class UtestErrorManagerUninitialized : public testing::Test {
 protected:
  void SetUp() {}
  void TearDown() {}
};

TEST_F(UtestErrorManagerUninitialized, IsUserDefinedErrorCode_Failed_uninitialized) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_FALSE(instance.is_init_);
  EXPECT_FALSE(instance.IsUserDefinedErrorCode("EU0001"));
}

TEST_F(UtestErrorManagerUninitialized, ReportUserDefinedErrMsg_Failed_uninitialized) {
  auto &instance = ErrorManager::GetInstance();
  EXPECT_FALSE(instance.is_init_);
  auto ret = error_message::ReportUserDefinedErrMsg("EU0001", "Report user defined error code!");
  EXPECT_EQ(ret, -1);
}
}
