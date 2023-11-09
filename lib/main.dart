import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final _provider = Provider<bool>((ref) {
//   final color = ref.watch(_sprovider);
//   return color == 'red';
// });
// final _sprovider = StateProvider<String>((ref) => '');

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

//in riverpod if we want to create a state we use a provider
//state means creating some variable and hold them .so that as you know that as ou change them and it reflects in your UI.
//

// class MyHomePage extends ConsumerWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final isRead = ref.watch(_provider);
//     // final selectedButton = ref.watch(_sprovider);
//     return Center(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           //  Text(selectedButton),
//           ElevatedButton(
//             onPressed: () {
//               //  ref.read(_sprovider.notifier).state = 'read';
//             },
//             child: Text("Red"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               //  ref.read(_sprovider.notifier).state = 'read';
//             },
//             child: Text("Blue"),
//           ),
//           //   isRead ? Text('Color is Read') : Text('Color is blue'),
//         ],
//       ),
//     );
//   }
// }

//stateNotifier and stateNotifierProvider

final numberProvider =
    StateNotifierProvider<numberNotifier, List<String>>((ref) {
  return numberNotifier();
});

class numberNotifier extends StateNotifier<List<String>> {
  numberNotifier() : super(['number 12', 'number 30']);
  void add(String number) {
    state = [...state, number];
  }

  void remove(String number) {
    state = [...state.where((element) => element != number)];
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numbers = ref.watch(numberProvider);
    return Scaffold(       
      appBar: AppBar(
        title: Text('State Notifier'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(numberProvider.notifier)
              .add('number ${Random().nextInt(100)}');
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: numbers
                .map((e) => GestureDetector(
                      onTap: () {
                        ref.read(numberProvider.notifier).remove(e);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(e),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
