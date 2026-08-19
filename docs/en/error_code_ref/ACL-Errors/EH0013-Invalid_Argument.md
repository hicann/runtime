# EH0013 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error stage \(or API name\), API name, error code, error cause, extended information.

```text
%s failed. Reason: Standard function %s failed. [Errno %s] %s. %s
```

Error example:

```text
acltdtSendTensor failed. Reason: Standard function memcpy_s failed. [Errno 22] Invalid argument. src=0x1234, dst=0x5678, dstLen=1024, srcLen=512
```

## Solution

Please locate the issue based on the prompts in the error message.
