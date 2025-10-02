import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _tasks = [];
  final TextEditingController _controller = TextEditingController();
  String _message = "";

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add({"title": _controller.text, "done": false});
        _controller.clear();
        _message = "";
      });
    }
  }

  void _toggleDone(int index) {
    setState(() {
      _tasks[index]["done"] = !_tasks[index]["done"];
      _message = "Task Done";
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _message = "";
      });
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _message = "Task Deleted ";
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _message = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Image.asset("assets/images/taskify_text.png", height: 400),
      ),

      body: Column(
        children: [
          if (_message.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _message,
                style: TextStyle(
                  fontSize: 16,
                  color: _message.contains("Deleted")
                      ? Colors.red
                      : const Color(0xFF5ACD8E),
                ),
              ),
            ),

          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: Text(
                      "No tasks yet",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        leading: IconButton(
                          icon: Icon(
                            task["done"]
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: const Color(0xFF5ACD8E),
                          ),
                          onPressed: () => _toggleDone(index),
                        ),
                        title: Text(
                          task["title"],
                          style: TextStyle(
                            fontSize: 18,
                            color: const Color(0xFF1A5A7A),
                            decoration: task["done"]
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A5A7A), // Blue FAB
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Add Task"),
                content: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Enter task here...",
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _controller.clear();
                    },
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A5A7A),
                    ),
                    onPressed: () {
                      _addTask();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 32,
        ), // Green +
      ),
    );
  }
}
