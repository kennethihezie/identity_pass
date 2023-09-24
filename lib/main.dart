import 'package:flutter/material.dart';
import 'package:prembly_flutter/prembly_flutter.dart';

void main() {
  // Initializing prembly plugin
  PremblyPlugin.initialize(
    appId: "e307f0f8-2c97-4b2e-b89f-88e220cfe82b",
    apiKey: "test_ucc8c5fyl6rl78idn3lqjp:ogINip3R6hrzzARkTI42vv13ybY",
  ).then((_) {
    return runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prembly Example',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Instance of PremblyPlugin
  PremblyPlugin premblyPlugin = PremblyPlugin();

  // Loading state controller
  bool loading = false;

  final TextEditingController _bvnNumberController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prembly Flutter Example'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [

            TextFormField(
              controller: _bvnNumberController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                hintText: "Verify BVN Number",
                suffixIcon: InkWell(
                  onTap: loading
                      ? null
                      : () async {
                    setState(() => loading = true);
                    var response = await premblyPlugin
                        .ngBvnNumberVerifier(_bvnNumberController.text);
                    print(response);

                    setState(() => loading = false);
                  }, //BVN verifier handler
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: loading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(),
                      )
                          : const Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/*
{status: false, detail: Bank Verification failed, response_code: 01, message: BVN not Found, verification: {status: NOT-VERIFIED, reference: 5f71b3b8-571d-455d-a925-83f15e459568}}
 */