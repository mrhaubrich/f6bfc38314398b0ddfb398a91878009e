import 'package:flutter/material.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:animais/ui/dark.dart';

class AppThemes {
  static const int dark = 0;
  static const int light = 1;
}

final themeCollection = ThemeCollection(
  themes: {
    AppThemes.dark: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark().copyWith(primary: Colors.blue)),
    AppThemes.light: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(primary: Colors.blue)),
  },
);

final List<Animal> _animal = [
  Dog(),
  Cat(),
  Turtle(),
];
List<DropdownMenuItem<Animal>> getList =
    _animal.map<DropdownMenuItem<Animal>>((Animal animal) {
  return DropdownMenuItem<Animal>(
    value: animal,
    child: Text(animal.getName()),
  );
}).toList();

Animal _selectedAnimal = _animal[0];

class DialogDropdown extends StatefulWidget {
  const DialogDropdown({Key? key}) : super(key: key);

  @override
  State<DialogDropdown> createState() => _DialogDropdownState();
}

class _DialogDropdownState extends State<DialogDropdown> {
  String? _grade;

  @override
  Widget build(BuildContext context) {
    return gradeDialog();
  }

  void _changeGrade(newGrade) {
    setState(
      () {
        _selectedAnimal = newGrade;
      },
    );
  }

  StatefulBuilder gradeDialog() {
    return StatefulBuilder(
      builder: (context, setter) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_grade ?? "Unknown"),
                const SizedBox(height: 30),
                DropdownButton<Animal>(
                  value: _selectedAnimal,
                  onChanged: (Animal? newGrade) {
                    setter(
                      () {
                        _selectedAnimal = newGrade!;
                      },
                    );
                    _changeGrade(newGrade);
                  },
                  items: getList,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: AppThemes.dark, // optional, default id is 0
        builder: (context, theme) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: theme,
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _action = '';
  final ColorMode _colorMode = ColorMode();

  void _talk() {
    setState(() {
      _action = _selectedAnimal.talk();
    });
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return const DialogDropdown();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: _colorMode.getIcon(context),
            onPressed: () {
              _colorMode.toggle(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'O animal diz:',
            ),
            Text(
              _action,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: _talk,
          tooltip: 'Talk',
          child: const Icon(Icons.campaign),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () => _displayTextInputDialog(context),
          tooltip: 'TextField in Dialog',
          child: const Icon(Icons.text_fields),
        ),
      ]),
    );
  }
}

abstract class Animal {
  String talk();
  String walk();
  String getName();
}

class Dog implements Animal {
  @override
  String talk() {
    print('Au au!');
    return 'Au au!';
  }

  @override
  String walk() {
    print('I\'m walking');
    return 'I\'m walking';
  }

  @override
  String getName() {
    return 'Dog';
  }
}

class Cat implements Animal {
  @override
  String talk() {
    print('Miau miau!');
    return 'Miau miau!';
  }

  @override
  String walk() {
    print('I\'m walking');
    return 'I\'m walking';
  }

  @override
  String getName() {
    return 'Cat';
  }
}

class Turtle implements Animal {
  @override
  String talk() {
    print('Aahh!');
    return 'Aahh!';
  }

  @override
  String walk() {
    print('I\'m waaaaaalking');
    return 'I\'m waaaaaalking';
  }

  @override
  String getName() {
    return 'Turtle';
  }
}
