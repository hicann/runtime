# EK0007 Invalid\_Argument

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: error mode, correct mode.

```text
Failed to start Profiling in %s mode because it is already in %s mode.
```

Error example:

```text
Failed to start Profiling in subscribe mode because it is already in aclapi mode.
```

## Possible Cause

Do not enable two or more profile data collection modes. Example: When Profiling is started using msprof command lines, do not use acl APIs in the app to start Profiling data collection.

## Solution

Change the Profiling startup mode as required.
