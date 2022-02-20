import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cause StateError on purpose', (tester) async {
    await tester.pumpWidget(HookBuilder(builder: (context) {
      expect(useXXX, throwsA(isA<StateError>()));
      useZZZ();
      return Container();
    }));
  });
}

void useXXX() {
  return use(const _XXXHook());
}

class _XXXHook extends Hook<void> {
  const _XXXHook();

  @override
  _XXXHookState createState() => _XXXHookState();
}

class _XXXHookState extends HookState<void, _XXXHook> {
  @override
  void build(BuildContext context) {
    useYYY();
  }
}

void useYYY() {
  return use(const _YYYHook());
}

class _YYYHook extends Hook<void> {
  const _YYYHook();

  @override
  _YYYHookState createState() => _YYYHookState();
}

class _YYYHookState extends HookState<void, _YYYHook> {
  @override
  void build(BuildContext context) {}
}

void useZZZ() {
  return use(const _ZZZHook());
}

class _ZZZHook extends Hook<void> {
  const _ZZZHook();

  @override
  _ZZZHookState createState() => _ZZZHookState();
}

class _ZZZHookState extends HookState<void, _ZZZHook> {
  final yyy = useYYY(); //Call the build() outside

  @override
  void build(BuildContext context) {
    // useYYY(); Don't call the build() inside.
  }
}
