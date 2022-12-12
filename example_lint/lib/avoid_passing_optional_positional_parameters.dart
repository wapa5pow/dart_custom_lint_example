import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class AvoidPassingOptionalPositionalParametersVisitor
    extends GeneralizingAstVisitor<void> {
  final code = 'avoid_passing_optional_positional_parameters';
  final message = 'Avoid passing optional positional parameters';

  final ResolvedUnitResult unit;
  final List<Lint> lints;

  AvoidPassingOptionalPositionalParametersVisitor(
    this.unit,
    this.lints,
  );

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    super.visitClassDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (node.functionExpression.parameters == null) return;
    for (final parameter in node.functionExpression.parameters!.parameters) {
      if (parameter.isOptionalPositional) {
        lints.add(Lint(
          code: code,
          message: message,
          severity: LintSeverity.error,
          location: unit.lintLocationFromOffset(
            node.declaredElement2?.nameOffset ?? 0,
            length: node.declaredElement2?.nameLength ?? 0,
          ),
        ));
        break;
      }
    }
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    if (node.parameters == null) return;
    for (final parameter in node.parameters!.parameters) {
      if (parameter.isOptionalPositional) {
        lints.add(Lint(
          code: code,
          message: message,
          severity: LintSeverity.error,
          location: unit.lintLocationFromOffset(
            node.declaredElement2?.nameOffset ?? 0,
            length: node.declaredElement2?.nameLength ?? 0,
          ),
        ));
        break;
      }
    }
    super.visitMethodDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    for (final parameter in node.parameters.parameters) {
      if (parameter.isOptionalPositional) {
        lints.add(Lint(
          code: code,
          message: message,
          severity: LintSeverity.error,
          location: unit.lintLocationFromOffset(
            node.declaredElement2?.nameOffset ?? 0,
            length: node.declaredElement2?.nameLength ?? 0,
          ),
        ));
        break;
      }
    }
    super.visitConstructorDeclaration(node);
  }
}
