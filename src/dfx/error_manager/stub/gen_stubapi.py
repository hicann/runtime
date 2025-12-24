#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# -----------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Huawei Technologies Co., Ltd.
# This program is free software, you can redistribute it and/or modify it under the terms and conditions of
# CANN Open Software License Agreement Version 2.0 (the "License").
# Please refer to the License for details. You may not use this file except in compliance with the License.
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED,
# INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY, OR FITNESS FOR A PARTICULAR PURPOSE.
# See LICENSE in the root of the software repository for the full text of the License.
# -----------------------------------------------------------------------------------------------------------

import os
import re
import sys
import logging

"""
    generate stub func body by return type
"""
RETURN_STATEMENTS = {
    'ErrorManager&': '    static ErrorManager instance;\n'
                     '    return instance;',
    'error_message::Context&': '    return error_context_;',
    'std::string': '    return "";',
    'std::string&': '    static std::string s;\n'
                    '    return s;',
    'std::vector<ErrorManager::ErrorItem>&': '    static std::vector<ErrorManager::ErrorItem> item;\n'
                                             '    return item;',
    'std::vector<ErrorManager::ErrorItem>': '    return {};\n',
    'int32_t': '    return 0;',
    'bool': '    return false;',
    'void': '    return;',
    'ErrorManagerContext': '    return {};',
    'uint64_t': '    return 0;',
    'std::unique_ptr<const char_t[]>': '    return nullptr;',
    'unique_const_char_array': '    return nullptr;',
    'std::vector<ErrMsgRawItem>': '    return {};',
    'std::map': '    return {};',
}

"""
    white_list_for_debug, include_dir_key_words is to
    determines which header files to generate cc files from
    when DEBUG on
"""
white_list_for_debug = ["error_manager.h", "err_msg.h", "err_mgr.h"]
include_dir_key_words = [".", "base"]

"""
    this attr is used for symbol table visible
"""
GE_ATTR = 'GE_FUNC_DEV_VISIBILITY GE_FUNC_HOST_VISIBILITY'

"""
    max code len per line in hua_wei software programming specifications
"""
MAX_CODE_LEN_PER_LINE = 100

DEBUG = True

logging.basicConfig(stream=sys.stdout, format='[%(asctime)s] [%(lineno)s] %(levelname)s: %(message)s',
                    level=logging.INFO)

# skip some private methods to Reduce the size of stub.so
SKIP_METHODS = [
    "ParseJsonFile",
    "ReadJsonFile",
    "ClassifyCompileFailedMsg",
    "IsInnerErrorCode",
    "IsUserDefinedErrorCode",
    "IsParamCheckErrorId",
]


def need_generate_func(func_line):
    """
    :param func_line:
    :return:
    """
    if func_line.strip().endswith("default") or func_line.strip().endswith("delete") \
            or func_line.strip().startswith("typedef") or func_line.strip().startswith("using"):
        return False
    return True


def file_endswith_white_list_suffix(file):
    """
    :param file:
    :return:
    """
    if DEBUG:
        for suffix in white_list_for_debug:
            suffix = re.sub(r'^/*', '/', suffix)
            if file.endswith(suffix):
                return True
        return False
    else:
        return True


"""
    belows are patterns used for analyse .h file
"""
# pattern function
pattern_func = re.compile(r"""(^[\s]*)([a-zA-Z~_].*[)](?!.*{).*)(;.*)\n$""", re.VERBOSE | re.MULTILINE | re.DOTALL)
# pattern comment
pattern_comment = re.compile(r'^\s*//')
pattern_comment_2_start = re.compile(r'^\s*/[*]')
pattern_comment_2_end = re.compile(r'[*]/\s*$')
# pattern define
pattern_define = re.compile(r'^\s*#define')
pattern_define_return = re.compile(r'\\\s*$')
# pattern format_error_message
pattern_format_error_message = re.compile(r'^int32_t FormatErrorMessage')
pattern_format_error_message_return = re.compile(r'__attribute__')

pattern_format_report_inner_error = re.compile(r'^void ReportInnerError')
pattern_format_report_inner_error_return = re.compile(r'__attribute__')
# blank line
pattern_blank_line = re.compile(r'^\s*$')
# virtual,explicit,friend,static
pattern_keyword = re.compile(r'(virtual\s+|explicit\s+|friend\s+|static\s+)')
# lead space
pattern_leading_space = re.compile(r'(^[\s]*)[a-zA-Z~_]')
# functions will have patterns such as func ( or func(
# but operator is an exception; the class name is preceded by an operator, and the above mode does not exist
# format like :"operator = ()"
pattern_func_name = re.compile(r'([a-zA-Z0-9~_\-]+\s*|operator?.*)[(]')
# template
pattern_template = re.compile(r'^\s*template')
pattern_template_end = re.compile(r'>\s*$')
# namespace
pattern_namespace = re.compile(r'namespace.*{')
# class : which can handle classA a and {not on the same line, but if found ';' after class,then don't deal with
pattern_class = re.compile(r'^[\s]*(class|struct)\s+(%s\s+)?([a-zA-Z0-9_\-]+<?)(?!.*;)' % GE_ATTR)
# pattern for function body start and end
pattern_start = re.compile('{')
pattern_end = re.compile('}')
# pattern for format func
pat_format_func = re.compile(r"""^(
                                   (?:const[ ]+)?
                                   (?:
                                    [:\w]+
                                    |
                                    std::(?:vector|shared_ptr)<[:\w ]+>
                                    |
                                    std::(?:vector|shared_ptr)<std::vector<[:\w ]+>>
                                    |
                                    std::(?:map|unordered_map|pair)<[:\w]+[, ]+[:\w]+>
                                   )
                                  )
                                  ([ ]+)
                                  ([&*]+)""", re.VERBOSE)
# pattern for parsing ret_type & func_name
pat_search_func = re.compile(r"""^(?:const[ ]+)?
                                  (?P<ret_type>
                                   (?:
                                    [:\w]+
                                    |
                                    std::(?:vector|shared_ptr)<[:\w ]+>
                                    |
                                    std::(?:vector|shared_ptr)<std::vector<[:\w ]+>>
                                    |
                                    std::(?:map|unordered_map|pair)<[:\w]+[, ]+[:\w]+>
                                   )
                                   (?:[&*]+)?
                                  )
                                  [ ]+
                                  (?P<class_name>\w+)
                                  ::
                                  \n?
                                  (?P<func_name>\w+|operator=)
                                  [ ]*
                                  \(""", re.VERBOSE)


class H2CC(object):
    def __init__(self, input_file, output_file, shared_includes_content):
        """
        :param input_file:
        :param output_file:
        :param shared_includes_content:
        """
        self.input_file = input_file
        self.output_file = output_file
        self.shared_includes_content = shared_includes_content
        self.line_index = 0
        self.input_fd = open(self.input_file, 'r')
        self.input_content = self.input_fd.readlines()
        self.output_fd = open(self.output_file, 'w')

        # The state may be normal_now(in the middle of {}),class_now,namespace_now
        self.stack = []
        self.stack_class = []
        self.stack_template = []
        # record funcs generated by h2cc func
        self.func_list_exist = []

    def __del__(self):
        self.input_fd.close()
        self.output_fd.close()
        del self.stack
        del self.stack_class
        del self.stack_template
        del self.func_list_exist

    def just_skip(self):
        # skip blank line or comment
        if pattern_blank_line.search(self.input_content[self.line_index]) or pattern_comment.search(
                self.input_content[self.line_index]):  # /n or comment using //
            self.line_index += 1
        if pattern_comment_2_start.search(self.input_content[self.line_index]):  # comment using /*
            while not pattern_comment_2_end.search(self.input_content[self.line_index]):  # */
                self.line_index += 1
            self.line_index += 1
        # skip define
        if pattern_define.search(self.input_content[self.line_index]):
            while pattern_blank_line.search(self.input_content[self.line_index]) or pattern_define_return.search(
                    self.input_content[self.line_index]):
                self.line_index += 1
            self.line_index += 1
        # skip FormatErrorMessage with __attribute__
        if pattern_format_error_message.search(self.input_content[self.line_index]) and \
           pattern_format_error_message_return.search(self.input_content[self.line_index + 1]):
            self.line_index += 2
        # skip ReportInnerError with __attribute__
        if pattern_format_report_inner_error.search(self.input_content[self.line_index]) and \
           pattern_format_report_inner_error_return.search(self.input_content[self.line_index + 1]):
            self.line_index += 2

    def write_inc_content(self):
        for shared_include_content in self.shared_includes_content:
            self.output_fd.write(shared_include_content)

    def should_skip_func(self, func_line):
        return any(skip_method in func_line for skip_method in SKIP_METHODS)

    def h2cc(self):
        """
        :return:
        """
        logging.info("start generate cc_file[%s] from h_file[%s]", self.output_file, self.input_file)
        # write inc content
        self.write_inc_content()
        # core processing cycle, process the input .h file by line
        while self.line_index < len(self.input_content):
            # handle comment and blank line
            self.just_skip()

            # match namespace
            self.handle_namespace()

            # match template
            template_string = self.handle_template()
            # match class
            line = self.input_content[self.line_index]
            match_class = pattern_class.search(line)
            match_start = pattern_start.search(line)
            handle_class_result = self.handle_class(template_string, line, match_start, match_class)
            if handle_class_result == "continue":
                continue

            # match "}"
            handle_stack_result = self.handle_stack(match_start)
            if handle_stack_result == "continue":
                continue
            # handle func
            handle_func1_result, line, start_i = self.handle_func1(line)
            if handle_func1_result == "continue":
                continue

            if self.should_skip_func(line):
                self.line_index += 1
                continue

            # here means func is found
            # delete key word
            line = pattern_keyword.sub('', line)
            logging.info("line[%s]", line)

            # Class member function
            # if friend we will not add class name
            friend_match = re.search('friend ', line)
            if len(self.stack_class) > 0 and not friend_match:
                line, func_name = self.handle_class_member_func(line, template_string)
            # Normal functions
            else:
                line, func_name = self.handle_normal_func(line, template_string)

            need_generate = need_generate_func(line)
            # func body
            line += self.implement_function(line)
            # comment
            line = self.gen_comment(start_i) + line
            # write to out file
            self.write_func_content(line, func_name, need_generate)
            # next loop
            self.line_index += 1

        if self.input_file.endswith('error_manager.h'):
            self.output_fd.write('thread_local error_message::Context ErrorManager::error_context_;')

        logging.info('Added %s functions', len(self.func_list_exist))
        logging.info('Successfully converted,please see ' + self.output_file)

    def handle_func1(self, line):
        """
        :param line:
        :return:
        """
        find1 = re.search('[(]', line)
        if not find1:
            self.line_index += 1
            return "continue", line, None
        find2 = re.search('[)]', line)
        start_i = self.line_index
        space_match = pattern_leading_space.search(line)
        # deal with
        # int abc(int a,
        #        int b)
        if find1 and (not find2):
            self.line_index += 1
            line2 = self.input_content[self.line_index]
            if space_match:
                line2 = re.sub('^' + space_match.group(1), '', line2)
            line += line2
            while self.line_index < len(self.input_content) and (not re.search('[)]', line2)):
                self.line_index += 1
                line2 = self.input_content[self.line_index]
                line2 = re.sub('^' + space_match.group(1), '', line2)
                line += line2

        match_start = pattern_start.search(self.input_content[self.line_index])
        match_end = pattern_end.search(self.input_content[self.line_index])
        if match_start:  # like  ) {  or ) {}    int the last line
            if not match_end:
                self.stack.append('normal_now')
            ii = start_i
            while ii <= self.line_index:
                ii += 1
            self.line_index += 1
            return "continue", line, start_i
        logging.info("line[%s]", line)
        # '  int abc();'->'int abc()'
        (line, match) = pattern_func.subn(r'\2\n', line)
        logging.info("line[%s]", line)
        # deal with case of 'return type' and 'func_name' are not in the same line, like: 'int \n abc(int a, int b)'
        if re.search(r'^\s*(inline)?\s*[a-zA-Z0-9_]+\s*$', self.input_content[start_i - 1]):
            line = self.input_content[start_i - 1] + line
        line = line.lstrip()
        if not match:
            self.line_index += 1
            return "continue", line, start_i
        return "pass", line, start_i

    def handle_stack(self, match_start):
        """
        :param match_start:
        :return:
        """
        line = self.input_content[self.line_index]
        match_end = pattern_end.search(line)
        if match_start:
            self.stack.append('normal_now')
        if match_end:
            top_status = self.stack.pop()
            if top_status == 'namespace_now':
                self.output_fd.write(line + '\n')
            elif top_status == 'class_now':
                self.stack_class.pop()
                self.stack_template.pop()
        if match_start or match_end:
            self.line_index += 1
            return "continue"

        if len(self.stack) > 0 and self.stack[-1] == 'normal_now':
            self.line_index += 1
            return "continue"
        return "pass"

    def handle_class(self, template_string, line, match_start, match_class):
        """
        :param template_string:
        :param line:
        :param match_start:
        :param match_class:
        :return:
        """
        if not match_class:  # we face a class
            return "pass"
        self.stack_template.append(template_string)
        self.stack.append('class_now')
        class_name = match_class.group(3)

        # class template specializations: class A<u,Node<u> >
        if '<' in class_name:
            k = line.index('<')
            fit = 1
            for ii in range(k + 1, len(line)):
                if line[ii] == '<':
                    fit += 1
                if line[ii] == '>':
                    fit -= 1
                if fit == 0:
                    break
            class_name += line[k + 1:ii + 1]
        logging.info('class_name[%s]', class_name)
        self.stack_class.append(class_name)
        while not match_start:
            self.line_index += 1
            line = self.input_content[self.line_index]
            match_start = pattern_start.search(line)
        self.line_index += 1
        return "continue"

    def handle_template(self):
        line = self.input_content[self.line_index]
        match_template = pattern_template.search(line)
        template_string = ''
        if match_template:
            match_template_end = pattern_template_end.search(line)
            template_string = line
            while not match_template_end:
                self.line_index += 1
                line = self.input_content[self.line_index]
                template_string += line
                match_template_end = pattern_template_end.search(line)
            self.line_index += 1
        return template_string

    def handle_namespace(self):
        line = self.input_content[self.line_index]
        match_namespace = pattern_namespace.search(line)
        if match_namespace:  # we face namespace
            self.output_fd.write(line + '\n')
            self.stack.append('namespace_now')
            self.line_index += 1

    def handle_normal_func(self, line, template_string):
        template_line = ''
        self.stack_template.append(template_string)
        if self.stack_template[-1] != '':
            template_line = re.sub(r'\s*template', 'template', self.stack_template[-1])
            # change '< class T = a, class U = A(3)>' to '<class T, class U>'
            template_line = re.sub(r'\s*=.*>(\s*)$', r'>\1', template_line)
            template_line = re.sub(r'\s*=.*,', ',', template_line)
            template_line = re.sub(r'\s*=.*', '', template_line)
        line = re.sub(r'\s*=.*,', ',', line)
        line = re.sub(r'\s*=.*\)', ')', line)
        line = re.sub(r'\sWEAK_SYMBOL', '', line)
        line = re.sub(r'\sFORMAT_PRINTF\(5, 6\)', '', line)
        line = re.sub(r'\sFORMAT_PRINTF\(2, 3\)', '', line)
        line = template_line + line
        self.stack_template.pop()
        func_name = re.search(r'^.*\)', line, re.MULTILINE | re.DOTALL).group()
        logging.info("line[%s]", line)
        logging.info("func_name[%s]", func_name)
        return line, func_name

    def handle_class_member_func(self, line, template_string):
        template_line = ''
        x = ''
        if template_string != '':
            template_string = re.sub(r'\s*template', 'template', template_string)
            template_string = re.sub(r'\s*=.*>(\s*)$', r'>\1', template_string)
            template_string = re.sub(r'\s*=.*,', ',', template_string)
            template_string = re.sub(r'\s*=.*', '', template_string)
        if self.stack_template[-1] != '':
            if not (re.search(r'<\s*>', stack_template[-1])):
                template_line = re.sub(r'^\s*template', 'template', stack_template[-1])
                if not (re.search(r'<.*>', self.stack_class[-1])):
                    # for x we get like template<class T, typename U> -> <T,U>
                    x = re.sub(r'template\s*<', '<', template_line)  # remove template -> <class T, typename U>
                    x = re.sub(r'\n', '', x)
                    x = re.sub(r'\s*=.*,', ',', x)
                    x = re.sub(r'\s*=.*\>', '>', x)
                    x = x.rstrip()  # remove \n
                    x = re.sub(r'(class|typename)\s+|(<class>|<typename>\s*class)', '',
                               x)  # remove class,typename ->  <T, U>
                    x = re.sub(r'<\s+', '<', x)
                    x = re.sub(r'\s+>', '>', x)
                    x = re.sub(r'\s+,', ',', x)
                    x = re.sub(r',\s+', ', ', x)
        line = re.sub(r'\s*=\s+0', '', line)
        line = re.sub(r'\s*=\s+.*,', ',', line)
        line = re.sub(r'\s*=\s+.*\)', ')', line)
        logging.info("x[%s]\nline[%s]", x, line)
        # if the function is long, void ABC::foo()
        # breaks into two lines void ABC::\n foo()
        rep_fmt = '%s%s::{}%s' % (self.stack_class[-1], x, r'\1(')
        temp_line = pattern_func_name.sub(rep_fmt.format(''), line, count=1)
        if len(temp_line) > MAX_CODE_LEN_PER_LINE:
            line = pattern_func_name.sub(rep_fmt.format('\n'), line, count=1)
        else:
            line = temp_line
        logging.info("line[%s]", line)
        # add template as the above if there is one
        template_line = re.sub(r'\s*=.*>(\s*)$', r'>\1', template_line)
        template_line = re.sub(r'\s*=.*,', ',', template_line)
        template_line = re.sub(r'\s*=.*', '', template_line)
        line = template_line + template_string + line
        func_name = re.search(r'^.*\)', line, re.MULTILINE | re.DOTALL).group()
        line = re.sub(r'std::vector<ErrorItem>', 'std::vector<ErrorManager::ErrorItem>', line)
        logging.info("line[%s]", line)
        logging.info("func_name[%s]", func_name)
        return line, func_name

    def write_func_content(self, content, func_name, need_generate):
        if not (func_name in self.func_list_exist) and need_generate:
            self.output_fd.write(content)
            self.func_list_exist.append(func_name)
            logging.info('add func:[%s]', func_name)

    def gen_comment(self, start_i):
        comment_line = ''
        # Function comments are on top of function declarations, copy them over
        k = start_i - 1  # one line before this func start
        if pattern_template.search(self.input_content[k]):
            k -= 1
        if pattern_comment_2_end.search(self.input_content[k]):
            comment_line = self.input_content[k].lstrip()
            while not pattern_comment_2_start.search(self.input_content[k]):
                k -= 1
                comment_line = self.input_content[k].lstrip() + comment_line
        else:
            for j in range(k, 0, -1):
                c_line = self.input_content[j]
                if pattern_comment.search(c_line):
                    c_line = re.sub(r'\s*//', '//', c_line)
                    comment_line = c_line + comment_line
                else:
                    break
        return comment_line

    @staticmethod
    def get_return_statements(func):
        func = pat_format_func.sub(r'\1\3\2', func)
        m = pat_search_func.search(func)
        if not m:
            return None
        logging.info('ret_type: %s, class_name: %s, func_name: %s', *m.group('ret_type', 'class_name', 'func_name'))
        type_cls_func_name = '%s %s::%s' % m.group('ret_type', 'class_name', 'func_name')
        if type_cls_func_name in RETURN_STATEMENTS:
            logging.info('type_cls_func_name:[%s] matched!', type_cls_func_name)
            return RETURN_STATEMENTS[type_cls_func_name]
        type_cls_name = '%s %s::' % m.group('ret_type', 'class_name')
        if type_cls_name in RETURN_STATEMENTS:
            logging.info('type_cls_name:[%s] matched!', type_cls_name)
            return RETURN_STATEMENTS[type_cls_name]
        type_only = m.group('ret_type')
        if type_only in RETURN_STATEMENTS:
            logging.info('type_only:[%s] matched!', type_only)
            return RETURN_STATEMENTS[type_only]
        return None

    @staticmethod
    def implement_function(func):
        function_def = ''
        function_def += '{\n'

        return_statements = H2CC.get_return_statements(func)
        if return_statements is not None:
            function_def += return_statements
        else:
            all_items = func.split()
            start = 0
            return_type = all_items[start]
            if return_type == "const":
                start += 1
                return_type = all_items[start]
            if return_type.startswith(('std::map', 'std::set', 'std::vector')):
                return_type = "std::map"
            if return_type.endswith('*') or (
                    len(all_items) > start + 1 and all_items[start + 1].startswith('*')) or return_type.startswith(
                'std::unique_ptr'):
                return_type = "Ptr"
            if len(all_items) > start + 1 and all_items[start + 1].startswith('&'):
                return_type += "&"
            if RETURN_STATEMENTS.__contains__(return_type):
                function_def += RETURN_STATEMENTS[return_type]
            else:
                logging.info("Unhandled func[%s]", func)
                logging.warning("Unhandled return type[%s]", return_type)

        function_def += '\n'
        function_def += '}\n'
        function_def += '\n'
        return function_def


def collect_header_files(path):
    """
    :param path:
    :return:
    """
    header_files = []
    shared_includes_content = []
    for root, dirs, files in os.walk(path):
        files.sort()
        dirs.sort()
        for file in files:
            if file.find("git") >= 0:
                continue
            if not file.endswith('.h'):
                continue
            file_path = os.path.join(root, file)
            file_path = file_path.replace('\\', '/')
            header_files.append(file_path)
            include_str = '#include "{}"\n'.format(file_path[path.rindex('/') + 1:])
            shared_includes_content.append(include_str)
    # for acl error code
    shared_includes_content.append('#include <iostream>\n')
    return header_files, shared_includes_content


def generate_stub_file(inc_dir, out_cc_dir):
    """
    :param inc_dir:
    :param out_cc_dir:
    :return:
    """
    target_header_files, shared_includes_content = collect_header_files(inc_dir)
    for header_file in target_header_files:
        if not file_endswith_white_list_suffix(header_file):
            continue
        cc_file = re.sub(r'([^/]+)\.h$', r'stub_\1.cc', header_file)
        h_2_cc = H2CC(header_file, out_cc_dir + cc_file[cc_file.rindex('/') + 1:], shared_includes_content)
        h_2_cc.h2cc()


def gen_code(inc_dir, out_cc_dir):
    """
    :param inc_dir:
    :param out_cc_dir:
    :return:
    """
    if not inc_dir.endswith('/'):
        inc_dir += '/'
    if not out_cc_dir.endswith('/'):
        out_cc_dir += '/'
    for include_dir_key_word in include_dir_key_words:
        generate_stub_file(inc_dir + include_dir_key_word, out_cc_dir)


def main():
    if len(sys.argv) != 3:
        logging.error("script %s must have 2 input parameters!" % sys.argv[0])
        return
    inc_dir = sys.argv[1]
    out_cc_dir = sys.argv[2]
    gen_code(inc_dir, out_cc_dir)


if __name__ == '__main__':
    main()
