# AI Core Stack Size Configuration

<!-- md-trans-meta sourceCommit=c984fae7c73f88f7e9e16b034bea72bc18e7517c translatedAt=2026-10-16T10:21:49.966Z pushedAt=2026-10-20T09:21:59.112Z -->

In CANN, each AI Core has its own private stack, which is used to store the local variables and function call information of operators. When an application process executes **aclrtSetDevice**, CANN allocates device memory of **aicore\_stack\_size** for each AI Core as stack space, totaling **aicore\_stack\_size \* aicore\_num**. By default, aicore\_stack\_size = 32 KB.

However, some operators require more stack space than the default 32 KB during execution. For example, AI Core operators compiled with -O0 for debugging may require more than 32 KB of stack space. If the default stack space size is not adjusted, operator execution may become abnormal (for example, stack overflow). Therefore, users need to configure an appropriate AI Core stack space size by modifying the JSON file of the aclInit initialization API when the process starts. **Note:** The stack space occupies device memory. Set it as required.

The following is an example of the JSON file configuration. Set the stack space size at the **aicore\_stack\_size** parameter, in bytes. For details, see the aclInit API description.

```json
{
    "StackSize":{
        "aicore_stack_size":32768
    }
}
```
