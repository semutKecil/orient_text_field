import 'package:flutter/material.dart';
import 'package:orient_text_field/orient_text_field.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const KeyboardStatusProvider(
      child: MaterialApp(home: FormExample()),
    );
  }
}

class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          MediaQuery.orientationOf(context) != Orientation.landscape,
      appBar: AppBar(
        title: Text("Example"),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            children: [
              OrientTextField(
                decoration: InputDecoration(labelText: "Text Field"),
                textDirection: TextDirection.rtl,
              ),
              OrientTextFormField(
                decoration: InputDecoration(labelText: "Text Form Field"),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              OrientTextField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Password Text",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(Icons.password),
                  ),
                ),
                keyboardType: TextInputType.visiblePassword,
                fullScreenFieldConfig: FullScreenFieldConfig(
                  obscureText: true,
                  withObscureToggle: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
