# 配置AI Core栈空间大小

在CANN中，每个AI Core都拥有自己的私有堆栈，用于存储算子的局部变量和函数调用信息。应用进程在执行aclrtSetDevice时，CANN会为每个AI Core分配大小为aicore\_stack\_size的Device内存作为栈空间，总计为aicore\_stack\_size \* aicore\_num。默认情况下，aicore\_stack\_size =  32KB。

然而，某些算子在执行时所需的栈空间超过默认的32KB，比如以-O0方式编译用于调试的AI Core算子，其栈空间需求可能会超过32KB。如果不调整系统默认的栈空间大小，可能会导致算子执行异常（如栈溢出）。因此，用户需要在进程启动时，通过修改aclInit初始化接口的json文件来配置合适的AI Core栈空间大小。**注意：**栈空间占用的是Device内存，请按需设置。

json文件的配置示例如下，在aicore\_stack\_size参数处设置栈空间大小，单位为字节，详细使用说明请参见aclInit接口。

```
{
    "StackSize":{
        "aicore_stack_size":32768
    }
}
```

