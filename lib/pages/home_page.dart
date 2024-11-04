// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _wordsSpoken = "";
//   double _confidenceLevel = 0;

//   @override
//   void initState() {
//     super.initState();
//     initSpeech();
//   }

//   void initSpeech() async {
//     _speechEnabled = await _speechToText.initialize();
//     setState(() {});
//   }

//   void _startListening() async {
//     await _speechToText.listen(onResult: _onSpeechResult);
//     setState(() {
//       _confidenceLevel = 0;
//     });
//   }

//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   void _onSpeechResult(result) {
//     setState(() {
//       _wordsSpoken = "${result.recognizedWords}";
//       _confidenceLevel = result.confidence;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: const Text(
//           'Speech Demo',
//           style: TextStyle(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _speechToText.isListening
//                     ? "listening..."
//                     : _speechEnabled
//                         ? "Tap the microphone to start listening..."
//                         : "Speech not available",
//                 style: const TextStyle(fontSize: 20.0),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   _wordsSpoken,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//             ),
//             if (_speechToText.isNotListening && _confidenceLevel > 0)
//               Padding(
//                 padding: const EdgeInsets.only(
//                   bottom: 100,
//                 ),
//                 child: Text(
//                   "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w200,
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _speechToText.isListening ? _stopListening : _startListening,
//         tooltip: 'Listen',
//         backgroundColor: Colors.purple,
//         child: Icon(
//           _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }
//!__________

// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:permission_handler/permission_handler.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _wordsSpoken = "";
//   double _confidenceLevel = 0;
//   String _selectedLanguage = 'ar_SA'; // اللغة الافتراضية هي العربية

//   @override
//   void initState() {
//     super.initState();
//     initSpeech();
//   }

//   void initSpeech() async {
//     // طلب إذن الميكروفون
//     var status = await Permission.microphone.request();
//     if (status.isGranted) {
//       _speechEnabled = await _speechToText.initialize(debugLogging: true);
//     }
//     setState(() {});
//   }

//   void _startListening() async {
//     // بدء الاستماع باللغة المختارة من القائمة
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       listenFor: Duration(minutes: 1),      // مدة الاستماع
//       pauseFor: Duration(seconds: 5),       // مدة الانتظار بين الكلمات
//       partialResults: true,
//       localeId: _selectedLanguage,          // استخدام اللغة المختارة من المستخدم
//     );
//     setState(() {
//       _confidenceLevel = 0;
//     });
//   }

//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   void _onSpeechResult(result) {
//     setState(() {
//       _wordsSpoken = "${result.recognizedWords}";
//       _confidenceLevel = result.confidence;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: const Text(
//           'Speech Demo',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _speechToText.isListening
//                     ? "Listening..."
//                     : _speechEnabled
//                         ? "Tap the microphone to start listening..."
//                         : "Speech not available",
//                 style: const TextStyle(fontSize: 20.0),
//               ),
//             ),
//             // إضافة قائمة منسدلة لاختيار اللغة
//             DropdownButton<String>(
//               value: _selectedLanguage,
//               items: const [
//                 DropdownMenuItem(
//                   value: 'ar_SA',
//                   child: Text('العربية'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'en_US',
//                   child: Text('English'),
//                 ),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//               },
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   _wordsSpoken,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//             ),
//             if (_speechToText.isNotListening && _confidenceLevel > 0)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 100),
//                 child: Text(
//                   "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w200,
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _speechToText.isListening ? _stopListening : _startListening,
//         tooltip: 'Listen',
//         backgroundColor: Colors.purple,
//         child: Icon(
//           _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

//!2_______

// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart';
// import 'package:permission_handler/permission_handler.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final SpeechToText _speechToText = SpeechToText();
//   bool _speechEnabled = false;
//   String _wordsSpoken = "";
//   double _confidenceLevel = 0;
//   String _selectedLanguage = 'en_US'; // افتراضيًا للإنجليزية

//   @override
//   void initState() {
//     super.initState();
//     initSpeech();
//   }

//   void initSpeech() async {
//     var status = await Permission.microphone.request();
//     if (status.isGranted) {
//       _speechEnabled = await _speechToText.initialize(debugLogging: true);
//     }
//     setState(() {});
//   }

//   void _startListening() async {
//     await _speechToText.listen(
//       onResult: _onSpeechResult,
//       listenFor: Duration(minutes: 1), // مدة الاستماع
//       pauseFor: Duration(seconds: 10), // مدة أطول لتجنب التوقف المبكر
//       partialResults: true,
//       localeId: _selectedLanguage,
//       onSoundLevelChange: (level) {
//         // يمكنك استخدام هذه لتشخيص ما إذا كان الميكروفون يلتقط الصوت بشكل صحيح
//         print("Sound level: $level");
//       },
//     );
//     setState(() {
//       _confidenceLevel = 0;
//     });
//   }

//   void _stopListening() async {
//     await _speechToText.stop();
//     setState(() {});
//   }

//   void _onSpeechResult(result) {
//     setState(() {
//       _wordsSpoken = "${result.recognizedWords}";
//       _confidenceLevel = result.confidence;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.purple,
//         title: const Text(
//           'Speech Demo',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 _speechToText.isListening
//                     ? "Listening..."
//                     : _speechEnabled
//                         ? "Tap the microphone to start listening..."
//                         : "Speech not available",
//                 style: const TextStyle(fontSize: 20.0),
//               ),
//             ),
//             DropdownButton<String>(
//               value: _selectedLanguage,
//               items: const [
//                 DropdownMenuItem(
//                   value: 'ar_SA',
//                   child: Text('العربية'),
//                 ),
//                 DropdownMenuItem(
//                   value: 'en_US',
//                   child: Text('English'),
//                 ),
//               ],
//               onChanged: (value) {
//                 setState(() {
//                   _selectedLanguage = value!;
//                 });
//               },
//             ),
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   _wordsSpoken,
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//             ),
//             if (_speechToText.isNotListening && _confidenceLevel > 0)
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 100),
//                 child: Text(
//                   "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
//                   style: const TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w200,
//                   ),
//                 ),
//               )
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _speechToText.isListening ? _stopListening : _startListening,
//         tooltip: 'Listen',
//         backgroundColor: const Color.fromARGB(255, 90, 7, 105),
//         child: Icon(
//           _speechToText.isNotListening ? Icons.mic_off : Icons.mic,
//           color: Colors.white,
//         ),
//       ),
//     );
//   }
// }

//!3


import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _wordsSpoken = "";
  double _confidenceLevel = 0;
  String _selectedLanguage = 'en_US';

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      _speechEnabled = await _speechToText.initialize(debugLogging: true);
    }
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: Duration(minutes: 1),
      pauseFor: Duration(seconds: 10),
      partialResults: true,
      localeId: _selectedLanguage,
      onSoundLevelChange: (level) {
        print("Sound level: $level");
      },
    );
    setState(() {
      _confidenceLevel = 0;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _wordsSpoken = "${result.recognizedWords}";
      _confidenceLevel = result.confidence;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Speech Recognition Demo',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildInfoCard(),
            const SizedBox(height: 20),
            _buildLanguageSelector(),
            const SizedBox(height: 20),
            _buildSpeechResult(),
            if (_speechToText.isNotListening && _confidenceLevel > 0)
              _buildConfidenceIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        label: Text(_speechToText.isListening ? 'Stop Listening' : 'Start Listening'),
        icon: Icon(_speechToText.isListening ? Icons.mic_off : Icons.mic),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      elevation: 5,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          _speechToText.isListening
              ? "Listening... Speak now."
              : _speechEnabled
                  ? "Tap the microphone to start listening..."
                  : "Speech recognition not available.",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLanguageSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.language, color: Colors.deepPurple),
              const SizedBox(width: 10),
              Text(
                'Select Language:',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedLanguage,
                underline: Container(),
                items: const [
                  DropdownMenuItem(
                    value: 'ar_SA',
                    child: Text('العربية'),
                  ),
                  DropdownMenuItem(
                    value: 'en_US',
                    child: Text('English'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedLanguage = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpeechResult() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Text(
                _wordsSpoken.isEmpty ? "Your speech will appear here..." : _wordsSpoken,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfidenceIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: Card(
        color: Colors.deepPurple[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              "Confidence: ${(_confidenceLevel * 100).toStringAsFixed(1)}%",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
