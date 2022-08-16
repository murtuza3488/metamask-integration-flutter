import 'package:metamask_inegration_flutter/metamask.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clipboard/clipboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold();
    // }
    return ChangeNotifierProvider(
      create: (context) => MetaMaskProvider()..init(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF1b202b),
          body: Stack(
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 15,
                  ),
                  Image.asset(
                    'assets/images/Seaflux_logo.png',
                    width: 200,
                    height: 150,
                  )
                ],
              ),
              Center(
                child: Consumer<MetaMaskProvider>(
                  builder: (context, provider, child) {
                    late final String text;
                    text = provider.account;
                    if (provider.isConnected) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.white54,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 15,
                        shadowColor: Colors.black,
                        color: const Color.fromARGB(255, 10, 17, 32),
                        child: Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 15),
                          height: 270,
                          width: 400,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Account",
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 24,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    height: 150,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.white60,
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Connected to MetaMask",
                                            style: TextStyle(
                                                color: Colors.white60),
                                          ),
                                          Text(
                                            '${text.substring(0, 7)}...${text.substring(text.length - 4, text.length)}',
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  _copytext(text);
                                                },
                                                icon: const Icon(
                                                    Icons.content_copy_rounded),
                                                color: Colors.white60,
                                              ),
                                              const Text(
                                                "Copy Address",
                                                style: TextStyle(
                                                    color: Colors.white60),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (provider.isEnabled) {
                      return ElevatedButton(
                        onPressed: () =>
                            context.read<MetaMaskProvider>().connect(),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            primary: const Color.fromARGB(255, 19, 43, 98),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Image.asset(
                                "assets/images/MetaMask_Fox.png",
                                height: 30,
                                width: 40,
                              ),
                            ),
                            const Text(
                              "Connect Wallet",
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 10)
                          ],
                        ),
                      );
                    } else {
                      'Please use a Web3 supported browser.';
                    }

                    return ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.purple, Colors.blue, Colors.red],
                      ).createShader(bounds),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Text Copied")));
  }

  void _copytext(String copytext) {
    FlutterClipboard.copy(copytext).then((value) => _showSnackbar());
  }
}
