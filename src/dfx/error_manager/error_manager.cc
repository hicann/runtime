/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#include <fstream>
#include <iostream>
#include <mutex>
#include <nlohmann/json.hpp>
#include <sstream>
#include <securec.h>
#include "mmpa/mmpa_api.h"
#include "dlog_pub.h"
#include "base/err_msg.h"
#include "base/err_mgr.h"
#include "error_manager.h"

#define GE_MODULE_NAME static_cast<int32_t>(GE)

template<typename TI, typename TO>
inline TO *PtrToPtr(TI *const ptr) {
  return reinterpret_cast<TO *>(ptr);
}

template<typename TI, typename TO>
inline const TO *PtrToPtr(const TI *const ptr) {
  return reinterpret_cast<const TO *>(ptr);
}

namespace {
const std::string kParamCheckErrorSuffix = "8888";
class GeLog {
 public:
  static uint64_t GetTid() {
#ifdef __GNUC__
    thread_local static const uint64_t tid = static_cast<uint64_t>(syscall(__NR_gettid));
#else
    thread_local static const uint64_t tid = static_cast<uint64_t>(GetCurrentThreadId());
#endif
    return tid;
  }
};

inline bool IsLogEnable(const int32_t module_name, const int32_t log_level) {
  const int32_t enable = CheckLogLevel(module_name, log_level);
  // 1:enable, 0:disable
  return (enable == 1);
}

std::string CurrentTimeFormatStr() {
  std::string time_str;
  auto now = std::chrono::system_clock::now();
  auto milli_seconds = std::chrono::time_point_cast<std::chrono::milliseconds>(now);
  auto micro_seconds = std::chrono::time_point_cast<std::chrono::microseconds>(now);
  const auto now_t = std::chrono::system_clock::to_time_t(now);
  const std::tm *tm_now = std::localtime(&now_t);
  if (tm_now == nullptr) {
    return time_str;
  }

  constexpr int32_t year_base = 1900;
  constexpr size_t kMaxTimeLen = 128U;
  constexpr int64_t kOneThousandMs = 1000L;
  error_message::char_t format_time[kMaxTimeLen] = {};
  (void) snprintf_s(format_time, kMaxTimeLen, kMaxTimeLen - 1U, "%04d-%02d-%02d-%02d:%02d:%02d.%03ld.%03ld",
                    tm_now->tm_year + year_base, tm_now->tm_mon + 1, tm_now->tm_mday, tm_now->tm_hour, tm_now->tm_min,
                    tm_now->tm_sec, milli_seconds.time_since_epoch().count() % kOneThousandMs,
                    micro_seconds.time_since_epoch().count() % kOneThousandMs);
  time_str = format_time;
  return time_str;
}
}

#define GELOGE(fmt, ...) \
  do {                                                                                            \
    dlog_error(GE_MODULE_NAME, "%" PRIu64 " %s: %s" fmt, GeLog::GetTid(), &__FUNCTION__[0],       \
               ErrorManager::GetInstance().GetLogHeader().c_str(), ##__VA_ARGS__);                \
  } while (false)

#define GELOGW(fmt, ...)                                                                          \
  do {                                                                                            \
    if (IsLogEnable(GE_MODULE_NAME, DLOG_WARN)) {                                                 \
      dlog_warn(GE_MODULE_NAME, "%" PRIu64 " %s:" fmt, GeLog::GetTid(), &__FUNCTION__[0],         \
                ##__VA_ARGS__);                                                                   \
    }                                                                                             \
  } while (false)

#define GELOGI(fmt, ...)                                                                          \
  do {                                                                                            \
    if (IsLogEnable(GE_MODULE_NAME, DLOG_INFO)) {                                                 \
      dlog_info(GE_MODULE_NAME, "%" PRIu64 " %s:" fmt, GeLog::GetTid(), &__FUNCTION__[0],         \
                ##__VA_ARGS__);                                                                   \
    }                                                                                             \
  } while (false)

#define GELOGD(fmt, ...)                                                                           \
  do {                                                                                             \
    if (IsLogEnable(GE_MODULE_NAME, DLOG_DEBUG)) {                                                 \
      dlog_debug(GE_MODULE_NAME, "%" PRIu64 " %s:" fmt, GeLog::GetTid(), &__FUNCTION__[0],         \
                 ##__VA_ARGS__);                                                                   \
    }                                                                                              \
  } while (false)

namespace {
int32_t ReportInnerErrorMessage(const char *file_name, const char *func, uint32_t line, const char *error_code,
                                const char *format, va_list arg_list) {
  std::vector<char> buf(LIMIT_PER_MESSAGE, '\0');
  auto ret = vsprintf_s(buf.data(), LIMIT_PER_MESSAGE, format, arg_list);
  if (ret < 0) {
    GELOGE("[Check][Param] FormatErrorMessage failed, ret:%d, file:%s, line:%u", ret, file_name, line);
    return -1;
  }
  ret = sprintf_s(buf.data() + ret, LIMIT_PER_MESSAGE - static_cast<size_t>(ret), "[FUNC:%s][FILE:%s][LINE:%u]",
                  func, error_message::TrimPath(std::string(file_name)).c_str(), line);
  if (ret < 0) {
    GELOGE("[Check][Param] FormatErrorMessage failed, ret:%d, file:%s, line:%u", ret, file_name, line);
    return -1;
  }

  return ErrorManager::GetInstance().ReportInterErrMessage(error_code, std::string(buf.data()));
}

std::unique_ptr<error_message::char_t[]> CreateUniquePtrFromString(const std::string &str) {
  const size_t buf_size = str.empty() ? 1U : (str.size() + 1U);
  auto uni_ptr = std::make_unique<error_message::char_t[]>(buf_size);
  if (uni_ptr == nullptr) {
    return nullptr;
  }

  if (str.empty()) {
    uni_ptr[0U] = '\0';
  } else {
    // 当src size < dst size时，strncpy_s会在末尾str.size()位置添加'\0'
    if (strncpy_s(uni_ptr.get(), str.size() + 1, str.c_str(), str.size()) != EOK) {
      return nullptr;
    }
  }
  return uni_ptr;
}

void ClearMessageContainerByWorkId(std::map<uint64_t, std::vector<ErrorManager::ErrorItem>> &message_container,
                                   const uint64_t work_stream_id) {
  const std::map<uint64_t, std::vector<ErrorManager::ErrorItem>>::const_iterator err_iter =
      message_container.find(work_stream_id);
  if (err_iter != message_container.cend()) {
    (void) message_container.erase(err_iter);
  }
}

std::vector<ErrorManager::ErrorItem> &GetOrCreateMessageContainerByWorkId(
    std::map<uint64_t, std::vector<ErrorManager::ErrorItem>> &message_container, uint64_t work_id) {
  auto iter = message_container.find(work_id);
  if (iter == message_container.end()) {
    (void) message_container.emplace(work_id, std::vector<ErrorManager::ErrorItem>());
    iter = message_container.find(work_id);
  }
  return iter->second;
}
}  // namespace


namespace error_message {
// first stage
const std::string kInitialize   = "INIT";
const std::string kModelCompile = "COMP";
const std::string kModelLoad    = "LOAD";
const std::string kModelExecute = "EXEC";
const std::string kFinalize     = "FINAL";

// SecondStage
// INITIALIZE
const std::string kParser               = "PARSER";
const std::string kOpsProtoInit         = "OPS_PRO";
const std::string kSystemInit           = "SYS";
const std::string kEngineInit           = "ENGINE";
const std::string kOpsKernelInit        = "OPS_KER";
const std::string kOpsKernelBuilderInit = "OPS_KER_BLD";
// MODEL_COMPILE
const std::string kPrepareOptimize    = "PRE_OPT";
const std::string kOriginOptimize     = "ORI_OPT";
const std::string kSubGraphOptimize   = "SUB_OPT";
const std::string kMergeGraphOptimize = "MERGE_OPT";
const std::string kPreBuild           = "PRE_BLD";
const std::string kStreamAlloc        = "STM_ALLOC";
const std::string kMemoryAlloc        = "MEM_ALLOC";
const std::string kTaskGenerate       = "TASK_GEN";
// COMMON
const std::string kOther = "DEFAULT";

#ifdef __GNUC__
std::string TrimPath(const std::string &str) {
  if (str.find_last_of('/') != std::string::npos) {
    return str.substr(str.find_last_of('/') + 1U);
  }
  return str;
}
#else
std::string TrimPath(const std::string &str) {
  if (str.find_last_of('\\') != std::string::npos) {
    return str.substr(str.find_last_of('\\') + 1U);
  }
  return str;
}
#endif

int32_t FormatErrorMessage(char_t *str_dst, size_t dst_max, const char_t *format, ...) {
  int32_t ret;
  va_list arg_list;

  va_start(arg_list, format);
  ret = vsprintf_s(str_dst, dst_max, format, arg_list);
  (void)arg_list;
  va_end(arg_list);
  if (ret < 0) {
    GELOGE("[Check][Param] FormatErrorMessage failed, ret:%d, pattern:%s", ret, format);
  }
  return ret;
}

void ReportInnerError(const char_t *file_name, const char_t *func, uint32_t line, const std::string error_code,
                      const char_t *format, ...) {
  va_list arg_list;
  va_start(arg_list, format);
  (void)ReportInnerErrorMessage(file_name, func, line, error_code.c_str(), format, arg_list);
  va_end(arg_list);
  return;
}
}

namespace {
#ifdef __GNUC__
constexpr const error_message::char_t *const kErrorCodePath = "../conf/error_manager/error_code.json";
constexpr const error_message::char_t *const kSeparator = "/";
#else
const error_message::char_t *const kErrorCodePath = "..\\conf\\error_manager\\error_code.json";
const error_message::char_t *const kSeparator = "\\";
#endif

constexpr uint64_t kLength = 2UL;

void Ltrim(std::string &s) {
  (void) s.erase(s.begin(),
                 std::find_if(s.begin(),
                              s.end(),
                              [](const error_message::char_t c) -> bool {
                                return static_cast<bool>(std::isspace(static_cast<uint8_t>(c)) == 0);
                              }));
}

void Rtrim(std::string &s) {
  (void) s.erase(std::find_if(s.rbegin(),
                              s.rend(),
                              [](const error_message::char_t c) -> bool {
                                return static_cast<bool>(std::isspace(static_cast<uint8_t>(c)) == 0);
                              }).base(),
                 s.end());
}

/// @ingroup domi_common
/// @brief trim space
void Trim(std::string &s) {
    Rtrim(s);
    Ltrim(s);
}

///
/// @brief Obtain error manager self library path
/// @return store liberror_manager.so path
///
std::string GetSelfLibraryDir(void) {
  mmDlInfo dl_info{nullptr, nullptr, nullptr, nullptr, 0, 0, 0};
  if (mmDladdr(reinterpret_cast<void *>(GetSelfLibraryDir), &dl_info) != EN_OK) {
    const error_message::char_t *error = mmDlerror();
    error = (error == nullptr) ? "" : error;
    GELOGW("Failed to read the shared library file path! reason:%s", error);
    return std::string();
  } else {
    std::string so_path = dl_info.dli_fname;
    error_message::char_t path[MMPA_MAX_PATH] = {};
    if (so_path.length() >= static_cast<size_t>(MMPA_MAX_PATH)) {
      GELOGW("The shared library file path is too long!");
      return std::string();
    }
    if (mmRealPath(so_path.c_str(), &(path[0]), MMPA_MAX_PATH) != EN_OK) {
      GELOGW("Failed to get realpath of %s, reason:%s", so_path.c_str(), strerror(errno));
      return std::string();
    }

    so_path = &(path[0]);
    so_path = so_path.substr(0U, so_path.rfind(kSeparator) + 1U);
    return so_path;
  }
}

// split string
std::vector<std::string> SplitByDelim(const std::string &str, const error_message::char_t delim) {
  std::vector<std::string> elems;

  if (str.empty()) {
    elems.emplace_back("");
    return elems;
  }

  std::stringstream ss(str);
  std::string item;

  while (getline(ss, item, delim)) {
    Trim(item);
    elems.push_back(item);
  }
  const auto str_size = str.size();
  if ((str_size > 0U) && (str[str_size - 1U] == delim)) {
    elems.emplace_back("");
  }

  return elems;
}
}  // namespace


thread_local error_message::Context ErrorManager::error_context_ = {0UL, "", "", ""};

///
/// @brief Obtain ErrorManager instance
/// @return ErrorManager instance
///
ErrorManager &ErrorManager::GetInstance() {
  static ErrorManager instance;
  return instance;
}

///
/// @brief init
/// @param [in] path: current so path
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::Init(const std::string path) {
  const std::unique_lock<std::mutex> lck(mutex_);
  const std::string file_path = path + kErrorCodePath;
  GELOGI("Begin to init, path is %s", path.c_str());
  const int32_t ret = ParseJsonFile(file_path);
  if (ret != 0) {
    GELOGW("[Parse][File]Parse config file:%s failed", file_path.c_str());
    return -1;
  }
  is_init_ = true;
  return 0;
}

///
/// @brief init
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::Init() {
  return Init(GetSelfLibraryDir());
}

int32_t ErrorManager::Init(error_message::ErrorMsgMode error_mode) {
  if (error_mode >= error_message::ErrorMsgMode::ERR_MSG_MODE_MAX) {
    GELOGE("[Init][Error]error mode is invalid %u", error_mode);
    return -1;
  }
  error_mode_ = error_mode;
  return Init(GetSelfLibraryDir());
}

int32_t ErrorManager::ReportInterErrMessage(const std::string error_code, const std::string &error_msg) {
  std::string report_time = CurrentTimeFormatStr();
  constexpr uint64_t kMaxWorkSize = 1000UL;
  if (!is_init_) {
    const int32_t kRetInit = Init();
    if (kRetInit == -1) {
      GELOGI("ErrorManager has not been initialized, can't report error_message.");
      return -1;
    }
  }
  if (!IsInnerErrorCode(error_code)) {
    GELOGE("[Report][Error]error_code %s is not internal error code", error_code.c_str());
    return -1;
  }

  const std::unique_lock<std::mutex> lck(mutex_);
  if (error_context_.work_stream_id == 0UL) {
    if (error_message_per_work_id_.size() > kMaxWorkSize) {
      GELOGW("[Report][Error]error_code %s, error work_stream total size exceed %lu, skip record",
             error_code.c_str(), kMaxWorkSize);
      return -1;
    }
    GenWorkStreamIdDefault();
  }

  GELOGI("report error_message, error_code:%s, work_stream_id:%lu, error_mode:%u",
    error_code.c_str(), error_context_.work_stream_id, error_mode_);

  auto& error_messages = GetErrorMsgContainer(error_context_.work_stream_id);
  auto& warning_messages = GetWarningMsgContainer(error_context_.work_stream_id);

  if (error_messages.size() > kMaxWorkSize) {
    GELOGW("[Report][Error]error_code %s, error work_stream_id:%lu item size exceed %lu, skip record",
           error_code.c_str(), error_context_.work_stream_id, kMaxWorkSize);
    return -1;
  }

  std::string tmp = error_msg;
  if (error_mode_ == error_message::ErrorMsgMode::PROCESS_MODE) {
    tmp += "[THREAD:" + std::to_string(mmGetTid()) + "]";
  }

  ErrorManager::ErrorItem item = {error_code, "", tmp, "", "", {}, report_time};
  if (error_code[0UL] == 'W') {
    const auto it = find(warning_messages.begin(), warning_messages.end(), item);
    if (it == warning_messages.end()) {
      warning_messages.emplace_back(item);
    }
  } else {
    const auto it = find(error_messages.begin(), error_messages.end(), item);
    if (it == error_messages.end()) {
      error_messages.emplace_back(item);
    }
  }
  return 0;
}

///
/// @brief report error message
/// @param [in] error_code: error code
/// @param [in] args_map: parameter map
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::ReportErrMessage(const std::string error_code,
                                       const std::map<std::string, std::string> &args_map) {
  std::string report_time = CurrentTimeFormatStr();
  if (!is_init_) {
    const int32_t kRetInit = Init();
    if (kRetInit == -1) {
      GELOGI("ErrorManager has not been initialized, can't report error_message.");
      return 0;
    }
  }

  if (error_context_.work_stream_id == 0UL) {
    GenWorkStreamIdDefault();
  }

  GELOGI("report error_message, error_code:%s, work_stream_id:%lu, error_mode:%u.",
    error_code.c_str(), error_context_.work_stream_id, error_mode_);
  const std::map<std::string, ErrorManager::ErrorInfoConfig>::const_iterator iter = error_map_.find(error_code);
  if (iter == error_map_.cend()) {
    GELOGW("[Report][Warning]error_code %s is not registered", error_code.c_str());
    return -1;
  }
  const ErrorInfoConfig &error_info = iter->second;
  std::string error_message = error_info.error_message;
  for (const std::string &arg : error_info.arg_list) {
    if (arg.empty()) {
      GELOGI("arg is null");
      break;
    }
    const auto arg_it = args_map.find(arg);
    if (arg_it == args_map.end()) {
      GELOGE("[Report][Error]error_code: %s, arg %s does not exist in map", error_code.c_str(), arg.c_str());
      return -1;
    }
    const std::string &arg_value = arg_it->second;
    const auto index = error_message.find("%s");
    if (index == std::string::npos) {
      GELOGE("[Report][Error]error_code: %s, %s location in error_message is not found",
             error_code.c_str(), arg.c_str());
      return -1;
    }
    (void)error_message.replace(index, kLength, arg_value);
  }

  const std::unique_lock<std::mutex> lock(mutex_);
  auto &error_messages = GetErrorMsgContainer(error_context_.work_stream_id);
  auto &warning_messages = GetWarningMsgContainer(error_context_.work_stream_id);

  if (error_mode_ == error_message::ErrorMsgMode::PROCESS_MODE) {
    error_message += "[THREAD:" + std::to_string(mmGetTid()) + "]";
  }
  ErrorManager::ErrorItem error_item = {
      error_code, error_info.error_title, error_message, error_info.possible_cause, error_info.solution, args_map,
      report_time};
  if (error_code[0UL] == 'W') {
    const auto it = find(warning_messages.begin(), warning_messages.end(), error_item);
    if (it == warning_messages.end()) {
      warning_messages.emplace_back(error_item);
    }
  } else {
    const auto it = find(error_messages.begin(), error_messages.end(), error_item);
    if (it == error_messages.end()) {
      error_messages.emplace_back(error_item);
    }
  }
  return 0;
}

int32_t ErrorManager::ReportErrMsgWithoutTpl(const std::string &error_code, const std::string &errmsg) {
  std::string report_time = CurrentTimeFormatStr();
  if (!is_init_) {
    const auto ret = Init();
    if (ret == -1) {
      GELOGI("ErrorManager has not been initialized, can't report error_message.");
      return -1;
    }
  }

  if (error_context_.work_stream_id == 0UL) {
    GenWorkStreamIdDefault();
  }

  auto final_error_code = error_code;
  if (!IsUserDefinedErrorCode(final_error_code)) {
    GELOGW("[Report] Current error code is [%s], suggest using the recommended U segment. "
           "The error code EU0000 is reported!", final_error_code.c_str());
    final_error_code = "EU0000";
  }

  GELOGI("report error_message, error_code:%s, work_stream_id:%lu, error_mode:%u.",
         error_code.c_str(), error_context_.work_stream_id, error_mode_);

  const std::unique_lock<std::mutex> lock(mutex_);
  auto &error_messages = GetErrorMsgContainer(error_context_.work_stream_id);

  ErrorItem error_item{final_error_code, "", errmsg, "", "", {}, report_time};
  const auto it = find(error_messages.begin(), error_messages.end(), error_item);
  if (it == error_messages.end()) {
    error_messages.emplace_back(error_item);
  }
  return 0;
}

void ErrorManager::AssembleInnerErrorMessage(const std::vector<ErrorItem> &error_messages,
                                             const std::string &first_code,
                                             std::stringstream &err_stream) const {
  std::string current_code_print = first_code;
  const bool IsErrorId = IsParamCheckErrorId(first_code);
  for (auto &item : error_messages) {
    if (!IsParamCheckErrorId(item.error_id)) {
      current_code_print = item.error_id;
      break;
    }
  }
  err_stream << current_code_print << ": Inner Error!" << std::endl;
  bool print_traceback_once = false;
  for (auto &item : error_messages) { // Display the first non 8888 error code
    if (IsParamCheckErrorId(item.error_id) && IsErrorId) {
      err_stream << "        " << item.error_message << std::endl;
      continue;
    }
    current_code_print == "      "
        ? (err_stream << current_code_print << " " << item.error_message << std::endl)
        : (err_stream << current_code_print << "[PID: " << std::to_string(mmGetPid()) << "] " << item.report_time
                      << " " << item.error_title << "(" << item.error_id << "): "
                      << " " << item.error_message << std::endl);

    current_code_print = "      ";
    if (!print_traceback_once) {
      err_stream << "        TraceBack (most recent call last):" << std::endl;
      print_traceback_once = true;
    }
  }
}

std::string ErrorManager::GetErrorMessage() {
  const auto &error_messages = GetRawErrorMessages();
  if (error_messages.empty()) {
    return "";
  }

  std::stringstream err_stream;
  std::string first_code = error_messages[0UL].error_id;
  for (const auto &item : error_messages) {
    if (!IsInnerErrorCode(item.error_id)) {
      first_code = item.error_id;
      err_stream << "[PID: " << std::to_string(mmGetPid()) << "] " << item.report_time << " " << item.error_title << "("
                 << first_code << "): " << item.error_message << std::endl;
      if (!item.possible_cause.empty() && item.possible_cause != "N/A") {
        err_stream << "        Possible Cause: " << item.possible_cause << std::endl;
      }
      if (!item.solution.empty() && item.solution != "N/A") {
        err_stream << "        Solution: " << item.solution << std::endl;
      }
      break;
    }
  }
  if (IsInnerErrorCode(first_code)) {
    AssembleInnerErrorMessage(error_messages, first_code, err_stream);
  } else {
    bool print_traceback_once = false;
    for (const auto &item : error_messages) {
      if (first_code == item.error_id && error_messages[0].error_message == item.error_message) {
        continue;
      }
      if (!print_traceback_once) {
        err_stream << "        TraceBack (most recent call last):" << std::endl;
        print_traceback_once = true;
      }
      err_stream << "        " << item.error_message << std::endl;
    }
  }
  const std::unique_lock<std::mutex> lck(mutex_);
  ClearErrorMsgContainer(error_context_.work_stream_id);
  return err_stream.str();
}

std::string ErrorManager::GetWarningMessage() {
  GELOGI("current work_stream_id:%lu, error_mode:%u", error_context_.work_stream_id, error_mode_);
  const std::unique_lock<std::mutex> lck(mutex_);
  auto &warning_messages = GetWarningMsgContainer(error_context_.work_stream_id);

  std::stringstream warning_stream;
  for (auto &item : warning_messages) {
    warning_stream << "[PID: " << std::to_string(mmGetPid()) << "] " << item.report_time << " " << item.error_title
                   << "(" << item.error_id << "): " << item.error_message << std::endl;
  }
  ClearWarningMsgContainer(error_context_.work_stream_id);
  return warning_stream.str();
}

///
/// @brief output error message
/// @param [in] handle: print handle
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::OutputErrMessage(int32_t handle) {
  std::string err_msg = GetErrorMessage();
  if (err_msg.empty()) {
    std::stringstream err_stream;
    err_stream << "E19999: Inner Error!" << std::endl;
    err_stream << "        " << "Unknown error occurred. Please check the log." << std::endl;
    err_msg = err_stream.str();
  }

  if (handle <= fileno(stderr)) {
    std::cout << err_msg << std::endl;
  } else {
    const mmSsize_t ret =
        mmWrite(handle, const_cast<error_message::char_t *>(err_msg.c_str()), static_cast<uint32_t>(err_msg.length()));
    if (ret == -1) {
      GELOGE("[Write][File]fail, reason:%s",  strerror(errno));
      return -1;
    }
  }
  return 0;
}

///
/// @brief output message
/// @param [in] handle: print handle
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::OutputMessage(int32_t handle) {
  const std::string warning_msg = GetWarningMessage();
  std::cout << warning_msg << std::endl;
  handle = 0;
  return handle;
}

int32_t ErrorManager::ParseJsonFile(const std::string path) {
  GELOGD("Begin to parse json file, path is %s", path.c_str());
  nlohmann::json json_file;
  const int32_t status = ReadJsonFile(path, &json_file);
  if (status != 0) {
    GELOGW("[Read][JsonFile]file path is %s", path.c_str());
    return -1;
  }
  return ParseJsonFormatString(PtrToPtr<nlohmann::json, void>(&json_file));
}
///
/// @brief parse json file
/// @param [in] handle: json handle
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::ParseJsonFormatString(const void *const handle, uint32_t priority) {
  GELOGD("Begin to parse json string");
  try {
    const nlohmann::json *const json_file = PtrToPtr<void, nlohmann::json>(handle);
    if (json_file->find("error_info_list") == json_file->end()) {
      GELOGW("[Check][Config]The message of error_info_list is not found");
      return -1;
    }
    const nlohmann::json &error_list_json = json_file->at("error_info_list");
    if (error_list_json.is_null() || !error_list_json.is_array()) {
      GELOGW("[Check][Config]The message of error_info_list is not found or the message of error_info_list is not array");
      return -1;
    }
    for (const auto &error_json : error_list_json) {
      ErrorInfoConfig error_info;
      error_info.error_id = error_json["ErrCode"];
      error_info.error_message = error_json["ErrMessage"];
      if (error_json.contains("errTitle")) {
        error_info.error_title = error_json["errTitle"];
      }
      if (error_json.contains("suggestion")) {
        error_info.possible_cause = error_json["suggestion"]["Possible Cause"];
        error_info.solution = error_json["suggestion"]["Solution"];
      }
      error_info.arg_list = SplitByDelim(error_json["Arglist"], ',');
      error_info.priority = priority;
      auto it = error_map_.find(error_info.error_id);
      if (it == error_map_.cend()) {
        (void) error_map_.emplace(error_info.error_id, error_info);
        GELOGD("add error_code %s success", error_info.error_id.c_str());
      } else {
        if (it->second.priority < error_info.priority) {
          it->second = error_info;
          GELOGD("Update error_code %s success, current priority[%u] is greater than saved priority[%u]",
                 error_info.error_id.c_str(), priority, it->second.priority);
        } else {
          GELOGD("No need update error_code %s, due to current priority[%u] is less and equal than saved priority[%u]",
                 error_info.error_id.c_str(), priority, it->second.priority);
        }
      }
    }
  } catch (const nlohmann::json::exception &e) {
    GELOGW("[Parse][JsonFile]exception message: %s", e.what());
    return -1;
  }
  return 0;
}

///
/// @brief read json file
/// @param [in] file_path: json path
/// @param [in] handle:  print handle
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::ReadJsonFile(const std::string &file_path, void *const handle) {
  if (file_path.empty()) {
    GELOGW("[Read][JsonFile]path %s is not valid", file_path.c_str());
    return -1;
  }
  nlohmann::json *const json_file = PtrToPtr<void, nlohmann::json>(handle);
  if (json_file == nullptr) {
    GELOGW("[Check][Param]JsonFile is nullptr");
    return -1;
  }
  const error_message::char_t *const file = file_path.data();
  if ((mmAccess2(file, M_F_OK)) != EN_OK) {
    GELOGW("[Read][JsonFile] %s does not exist, error %s", file_path.c_str(), strerror(errno));
    return -1;
  }

  std::ifstream ifs(file_path);
  if (!ifs.is_open()) {
    GELOGW("[Read][JsonFile]Open %s failed", file_path.c_str());
    return -1;
  }

  try {
    ifs >> *json_file;
  } catch (const nlohmann::json::exception &e) {
    GELOGW("[Read][JsonFile]ifstream to json fail. path: %s, exception message: %s.", file_path.c_str(), e.what());
    ifs.close();
    return -1;
  }

  ifs.close();
  GELOGD("Read json file success");
  return 0;
}

///
/// @brief report error message
/// @param [in] error_code: error code
/// @param [in] vector parameter key, vector parameter value
/// @return int 0(success) -1(fail)
///
void ErrorManager::ATCReportErrMessage(const std::string error_code, const std::vector<std::string> &key,
                                       const std::vector<std::string> &value) {
  if (!is_init_) {
    const int32_t kRetInit = Init();
    if (kRetInit == -1) {
      GELOGI("ErrorManager has not been initialized, can't report error_message.");
      return;
    }
  }
  std::map<std::string, std::string> args_map;
  if (key.empty()) {
    (void)ErrorManager::GetInstance().ReportErrMessage(error_code, args_map);
  } else if (key.size() == value.size()) {
    for (size_t i = 0UL; i < key.size(); ++i) {
      (void)args_map.insert(std::make_pair(key[i], value[i]));
    }
    (void)ErrorManager::GetInstance().ReportErrMessage(error_code, args_map);
  } else {
    GELOGW("ATCReportErrMessage wrong, vector key and value size is not equal");
  }
}

///
/// @brief report graph compile failed message such as error code and op_name in mustune case
/// @param [in] msg: failed message map, key is error code, value is op_name
/// @param [out] classified_msg: classified_msg message map, key is error code, value is op_name vector
///
void ErrorManager::ClassifyCompileFailedMsg(const std::map<std::string, std::string> &msg,
                                            std::map<std::string,
                                            std::vector<std::string>> &classified_msg) {
  for (const auto &itr : msg) {
    GELOGD("msg is error_code:%s, op_name:%s", itr.first.c_str(), itr.second.c_str());
    const auto err_code_itr = classified_msg.find(itr.first);
    if (err_code_itr == classified_msg.end()) {
      (void)classified_msg.emplace(itr.first, std::vector<std::string>{itr.second});
    } else {
      std::vector<std::string> &op_name_list = err_code_itr->second;
      op_name_list.emplace_back(itr.second);
    }
  }
}

///
/// @brief report graph compile failed message such as error code and op_name in mustune case
/// @param [in] root_graph_name: root graph name
/// @param [in] msg: failed message map, key is error code, value is op_name
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::ReportMstuneCompileFailedMsg(const std::string &root_graph_name,
                                                   const std::map<std::string, std::string> &msg) {
  if (!is_init_) {
    const int32_t kRetInit = Init();
    if (kRetInit == -1) {
      GELOGI("ErrorManager has not been initialized, can't report error_message.");
      return 0;
    }
  }
  if (msg.empty() || root_graph_name.empty()) {
    GELOGW("Msg or root graph name is empty, msg size is %zu, root graph name is %s",
           msg.size(), root_graph_name.c_str());
    return -1;
  }
  GELOGD("Report graph:%s compile failed msg", root_graph_name.c_str());
  const std::unique_lock<std::mutex> lock(mutex_);
  const auto itr = compile_failed_msg_map_.find(root_graph_name);
  if (itr != compile_failed_msg_map_.end()) {
    std::map<std::string, std::vector<std::string>> &classified_msg = itr->second;
    ClassifyCompileFailedMsg(msg, classified_msg);
  } else {
    std::map<std::string, std::vector<std::string>> classified_msg;
    ClassifyCompileFailedMsg(msg, classified_msg);
    (void)compile_failed_msg_map_.emplace(root_graph_name, classified_msg);
  }
  return 0;
}

///
/// @brief get graph compile failed message in mustune case
/// @param [in] graph_name: graph name
/// @param [out] msg_map: failed message map, key is error code, value is op_name list
/// @return int 0(success) -1(fail)
///
int32_t ErrorManager::GetMstuneCompileFailedMsg(const std::string &graph_name, std::map<std::string,
                                            std::vector<std::string>> &msg_map) {
  if (!is_init_) {
    const int32_t kRetInit = Init();
    if (kRetInit == -1) {
      GELOGI("ErrorManager has not been initialized, can't report error_message.");
      return 0;
    }
  }
  if (!msg_map.empty()) {
    GELOGW("msg_map is not empty, exist msg");
    return -1;
  }
  const std::unique_lock<std::mutex> lock(mutex_);
  const auto iter = compile_failed_msg_map_.find(graph_name);
  if (iter == compile_failed_msg_map_.end()) {
    GELOGW("can not find graph, name is:%s", graph_name.c_str());
    return -1;
  } else {
    auto &compile_failed_msg = iter->second;
    msg_map.swap(compile_failed_msg);
    (void)compile_failed_msg_map_.erase(graph_name);
  }
  GELOGI("get graph:%s compile result msg success", graph_name.c_str());

  return 0;
}

std::vector<ErrorManager::ErrorItem> &ErrorManager::GetErrorMsgContainerByWorkId(uint64_t work_id) {
  return GetOrCreateMessageContainerByWorkId(error_message_per_work_id_, work_id);
}

std::vector<ErrorManager::ErrorItem> &ErrorManager::GetWarningMsgContainerByWorkId(uint64_t work_id) {
  return GetOrCreateMessageContainerByWorkId(warning_messages_per_work_id_, work_id);
}

std::vector<ErrorManager::ErrorItem> &ErrorManager::GetErrorMsgContainer(uint64_t work_stream_id) {
  return (error_mode_ == error_message::ErrorMsgMode::INTERNAL_MODE) ?
    GetErrorMsgContainerByWorkId(work_stream_id) : error_message_process_;
}

std::vector<ErrorManager::ErrorItem> &ErrorManager::GetWarningMsgContainer(uint64_t work_stream_id) {
  return (error_mode_ == error_message::ErrorMsgMode::INTERNAL_MODE) ?
    GetWarningMsgContainerByWorkId(work_stream_id) : warning_messages_process_;
}

void ErrorManager::GenWorkStreamIdDefault() {
  // system getpid and gettid is always successful
  const int32_t pid = mmGetPid();
  const int32_t tid = mmGetTid();

  constexpr uint64_t kPidOffset = 100000UL;
  const uint64_t work_stream_id = static_cast<uint64_t>(static_cast<uint32_t>(pid) * kPidOffset) +
      static_cast<uint64_t>(tid);
  error_context_.work_stream_id = work_stream_id;
}

void ErrorManager::GenWorkStreamIdBySessionGraph(const uint64_t session_id, const uint64_t graph_id) {
  constexpr uint64_t kSessionIdOffset = 100000UL;
  const uint64_t work_stream_id = (session_id * kSessionIdOffset) + graph_id;
  error_context_.work_stream_id = work_stream_id;

  const std::unique_lock<std::mutex> lck(mutex_);
  ClearErrorMsgContainerByWorkId(work_stream_id);
  ClearWarningMsgContainerByWorkId(work_stream_id);
}

void ErrorManager::GenWorkStreamIdWithSessionIdGraphId(const uint64_t session_id, const uint64_t graph_id) {
  constexpr uint64_t kSessionIdOffset = 100000UL;
  const uint64_t work_stream_id = (session_id * kSessionIdOffset) + graph_id;
  error_context_.work_stream_id = work_stream_id;
}

void ErrorManager::ClearErrorMsgContainerByWorkId(const uint64_t work_stream_id) {
  return ClearMessageContainerByWorkId(error_message_per_work_id_, work_stream_id);
}

void ErrorManager::ClearWarningMsgContainerByWorkId(const uint64_t work_stream_id) {
  return ClearMessageContainerByWorkId(warning_messages_per_work_id_, work_stream_id);
}

void ErrorManager::ClearErrorMsgContainer(const uint64_t work_stream_id) {
  if (error_mode_ == error_message::ErrorMsgMode::PROCESS_MODE) {
    error_message_process_.clear();
  } else {
    ClearErrorMsgContainerByWorkId(work_stream_id);
  }
}

void ErrorManager::ClearWarningMsgContainer(const uint64_t work_stream_id) {
  if (error_mode_ == error_message::ErrorMsgMode::PROCESS_MODE) {
    warning_messages_process_.clear();
  } else {
    ClearWarningMsgContainerByWorkId(work_stream_id);
  }
}

const std::string &ErrorManager::GetLogHeader() {
  if ((error_context_.first_stage == "") && (error_context_.second_stage == "")) {
    error_context_.log_header = "";
  } else {
    error_context_.log_header = "[" + error_context_.first_stage + "][" + error_context_.second_stage + "]";
  }
  return error_context_.log_header;
}

error_message::Context &ErrorManager::GetErrorManagerContext() {
  // son thread need set father thread work_stream_id, but work_stream_id cannot be zero
  // so GenWorkStreamIdDefault here directly
  if (error_context_.work_stream_id == 0UL) {
    GenWorkStreamIdDefault();
  }
  return error_context_;
}

void ErrorManager::SetErrorContext(error_message::Context error_context) {
  error_context_.work_stream_id = error_context.work_stream_id;
  error_context_.first_stage = std::move(error_context.first_stage);
  error_context_.second_stage = std::move(error_context.second_stage);
  error_context_.log_header = std::move(error_context.log_header);
}

void ErrorManager::SetStage(const std::string &first_stage, const std::string &second_stage) {
  error_context_.first_stage = first_stage;
  error_context_.second_stage = second_stage;
}

bool ErrorManager::IsInnerErrorCode(const std::string &error_code) const {
  const std::string kInterErrorCodePrefix = "9999";
  if (!IsValidErrorCode(error_code)) {
    return false;
  } else {
    return (error_code.substr(2U, 4U) == kInterErrorCodePrefix) || IsParamCheckErrorId(error_code);
  }
}

// 这里只做简单校验, 校验是非内部错误码、非预定义错误码的6位字符串即可
bool ErrorManager::IsUserDefinedErrorCode(const std::string &error_code) {
  if (!IsValidErrorCode(error_code) || IsInnerErrorCode(error_code)) {
    return false;
  }

  if (!is_init_) {
    const auto ret = Init();
    if (ret == -1) {
      GELOGI("ErrorManager has not been initialized, can't verify error code.");
      return false;
    }
  }

  if (error_map_.find(error_code) != error_map_.end()) {
    GELOGW("Report error_code:[%s] is predefined error code, suggested use U error code", error_code.c_str());
    return false;
  }
  return true;
}

bool ErrorManager::IsParamCheckErrorId(const std::string &error_code) const {
  return (error_code.substr(2U, 4U) == kParamCheckErrorSuffix);
}

int32_t ErrorManager::SetRawErrorMessages(const std::vector<ErrorItem> &items) {
  const std::unique_lock<std::mutex> lck(mutex_);
  if (error_context_.work_stream_id == 0UL) {
    GenWorkStreamIdDefault();
  }

  GELOGI("Set error_message, work_stream_id:%lu.", error_context_.work_stream_id);
  auto &error_messages = GetErrorMsgContainer(error_context_.work_stream_id);
  (void)error_messages.insert(error_messages.end(), items.begin(), items.end());
  return 0;
}

std::vector<error_message::ErrorItem> ErrorManager::GetRawErrorMessages() {
  GELOGI("current work_stream_id:%lu", error_context_.work_stream_id);
  const std::unique_lock<std::mutex> lck(mutex_);
  auto error_items = GetErrorMsgContainer(error_context_.work_stream_id);
  ClearErrorMsgContainer(error_context_.work_stream_id);
  return error_items;
}

namespace error_message {
int32_t RegisterFormatErrorMessage(const char_t *error_msg, size_t error_msg_len) {
  nlohmann::json j;
  try {
    j = nlohmann::json::parse(error_msg, error_msg + error_msg_len);
  } catch (const nlohmann::json::parse_error& e) {
    return -1;
  }
  GELOGI("RegisterFormatErrorMessage, try to register error message");
  // User registration error codes have high priority than those defined in the json file, 
  // set priority to 1 here.
  return ErrorManager::GetInstance().ParseJsonFormatString(PtrToPtr<nlohmann::json, void>(&j), 1);
}

int32_t ReportInnerErrMsg(const char *file_name, const char *func, uint32_t line, const char *error_code,
                          const char *format, ...) {
  va_list arg_list;
  va_start(arg_list, format);
  const auto ret = ReportInnerErrorMessage(file_name, func, line, error_code, format, arg_list);
  va_end(arg_list);
  return ret;
}

int32_t ReportUserDefinedErrMsg(const char *error_code, const char *format, ...) {
  va_list arg_list;
  std::vector<char> buf(LIMIT_PER_MESSAGE, '\0');
  va_start(arg_list, format);
  const auto ret = vsprintf_s(buf.data(), LIMIT_PER_MESSAGE, format, arg_list);
  if (ret < 0) {
    GELOGE("[Check][Param] Format error message failed, ret:%d", ret);
    return -1;
  }

  return ErrorManager::GetInstance().ReportErrMsgWithoutTpl(error_code, std::string(buf.data()));
}

int32_t ReportPredefinedErrMsg(const char *error_code, const std::vector<const char *> &key,
                               const std::vector<const char *> &value) {
  if (key.size() != value.size()) {
    GELOGE("[Check][Param] ReportPredefinedErrMsg failed, vector key size:[%zu] and value size:[%zu] is not equal",
           key.size(), value.size());
    return -1;
  }
  std::map<std::string, std::string> args_map;
  for (size_t i = 0UL; i < key.size(); ++i) {
    (void)args_map.insert(std::make_pair(key[i], value[i]));
  }
  return ErrorManager::GetInstance().ReportErrMessage(error_code, args_map);
}

int32_t ReportPredefinedErrMsg(const char *error_code) {
  return ReportPredefinedErrMsg(error_code, {}, {});
}

int32_t ErrMgrInit(ErrorMessageMode error_mode) {
  return ErrorManager::GetInstance().Init(static_cast<error_message::ErrorMsgMode>(error_mode));
}

ErrorManagerContext GetErrMgrContext() {
  auto ctx = ErrorManager::GetInstance().GetErrorManagerContext();
  ErrorManagerContext error_context{};
  error_context.work_stream_id = ctx.work_stream_id;
  return error_context;
}

void SetErrMgrContext(ErrorManagerContext error_context) {
  Context ctx;
  ctx.work_stream_id = error_context.work_stream_id;
  return ErrorManager::GetInstance().SetErrorContext(ctx);
}

unique_const_char_array GetErrMgrErrorMessage() {
  return CreateUniquePtrFromString(ErrorManager::GetInstance().GetErrorMessage());
}

unique_const_char_array GetErrMgrWarningMessage() {
  return CreateUniquePtrFromString(ErrorManager::GetInstance().GetWarningMessage());
}

std::vector<ErrMsgRawItem> GetErrMgrRawErrorMessages() {
  std::vector<ErrMsgRawItem> raw_items;
  auto error_items = ErrorManager::GetInstance().GetRawErrorMessages();
  for (const auto &item : error_items) {
    ErrMsgRawItem raw_item;
    raw_item.error_id = CreateUniquePtrFromString(item.error_id);
    raw_item.error_title = CreateUniquePtrFromString(item.error_title);
    raw_item.error_message = CreateUniquePtrFromString(item.error_message);
    raw_item.possible_cause = CreateUniquePtrFromString(item.possible_cause);
    raw_item.solution = CreateUniquePtrFromString(item.solution);
    for (const auto &arg : item.args_map) {
      raw_item.args_key.emplace_back(CreateUniquePtrFromString(arg.first));
      raw_item.args_value.emplace_back(CreateUniquePtrFromString(arg.second));
    }
    raw_item.report_time = CreateUniquePtrFromString(item.report_time);
    raw_items.emplace_back(std::move(raw_item));
  }
  return raw_items;
}
}  // namespace error_message
