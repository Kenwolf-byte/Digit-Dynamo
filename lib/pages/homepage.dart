import 'package:flutter/material.dart';
import 'dart:math'; // For sqrt and pow
import 'package:shared_preferences/shared_preferences.dart'; // For persistent storage

class MyHomePage extends StatefulWidget {
  final String? title;
  const MyHomePage({super.key, this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  List<String> history = []; //=== List to store calculation history

  @override
  void initState() {
    super.initState();
    _loadHistory(); //=== Load history from persistent storage when the app starts
  }

  //=== Load history from SharedPreferences
  void _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      history = prefs.getStringList("history") ?? [];
    });
  }

  //=== Save history to SharedPreferences
  void _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("history", history);
  }

  void buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "⌫") {
      // Backspace button
      if (_output.isNotEmpty && _output != "0") {
        _output = _output.substring(0, _output.length - 1);
        if (_output.isEmpty) {
          _output = "0"; //=== Reset to "0" if all digits are deleted
        }
      }
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X" ||
        buttonText == "^") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "√") {
      double num = double.parse(output);
      if (num < 0) {
        _output = "Error";
      } else {
        _output = (sqrt(num)).toString();
      }
    } else if (buttonText == "%") {
      double num = double.parse(output);
      _output = (num / 100).toString();
    } else if (buttonText == "±") {
      double num = double.parse(output);
      _output = (num * -1).toString();
    } else if (buttonText == "±") {
      try {
        double num = double.parse(_output);
        _output = (num * -1).toString();
        // Remove ".0" if the number is an integer
        if (_output.endsWith('.0')) {
          _output = _output.substring(0, _output.length - 2);
        }
      } catch (e) {
        _output = "Error"; // Handle parsing errors
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);

      String calculation =
          "$num1 $operand $num2 = "; //=== Create the calculation string

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        if (num2 == 0) {
          _output = "Error";
        } else {
          _output = (num1 / num2).toString();
        }
      }
      if (operand == "^") {
        if (num1 == 0 && num2 == 0) {
          _output = "Error"; //=== or "1" if you choose to define 0^0 = 1
        } else {
          _output = (pow(num1, num2)).toString();
        }
      }

      calculation += _output; //=== Append the result to the calculation string
      debugPrint(
          "Calculation: $calculation"); //=== Debugging: Print the calculation string
      history.add(calculation); //=== Add the calculation to the history list
      _saveHistory(); //=== Save the updated history to persistent storage

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output == "0" ? buttonText : _output + buttonText;
    }

    setState(() {
      output = _output;
    });
  }

  void clearHistory() {
    setState(() {
      history.clear(); // Clear the history list
      _saveHistory(); // Save the updated history to persistent storage
    });
  }

  void deleteHistoryEntry(int index, StateSetter setDialogState) {
    // Show confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Entry"),
          content: const Text("Are you sure you want to delete this entry?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the confirmation dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (index >= 0 && index < history.length) {
                  setState(() {
                    history
                        .removeAt(index); // Remove the selected history entry
                    _saveHistory(); // Save the updated history to persistent storage
                  });
                  setDialogState(() {}); // Rebuild the dialog
                }
                Navigator.pop(context); // Close the confirmation dialog
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void reuseCalculation(String calculation) {
    //=== Check if the calculation string contains the '=' character
    if (calculation.contains("=")) {
      //=== Extract the result from the calculation string
      String result = calculation.split("=").last.trim();
      setState(() {
        output = result;
        _output = result;
      });
      Navigator.pop(context); //=== Close the history dialog
    } else {
      //=== Handle invalid calculation string
      setState(() {
        output = "Error";
        _output = "Error";
      });
    }
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          key: Key('button_$buttonText'), //=== Add a unique key
          style: ElevatedButton.styleFrom(
            backgroundColor: _getButtonColor(buttonText),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(20.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String buttonText) {
    if (buttonText == "CLEAR") {
      return Colors.red;
    } else if (buttonText == "=") {
      return Colors.green;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "X" ||
        buttonText == "/" ||
        buttonText == "^" ||
        buttonText == "√" ||
        buttonText == "%" ||
        buttonText == "±") {
      return Colors.orange;
    } else if (buttonText == "⌫") {
      return Colors.grey; //=== Backspace button color
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    // String Size = "MediaQuery.of(context).size";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.history),
            onPressed: () {
              //=== Show history in a dialog
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setDialogState) {
                      return AlertDialog(
                        title: const Text("Calculation History"),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: history.length,
                            itemBuilder: (context, index) {
                              String calculation = history[index];
                              return ListTile(
                                title: Text(calculation),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => deleteHistoryEntry(
                                      index, setDialogState), //=== Delete entry
                                ),
                                onTap: () {
                                  if (calculation.contains("=")) {
                                    reuseCalculation(
                                        calculation); //=== Reuse calculation
                                  } else {
                                    setState(() {
                                      output = "Error";
                                      _output = "Error";
                                    });
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              //=== Show confirmation dialog before clearing history
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Clear History"),
                                    content: const Text(
                                        "Hey!, Edwin says, Are you sure you want to clear all history?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                              context); //=== Close the confirmation dialog
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          clearHistory(); //=== Clear history
                                          setDialogState(
                                              () {}); //=== Rebuild the dialog
                                          Navigator.pop(
                                              context); //=== Close the confirmation dialog
                                          Navigator.pop(
                                              context); //=== Close the history dialog
                                        },
                                        child: const Text("Clear"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text("Clear History"),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple.shade300, Colors.deepPurple.shade700],
          ),
        ),
        child: Column(
          children: <Widget>[
            //=== Display Section
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.symmetric(
                  vertical: 24.0,
                  horizontal: 12.0,
                ),
                child: Card(
                  elevation: 8.0,
                  color: Colors.white.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      output,
                      key: const Key('display'), // Add a unique key
                      style: const TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Divider(height: 1.0, color: Colors.white),

            //=== Buttons Section
            Expanded(
              flex: 2, //=== Give more space to the buttons
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //=== Row 1
                    Expanded(
                      child: Row(
                        children: [
                          buildButton("7"),
                          buildButton("8"),
                          buildButton("9"),
                          buildButton("/"),
                          buildButton("√"),
                        ],
                      ),
                    ),
                    //=== Row 2
                    Expanded(
                      child: Row(
                        children: [
                          buildButton("4"),
                          buildButton("5"),
                          buildButton("6"),
                          buildButton("X"),
                          buildButton("%"),
                        ],
                      ),
                    ),
                    //=== Row 3
                    Expanded(
                      child: Row(
                        children: [
                          buildButton("1"),
                          buildButton("2"),
                          buildButton("3"),
                          buildButton("-"),
                          buildButton("^"),
                        ],
                      ),
                    ),
                    //=== Row 4
                    Expanded(
                      child: Row(
                        children: [
                          buildButton("."),
                          buildButton("0"),
                          buildButton("⌫"), // Backspace button
                          buildButton("+"),
                          buildButton("±"),
                        ],
                      ),
                    ),
                    //=== Row 5
                    Expanded(
                      child: Row(
                        children: [
                          buildButton("CLEAR"),
                          buildButton("="),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
