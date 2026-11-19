# Runtime Error Message Development Guidelines

This directory is the unified specification source for Runtime/ACL Error Message rectification and review, and developers and AI agents share it. Maintain the rules for error codes, macros, error texts, and reporting boundaries in this directory first, so that multiple skills do not copy the rules separately and produce inconsistent standards.

## Document structure

| File | Purpose |
|------|------|
| [rectification-principles.md](rectification-principles.md) | Determine the rectification boundary, user errors and internal errors, parameter sources, the first failure site, defensive programming, repeated structured reporting, and print format specifications |
| [error-code-guide.md](error-code-guide.md) | Select Runtime EE and ACL EH error codes |
| [macro-selection-guide.md](macro-selection-guide.md) | Select ErrMsg external/internal error code reporting macros |
| [message-examples.md](message-examples.md) | View ErrMsg message templates, Arglist, typical expressions, and message rectification examples |
| [review-checklist.md](review-checklist.md) | Check whether an ErrMsg modification complies with the rules, focusing on the dual-source synchronization of error_code.json / error_code_meta.h, the macro parameter count, the error message syntax, and the parameter values |

## Usage

- When you determine whether to perform rectification, whether a location is the first failure site, and whether reporting is duplicated, and when you confirm the defensive programming and print format requirements, read `rectification-principles.md` first.
- When you select or review error codes, read `error-code-guide.md`. For ErrCode, ErrMessage, Arglist, and suggestion, use `src/dfx/error_manager/error_code.json` as the reference.
- When you select or review macros, read `macro-selection-guide.md`. Note the difference between the printf-style parameters of the `_INNER` series and the structured parameters of the `_OUTER` series.
- When you optimize error texts, read `message-examples.md`, and combine the templates and Arglist in `error_code.json` with the print format specifications in `rectification-principles.md`.
- Before you submit or review an ErrMsg modification, read `review-checklist.md` for a self-check. Confirm that `error_code.json` is synchronized with `error_code_meta.h`, the number of `%s` format specifiers matches the number of Arglist parameters, macro calls do not pass parameters repeatedly, and the suggestion and ErrMessage texts meet the format requirements.

## Source of truth

When the specification documents and the code are inconsistent, use the code as the reference and fix the specification documents at the same time. Key code sources include:

- `src/dfx/error_manager/error_code.json`
- `src/runtime/core/inc/common/error_code_meta.h`
- `src/runtime/core/inc/base.hpp`
- `src/runtime/core/inc/common/error_message_manage.hpp`
- `src/dfx/error_manager/error_manager.h`

## Maintenance principles

- This directory contains the formal specifications. Skills keep only the process and navigation, and do not copy the complete rules.
- When you modify error code, macro, or message specifications, also check whether the related documents in this directory need updates. When you add or adjust error codes, check and update `error_code.json`, `error_code_meta.h`, and `error-code-guide.md`. When you add or adjust reporting macros, check and update `macro-selection-guide.md`.
- `review-checklist.md` supports review and self-check. When you add common issues, parameter calculation rules, or dual-source synchronization requirements, add them to this checklist.
- When you add or adjust an ErrMsg call point, do not modify the business logic, return values, condition checks, or normal log levels, unless the requirement explicitly asks for it.
