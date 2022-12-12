import 'dart:isolate';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:custom_lint_example_lint/avoid_passing_optional_positional_parameters.dart';
import 'package:custom_lint_example_lint/riverpod_lint.dart';

void main(List<String> args, SendPort sendPort) {
  startPlugin(sendPort, _RootLint());
}

class _RootLint extends PluginBase {
  @override
  Stream<Lint> getLints(ResolvedUnitResult unit) async* {
    // Element Tree approach lints
    await for (final lint in riverpodLint(unit)) yield lint;

    // AST approach lints
    final astLints = <Lint>[];
    unit.unit.visitChildren(
      AvoidPassingOptionalPositionalParametersVisitor(unit, astLints),
    );
    await for (final lint in Stream.fromIterable(astLints)) yield lint;
  }
}
