import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

Stream<Lint> riverpodLint(ResolvedUnitResult resolvedUnitResult) async* {
  final library = resolvedUnitResult.libraryElement;
  final providers = library.topLevelElements
      .whereType<VariableElement>()
      .where((e) => !e.isFinal)
      .where((e) => _isProvider(e.type))
      .toList();

  for (final provider in providers) {
    yield Lint(
      code: 'riverpod_final_provider',
      message: 'Providers should always be declared as final',
      location: provider.nameLintLocation!,
    );
  }
}

bool _isProvider(DartType type) {
  final element = type.element2! as ClassElement;
  final source = element.librarySource.uri;

  final isProviderBase = source.scheme == 'package' &&
      source.pathSegments.first == 'riverpod' &&
      element.name == 'ProviderBase';

  return isProviderBase || element.allSupertypes.any(_isProvider);
}
