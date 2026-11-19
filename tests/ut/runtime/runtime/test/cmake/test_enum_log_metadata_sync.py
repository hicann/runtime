#!/usr/bin/env python3
# Copyright (c) 2026 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.

"""Regressions for independent enum declarations and private log metadata."""

import re
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import enum_log_metadata_sync as sync


def repository_root():
    for parent in Path(__file__).resolve().parents:
        if (parent / "src/runtime/core/src/common/api_enum_log.cc").is_file():
            return parent
    raise RuntimeError("cannot locate the current Runtime source tree")


ROOT = repository_root()


class EnumMembersTest(unittest.TestCase):
    def test_ordinary_typedef_scoped_and_fixed_enums(self):
        declarations = (
            "enum Plain { FIRST, SECOND = 7, END };",
            "typedef enum { FIRST, SECOND = 7, END } Alias;",
            "typedef enum Tag { FIRST, SECOND = 7, END } Alias;",
            "enum class Scoped : uint64_t { FIRST, SECOND = 7, END };",
            "enum struct Scoped : unsigned int { FIRST, SECOND = 7, END };",
        )
        for declaration in declarations:
            with self.subTest(declaration=declaration):
                self.assertEqual(sync.enum_members(declaration, "FIRST"), ["FIRST", "SECOND", "END"])

    def test_sparse_alias_and_sentinel_are_independent_members(self):
        source = "enum Type { FIRST = 0, ALIAS = FIRST, SPARSE = 64, END = 128 };"
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "ALIAS", "SPARSE", "END"])

    def test_initializer_parentheses_and_strings_do_not_split_members(self):
        source = '''enum Type {
            FIRST = (1 << (2 + 1)),
            SECOND = VALUE(1, 2),
            THIRD = sizeof("comma, enum Fake { BAD }"),
            LAST = ')'
        };'''
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "SECOND", "THIRD", "LAST"])

    def test_last_member_does_not_require_trailing_comma(self):
        self.assertEqual(sync.enum_members("enum E { FIRST = 0, LAST = 1 };", "FIRST"), ["FIRST", "LAST"])

    def test_forward_declarations_do_not_replace_the_target_definition(self):
        source = "enum class Forward : uint32_t; enum Real { FIRST, LAST };"
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "LAST"])
        for declaration in ("enum class Forward : uint32_t;", "enum Incomplete"):
            with self.subTest(declaration=declaration), self.assertRaisesRegex(sync.SyncError, "FIRST"):
                sync.enum_members(declaration, "FIRST")

    def test_both_preprocessor_branches_belong_to_the_checked_domain(self):
        source = """enum Type {
            FIRST,
        #if defined(DEVICE_VARIANT)
            ON_VARIANT,
        #else
            OFF_VARIANT,
        #endif
            END
        };"""
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "ON_VARIANT", "OFF_VARIANT", "END"])

    def test_duplicate_members_in_conditional_branches_require_review(self):
        source = "enum Type { FIRST,\n#if VARIANT\nSAME,\n#else\nSAME,\n#endif\nEND };"
        with self.assertRaisesRegex(sync.SyncError, "duplicate.*SAME"):
            sync.enum_members(source, "FIRST")

    def test_same_type_name_in_other_namespaces_uses_unique_member_anchor(self):
        source = "namespace one { enum E { FIRST, LAST }; } namespace two { enum E { OTHER, OTHER_END }; }"
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "LAST"])
        self.assertEqual(sync.enum_members(source, "OTHER"), ["OTHER", "OTHER_END"])

    def test_unrelated_enum_attributes_do_not_bypass_target_validation(self):
        source = 'enum Unrelated { OLD DEPRECATED("reason") = 0 }; enum Target { FIRST, LAST };'
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "LAST"])
        with self.assertRaises(sync.SyncError):
            sync.enum_members(source.replace("FIRST, LAST", 'FIRST, LAST DEPRECATED("reason") = 1'), "FIRST")

    def test_ambiguous_or_absent_anchor_fails(self):
        source = "namespace one { enum E { FIRST }; } namespace two { enum E { FIRST }; }"
        for anchor in ("FIRST", "ABSENT"):
            with self.subTest(anchor=anchor), self.assertRaisesRegex(sync.SyncError, anchor):
                sync.enum_members(source, anchor)

    def test_comments_quoted_and_raw_strings_do_not_define_enums(self):
        source = r'''// enum Fake { FIRST, BAD };
            /* enum Fake { FIRST, BAD }; */
            const char *a = "enum Fake { FIRST, BAD }; \\\"";
            const char *b = R"tag(enum Fake { FIRST, BAD };)tag";
            const char *c = u8R"tag(enum Fake { FIRST, BAD };)tag";
            enum Real { FIRST /* , BAD */, LAST // , BAD
            };
        '''
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "LAST"])

    def test_line_splicing_precedes_line_comment_removal(self):
        source = "\\\n".join(("// continued comment ", "enum Fake { FIRST, BAD };\nenum Real { FIRST, LAST };"))
        self.assertEqual(sync.enum_members(source, "FIRST"), ["FIRST", "LAST"])
        self.assertEqual(sync.enum_members(source.replace("\n", "\r\n"), "FIRST"), ["FIRST", "LAST"])

    def test_duplicate_members_and_unsupported_declarations_fail(self):
        sources = (
            "enum E { FIRST, FIRST };",
            "enum E { FIRST,, LAST };",
            "enum E { FIRST OTHER };",
            "enum E { FIRST = };",
            "enum E { FIRST = (1, LAST };",
            "enum E { FIRST, LAST;",
        )
        for source in sources:
            with self.subTest(source=source), self.assertRaises(sync.SyncError):
                sync.enum_members(source, "FIRST")


class MetadataTablesTest(unittest.TestCase):
    def test_table_discovery_does_not_depend_on_the_rt_prefix(self):
        source = '#define OTHER_ENUM_META(X) X(FIRST, "FIRST")\n'
        self.assertEqual(sync.metadata_tables(source), {"OTHER_ENUM_META": ["FIRST"]})

    def test_multiple_multiline_tables_and_comments(self):
        source = '''#define RT_FIRST_META(X) \\
            X(FIRST, "FIRST") /* row comment */ \\
            X(LAST, \\
              "text, with ) and enum Fake { BAD }")
            #define RT_OTHER_META(ROW) ROW(OTHER, "OTHER")
        '''
        self.assertEqual(sync.metadata_tables(source), {"RT_FIRST_META": ["FIRST", "LAST"], "RT_OTHER_META": ["OTHER"]})

    def test_comments_and_strings_cannot_register_fake_tables(self):
        source = r'''// #define RT_COMMENT_META(X) X(BAD, "BAD")
            /* #define RT_BLOCK_META(X) X(BAD, "BAD") */
            const char *text = "#define RT_STRING_META(X) X(BAD, \"BAD\")";
            const char *raw = R"tag(
#define RT_RAW_META(X) X(BAD, "BAD")
)tag";
            #define RT_REAL_META(X) X(FIRST, "FIRST")
        '''
        self.assertEqual(sync.metadata_tables(source), {"RT_REAL_META": ["FIRST"]})

    def test_crlf_and_line_continuation_preserve_rows(self):
        source = "\\\n".join(('#define RT_TEST_META(X) ', 'X(FIRST, "FIRST") ', 'X(LAST, "LAST")\n'))
        self.assertEqual(sync.metadata_tables(source.replace("\n", "\r\n")), {"RT_TEST_META": ["FIRST", "LAST"]})

    def test_duplicate_or_empty_table_fails(self):
        sources = (
            '#define RT_TEST_META(X) X(FIRST, "FIRST")\n#define RT_TEST_META(X) X(LAST, "LAST")\n',
            "#define RT_TEST_META(X)\n",
        )
        for source in sources:
            with self.subTest(source=source), self.assertRaisesRegex(sync.SyncError, "RT_TEST_META"):
                sync.metadata_tables(source)

    def test_noncanonical_rows_fail_instead_of_skipping_a_table(self):
        bodies = (
            'OTHER(FIRST, "FIRST")',
            'X(FIRST)',
            'X(FIRST, 0, "FIRST")',
            'X(FIRST, "FIRST", EXTRA)',
            'X(scope::FIRST, "FIRST")',
            'X(FIRST, "FIRST") trailing',
            'X(FIRST, "FIRST"',
            'X(FIRST, )',
        )
        for body in bodies:
            with self.subTest(body=body), self.assertRaises(sync.SyncError):
                sync.metadata_tables("#define RT_TEST_META(X) " + body + "\n")

    def test_noncanonical_table_parameters_fail(self):
        for declaration in ("RT_TEST_META(X, Y)", "RT_TEST_META()", "RT_TEST_META"):
            with self.subTest(declaration=declaration), self.assertRaisesRegex(sync.SyncError, "RT_TEST_META"):
                sync.metadata_tables("#define " + declaration + ' X(FIRST, "FIRST")\n')


class CheckMembersTest(unittest.TestCase):
    def test_member_order_and_integer_holes_do_not_change_coverage(self):
        self.assertIsNone(sync.check_members("RT_TEST_META", ["FIRST", "SPARSE", "END"], ["END", "FIRST", "SPARSE"]))

    def test_missing_sparse_alias_or_sentinel_reports_exact_symbol(self):
        expected = ["FIRST", "ALIAS", "SPARSE", "END"]
        for omitted in expected:
            with self.subTest(omitted=omitted), self.assertRaisesRegex(sync.SyncError, "RT_TEST_META.*" + omitted):
                sync.check_members("RT_TEST_META", expected, [name for name in expected if name != omitted])

    def test_stale_and_duplicate_rows_report_exact_symbol(self):
        for actual in (["FIRST", "STALE"], ["FIRST", "FIRST"]):
            with self.subTest(actual=actual), self.assertRaisesRegex(sync.SyncError, "RT_TEST_META.*" + actual[-1]):
                sync.check_members("RT_TEST_META", ["FIRST"], actual)

    def test_exact_alias_exclusion_is_allowed(self):
        self.assertIsNone(sync.check_members("RT_TEST_META", ["FIRST", "ALIAS", "END"], ["FIRST", "END"], ("ALIAS",)))

    def test_exclusions_must_still_exist_and_must_not_have_a_row(self):
        for ignored in (("REMOVED_ALIAS",), ("FIRST",)):
            with self.subTest(ignored=ignored), self.assertRaisesRegex(sync.SyncError, "RT_TEST_META.*" + ignored[0]):
                sync.check_members("RT_TEST_META", ["FIRST", "ALIAS"], ["FIRST"], ignored)

    def test_an_existing_exclusion_cannot_hide_a_new_member(self):
        with self.assertRaisesRegex(sync.SyncError, "RT_TEST_META.*NEW_MEMBER"):
            sync.check_members("RT_TEST_META", ["FIRST", "ALIAS", "NEW_MEMBER"], ["FIRST"], ("ALIAS",))


class RepositoryMetadataTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.sources = {}
        cls.owners = {}
        for relative in sync.metadata_sources(ROOT):
            source = (ROOT / relative).read_text(encoding="utf-8")
            cls.sources[relative] = source
            for table in sync.metadata_tables(source):
                if table in cls.owners:
                    raise AssertionError("duplicate actual metadata table: " + table)
                cls.owners[table] = relative

    def table_block(self, table):
        """Locate an actual macro definition only to edit the mutation input."""
        source = self.sources[self.owners[table]]
        match = re.search(r"(?m)^[ \t]*#[ \t]*define[ \t]+" + re.escape(table) + r"\b[^\n]*(?:\n|$)", source)
        self.assertIsNotNone(match, table)
        end = match.end()
        line = match[0]
        while line.rstrip("\r\n").endswith("\\"):
            next_end = source.find("\n", end)
            next_end = len(source) if next_end < 0 else next_end + 1
            line = source[end:next_end]
            self.assertTrue(line, "unterminated actual macro: " + table)
            end = next_end
        return source, match.start(), end

    def missing_row_source(self, table):
        source, start, end = self.table_block(table)
        block = source[start:end]
        symbols = sync.metadata_tables(block)[table]
        # Every current table has a complete single-line row. Requiring one
        # avoids implementing a second C++ parser just to create a mutation.
        for symbol in symbols:
            row = re.search(r"(?m)^[ \t]*X\([ \t]*" + re.escape(symbol) + r"[ \t]*,[^\n]*\)[^\n]*(?:\n|$)", block)
            if row is not None:
                mutated_block = block[:row.start()] + block[row.end():]
                self.assertEqual(
                    sync.metadata_tables(mutated_block)[table], [name for name in symbols if name != symbol]
                )
                return symbol, source[:start] + mutated_block + source[end:]
        self.fail("no complete row available for mutation: " + table)

    def added_member_source(self, table):
        path, anchor, _ = sync.DOMAINS[table]
        source = (ROOT / path).read_text(encoding="utf-8")
        original = sync.enum_members(source, anchor)
        symbol = "RT_ENUM_SYNC_NEW_" + table
        # Match a declaration member, not a reference in a comment or switch.
        member = re.search(
            r"(?m)(?:^[ \t]*|\{[ \t]*)(?P<anchor>" + re.escape(anchor) + r")(?=[ \t]*(?:=|,|\}))", source
        )
        self.assertIsNotNone(member, "cannot mutate the actual enum declaration: " + table)
        # Keep the existing initializer intact by inserting before the anchor.
        position = member.start("anchor")
        mutated = source[:position] + symbol + " = 0, " + source[position:]
        expected = original[:original.index(anchor)] + [symbol] + original[original.index(anchor):]
        self.assertEqual(sync.enum_members(mutated, anchor), expected, table)
        return path, symbol, mutated

    def test_current_repository_tables_match_current_enum_declarations(self):
        result = sync.check_repository(ROOT)
        self.assertTrue(sync.DOMAINS, "the owner registry must not silently be empty")
        self.assertEqual(result["tables"], len(sync.DOMAINS))
        self.assertEqual(set(self.owners), set(sync.DOMAINS))
        expected_symbols = sum(
            len(sync.enum_members((ROOT / path).read_text(encoding="utf-8"), anchor)) - len(ignored)
            for path, anchor, ignored in sync.DOMAINS.values()
        )
        self.assertEqual(result["symbols"], expected_symbols)

    def test_each_table_detects_a_missing_actual_metadata_row(self):
        self.assertTrue(self.owners, "the mutation loop must execute")
        for table, path in self.owners.items():
            with self.subTest(table=table):
                symbol, mutated = self.missing_row_source(table)
                with self.assertRaisesRegex(sync.SyncError, re.escape(table) + r".*" + re.escape(symbol)):
                    sync.check_repository(ROOT, {path: mutated})

    def test_each_table_detects_an_actual_enum_member_added_without_a_row(self):
        self.assertTrue(sync.DOMAINS, "the mutation loop must execute")
        for table in sync.DOMAINS:
            with self.subTest(table=table):
                path, symbol, mutated = self.added_member_source(table)
                with self.assertRaisesRegex(sync.SyncError, re.escape(table) + r".*" + re.escape(symbol)):
                    sync.check_repository(ROOT, {path: mutated})

    def test_existing_alias_exclusion_requires_the_original_same_value_relationship(self):
        table = "RT_MEMCPY_DIRECTION_META"
        path, anchor, _ = sync.DOMAINS[table]
        source = (ROOT / path).read_text(encoding="utf-8")
        members = sync.enum_members(source, anchor)
        cases = (
            ("RT_MEMCPY_DIR_H2H", "1"),
            ("RT_MEMCPY_DIR_H2D", "99"),
            ("RT_MEMCPY_DIR_H2H", None),
            ("RT_MEMCPY_DIR_H2H", "RT_MEMCPY_DIR_H2D"),
        )
        for symbol, initializer in cases:
            with self.subTest(symbol=symbol, initializer=initializer):
                pattern = r"(?m)^([ \t]*" + re.escape(symbol) + r"[ \t]*)=[ \t]*0(?=[ \t]*,)"
                replacement = r"\g<1>" + ("" if initializer is None else "= " + initializer)
                mutated, changes = re.subn(pattern, replacement, source, count=1)
                self.assertEqual(changes, 1, "the alias mutation must edit the actual declaration")
                self.assertEqual(sync.enum_members(mutated, anchor), members)
                with self.assertRaisesRegex(sync.SyncError, table + ".*alias exception"):
                    sync.check_repository(ROOT, {path: mutated})


class RepositoryDiscoveryTest(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix="runtime-enum-sync-")
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        self.common = self.root / "src/runtime/core/src/common"
        self.common.mkdir(parents=True)
        self.enum_path = "owner.hpp"
        self.meta_path = "src/runtime/core/src/common/fixture_enum_log.cc"
        (self.root / self.enum_path).write_text("enum Type { FIRST, LAST };\n", encoding="utf-8")
        (self.root / self.meta_path).write_text(
            '#define RT_TEST_META(X) X(FIRST, "FIRST") X(LAST, "LAST")\n', encoding="utf-8"
        )
        registry = mock.patch.object(sync, "DOMAINS", {"RT_TEST_META": (self.enum_path, "FIRST", ())})
        registry.start()
        self.addCleanup(registry.stop)

    def test_current_sources_can_evolve_together_without_a_frozen_baseline(self):
        result = sync.check_repository(self.root)
        self.assertEqual(result, {"tables": 1, "symbols": 2})
        overrides = {
            self.enum_path: "enum Type { FIRST, ADDED = 64, LAST };\n",
            self.meta_path: '#define RT_TEST_META(X) X(FIRST, "FIRST") X(ADDED, "ADDED") X(LAST, "LAST")\n',
        }
        self.assertEqual(sync.check_repository(self.root, overrides), {"tables": 1, "symbols": 3})
        self.assertEqual(sync.check_repository(self.root), result, "overrides must not alter the source tree")

    def test_unregistered_table_in_an_existing_source_fails(self):
        source = (self.root / self.meta_path).read_text(encoding="utf-8")
        for table in ("RT_NEW_META", "OTHER_NEW_META"):
            with self.subTest(table=table):
                mutated = source + '#define ' + table + '(X) X(ADDED, "ADDED")\n'
                with self.assertRaisesRegex(sync.SyncError, "unregistered.*" + table):
                    sync.check_repository(self.root, {self.meta_path: mutated})

    def test_unregistered_table_in_a_new_mapping_source_fails(self):
        (self.common / "new_enum_log.cc").write_text('#define RT_NEW_META(X) X(ADDED, "ADDED")\n', encoding="utf-8")
        with self.assertRaisesRegex(sync.SyncError, "unregistered.*RT_NEW_META"):
            sync.check_repository(self.root)

    def test_unregistered_table_in_a_local_business_source_fails(self):
        local = self.root / sync.LOCAL_METADATA_SOURCES[0]
        local.parent.mkdir(parents=True)
        local.write_text('#define RT_LOCAL_META(X) X(LOCAL, "LOCAL")\n', encoding="utf-8")
        with self.assertRaisesRegex(sync.SyncError, "unregistered.*RT_LOCAL_META"):
            sync.check_repository(self.root)

    def test_registered_table_removed_from_a_local_business_source_fails(self):
        local_path = sync.LOCAL_METADATA_SOURCES[0]
        local = self.root / local_path
        local.parent.mkdir(parents=True)
        local.write_text('#define RT_LOCAL_META(X) X(FIRST, "FIRST") X(LAST, "LAST")\n', encoding="utf-8")
        with mock.patch.dict(sync.DOMAINS, {"RT_LOCAL_META": (self.enum_path, "FIRST", ())}):
            self.assertEqual(sync.check_repository(self.root), {"tables": 2, "symbols": 4})
            with self.assertRaisesRegex(sync.SyncError, "missing tables: RT_LOCAL_META"):
                sync.check_repository(self.root, {local_path: "// local table removed\n"})

    def test_registered_table_removed_from_sources_fails(self):
        with self.assertRaisesRegex(sync.SyncError, "missing tables: RT_TEST_META"):
            sync.check_repository(self.root, {self.meta_path: "// table removed\n"})

    def test_registered_owner_without_the_real_enum_fails(self):
        with self.assertRaisesRegex(sync.SyncError, "FIRST"):
            sync.check_repository(self.root, {self.enum_path: "enum Wrong { OTHER, OTHER_END };\n"})

    def test_new_table_with_an_independent_owner_can_be_registered(self):
        (self.root / "new_owner.hpp").write_text("enum NewType { NEW_FIRST, NEW_LAST };\n", encoding="utf-8")
        (self.common / "new_enum_log.cc").write_text(
            '#define RT_NEW_META(X) X(NEW_FIRST, "NEW_FIRST") X(NEW_LAST, "NEW_LAST")\n', encoding="utf-8"
        )
        with mock.patch.dict(sync.DOMAINS, {"RT_NEW_META": ("new_owner.hpp", "NEW_FIRST", ())}):
            self.assertEqual(sync.check_repository(self.root), {"tables": 2, "symbols": 4})

    def test_duplicate_table_in_another_mapping_source_fails(self):
        (self.common / "duplicate_enum_log.cc").write_text(
            '#define RT_TEST_META(X) X(FIRST, "FIRST")\n', encoding="utf-8"
        )
        with self.assertRaisesRegex(sync.SyncError, "duplicate.*RT_TEST_META"):
            sync.check_repository(self.root)


if __name__ == "__main__":
    unittest.main()
