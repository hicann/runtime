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
#include <mockcpp/mockcpp.hpp>
#include <mockcpp/ChainingMockHelper.h>
#include <gtest/gtest_pred_impl.h>

#include <arpa/inet.h>
#include <netinet/in.h>
#include "mmpa_api.h"


#ifdef __cplusplus
#if    __cplusplus
extern "C"{
#endif /* __cpluscplus */
#endif /* __cpluscplus */

mmCond   cond;
mmMutexFC  mtxfc;
int socketFlag = 0;
INT32 pollFlag = 0;
int pipeFlag = 0;
int namedpipeFlag = 0;
#define BUFFER 255
#define PERM S_IREAD | S_IWRITE
char g_tmpStr[BUFFER+1] = "hello msg queue!";
mmKey_t g_key = 0x12121212;
mmThreadKey g_thread_log_key;

struct msgtype
{
    long mtype;
    char buffer[BUFFER+1];
};

int utFilter(const struct dirent *entry)
{
    return entry->d_name[0] == 't';
}

void signal_action(int arg)
{
   printf("Receive the shutdown singal\n");
}

void *thread_action(void* arg)
{
    printf("install the signal slot\n");
    signal(SIGINT,signal_action);

	while(1)
    {
        sleep(1);
    }
}

VOID *tlsTestThread1(VOID *p)
{
    char *ptrResult= NULL;
    mmThreadKey keyTmp = 121212;
    char thread_log_filename[20];
    sprintf_s(thread_log_filename, sizeof(thread_log_filename), "tlsTestThread%d.log", 1);

    mmTlsSet(keyTmp, thread_log_filename);
    ptrResult = (char*)mmTlsGet(keyTmp);

    mmTlsSet(g_thread_log_key, thread_log_filename);

    ptrResult = (char*)mmTlsGet(g_thread_log_key);
    if(ptrResult)
    {
        printf("thread1 result is %s\n",ptrResult);
    }

    return NULL;
}

VOID *tlsTestThread2(VOID *p)
{
    char thread_log_filename[20];
    char *ptrResult= NULL;
    sprintf_s(thread_log_filename, sizeof(thread_log_filename), "tlsTestThread%d.log", 2);

    mmTlsSet(g_thread_log_key, thread_log_filename);

    ptrResult = (char*)mmTlsGet(g_thread_log_key);
    if(ptrResult)
    {
        printf("thread2 result is %s\n",ptrResult);
    }

    return NULL;
}

VOID* msgqueue_server(VOID* p)
{
    struct msgtype msg;
    mmMsgid msgid;

    if((msgid = mmMsgCreate(g_key, PERM|M_MSG_CREAT)) == (mmMsgid)EN_ERROR)
    {
        fprintf(stderr,"Creat Message Error??%s\a\n",strerror(errno));
        return NULL;
    }
    msg.mtype = 1;
    strncpy_s(msg.buffer, sizeof(msg.buffer), g_tmpStr, BUFFER);
    printf("server:start mmMsgSnd\n");
    mmMsgSnd(msgid, NULL, 0, M_MSG_NOWAIT);
    mmMsgSnd(msgid, &msg, sizeof(struct msgtype), M_MSG_NOWAIT);
    sleep(2);
    mmMsgClose(msgid);
    return NULL;
}

VOID* msgqueue_client(VOID* p)
{
    struct msgtype msg;
    mmMsgid msgid;

    if ((msgid = mmMsgOpen(g_key, PERM|M_MSG_CREAT)) == (mmMsgid)EN_ERROR)
    {
        fprintf(stderr, "Creat Message Error??%s\a\n", strerror(errno));
        return NULL;
    }
    msg.mtype = 0;
    mmMsgRcv(msgid,NULL,sizeof(struct msgtype),0);
    mmMsgRcv(msgid,&msg,sizeof(struct msgtype),0);

    printf("client:recv msg:%s\n",msg.buffer);
    mmMsgClose(msgid);
    return NULL;
}


INT32 getIdleSocketid()
{
    for(INT32 i=50000;i<=55000;i++)
    {
        CHAR port[50];
        sprintf_s(port,sizeof(port),"netstat -np| grep -v STREAM | grep %d",i);
        INT32 ret=system(port);
	if(0 != ret)
	{
	    printf("i=%d\n",i);
	    return i;
        }
    }
}

void pollDataCallback(pmmPollData pPolledData)
{
    if (pPolledData == NULL || pPolledData->buf == NULL || pPolledData->bufRes <= 0)
    {
        printf("pPolledData is NULL\n");
        return;
    }
    printf("pPolledData->buf is %s\n",pPolledData->buf);
    printf("pPolledData->bufRes is %d\n",pPolledData->bufRes);

    switch (pPolledData->bufType)
    {
        case pollTypeIoctl:
            printf("pPolledData->bufType is %d\n",pPolledData->bufType);
            break;
        case pollTypeRead:
            printf("pPolledData->bufType is %d\n",pPolledData->bufType);
            break;
        case pollTypeRecv:
            printf("pPolledData->bufType is %d\n",pPolledData->bufType);
            break;
    }
}

VOID* UTtest_callback(VOID * pstArg)
{
    printf("UTtest_callback run success\n");
    char threadName[MMPA_THREADNAME_SIZE] = "UTCALLBACK";
    char getName[MMPA_THREADNAME_SIZE] = {};
    (void)mmSetCurrentThreadName(threadName);
    (void)mmGetCurrentThreadName(getName,MMPA_THREADNAME_SIZE);
    printf("mmGetCurrentThreadName name is %s\n",getName);
    mmSleep(100);
    return NULL;

}

VOID* poll_server_pipe(VOID* p)
{
    char *fifo_name[MMPA_PIPE_COUNT] = {"../tests/ut/mmpa/ut_readfifo","../tests/ut/mmpa/ut_writefifo"};

    int res = 0;
    const int mode = 0;

    mmPipeHandle pipe[MMPA_PIPE_COUNT];
    res = mmCreateNamedPipe(pipe,fifo_name,mode);
    pipeFlag = 1;

    if(res != -1 || pipe[0] != 0)
    {
        mmPollfd fds[10];
        memset_s(fds, sizeof(fds), 0, sizeof(fds));
        fds[0].handle = pipe[0];
        fds[0].pollType = pollTypeRead;

        mmPollData polledData;
        memset_s(&polledData,sizeof(mmPollData),0,sizeof(mmPollData));
        char buf[1024] = {0};
        polledData.buf = buf;
        polledData.bufLen = 1024;
        mmCompletionHandle handleIOCP = mmCreateCompletionPort();
        while(1)
        {
            INT32 bResult = mmPoll(fds, 1, 5000, handleIOCP, &polledData, pollDataCallback);
            if(bResult < 0)
            {
                printf("mmPoll return,fd is closed!\n");
                break;
            }

            polledData.bufLen = 0;
        }
        polledData.bufLen = 1024;
        while(1)
        {
            INT32 bResult = mmPoll(fds, 1, 100000, handleIOCP, &polledData, pollDataCallback);
            if(bResult < 0)
            {
                printf("mmPoll return,fd is closed!\n");
                break;
            }


        }
        mmCloseNamedPipe(pipe);
    }
    return NULL;

}

VOID* poll_client_pipe(VOID* p)
{
    char *fifo_name[MMPA_PIPE_COUNT] = {"../tests/ut/mmpa/ut_readfifo","../tests/ut/mmpa/ut_writefifo"};

    int res = 0;
    const int mode = 0;
    char buffer[PIPE_BUF + 1];
    memset_s(buffer, sizeof(buffer), '\0', sizeof(buffer));
    mmPipeHandle pipe[MMPA_PIPE_COUNT];

    while(true)
    {
        if (0 != pipeFlag)
        {
            res = mmOpenNamePipe(pipe,fifo_name, mode);
            break;
        }
    }

    if(res != -1)
    {
        snprintf_s(buffer,sizeof(buffer),64,"the message :hello pipe!");
        res = write(pipe[0], buffer, strlen(buffer));
        if(res == -1)
        {
            fprintf(stderr, "Write error on pipe\n");
            return NULL;
        }
        sleep(2);
        res = write(pipe[0], buffer, strlen(buffer));
        if(res == -1)
        {
            fprintf(stderr, "Write error on pipe\n");
            return NULL;
        }
        sleep(2);
        res = write(pipe[0], buffer, strlen(buffer));
        if(res == -1)
        {
            fprintf(stderr, "Write error on pipe\n");
            return NULL;
        }
        mmCloseNamedPipe(pipe);
        unlink(fifo_name[0]);
        unlink(fifo_name[1]);
    }

    return NULL;
}

VOID* poll_server_namepipe(VOID* p)
{
    char *fifo_name[MMPA_PIPE_COUNT] = {"../tests/ut/mmpa/readpipe","../tests/ut/mmpa/writepipe"};

    int res = 0;
    const int mode = 0;
    int bytes_sent = 0;
    char buffer[64] = {};

    unlink(fifo_name[0]);
    unlink(fifo_name[1]);

    mmPipeHandle pipe[MMPA_PIPE_COUNT] = {0};
    res = mmCreatePipe(pipe,fifo_name,MMPA_PIPE_COUNT,mode);
    if(res == 0) {
        printf("mmCreatePipe success\n");
        namedpipeFlag = 1;
    } else {
        printf("mmCreatePipe failed\n");
        return NULL;
    }
    if(res != -1 && pipe[0] > 0)
    {
        mmPollfd fds[10];
        memset_s(fds, sizeof(fds), 0, sizeof(fds));
        fds[0].handle = pipe[0];
        fds[0].pollType = pollTypeRead;

        mmPollData polledData;
        memset_s(&polledData,sizeof(mmPollData),0,sizeof(mmPollData));
        char buf[1024] = {0};
        polledData.buf = buf;
        polledData.bufLen = 1024;
        INT32 bResult = 0;
        mmCompletionHandle handleIOCP = mmCreateCompletionPort();
        while(1)
        {
            INT32 bResult = mmPoll(fds, 1, 5000, handleIOCP, &polledData, pollDataCallback);
            if(bResult < 0)
            {
                printf("mmPoll return,fd is closed!\n");
                break;
            }

            polledData.bufLen = 0;
        }
        polledData.bufLen = 1024;
        while(1)
        {
            INT32 bResult = mmPoll(fds, 1, 10000, handleIOCP, &polledData, pollDataCallback);
            if(bResult < 0)
            {
                printf("mmPoll return,fd is closed!\n");
                break;
            }
        }
        mmClosePipe(pipe,MMPA_PIPE_COUNT);
    }
    return NULL;

}

VOID* poll_client_namepipe(VOID* p)
{
    char *fifo_name[MMPA_PIPE_COUNT] = {"../tests/ut/mmpa/readpipe","../tests/ut/mmpa/writepipe"};
    int count = 5;
    int res = 0;
    const int mode = 0;
    char buffer[PIPE_BUF + 1];
    memset_s(buffer, sizeof(buffer), '\0', sizeof(buffer));
    mmPipeHandle pipe[MMPA_PIPE_COUNT] = {0};

    while(count--)
    {
        if (0 != namedpipeFlag)
        {
            res = mmOpenPipe(pipe,fifo_name,MMPA_PIPE_COUNT, mode);
            if(res == 0){
                printf("mmOpenPipe success\n");
                break;
            }
        }
        sleep(1);
    }

    if(res != -1)
    {
        snprintf_s(buffer,sizeof(buffer),64,"the message :hello namepipe!");
        res = write(pipe[0], buffer, strlen(buffer));
        if(res == -1)
        {
            fprintf(stderr, "Write error on pipe\n");
            return NULL;
        }
        sleep(2);
        res = write(pipe[0], buffer, strlen(buffer));
        if(res == -1)
        {
            fprintf(stderr, "Write error on pipe\n");
            return NULL;
        }
        sleep(2);
        res = write(pipe[0], buffer, strlen(buffer));
        if(res == -1)
        {
            fprintf(stderr, "Write error on pipe\n");
            return NULL;
        }
        mmClosePipe(pipe,MMPA_PIPE_COUNT);
        unlink(fifo_name[0]);
        unlink(fifo_name[1]);
    }

    return NULL;
}

VOID* poll_server_socket(VOID* p)
{
    mmSockHandle listenfd, connfd;
    struct sockaddr_in serv_add;
    mmSocklen_t stAddrLen = sizeof(serv_add);
    char recvMsg[50] = {0};
    INT32 recvResult = 0;

    listenfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    memset_s(&serv_add, sizeof(serv_add), '0', sizeof(serv_add));

    serv_add.sin_family = AF_INET;
    serv_add.sin_addr.s_addr = 0;
    serv_add.sin_port = htons(*(INT32 *)p);

    mmBind(listenfd, (mmSockAddr*)&serv_add, stAddrLen);
    mmListen(listenfd, 5);
    pollFlag = 1;
    while (true)
    {
        connfd = mmAccept(listenfd, (mmSockAddr*)NULL, NULL);
        if (connfd >= 0)
        {
            mmPollfd fds[10];
            memset_s(fds, sizeof(fds), 0, sizeof(fds));
            fds[0].handle = connfd;
            fds[0].pollType = pollTypeRecv;

            mmPollData polledData;
            memset_s(&polledData,sizeof(mmPollData),0,sizeof(mmPollData));
            char buf[1024] = {0};
            polledData.buf = buf;
            polledData.bufLen = 1024;
            INT32 bResult = 0;
            mmCompletionHandle handleIOCP = mmCreateCompletionPort();
            while(true)
            {
                INT32 bResult = mmPoll(fds, 1, 10000, handleIOCP, &polledData, pollDataCallback);
                if(bResult < 0)
                {
                    printf("mmPoll return,fd is closed!\n");
                    break;
                }
            }

            mmCloseCompletionPort(handleIOCP);

            sleep(1);
            mmCloseSocket(connfd);
            break;
        }
    }
    mmCloseSocket(listenfd);
    return NULL;
}

VOID* poll_client_socket(VOID* p)
{
    mmSockHandle sockfd;
    struct sockaddr_in serv_add;
    CHAR sendMsg[50] = {"hello.mmpa!"};
    INT32 sendResult = 0;

    memset_s(&serv_add, sizeof(serv_add), '0', sizeof(serv_add));
    serv_add.sin_family = AF_INET;
    inet_aton("127.0.0.1", (struct in_addr *)&serv_add.sin_addr);
    serv_add.sin_port = htons(*(INT32 *)p);

    sockfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    while (true)
    {
        if (0 != pollFlag)
        {
            mmConnect(sockfd, (mmSockAddr*)&serv_add, sizeof(serv_add));
            sendResult = mmSocketSend(sockfd, (VOID*)sendMsg, 50, 0);
            printf("The send msg length is %d.\r\n", sendResult);
            break;
        }
        mmSleep(1000);
    }
    mmSleep(1000);
    mmCloseSocket(sockfd);
    return NULL;
}

VOID* server_socket(VOID* p)
{
    mmSockHandle listenfd, connfd;
    struct sockaddr_in serv_add;
    mmSocklen_t stAddrLen = sizeof(serv_add);
    char recvMsg[50] = {0};
    INT32 recvResult = 0;

    listenfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    memset_s(&serv_add, sizeof(serv_add), '0', sizeof(serv_add));

    serv_add.sin_family = AF_INET;
    serv_add.sin_addr.s_addr = 0;
    serv_add.sin_port = htons(*(INT32 *)p);

    mmBind(listenfd, (mmSockAddr*)&serv_add, stAddrLen);
    mmListen(listenfd, 5);
    socketFlag = 1;
    while (true)
    {
        connfd = mmAccept(listenfd, (mmSockAddr*)NULL, NULL);
        if (connfd >= 0)
        {
            sleep(1);
            recvResult = mmSocketRecv(connfd, (VOID*)recvMsg, 50, 0);
            printf("The recv msg length is %d; the msg is %s\r\n", recvResult, recvMsg);
            sleep(1);
            mmCloseSocket(connfd);
            break;
        }
    }
    mmCloseSocket(listenfd);
    return NULL;
}


VOID* client_socket(VOID* p)
{
    mmSockHandle sockfd;
    struct sockaddr_in serv_add;
    char sendMsg[50] = {"hello.mmpa!"};
    INT32 sendResult = 0;

    memset_s(&serv_add, sizeof(serv_add), '0', sizeof(serv_add));
    sockfd = mmSocket(AF_INET, SOCK_STREAM, 0);
    serv_add.sin_family = AF_INET;
    inet_aton("127.0.0.1", (struct in_addr *)&serv_add.sin_addr);
    serv_add.sin_port = htons(*(INT32 *)p);
    while (true)
    {
        if (0 != socketFlag)
        {
            mmConnect(sockfd, (mmSockAddr*)&serv_add, sizeof(serv_add));
            sendResult = mmSocketSend(sockfd, (VOID*)sendMsg, 50, 0);
            printf("The send msg length is %d.\r\n", sendResult);
            break;
        }
        sleep(1);
    }

    sleep(1);
    mmCloseSocket(sockfd);
    return NULL;
}

/*[thread_func]*/
static void cleanup_handler(void *arg)
{
    printf("Cleanup handler of second thread./n");
    free(arg);
    mmMutexUnLock(&mtxfc);
    return;
}

VOID* thread_func(VOID *arg)
{
    struct node *p = NULL;
    INT32 ret = EN_OK;
    pthread_cleanup_push(cleanup_handler, p);

    mmMutexLock(&mtxfc);
    ret = mmCondWait(&cond, &mtxfc);
    mmMutexUnLock(&mtxfc);
    pthread_cleanup_pop(0);
    return NULL;
}

VOID* thread_func_time(VOID *arg)
{
    struct node *p = NULL;
    INT32 ret = EN_OK;
    pthread_cleanup_push(cleanup_handler, p);
    mmMutexLock(&mtxfc);
    time_t t;
	struct tm *timeinfo;
	time(&t);
	timeinfo = localtime(&t);
	printf("before mmCondTimedWait 时间：%s\n", asctime(timeinfo));
    ret = mmCondTimedWait(&cond, &mtxfc, 999);
	time(&t);
	timeinfo = localtime(&t);
	printf("after mmCondTimedWait1 时间：%s\n", asctime(timeinfo));
    ret = mmCondTimedWait(&cond, &mtxfc, 999);
	time(&t);
	timeinfo = localtime(&t);
	printf("after mmCondTimedWait2 时间：%s\n", asctime(timeinfo));
    mmMutexUnLock(&mtxfc);
    pthread_cleanup_pop(0);
    return NULL;
}

#ifdef __cplusplus
#if __cplusplus
}
#endif /* __cpluscplus */
#endif /* __cpluscplus */
