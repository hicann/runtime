# E20003 Config\_Error

## Symptom

The following is error format. The meanings of the placeholders %s in sequence are: configuration item, configuration file, error cause.

```text
Configuration item %s in configuration file %s is invalid. Reason: %s.
```

Error example:

```text
Configuration item false in configuration file /home/module/fusion_switch.json is invalid. Reason: The switch value of pass CustomSelfDefinePass must be on or off, instead of false.
```

## Possible Cause

The content or format of the configuration file does not comply with the specifications provided in the documentation.

## Solution

Modify the configuration file by referring to the specifications in the user guide.
