# EZ2001 Execution\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: AI Core error information, fault type, fault information.

```text
%s\nFault %s occurs in the system: %s
```

Error example:

```text
An error occurs on the device(chipId:0, dieId:0), the serial number is 3, the error is aivec error error, core id is 0, error code = 95, dump info: pc start: 0x120041000068, current: 0x120041000118, sc error info: 0xffffffffffff, su error info: 0xeadbe7fe29c20002,0x80400000f800f7da, mte error info: 0x263000000040041, vec error info: 0xbf7f93fe007efefa, cube error info: 0, l1 error info: 0, aic error mask: 0x395856, para base: 0x120000200000, mte error: 0x80000000, aic cond: 0.
The extend info: errcode:(95) errorStr: The DDR address of the MTE instruction is out of range. subErrType: 0x4.
Fault RAS occurs in the system: [event_id:0x80e18400] New uncorrectable ECC / other uncorrectable memory error. For details about troubleshooting, see Health Management Error Definition.
```

## Solution

Please locate the issue as prompted in the error messsage.
