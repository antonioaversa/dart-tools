import 'dart:convert';
import 'dart:io';
import 'package:yaml/yaml.dart';

final List<String> ruleSetNames = [
  "core.yaml",
  "flutter.yaml",
  "recommended.yaml",
  "all_lint_rules.yaml",
];

// From the Google Sheets "Dart rules to import"
final List<List<String>> ruleSets = [
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["Y","Y","Y","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["Y","N","N","Y"],
  ["Y","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","Y","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","Y","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
  ["N","N","N","Y"],
];

// From the Google Sheets "Dart rules to import"
final List<String> ruleNames = [
  "empty_constructor_bodies",
  "prefer_null_aware_operators",
  "camel_case_types",
  "no_leading_underscores_for_local_identifiers",
  "avoid_empty_else",
  "prefer_if_null_operators",
  "camel_case_extensions",
  "null_check_on_nullable_type_parameter",
  "avoid_renaming_method_parameters",
  "prefer_is_empty",
  "prefer_final_fields",
  "unnecessary_string_escapes",
  "prefer_iterable_whereType",
  "constant_identifier_names",
  "await_only_futures",
  "package_names",
  "provide_deprecation_message",
  "prefer_function_declarations_over_variables",
  "annotate_overrides",
  "empty_catches",
  "curly_braces_in_flow_control_structures",
  "unnecessary_overrides",
  "use_rethrow_when_possible",
  "control_flow_in_finally",
  "avoid_returning_null_for_void",
  "recursive_getters",
  "empty_statements",
  "hash_and_equals",
  "unrelated_type_equality_checks",
  "prefer_collection_literals",
  "avoid_null_checks_in_equality_operators",
  "exhaustive_cases",
  "prefer_conditional_assignment",
  "prefer_generic_function_type_aliases",
  "collection_methods_unrelated_type",
  "depend_on_referenced_packages",
  "prefer_relative_imports",
  "avoid_init_to_null",
  "prefer_interpolation_to_compose_strings",
  "avoid_types_as_parameter_names",
  "avoid_shadowing_type_parameters",
  "avoid_return_types_on_setters",
  "prefer_is_not_operator",
  "file_names",
  "prefer_typing_uninitialized_variables",
  "avoid_relative_lib_imports",
  "no_duplicate_case_values",
  "no_wildcard_variable_uses",
  "avoid_function_literals_in_foreach_calls",
  "avoid_single_cascade_in_expression_statements",
  "valid_regexps",
  "dangling_library_doc_comments",
  "implementation_imports",
  "implicit_call_tearoffs",
  "library_annotations",
  "library_prefixes",
  "library_private_types_in_public_api",
  "no_leading_underscores_for_library_prefixes",
  "non_constant_identifier_names",
  "null_closures",
  "overridden_fields",
  "prefer_adjacent_string_concatenation",
  "prefer_contains",
  "prefer_for_elements_to_map_fromIterable",
  "prefer_initializing_formals",
  "prefer_inlined_adds",
  "prefer_is_not_empty",
  "prefer_spread_collections",
  "slash_for_doc_comments",
  "type_init_formals",
  "type_literal_in_constant_pattern",
  "unnecessary_brace_in_string_interps",
  "unnecessary_const",
  "unnecessary_constructor_name",
  "unnecessary_this",
  "unnecessary_late",
  "unnecessary_new",
  "unnecessary_null_aware_assignments",
  "unnecessary_null_in_if_null_operators",
  "unnecessary_nullable_for_final_variable_declarations",
  "unnecessary_string_interpolations",
  "unnecessary_to_list_in_spreads",
  "use_function_type_syntax_for_parameters",
  "unnecessary_getters_setters",
  "use_string_in_part_of_directives",
  "use_super_parameters",
  "void_checks",
  "secure_pubspec_urls",
  "deprecated_member_use_from_same_package",
  "literal_only_boolean_expressions",
  "avoid_print",
  "unnecessary_statements",
  "invariant_booleans",
  "discarded_futures",
  "no_self_assignments",
  "implicit_reopen",
  "no_adjacent_strings_in_list",
  "iterable_contains_unrelated_type",
  "list_remove_unrelated_type",
  "prefer_void_to_null",
  "avoid_returning_null_for_future",
  "throw_in_finally",
  "always_use_package_imports",
  "avoid_dynamic_calls",
  "avoid_slow_async_io",
  "avoid_type_to_string",
  "avoid_unstable_final_fields",
  "avoid_web_libraries_in_flutter",
  "cancel_subscriptions",
  "close_sinks",
  "comment_references",
  "diagnostic_describe_all_properties",
  "invalid_case_patterns",
  "invalid_runtime_check_with_js_interop_types",
  "missing_code_block_language_in_doc_comment",
  "no_logic_in_create_state",
  "test_types_in_equals",
  "unintended_html_in_doc_comment",
  "unsafe_html",
  "use_build_context_synchronously",
  "use_key_in_widget_constructors",
  "avoid_unused_constructor_parameters",
  "prefer_null_aware_method_calls",
  "avoid_bool_literals_in_conditional_expressions",
  "no_literal_bool_comparisons",
  "unnecessary_null_checks",
  "matching_super_parameters",
  "lines_longer_than_80_chars",
  "use_string_buffers",
  "parameter_assignments",
  "unnecessary_lambdas",
  "library_names",
  "unnecessary_parenthesis",
  "avoid_multiple_declarations_per_line",
  "eol_at_end_of_file",
  "only_throw_errors",
  "use_named_constants",
  "use_test_throws_matchers",
  "avoid_catching_errors",
  "always_put_control_body_on_new_line",
  "avoid_void_async",
  "prefer_final_in_for_each",
  "prefer_final_locals",
  "omit_local_variable_types",
  "unnecessary_await_in_return",
  "avoid_setters_without_getters",
  "no_default_cases",
  "sort_constructors_first",
  "sort_unnamed_constructors_first",
  "avoid_redundant_argument_values",
  "avoid_catches_without_on_clauses",
  "use_raw_strings",
  "avoid_equals_and_hash_code_on_mutable_classes",
  "use_full_hex_values_for_flutter_colors",
  "prefer_asserts_with_message",
  "use_setters_to_change_properties",
  "prefer_const_declarations",
  "package_api_docs",
  "public_member_api_docs",
  "avoid_js_rounded_ints",
  "cascade_invocations",
  "unnecessary_raw_strings",
  "leading_newlines_in_multiline_strings",
  "type_annotate_public_apis",
  "super_goes_last",
  "always_declare_return_types",
  "always_put_required_named_parameters_first",
  "always_require_non_null_named_parameters",
  "always_specify_types",
  "annotate_redeclares",
  "avoid_annotating_with_dynamic",
  "avoid_as",
  "avoid_classes_with_only_static_members",
  "avoid_double_and_int_checks",
  "avoid_escaping_inner_quotes",
  "avoid_field_initializers_in_const_classes",
  "avoid_final_parameters",
  "avoid_implementing_value_types",
  "avoid_positional_boolean_parameters",
  "avoid_private_typedef_functions",
  "avoid_returning_null",
  "avoid_returning_this",
  "avoid_types_on_closure_parameters",
  "avoid_unnecessary_containers",
  "cast_nullable_to_non_nullable",
  "combinators_ordering",
  "conditional_uri_does_not_exist",
  "deprecated_consistency",
  "directives_ordering",
  "do_not_use_environment",
  "document_ignores",
  "enable_null_safety",
  "flutter_style_todos",
  "join_return_with_assignment",
  "missing_whitespace_between_adjacent_strings",
  "no_runtimeType_toString",
  "noop_primitive_operations",
  "one_member_abstracts",
  "package_prefixed_library_names",
  "prefer_asserts_in_initializer_lists",
  "prefer_bool_in_asserts",
  "prefer_const_constructors",
  "prefer_const_constructors_in_immutables",
  "prefer_const_literals_to_create_immutables",
  "prefer_constructors_over_static_methods",
  "prefer_double_quotes",
  "prefer_equal_for_default_values",
  "prefer_expression_function_bodies",
  "prefer_final_parameters",
  "prefer_foreach",
  "prefer_if_elements_to_conditional_expressions",
  "prefer_int_literals",
  "prefer_mixin",
  "prefer_single_quotes",
  "require_trailing_commas",
  "sized_box_for_whitespace",
  "sized_box_shrink_expand",
  "sort_child_properties_last",
  "tighten_type_of_initializing_formals",
  "unawaited_futures",
  "unnecessary_breaks",
  "unnecessary_final",
  "unnecessary_library_directive",
  "unnecessary_library_name",
  "unnecessary_null_aware_operator_on_extension_on_nullable",
  "unreachable_from_main",
  "use_colored_box",
  "use_decorated_box",
  "use_enums",
  "use_if_null_to_convert_nulls_to_bools",
  "use_is_even_rather_than_modulo",
  "use_late_for_private_fields_and_variables",
  "use_to_and_as_if_applicable",
  "sort_pub_dependencies",
];

Future<void> updateCountsFromUrl(
    List<int> ruleSetCounts,
    List<int> counts,
    String url,
    HttpClient httpClient) async {
  final gitHubUrl = url
      .replaceAll("sourcegraph.com/github.com", "raw.githubusercontent.com")
      .replaceAll("-", "master")
      .replaceAll("/blob", "");
  print("Processing URL '$gitHubUrl'...");

  final request = await httpClient.getUrl(Uri.parse(gitHubUrl));
  final response = await request.close();
  final yamlContent = await response.transform(utf8.decoder).join();
  final yamlObject = loadYaml(yamlContent);

  if (yamlObject['include'] case String includePath) {
    updateRuleSetCountsFromInclude(ruleSetCounts, includePath);
  }

  if (yamlObject['include'] case String includePath) {
    // TODO: disabled
    //updateCountsFromInclude(counts, includePath);
  }

  if (yamlObject['linter'] case YamlMap linterSection) {
    // TODO: disabled
    //if (linterSection['rules'] case YamlMap linterRules) {
    //  updateCountsFromLinterRulesList(counts, linterRules);
    //}
  }

  print("Processed URL '$gitHubUrl'");
}

int getRuleSetIndexFromIncludePath(String includePath) {
  for (var i = 0; i < ruleSetNames.length; i++) {
    if (includePath.toLowerCase().endsWith(ruleSetNames[i].toLowerCase())) {
      return i;
    }
  }
  print("Not recognized: $includePath");
  return -1;
}

void updateRuleSetCountsFromInclude(List<int> profileCounts, String includePath) {
  var ruleSetIndex = getRuleSetIndexFromIncludePath(includePath);
  if (ruleSetIndex >= 0) {
    profileCounts[ruleSetIndex]++;
  }
}

void updateCountsFromInclude(List<int> counts, String includePath) {
  var ruleSetIndex = getRuleSetIndexFromIncludePath(includePath);
  if (ruleSetIndex >= 0) {
    for (var ruleIndex = 0; ruleIndex < ruleSets.length; ruleIndex++) {
      if (ruleSets[ruleIndex][ruleSetIndex] == "Y") {
        counts[ruleIndex]++;
      }
    }
  }
}

void updateCountsFromLinterRulesList(List<int> counts, YamlMap linterRules) {
  for (var linterRuleKey in linterRules.keys) {
    final linterRuleActive = linterRules[linterRuleKey];
    final ruleIndex = ruleNames.indexOf(linterRuleKey);
    if (ruleIndex < 0) {
      throw Exception("Invalid rule name $linterRuleKey");
    }
    counts[ruleIndex] += linterRuleActive ? 1 : -1;
  }
}

void printCounts(List<int> counts) {
  for (var i = 0; i < counts.length; i++) {
    print("${ruleNames[i]}\t${counts[i]}");
  }
}

Future<void> writeRuleSetCountsToFile(List<int> ruleSetCounts, String filePath) async {
  var stringBuffer = StringBuffer();
  for (var i = 0; i < ruleSetCounts.length; i++) {
    stringBuffer.writeln("${ruleSetNames[i]}\t${ruleSetCounts[i]}");
  }

  final File file = File(filePath);
  final String fileContent = stringBuffer.toString();
  await file.writeAsString(fileContent);
}

Future<void> writeCountsToFile(List<int> counts, String filePath) async {
  var stringBuffer = StringBuffer();
  for (var i = 0; i < counts.length; i++) {
    stringBuffer.writeln("${ruleNames[i]}\t${counts[i]}");
  }

  final File file = File(filePath);
  final String fileContent = stringBuffer.toString();
  await file.writeAsString(fileContent);
}

void main(List<String> arguments) async {
  final httpClient = HttpClient();
  final ruleSetCounts = List.filled(3, 0);
  final counts = List.filled(ruleSets.length, 0);
  final file = File("data_in/urls.txt");
  final lines = file.openRead().transform(utf8.decoder).transform(LineSplitter());
  var urlIndex = 0;
  await for (var line in lines) {
    try {
      await updateCountsFromUrl(ruleSetCounts, counts, line, httpClient);
      await writeRuleSetCountsToFile(ruleSetCounts, "data_out/ruleSetCounts_$urlIndex.txt");
      await writeCountsToFile(counts, "data_out/counts_$urlIndex.txt");
      //await Future.delayed(Duration(seconds: 5));
    } catch (e) {
      print("Error: $e");
    }

    urlIndex++;
  }

  printCounts(counts);
}
