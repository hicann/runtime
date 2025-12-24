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
#include "mockcpp/mockcpp.hpp"

#include "securec.h"
#include "white_list.h"
#include <regex.h>

extern bool IsIncRightCommand(const std::string &command);
extern bool IsValidCommand(const std::string &command, const std::string &targetCommand, bool all);
extern bool IsConstCommand(const std::string &command);
extern bool IsNonConstCommand(const std::string &command);
extern bool IsWhiteListCommand(const std::string &command, bool &inc_right);
extern bool IsBlackListCommand(const std::string &command);

class IDE_WHITE_LIST_UTEST: public testing::Test {
protected:
	virtual void SetUp() {

	}
	virtual void TearDown() {
        GlobalMockObject::verify();
	}

};

TEST_F(IDE_WHITE_LIST_UTEST, IsValidCommand)
{
    const char *cmd = "ls";
    EXPECT_FALSE(IsValidCommand(cmd, "reboot mini", true));

    cmd = "reboot mini";
    EXPECT_TRUE(IsValidCommand(cmd, "reboot mini", true));

    EXPECT_FALSE(IsValidCommand(cmd, "+", true));
    GlobalMockObject::verify();
}


TEST_F(IDE_WHITE_LIST_UTEST, IsIncRightCommand)
{
    MOCKER(IsValidCommand)
        .stubs()
        .will(returnValue(false));

    EXPECT_FALSE(IsIncRightCommand("ls"));
    GlobalMockObject::verify();

    MOCKER(IsValidCommand)
        .stubs()
        .will(returnValue(true));
    EXPECT_TRUE(IsIncRightCommand("ls"));
}

TEST_F(IDE_WHITE_LIST_UTEST, IsConstCommand)
{
    EXPECT_FALSE(IsConstCommand("ls"));
    EXPECT_TRUE(IsConstCommand("date"));
}

TEST_F(IDE_WHITE_LIST_UTEST, IsNonConstCommand)
{
    MOCKER(IsValidCommand)
        .stubs()
        .will(returnValue(false));

    EXPECT_FALSE(IsNonConstCommand("ls"));
    GlobalMockObject::verify();

    MOCKER(IsValidCommand)
        .stubs()
        .will(returnValue(true));
    EXPECT_TRUE(IsNonConstCommand("ls"));
}

TEST_F(IDE_WHITE_LIST_UTEST, IsBlackListCommand)
{
    MOCKER(IsValidCommand)
        .stubs()
        .will(returnValue(false));

    EXPECT_FALSE(IsBlackListCommand("ls"));
    GlobalMockObject::verify();

    MOCKER(IsValidCommand)
        .stubs()
        .will(returnValue(true));
    EXPECT_TRUE(IsBlackListCommand("ls"));
}

TEST_F(IDE_WHITE_LIST_UTEST, IsWhiteListCommand)
{
    const char *cmd = "ls";
    bool inc_right = false;
     //black_list
    MOCKER(IsBlackListCommand)
        .stubs()
        .will(returnValue(true));

    EXPECT_FALSE(IsWhiteListCommand(cmd, inc_right));
    GlobalMockObject::verify();

    MOCKER(IsBlackListCommand)
        .stubs()
        .will(returnValue(false));

    //is_not_valiable command
    MOCKER(IsConstCommand)
        .stubs()
        .will(returnValue(false));

    MOCKER(IsNonConstCommand)
        .stubs()
        .will(returnValue(false));

    EXPECT_FALSE(IsWhiteListCommand(cmd, inc_right));
    GlobalMockObject::verify();

    MOCKER(IsBlackListCommand)
        .stubs()
        .will(returnValue(false));

    //IsConstCommand
    MOCKER(IsConstCommand)
        .stubs()
        .will(returnValue(true));

    MOCKER(IsIncRightCommand)
        .stubs()
        .will(returnValue(true));

    EXPECT_TRUE(IsWhiteListCommand(cmd, inc_right));
    EXPECT_TRUE(inc_right);
    GlobalMockObject::verify();

    MOCKER(IsBlackListCommand)
        .stubs()
        .will(returnValue(false));

    //IsConstCommand
    MOCKER(IsConstCommand)
        .stubs()
        .will(returnValue(false));

    MOCKER(IsNonConstCommand)
        .stubs()
        .will(returnValue(true));

    MOCKER(IsIncRightCommand)
        .stubs()
        .will(returnValue(false));

    EXPECT_TRUE(IsWhiteListCommand(cmd, inc_right));
    EXPECT_FALSE(inc_right);
}

const char * constCommand[] = {
    "ide_cmd.sh --install_info",
    "date",
    "chmod -R +rwx ~/HIAI_PROJECTS/workspace_mind_studio/include",
};

TEST_F(IDE_WHITE_LIST_UTEST, IsWhiteListCommandConstList)
{
    bool inc_right = false;
    for (int i = 0; i < sizeof(constCommand) / sizeof(char *); i++) {
        std::cout <<"Whilt List :"<<constCommand[i]<<std::endl;
        EXPECT_TRUE(IsWhiteListCommand(constCommand[i], inc_right));
    }
}

const char * nonConstCommand[] = {
// "^rm (-rf )?(( )?~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app)|(ide_daemon))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*)*",
    "rm -rf ~/ide_daemon/xxx",
    "rm -rf ~/ide_daemon/xxx/abcd",
    "rm -rf ~/ide_daemon/xxx/abcd.sh",
    "rm -rf ~/ide_daemon/xxx//abcd.sh",
    "rm -rf ~/ide_daemon/xxx/abcd/abcd.sh",
    "rm ~/ide_daemon/xxx/abcd/abcd.sh",
    "rm -rf ~/HIAI_PROJECTS/xxx",
    "rm -rf ~/HIAI_PROJECTS/xxx/abcd",
    "rm -rf ~/HIAI_PROJECTS/xxx/ab-cd.sh",
    "rm -rf ~/HIAI_PROJECTS/xxx/abcd.sh",
    "rm -rf ~/HIAI_PROJECTS//abcd.sh",
    "rm -rf ~/HIAI_PROJECTS/xxx/abcd/abcd.sh",
    "rm -rf ~/HIAI_PROJECTS/xxx/abcd/abcd.sh ~/ide_daemon/xxx/abcd/abcd.sh",
    "rm ~/HIAI_PROJECTS/xxx/abcd/abcd.sh ~/ide_daemon/xxx/abcd/abcd.sh",
    
// "^wc -l ~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*(\\*)?",
    "wc -l ~/profiler-app/xxx*",
    "wc -l ~/profiler-app/xxx/abcd",
    "wc -l ~/profiler-app/xxx/abcd.sh",
    "wc -l ~/profiler-app/xxx//abcd.sh",
    "wc -l ~/profiler-app/xxx/abcd/abcd.sh",
    "wc -l ~/HIAI_PROJECTS/xxx",
    "wc -l ~/HIAI_PROJECTS/xxx/abcd",
    "wc -l ~/HIAI_PROJECTS/xxx/ab-cd.sh",
    "wc -l ~/HIAI_PROJECTS/xxx/abcd.sh",
    "wc -l ~/HIAI_PROJECTS//abcd.sh",
    "wc -l ~/HIAI_PROJECTS/xxx/abcd/abcd.sh*",

// "^mkdir (-p )?~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app)|(ide_daemon))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "mkdir -p ~/profiler-app/xxx",
    "mkdir -p ~/profiler-app/xxx/abcd",
    "mkdir -p ~/profiler-app/xxx/abcd.sh",
    "mkdir -p ~/profiler-app/xxx//abcd.sh",
    "mkdir -p ~/profiler-app/xxx/abcd/abcd.sh",
    "mkdir ~/HIAI_PROJECTS/xxx",
    "mkdir ~/HIAI_PROJECTS/xxx/abcd",
    "mkdir ~/HIAI_PROJECTS/xxx/ab-cd.sh",
    "mkdir ~/HIAI_PROJECTS/xxx/abcd.sh",
    "mkdir ~/HIAI_PROJECTS//abcd.sh",
    "mkdir ~/HIAI_PROJECTS/xxx/abcd/abcd.sh",

// "^tar -xvf ~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\.tar -C ~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "tar -xvf ~/profiler-app/xxx.tar -C ~/profiler-app/xxx",
    "tar -xvf ~/profiler-app/xxx/abcd.tar -C ~/profiler-app/xxx/abcd",
    "tar -xvf ~/profiler-app/xxx/abcd.sh.tar -C ~/profiler-app/xxx/abcd.sh",
    "tar -xvf ~/profiler-app/xxx//abcd.sh.tar -C ~/profiler-app/xxx//abcd.sh",
    "tar -xvf ~/profiler-app/xxx/abcd/abcd.sh.tar -C ~/profiler-app/xxx/abcd/abcd.sh",
    "tar -xvf ~/HIAI_PROJECTS/xx-x.tar -C ~/HIAI_PROJECTS/xxx",
    "tar -xvf ~/HIAI_PROJECTS/xxx/abcd.tar -C ~/HIAI_PROJECTS/xxx/abcd",
    "tar -xvf ~/HIAI_PROJECTS/xxx/ab-cd.sh.tar -C ~/HIAI_PROJECTS/xxx/ab-cd.sh",
    "tar -xvf ~/HIAI_PROJECTS/xxx/abcd.sh.tar -C ~/HIAI_PROJECTS/xxx/abcd.sh",
    "tar -xvf ~/HIAI_PROJECTS//abcd.sh.tar -C ~/HIAI_PROJECTS//abcd.sh",
    "tar -xvf ~/HIAI_PROJECTS/xxx/abcd/abcd.sh.tar -C ~/HIAI_PROJECTS/xxx/abcd/abcd.sh",

// "^tar -cf ~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\.tar -C ~\\/((HIAI_PROJECTS)|(HIAI_DATANDMODELSET)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+ [a-z0-9A-Z_-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "tar -cf ~/profiler-app/xxx.tar -C ~/profiler-app/xxx xxx",
    "tar -cf ~/profiler-app/xxx/abcd.tar -C ~/profiler-app/xxx/ abcd",
    "tar -cf ~/profiler-app/xxx/abcd.sh.tar -C ~/profiler-app/xxx/ abcd.sh",
    "tar -cf ~/profiler-app/xxx//abcd.sh.tar -C ~/profiler-app/xxx// abcd.sh",
    "tar -cf ~/profiler-app/xxx/abcd/abcd.sh.tar -C ~/profiler-app/xxx/abcd/ abcd.sh",
    "tar -cf ~/HIAI_PROJECTS/xx-x.tar -C ~/HIAI_PROJECTS/ad-cd/ xxx",
    "tar -cf ~/HIAI_PROJECTS/x_xx.tar -C ~/HIAI_PROJECTS/ad_cd/ xxx",
    "tar -cf ~/HIAI_PROJECTS/xxx/abcd.tar -C ~/HIAI_PROJECTS/xxx/ abcd",
    "tar -cf ~/HIAI_PROJECTS/xxx/ab-cd.sh.tar -C ~/HIAI_PROJECTS/xxx/ ab-cd.s-h",
    "tar -cf ~/HIAI_PROJECTS/xxx/abcd.sh.tar -C ~/HIAI_PROJECTS/xxx/ abcd.sh",
    "tar -cf ~/HIAI_PROJECTS//abcd.sh.tar -C ~/HIAI_PROJECTS// abcd.sh",
    "tar -cf ~/HIAI_PROJECTS/xxx/abcd/abcd.sh.tar -C ~/HIAI_PROJECTS/xxx/abcd/ abcd.sh",

// "^mv ~\\/((HIAI_PROJECTS)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)* ~\\/((HIAI_PROJECTS)|(profiler-app))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "mv ~/profiler-app/xxx ~/profiler-app/xxx",
    "mv ~/profiler-app/xxx/abcd ~/profiler-app/xxx/abcd",
    "mv ~/profiler-app/xxx/abcd.sh ~/profiler-app/xxx/abcd.sh",
    "mv ~/profiler-app/xxx//abcd.sh ~/profiler-app/xxx//abcd.sh",
    "mv ~/profiler-app/xxx/abcd/abcd.sh ~/profiler-app/xxx/abcd/abcd.sh",
    "mv ~/HIAI_PROJECTS/xxx.tar ~/HIAI_PROJECTS/xxx",
    "mv ~/HIAI_PROJECTS/xxx/abcd.tar ~/HIAI_PROJECTS/xxx/abcd",
    "mv ~/HIAI_PROJECTS/xxx/ab-cd.sh.tar ~/HIAI_PROJECTS/xxx/ab-cd.sh",
    "mv ~/HIAI_PROJECTS/xxx/abcd.sh.tar ~/HIAI_PROJECTS/xxx/abcd.sh",
    "mv ~/HIAI_PROJECTS//abcd.sh.tar ~/HIAI_PROJECTS//abcd.sh",
    "mv ~/HIAI_PROJECTS/xxx/abcd/abcd.sh.tar ~/HIAI_PROJECTS/xxx/abcd/abcd.sh",

// "^chmod \\+x ~\\/((HIAI_PROJECTS)|(profiler-app)|(ide_daemon))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "mv ~/profiler-app/xxx ~/profiler-app/xxx",
    "mv ~/profiler-app/xxx/abcd ~/profiler-app/xxx/abcd",
    "mv ~/profiler-app/xxx/abcd.sh ~/profiler-app/xxx/abcd.sh",
    "mv ~/profiler-app/xxx//abcd.sh ~/profiler-app/xxx//abcd.sh",
    "mv ~/profiler-app/xxx/abcd/abcd.sh ~/profiler-app/xxx/abcd/abcd.sh",
    "mv ~/HIAI_PROJECTS/xxx.tar ~/HIAI_PROJECTS/xxx",
    "mv ~/HIAI_PROJECTS/xxx/abcd.tar ~/HIAI_PROJECTS/xxx/abcd",
    "mv ~/HIAI_PROJECTS/xxx/ab-cd.sh.tar ~/HIAI_PROJECTS/xxx/ab-cd.sh",
    "mv ~/HIAI_PROJECTS/xxx/abcd.sh.tar ~/HIAI_PROJECTS/xxx/abcd.sh",
    "mv ~/HIAI_PROJECTS//abcd.sh.tar ~/HIAI_PROJECTS//abcd.sh",
    "mv ~/HIAI_PROJECTS/xxx/abcd/abcd.sh.tar ~/HIAI_PROJECTS/xxx/abcd/abcd.sh",

// "^chmod \\-w ~\\/ide_daemon\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "chmod -w ~/ide_daemon/xxx",
    "chmod -w ~/ide_daemon/xxx.sh",
    "chmod -w ~/ide_daemon/xx-x.sh",
    "chmod -w ~/ide_daemon/xxx/abcd",
    "chmod -w ~/ide_daemon/xxx/abcd.sh",
    "chmod -w ~/ide_daemon/xxx//abcd.sh",
    "chmod -w ~/ide_daemon/xxx/abcd/abcd.sh",
    
// "^cp (-af )?~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)* ~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "cp -af ~/HIAI_PROJECTS/xxx ~/HIAI_PROJECTS/xxx",
    "cp -af ~/HIAI_PROJECTS/xxab.sh ~/HIAI_PROJECTS/xxab.sh",
    "cp -af ~/HIAI_PROJECTS/xxx/abcd ~/HIAI_PROJECTS/xxx-",
    "cp -af ~/HIAI_PROJECTS/xxx/abcd.sh ~/HIAI_PROJECTS/xxx_",
    "cp -af ~/HIAI_PROJECTS/xxx//abcd.sh ~/HIAI_PROJECTS/xxx-pp",
    "cp -af ~/HIAI_PROJECTS/xxx/abcd/abcd.sh ~/HIAI_PROJECTS//.sh",
    "cp ~/HIAI_PROJECTS/xxx ~/HIAI_PROJECTS/xxx",
    "cp ~/HIAI_PROJECTS/xxx/abcd ~/HIAI_PROJECTS/xxab.sh",
    "cp ~/HIAI_PROJECTS/xxx/ab-cd.sh ~/HIAI_PROJECTS/xxx_",
    "cp ~/HIAI_PROJECTS/xxx/abcd.sh ~/HIAI_PROJECTS//.sh",
    "cp ~/HIAI_PROJECTS//abcd.sh ~/HIAI_PROJECTS/xxx-",
    "cp ~/HIAI_PROJECTS/xxx/abcd/abcd.sh ~/HIAI_PROJECTS/xxx-/",

// "^sha512sum ~\\/HIAI_DATANDMODELSET\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "sha512sum ~/HIAI_DATANDMODELSET/xxx",
    "sha512sum ~/HIAI_DATANDMODELSET/xxx.sh",
    "sha512sum ~/HIAI_DATANDMODELSET/xx-x.sh",
    "sha512sum ~/HIAI_DATANDMODELSET/xxx/abcd",
    "sha512sum ~/HIAI_DATANDMODELSET/xxx/abcd.sh",
    "sha512sum ~/HIAI_DATANDMODELSET/xxx//abcd.sh",
    "sha512sum ~/HIAI_DATANDMODELSET/xxx/abcd/abcd.sh",

// "^find ~\\/HIAI_DATANDMODELSET\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)* -type f\\|xargs sha512sum\\|sort",
    "find ~/HIAI_DATANDMODELSET/xxx -type f|xargs sha512sum|sort",
    "find ~/HIAI_DATANDMODELSET/xxx.sh -type f|xargs sha512sum|sort",
    "find ~/HIAI_DATANDMODELSET/xx-x.sh -type f|xargs sha512sum|sort",
    "find ~/HIAI_DATANDMODELSET/xxx/abcd -type f|xargs sha512sum|sort",
    "find ~/HIAI_DATANDMODELSET/xxx/abcd.sh -type f|xargs sha512sum|sort",
    "find ~/HIAI_DATANDMODELSET/xxx//abcd.sh -type f|xargs sha512sum|sort",
    "find ~/HIAI_DATANDMODELSET/xxx/abcd/abcd.sh -type f|xargs sha512sum|sort",

// "^~\\/((HIAI_PROJECTS)|(ide_daemon))\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*",
    "~/HIAI_PROJECTS/xxx",
    "~/HIAI_PROJECTS/xxx.sh",
    "~/HIAI_PROJECTS/xx-x.sh",
    "~/HIAI_PROJECTS/xxx/abcd",
    "~/HIAI_PROJECTS/xxx/abcd.sh",
    "~/HIAI_PROJECTS/xxx//abcd.sh",
    "~/HIAI_PROJECTS/xxx/abcd/abcd.sh",
    "~/ide_daemon/xxx",
    "~/ide_daemon/xxx.sh",
    "~/ide_daemon/xx-x.sh",
    "~/ide_daemon/xxx/abcd",
    "~/ide_daemon/xxx/abcd.sh",
    "~/ide_daemon/xxx//abcd.sh",
    "~/ide_daemon/xxx/abcd/abcd.sh",

// "^~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*( )?(~\\/HIAI_DATANDMODELSET\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*)?( )?([a-z0-9A-Z_-]+)?( )?([0-9]+)?( )?([0-9]+)?",
    "~/HIAI_PROJECTS/xxx",
    "~/HIAI_PROJECTS/xxx.sh",
    "~/HIAI_PROJECTS/xx-x.sh",
    "~/HIAI_PROJECTS/xxx/abcd",
    "~/HIAI_PROJECTS/xxx/abcd.sh",
    "~/HIAI_PROJECTS/xxx//abcd.sh",
    "~/HIAI_PROJECTS/xxx/abcd/abcd.sh",
    "~/HIAI_PROJECTS/xxx 1",
    "~/HIAI_PROJECTS/xxx.sh 1 2",
    "~/HIAI_PROJECTS/xx-x.sh abcd 1 2",
    "~/HIAI_PROJECTS/xxx/abcd ~/HIAI_DATANDMODELSET/xxxx",
    "~/HIAI_PROJECTS/xxx/abcd.sh ~/HIAI_DATANDMODELSET/xxxx.sh abcd",
    "~/HIAI_PROJECTS/xxx//abcd.sh ~/HIAI_DATANDMODELSET/xxxx.sh 11",
    "~/HIAI_PROJECTS/xxx/abcd/abcd.sh ~/HIAI_DATANDMODELSET/xxxx.sh 1 122",
    "~/HIAI_PROJECTS/xxx/abcd/abcd.sh ~/HIAI_DATANDMODELSET/xxxx.sh abcd 1 2",

// "^cd ~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\/out(\\/)?;\\.\\/[a-z0-9A-Z_-]+((\\.)?[a-z0-9A-Z_-]+)*( 2>&1)?",
    "cd ~/HIAI_PROJECTS/xxx/out;./ad1d.sh",
    "cd ~/HIAI_PROJECTS/xxx.sh/out;./s2d-ad",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out;./s3d_sh.sh",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out;./ss4.ta.sh",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out;./s13hh",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out;./saaf",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out;./sh2a.ke",
    "cd ~/HIAI_PROJECTS/xxx/out/;./add.sh",
    "cd ~/HIAI_PROJECTS/xxx.sh/out/;./sd-ad",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out/;./sd_sh.sh",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out/;./ss.ta.sh",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out/;./shh",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out/;./saaf",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out/;./sha.ke",
    "cd ~/HIAI_PROJECTS/xxx/out/;./tvm_bbit 2>&1",

// "^cd ~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\/out(\\/)?;\\.\\/[a-z0-9A-Z_-]+((\\.)?[a-z0-9A-Z_-]+)*( )?(~\\/HIAI_DATANDMODELSET\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*)?( )?([a-z0-9A-Z_-]+)?( )?([0-9]+)?( )?([0-9]+)?",
    "cd ~/HIAI_PROJECTS/xxx/out;./ad1d.sh 1",
    "cd ~/HIAI_PROJECTS/xxx.sh/out;./s2d-ad 1 2",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out;./s3d_sh.sh adncd 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out;./ss4.ta.sh adcd",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out;./s13hh ~/HIAI_DATANDMODELSET/xxxx",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out;./saaf ~/HIAI_DATANDMODELSET/xxxx.sh abc",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out;./sh2a.ke ~/HIAI_DATANDMODELSET/xxxx.sh abc 1",
    "cd ~/HIAI_PROJECTS/xxx/out/;./add.sh ~/HIAI_DATANDMODELSET/xxxx.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx.sh/out/;./sd-ad ~/HIAI_DATANDMODELSET/xxxx.sh 1",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out/;./sd_sh.sh ~/HIAI_DATANDMODELSET/xxxx.sh 1 245",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out/;./ss.ta.sh ~/HIAI_DATANDMODELSET/xxxx.sh abc 144 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out/;./shh ~/HIAI_DATANDMODELSET/xx-xx/.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out/;./saaf ~/HIAI_DATANDMODELSET/xxxx/x-x/s.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out/;./sha.ke ~/HIAI_DATANDMODELSET/xxx_x.sh 2",
    
// "^cd ~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\/out(\\/)?;~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\/out\\/[a-z0-9A-Z_-]+((\\.)?[a-z0-9A-Z_-]+)*( )?(~\\/HIAI_DATANDMODELSET\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*)?( )?([a-z0-9A-Z_-]+)?( )?([0-9]+)?( )?([0-9]+)?",
    "cd ~/HIAI_PROJECTS/xxx/out;~/HIAI_PROJECTS/xxxx/out/ad1d.sh",
    "cd ~/HIAI_PROJECTS/xxx.sh/out;~/HIAI_PROJECTS/xxxx/out/yy-ad",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out;~/HIAI_PROJECTS/xxxx/out/y_y.as",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out;~/HIAI_PROJECTS/xxxx/out/ss4.ta.sh",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/out/s13hh",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out/;~/HIAI_PROJECTS/xxxx//out/saaf",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/y_y/out/sh2a.ke",
    "cd ~/HIAI_PROJECTS/xxx/out;~/HIAI_PROJECTS/xxxx/out/ad1d.sh 1",
    "cd ~/HIAI_PROJECTS/xxx.sh/out;~/HIAI_PROJECTS/xxxx/out/s2d-ad 1 32",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out/;~/HIAI_PROJECTS/xxxx/out/s3d_sh.sh adncd 112 23",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out/;~/HIAI_PROJECTS/xxxx/out/ss4.ta.sh adcd",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/out/s13hh ~/HIAI_DATANDMODELSET/xxxx",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out;~/HIAI_PROJECTS/xxxx/out/s13hh ~/HIAI_DATANDMODELSET/xxxx.sh abc",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out;~/HIAI_PROJECTS/xxxx/out/yy ~/HIAI_DATANDMODELSET/xxxx.sh abc 1",
    "cd ~/HIAI_PROJECTS/xxx/out/;~/HIAI_PROJECTS/xxxx/out/sd_2ad ~/HIAI_DATANDMODELSET/xxxx.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx.sh/out/;~/HIAI_PROJECTS/xxxx/out/sd-ad ~/HIAI_DATANDMODELSET/xxxx.sh 1",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out/;~/HIAI_PROJECTS/xxxx/out/sd_sh.sh ~/HIAI_DATANDMODELSET/xxxx.sh 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out/;~/HIAI_PROJECTS/xxxx/out/ss.ta.sh ~/HIAI_DATANDMODELSET/xxxx.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/out/yy ~/HIAI_DATANDMODELSET/xx-xx/.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out/;~/HIAI_PROJECTS/xxxx/out/yy ~/HIAI_DATANDMODELSET/xxxx/x-x/s.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/out/yy ~/HIAI_DATANDMODELSET/xxx_x.sh 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out;~/HIAI_PROJECTS/xxxx/abcd//out/yy ~/HIAI_DATANDMODELSET/xxxx",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out;~/HIAI_PROJECTS/xxxx/abcd/cds/out/yy ~/HIAI_DATANDMODELSET/xxxx.sh abc",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out;~/HIAI_PROJECTS/xxxx/out/yy ~/HIAI_DATANDMODELSET/xxxx.sh abc 1",
    "cd ~/HIAI_PROJECTS/xxx/out/;~/HIAI_PROJECTS/xxxx/abcd/out/yy.sh ~/HIAI_DATANDMODELSET/xxxx.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx.sh/out/;~/HIAI_PROJECTS/xxxx/abcd/out/yy-23 ~/HIAI_DATANDMODELSET/xxxx.sh 1",
    "cd ~/HIAI_PROJECTS/xx-x.sh/out/;~/HIAI_PROJECTS/xxxx/abcd/out/yy.7sj ~/HIAI_DATANDMODELSET/xxxx.sh 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd/out/;~/HIAI_PROJECTS/xxxx/abcd/out/yy.90 ~/HIAI_DATANDMODELSET/xxxx.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/abcd/out/yy.syu7.89 ~/HIAI_DATANDMODELSET/xx-xx/.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx//abcd.sh/out/;~/HIAI_PROJECTS/xxxxabcd//out/yy.tar ~/HIAI_DATANDMODELSET/xxxx/x-x/s.sh abc 1 2",
    "cd ~/HIAI_PROJECTS/xxx/abcd/abcd.sh/out/;~/HIAI_PROJECTS/xxxx/abcd/out/yy.st2 ~/HIAI_DATANDMODELSET/xxx_x.sh 2",

// "^ps ux \\| awk '\\{print( [0-9\\$\\t\"]+)?\\}'\\| sed 1d",
    "ps ux | awk '{print}'| sed 1d",
    "ps ux | awk '{print \\t\"}'| sed 1d",
    "ps ux | awk '{print 3}'| sed 1d",
    "ps ux | awk '{print $3}'| sed 1d",
    "ps ux | awk '{print $}'| sed 1d",
    "ps ux | awk '{print \"}'| sed 1d",
    "ps ux | awk '{print \\t}'| sed 1d",
    "ps ux | awk '{print $\"\\t\"}'| sed 1d",
    "ps ux | awk '{print $5\\t\"}'| sed 1d",
    "ps ux | awk '{print $5\"\\t\"$8}'| sed 1d",
// "^ps -ef \\| awk '\\{print( [0-9\\$\\t\"]+)?\\}'\\| sed 1d",
    "ps -ef | awk '{print}'| sed 1d",
    "ps -ef | awk '{print $3}'| sed 1d",
    "ps -ef | awk '{print 3}'| sed 1d",
    "ps -ef | awk '{print $}'| sed 1d",
    "ps -ef | awk '{print \\t}'| sed 1d",
    "ps -ef | awk '{print \"}'| sed 1d",
    "ps -ef | awk '{print $\\t\"}'| sed 1d",
    "ps -ef | awk '{print $5\\t\"}'| sed 1d",
    "ps -ef | awk '{print $5\"\\t\"$2}'| sed 1d",

// "^kill (-9 )?\\$\\(pidof (-x )?~\\/HIAI_PROJECTS\\/[a-z0-9A-Z_\\/-]+((\\.)?[a-z0-9A-Z_-]+)*\\/out\\/[a-z0-9A-Z_-]+((\\.)?[a-z0-9A-Z_-]+)*\\)",
    "kill $(pidof ~/HIAI_PROJECTS/xxx/out/abcd)",
    "kill $(pidof ~/HIAI_PROJECTS///out/ab-c_12d.sh)",
    "kill $(pidof ~/HIAI_PROJECTS/xxx.sh/out/a213b_c-d.sh)",
    "kill $(pidof ~/HIAI_PROJECTS/xxx/y-98/out/a213b_c-d.sh)",
    "kill $(pidof ~/HIAI_PROJECTS/xxx/y-98.sh/out/a213bcd)",
    "kill $(pidof -x ~/HIAI_PROJECTS/xxx/out/abcd)",
    "kill $(pidof -x ~/HIAI_PROJECTS///out/ab-c_12d.sh)",
    "kill $(pidof -x ~/HIAI_PROJECTS/xxx.sh/out/a213b_c-d.sh)",
    "kill $(pidof -x ~/HIAI_PROJECTS/xxx/y-98/out/a213b_c-d.sh)",
    "kill $(pidof -x ~/HIAI_PROJECTS/xxx/y-98.sh/out/a213bcd)",
    "kill -9 $(pidof ~/HIAI_PROJECTS/xxx/out/abcd)",
    "kill -9 $(pidof ~/HIAI_PROJECTS///out/ab-c_12d.sh)",
    "kill -9 $(pidof ~/HIAI_PROJECTS/xxx.sh/out/a213b_c-d.sh)",
    "kill -9 $(pidof ~/HIAI_PROJECTS/xxx/y-98/out/a213b_c-d.sh)",
    "kill -9 $(pidof ~/HIAI_PROJECTS/xxx/y-98.sh/out/a213bcd)",
    "kill -9 $(pidof -x ~/HIAI_PROJECTS/xxx/out/abcd)",
    "kill -9 $(pidof -x ~/HIAI_PROJECTS///out/ab-c_12d.sh)",
    "kill -9 $(pidof -x ~/HIAI_PROJECTS/xxx.sh/out/a213b_c-d.sh)",
    "kill -9 $(pidof -x ~/HIAI_PROJECTS/xxx/y-98/out/a213b_c-d.sh)",
    "kill -9 $(pidof -x ~/HIAI_PROJECTS/xxx/y-98.sh/out/a213bcd)",
// "^pidof [a-z0-9A-Z_-]+",
    "pidof ad1256",
    "pidof sftp-server",
    "pidof ad1_256",
};

TEST_F(IDE_WHITE_LIST_UTEST, IsWhiteListCommandNonConstList)
{
    bool inc_right = false;
    for (int i = 0; i < sizeof(nonConstCommand) / sizeof(char *); i++) {
        std::cout <<"Whilt List :"<<nonConstCommand[i]<<std::endl;
        EXPECT_TRUE(IsWhiteListCommand(nonConstCommand[i], inc_right));
    }
}

//the commands cannot run
const std::string blackListCommands[] = {
//"^tar ((-xvf)|(-cf)) [^(|)(;)(&)]+(--use-compress-program=)[^(|)(;)(&)]+",
    "tar -xvf abcd.tar --use-compress-program=adcd",
//"^tar ((-xvf)|(-cf)) [^(|)(;)(&)]+( -I )[^(|)(;)(&)]+"
    "tar -xvf abcd.tar -I adcd",
    "rm -rf ~/HIAI_PROJECTS/xxx/\\./\\./yyy",
    "rm -rf ~/HIAI_PROJECTS/xxx/\\.\\./yyy",
    "rm -rf ~/HIAI_PROJECTS/xxx/./\\./yyy",
    "rm -rf ~/HIAI_PROJECTS/xxx/../\\./yyy",
};

TEST_F(IDE_WHITE_LIST_UTEST, IsWhiteListCommandBlackList)
{
    bool inc_right = false;
    for (int i = 0; i < sizeof(blackListCommands) / sizeof(char *); i++) {
        std::cout <<"Whilt List :"<<blackListCommands[i]<<std::endl;
        EXPECT_FALSE(IsWhiteListCommand(blackListCommands[i], inc_right));
        EXPECT_TRUE(IsBlackListCommand(blackListCommands[i]));
    }
}

const std::string incRightCommands[] = {
// "^ide_cmd.sh --install_info",
    "ide_cmd.sh --install_info",
};

TEST_F(IDE_WHITE_LIST_UTEST, IsWhiteListCommandIncRightList)
{
    bool inc_right = false;
    for (int i = 0; i < sizeof(incRightCommands) / sizeof(char *); i++) {
        std::cout <<"Whilt List :"<<incRightCommands[i]<<std::endl;
        EXPECT_TRUE(IsWhiteListCommand(incRightCommands[i], inc_right));
        EXPECT_TRUE(inc_right);
        EXPECT_TRUE(IsIncRightCommand(incRightCommands[i]));
    }
}

TEST_F(IDE_WHITE_LIST_UTEST, IsCheckListCommand)
{
    std::string strCmd;
    EXPECT_TRUE(IsCheckListCommand("tar -xvf ~/HIAI_PROJECTS/out.tar", strCmd));
    EXPECT_FALSE(IsCheckListCommand("tar -xvf ~/HIAI_PROJECTS/out.tr", strCmd));
    EXPECT_FALSE(IsCheckListCommand("tar -cf ~/HIAI_PROJECTS/out.tar", strCmd));
}

