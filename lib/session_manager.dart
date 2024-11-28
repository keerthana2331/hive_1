import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SessionManager extends StatefulWidget {
  @override
  _SessionManagerState createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  final _box = Hive.box('sessionBox');

  String? _userId;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  // Save session data
  Future<void> _saveSession(String userId, String token) async {
    await _box.put('userId', userId);
    await _box.put('token', token);

    setState(() {
      _userId = userId;
      _token = token;
    });
  }

  // Load session data
  void _loadSession() {
    setState(() {
      _userId = _box.get('userId');
      _token = _box.get('token');
    });
  }

  // Clear session data
  Future<void> _clearSession() async {
    await _box.clear();

    setState(() {
      _userId = null;
      _token = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hive Session Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_userId != null && _token != null)
              Column(
                children: [
                  Text('User ID: $_userId'),
                  Text('Token: $_token'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _clearSession,
                    child: Text('Clear Session'),
                  ),
                ],
              )
            else
              Column(
                children: [
                  Text('No session data found.'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _saveSession('user123', 'token_abc123'),
                    child: Text('Save Session'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
