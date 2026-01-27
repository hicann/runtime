/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include <stdio.h>      // 使用snprintf
#include <stdlib.h>     // 使用getenv
#include <fcntl.h>      // 使用文件权限
#include <memory.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#include <time.h>

#include "log_writer.h"

LogWriter::LogWriter() : m_FileIndex(0), m_FileHandle(-1)
{
    m_iLogSize        = 0;
    m_iHeadSize       = 0;
    m_lInterval       = 1;
    m_lLastTime       = time(NULL);
    m_szLogBuff[0]    = 0;
    m_Pid             = getpid();
    m_FilePath[0]     = 0;
    m_FilePrev[0]     = 0;
    m_FileName[0]     = 0;

    pthread_mutex_init(&m_Mutex, NULL);
}

LogWriter::~LogWriter()
{
    if (-1 != m_FileHandle)
    {
        close(m_FileHandle);
    }
}

void LogWriter::Init(const char *szPath, const char *szPrefix)
{
    snprintf(m_FilePath, PATH_MAX, "%s", szPath);
    snprintf(m_FilePrev, PATH_MAX, "%s", szPrefix);

    snprintf(m_FileName, PATH_MAX, "%s/%s_%u_%.2u.log", m_FilePath, m_FilePrev, m_Pid, m_FileIndex);
}

void LogWriter::Lock()
{
    pthread_mutex_lock(&m_Mutex);
}

void LogWriter::Unlock()
{
    pthread_mutex_unlock(&m_Mutex);
}

void LogWriter::addToBuffer(const char *pszBuff, pthread_t ulThreadId)
{
    Lock();

    time_t lNowTime = time(NULL);
    struct tm tmNowTime;
    localtime_r(&lNowTime, &tmNowTime);

    char szHead[Max_Head_Len];
    size_t iHead = snprintf(szHead, Max_Head_Len, "[%04d-%02d-%02d %02d:%02d:%02d][%lu]",
                            tmNowTime.tm_year + 1900, tmNowTime.tm_mon + 1, tmNowTime.tm_mday,
                            tmNowTime.tm_hour, tmNowTime.tm_min, tmNowTime.tm_sec,
                            ulThreadId);    //lint !e732

    // 如果不能添加则需要把已经存储的日志写入文件.
    size_t uiMsgLen = strlen(pszBuff);
    if (m_iLogSize + uiMsgLen + iHead >= Max_Buff_Size)
    {
        WriteToFile(m_szLogBuff + m_iHeadSize, m_iLogSize - m_iHeadSize);
        m_iLogSize = m_iHeadSize;
    }

    memcpy(m_szLogBuff + m_iLogSize, szHead, iHead);
    m_iLogSize += iHead;

    if ((0 == uiMsgLen) || (*(pszBuff + uiMsgLen - 1) != '\n'))
    {
        memcpy(m_szLogBuff + m_iLogSize, pszBuff, uiMsgLen);
        m_iLogSize += uiMsgLen;
        memcpy(m_szLogBuff + m_iLogSize, "\n", 1);
        m_iLogSize += 1;
    }
    else if((uiMsgLen >= 2) && ('\r' == *(pszBuff + uiMsgLen - 2)))
    {
        memcpy(m_szLogBuff + m_iLogSize, pszBuff, uiMsgLen - 2);
        m_iLogSize += uiMsgLen - 2;
        memcpy(m_szLogBuff + m_iLogSize, "\n", 1);
        m_iLogSize += 1;
    }
    else
    {
        memcpy(m_szLogBuff + m_iLogSize, pszBuff, uiMsgLen);
        m_iLogSize += uiMsgLen;
    }

    Unlock();
}

void LogWriter::WriteToFile(const char *szBuf, size_t uiLen)
{
    struct stat buf;
    if (-1 == stat(m_FilePath, &buf))
    {
        // mlog目录下文件不存在, 创建目录.
        mkdir(m_FilePath, S_IRWXU | S_IRWXG);
    }

    if (-1 == stat(m_FileName, &buf))
    {
        // 文件不存在.
        if (-1 != m_FileHandle)
        {
            close(m_FileHandle);
        }

        m_FileHandle = open(m_FileName, O_TRUNC | O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    }
    else if (-1 == m_FileHandle)
    {
        // 文件未打开.
        m_FileHandle = open(m_FileName, O_TRUNC | O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    }
    else if (buf.st_size >= 20 * 1024 * 1024)
    {
        // 文件已写满.
        close(m_FileHandle);

        // 删除备份文件.
        char szBackFile[PATH_MAX] = {0};
        snprintf(szBackFile, PATH_MAX, "%s/.%s_%u_%.2u.log", m_FilePath, m_FilePrev, m_Pid, m_FileIndex);
        remove(szBackFile);

        // 备份当前文件.
        rename(m_FileName, szBackFile);

        ++m_FileIndex;
        if (m_FileIndex >= 20)  // 最多存储20个文件(400M).
        {
            m_FileIndex = 0;
        }
        snprintf(m_FileName, PATH_MAX, "%s/%s_%u_%.2u.log", m_FilePath, m_FilePrev, m_Pid, m_FileIndex);

        // 开始写新文件.
        m_FileHandle = open(m_FileName, O_TRUNC | O_CREAT | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    }

    write(m_FileHandle, szBuf, uiLen);
}

void LogWriter::WriteLastLog()
{
    Lock();

    // 直接从iHeadSize出开始写
    if (m_iHeadSize != m_iLogSize)
    {
        WriteToFile(m_szLogBuff + m_iHeadSize, m_iLogSize - m_iHeadSize);
        m_iLogSize = m_iHeadSize;
    }

    fsync(m_FileHandle);

    Unlock();
}

void LogWriter::CheckWriteLog(time_t ulNowTime)
{
    Lock();

    if ((ulNowTime - m_lLastTime >= m_lInterval) || (m_iLogSize >= Max_Trace_Len) || (ulNowTime < m_lLastTime))
    {
        // 直接从iHeadSize出开始写
        if (m_iHeadSize != m_iLogSize)
        {
            WriteToFile(m_szLogBuff + m_iHeadSize, m_iLogSize - m_iHeadSize);
            m_iLogSize = m_iHeadSize;
        }

        m_lLastTime = ulNowTime;
    }

    fsync(m_FileHandle);

    Unlock();
}


std::mutex  LogThread::m_ImplMutex;
LogThread  *LogThread::m_Singleton = NULL;

LogThread::LogThread() : m_working(false)
{
}

LogThread::~LogThread()
{
    doFlush();

    if (m_working) {
        m_working = false;
        if (m_ImplThread.joinable()) {
            m_ImplThread.join();
        }
    }

    fprintf(stderr, "LogThread::~LogThread\n");
}

void LogThread::Init()
{
    char filePath[PATH_MAX] = {0};
    const char *pszWorkDir = getenv("WORK_DIR");
    if (NULL != pszWorkDir)
    {
        // 存在WORK_DIR创建专用目录输出日志.
        snprintf(filePath, PATH_MAX, "%s/mlog", pszWorkDir);
    }
    else
    {
        // 没有WORK_DIR直接输出到当前目录.
        getcwd(filePath, PATH_MAX);     // 不判断结果了, 爱咋咋地.
    }

    struct stat buf;
    if (-1 == stat(filePath, &buf))
    {
        // mlog目录下文件不存在, 创建目录.
        mkdir(filePath, S_IRUSR | S_IWUSR | S_IXUSR);
    }

    m_AllocBuff.Init(filePath, "log_tdt");
    m_ImplThread = std::thread(&LogThread::Worker, this);
}

void LogThread::Worker()
{
    m_working = true;
    while (m_working)
    {
        sleep(1);
        time_t now = time(NULL);
        m_AllocBuff.CheckWriteLog(now);
    }

    m_AllocBuff.WriteLastLog();
}

void LogThread::addDebugLog(int logLevel, int moduleId, const char *szInfo)
{
    if (!m_Singleton) {
        std::lock_guard<std::mutex> lock(m_ImplMutex);
        if (!m_Singleton) {
            m_Singleton = new LogThread();
            m_Singleton->Init();
        }
    }

    pthread_t ulThreadId = pthread_self();
    m_Singleton->m_AllocBuff.addToBuffer(szInfo, ulThreadId);
}

void LogThread::doFlush()
{
    m_AllocBuff.WriteLastLog();
}
