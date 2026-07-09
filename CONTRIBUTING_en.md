# Contributing Guide

This project welcomes developers to experience and contribute. Before participating in community contributions, refer to [cann-community](https://gitcode.com/cann/community) to understand the code of conduct, sign the CLA agreement, and learn about the contribution process for source code repositories.

Developers should pay attention to the following points when preparing local code and submitting PRs:

1. When submitting a PR, follow the PR template and carefully fill in the business background, purpose, and solution information for this PR.
2. If your modification is not a simple bug fix but involves adding new features, new interfaces, new configuration parameters, or modifying code flows, discuss the solution through an Issue first to avoid having your code rejected. If you are unsure whether your modification qualifies as a "simple bug fix", you can also submit an Issue for solution discussion.

Additionally, before coding, writing tests, and preparing design proposals, please read the development guides in the `docs/zh/guidelines/` directory first and follow the relevant standards:

- [Development Guide Overview](docs/zh/guidelines/README.md)
- [pre-commit Usage](docs/zh/guidelines/pre-commit_guide.md): For configuring pre-commit and running formatting and compliance checks before committing code
- [Coding Standards](docs/zh/guidelines/coding-guidelines.md): Unified coding standards for Runtime repository source code implementation
- [UT Coding Standards](docs/zh/guidelines/ut-coding-guidelines.md): Implementation standards for UT code under `tests/**`
- [UT Case Development Guide](docs/zh/guidelines/dt_guide/ut_case_development_guide.md): For UT scenario design, validation methods, and test implementation
- [Design Document Template](docs/zh/guidelines/design_document_template.md): For new features, interfaces, configuration parameters, or flow modifications, it is recommended to complete the design description using the template first

Follow these principles:

1. Before modifying source code, read and follow the corresponding coding standards.
2. When modifying UT code, in addition to the general coding standards, also follow `ut-coding-guidelines.md` and `UT Case Development Guide`.
3. For changes involving new capabilities, interfaces, or flow adjustments, complete the design description first before coding.

Developer contribution scenarios mainly include:

- Bug Fixes

    If you discover certain bugs in this project and want to fix them, you are welcome to create a new Issue for feedback and tracking.

    You can follow the [Submit Issue/Handle Issue Task](https://gitcode.com/cann/community#提交Issue处理Issue任务) guide to create a `Bug-Report|Defect Feedback` type Issue to describe the bug, then enter "/assign" or "/assign @yourself" in the comment box to assign the Issue to yourself for handling.

- Documentation Corrections

    If you discover errors in certain operator documentation descriptions in this project, you are welcome to create a new Issue for feedback and correction.

    You can follow the [Submit Issue/Handle Issue Task](https://gitcode.com/cann/community#提交Issue处理Issue任务) guide to create a `Documentation|Documentation Feedback` type Issue to point out the corresponding documentation issues, then enter "/assign" or "/assign @yourself" in the comment box to assign the Issue to yourself for correcting the corresponding documentation description.

- Help Resolve Others' Issues

    If you have appropriate solutions for problems encountered by others in the community, you are welcome to comment in the Issue for discussion, helping others solve problems and pain points, and jointly improving usability.

    If the corresponding Issue requires code modifications, you can enter "/assign" or "/assign @yourself" in the Issue comment box to assign the Issue to yourself for tracking and assisting in problem resolution.