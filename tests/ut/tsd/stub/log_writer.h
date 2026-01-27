/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#ifndef __INC_LOG_WRITER_HPP
#define __INC_LOG_WRITER_HPP

#include <linux/limits.h>   // for PATH_MAX

#include <mutex>
#include <thread>
#include <atomic>

// 日志输出类型定义
#define ELOG_ALLOC          0
#define ELOG_STACK          1

#define Max_Head_Len        64
#define Max_Buff_Size       (50 * 1024)
#define Max_Trace_Len       4096

class LogWriter
{
public:
                        LogWriter();
                        ~LogWriter();

    void                Init(const char *szPath, const char *szPrefix);

    void                addToBuffer(const char *pszBuff, pthread_t ulThreadId);
    void                CheckWriteLog(time_t ulNowTime);
    void                WriteLastLog();

private:
    void                Lock();
    void                Unlock();
    void                WriteToFile(const char *szBuf, size_t uiLen);

private:
    char                m_szLogBuff[Max_Buff_Size + 1];
    size_t              m_iLogSize;
    size_t              m_iHeadSize;

    time_t              m_lLastTime;
    time_t              m_lInterval;

    pthread_mutex_t     m_Mutex;

private:
    pid_t               m_Pid;
    char                m_FilePath[PATH_MAX];
    char                m_FilePrev[PATH_MAX];
    char                m_FileName[PATH_MAX];
    unsigned int        m_FileIndex;
    int                 m_FileHandle;
};

class LogThread
{
public:
    static void         addDebugLog(int logLevel, int moduleId, const char *szInfo);

private:
                        LogThread();
    virtual             ~LogThread();

    void                Init();
    void                doFlush();
    void                Worker();

private:
    static std::mutex   m_ImplMutex;
    static LogThread   *m_Singleton;
    std::thread         m_ImplThread;
    std::atomic_bool    m_working;
    LogWriter           m_AllocBuff;
};

#endif /*__INC_LOG_WRITER_HPP*/
