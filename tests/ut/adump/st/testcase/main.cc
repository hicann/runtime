/**
 * Copyright (c) 2025 Huawei Technologies Co., Ltd.
 * This program is free software, you can redistribute it and/or modify it under the terms and conditions of
 * CANN Open Software License Agreement Version 2.0 (the "License").
 * Please refer to the License for details. You may not use this file except in compliance with the License.
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
 * See LICENSE in the root of the software repository for the full text of the License.
 */
#include "defs.h"
#include "gtest/gtest.h"
using namespace std;
//建议这样引用，避免下面用关键字时需要加前缀 testing::
using namespace testing;

class FooEnvironment : public testing::Environment
{
public:
    virtual void SetUp()
    {
        std::cout << "Foo FooEnvironment SetUP" << std::endl;

    }
    virtual void TearDown()
    {
        std::cout << "Foo FooEnvironment TearDown" << std::endl;
    }
};

int main(int argc, char* argv[])
{
	//std::vector<PFUNC> g_func1 = GET_FUNC_CTOR_LIST();
	//全局事件：设置执行全局事件
	AddGlobalTestEnvironment(new FooEnvironment);

	//输出 用例列表，用例不执行了~，可以用参数控制
	//testing::GTEST_FLAG(list_tests) = " ";
	//设置过滤功能后，参数化功能失效~~~~//执行列出来的测试套的用例
	//testing::GTEST_FLAG(filter) = "EXEPath.*";//"FooTest.*:TestCase.*:TestSuite.*:TestCaseTest.*:IsPrimeParamTest.*";

	//测试套排序，下面两种情况不能同时使用，否则排序就无作用
	//GTEST_FLAG(list_order) = "Test_Fhho;UT_DEMO;TestSuitName;FuncFoo;TestSuitEvent";
	//测试套模糊匹配排序，注：只以开头进行精确匹配，遇到 * 后模糊匹配
	//如UT_*;IT_*，先执行所有UT_开头的用例再执行IT_开头的用例
	/*GTEST_FLAG(dark_list_order) = "UT_*;\
		    IT_*";*/
    // Returns 0 if all tests passed, or 1 other wise.
	InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
    //return 0;
	//return ret;
}
