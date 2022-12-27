import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

Stream<Lint> lintAvoidOptionalPositionalParameters(
  ResolvedUnitResult resolvedUnitResult,
) {
  final finder = _OptionalPositionalParametersFinder();
  resolvedUnitResult.unit.visitChildren(finder);

  return Stream.fromIterable(finder.foundParameters.map((parameter) => Lint(
        code: 'avoid_passing_optional_positional_parameters',
        message: 'Avoid passing optional positional parameters',
        severity: LintSeverity.info,
        location: resolvedUnitResult.lintLocationFromOffset(
          parameter.offset,
          length: parameter.length,
        ),
      )));
}

class _OptionalPositionalParametersFinder extends GeneralizingAstVisitor<void> {
  final foundParameters = <FormalParameter>[];

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    node.functionExpression.parameters?.parameters
        .where((parameter) => parameter.isOptionalPositional)
        .forEach(foundParameters.add);
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    node.parameters?.parameters
        .where((parameter) => parameter.isOptionalPositional)
        .forEach(foundParameters.add);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    node.parameters.parameters
        .where((parameter) => parameter.isOptionalPositional)
        .forEach(foundParameters.add);
    super.visitConstructorDeclaration(node);
  }
}
