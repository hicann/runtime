/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */

#ifndef FILE_IF_H
#define FILE_IF_H

#define MAX_FILE_NAME_LEN           180

typedef enum {
    SEEK_FILE_BEGIN = 0,
    SEEK_CUR_POS,
    SEEK_FILE_END,
    SEEK_TYPE_BUTT
} seek_type;

#define MAX_FILE_NAME_LEN           180

typedef struct {
    char name[MAX_FILE_NAME_LEN];
} file_name_t;

typedef struct {
    uint32_t file_idx;
} file_t;

int32_t file_sys_init(void)
{
    return 0;
}

void file_sys_deinit(void)
{
}

/* 功能说明: 创建文件，为其开辟flash空间
 * 参数: 1) filename: 入参，带完整路径的文件名
 *       2) size: 文件最大占用空间
 * 返回值: 0, succ; other, fail
*/
int32_t file_create(char *filename, size_t size)
{
    return 0;
}

static file_t g_openFile = { 0 };
/* 功能说明: 打开文件
 * 参数: 1) filename: 入参，带完整路径的文件名
 *       2) mode: 入参，'r':只读， 'w':可写且OFFSET指向文件开始， 'a':可写且OFFSET指向文件尾
 * 返回值: 文件句柄, 失败返回NULL
*/
file_t *file_open(const char *filename, const char *mode)
{
    return &g_openFile;
}

/* 功能说明: 关闭文件
 * 参数: 1) file: 入参，文件句柄
 * 返回值: 0, succ; other, fail
*/
int32_t file_close(file_t *file)
{
    return 0;
}

/* 功能说明: 从文件offset处读取size*nmemb字节数据至dst中
 * 参数: 1) dst: 入参，读取到的目标地址，最小尺寸 size*nmemb
 *       2) size: 入参，读取的每个元素的大小，以字节为单位
 *       3) nmemb: 入参，元素的个数，每个元素的大小为 size 字节
 *       4) file: 入参，文件句柄
 * 返回值: 读取元素的个数，等于nmemb表示成功，否则表示失败
*/
size_t file_read(void *dst, size_t size, size_t nmemb, file_t *file)
{
    return 0;
}

/* 功能说明: 将src指向的数据写入文件offset指向的位置
 * 参数: 1) src: 入参，指向被写入区域
 *       2) size: 入参，被写入的每个元素的大小，以字节为单位
 *       3) nmemb: 入参，元素的个数，每个元素的大小为 size 字节
 *       4) file: 入参，文件句柄
 * 返回值: 写入元素的个数，等于nmemb表示成功，否则表示失败
*/
size_t file_write(const void *src, size_t size, size_t nmemb, file_t *file)
{
    return nmemb;
}

/* 功能说明: 设置文件offse至指定位置
 * 参数: 1) file: 入参，文件句柄
 *       2) offset: 入参，相对 whence 的偏移量
 *       3) whence : 入参，开始添加偏移 offset 的位置, 见seek_type
 * 返回值: 0, succ; other, fail
*/
int32_t file_seek(file_t *file, long offset, int32_t whence)
{
    return 0;
}

/* 功能说明: 设置文件offse至指定位置
 * 参数: 1) file: 入参，文件句柄
 * 返回值: 位置标识符的当前值。如果发生错误，则返回 -1
*/
long int file_tell(file_t *file)
{
    return 10240;
}

/* 功能说明: 测试该文件的结束标识符
 * 参数: 1) file: 入参，文件句柄
 * 返回值: 0, 非end of file; 1, end of file; 如果发生错误，则返回 -1
*/
int file_eof(file_t *file)
{
    return 0;
}

/* 功能说明: 测试该文件的操作错误标识符
 * 参数: 1) file: 入参，文件句柄
 * 返回值: 0, 无异常; 非0, 发生错误
*/
int file_error(file_t *file)
{
    return 0;
}

int32_t file_dir_get_file_num(char *dir_name, uint32_t *file_num)
{
    return 0;
}

int32_t file_dir_get_list(char *dir_name, file_name_t *file_list, uint32_t file_num)
{
    return 0;
}
#endif