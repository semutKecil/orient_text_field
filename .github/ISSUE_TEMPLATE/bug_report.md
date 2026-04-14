---
name: Bug Report
about: Report a bug or issue with OrientTextField
title: '[BUG] '
labels: bug
assignees: ''
---

## Bug Report

**Important:** Before submitting, please ensure:

1. ✅ **KeyboardStatusProvider is applied** - Your app must be wrapped with `KeyboardStatusProvider` as shown in the README
2. ✅ **Provide your implementation code** - Include the code you're using that causes the issue

### Environment
- Flutter version: <!-- flutter --version -->
- Platform: <!-- iOS/Android/Web/etc. -->
- Device: <!-- e.g., iPhone, Android emulator -->

### Description
<!-- Briefly describe the bug -->

### Steps to Reproduce
<!-- How to reproduce the issue -->

### Expected vs Actual Behavior
<!-- What should happen vs what actually happens -->

### Code Sample
**Must include:**
- How you wrapped your app with `KeyboardStatusProvider`
- Your `OrientTextField` or `OrientTextFormField` implementation

```dart
// Your code here - make sure KeyboardStatusProvider is shown
import 'package:flutter/material.dart';
import 'package:orient_text_field/orient_text_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardStatusProvider(  // <-- REQUIRED
      child: MaterialApp(
        home: Scaffold(
          body: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientTextField(
      // Your implementation here
    );
  }
}
```

### Checklist
- [ ] I have wrapped my app with `KeyboardStatusProvider`
- [ ] I have provided my implementation code above