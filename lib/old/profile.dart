import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({super.key, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> profile;
  final _formKey = GlobalKey<FormState>();
  late String _username;
  late String _dAddress;
  late String _bAddress;
  late String _gender;

  @override
  void initState() {
    super.initState();
    profile = getProfileInfo(widget.userId);
  }

  Future<Map<String, dynamic>> getProfileInfo(int userId) async {
    final response = await http.get(Uri.parse('http://192.168.10.7/dbproject/fetch_profile.php?userId=$userId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      // Ensure data is a map, even if empty
      if (data is Map<String, dynamic> && data.isNotEmpty) {
        return data;
      } else {
        return {
          'username': '',
          'Daddress': '',
          'Baddress': '',
          'gender': 'Male',
        };
      }
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> addProfileInfo(Map<String, dynamic> profileData) async {
    final response = await http.post(
      Uri.parse('http://192.168.10.7/dbproject/profile.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(profileData),
    );
// Log the request

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == true) {
        setState(() {
          profile = getProfileInfo(widget.userId);
        });
      } else {
        throw Exception('Failed to insert profile: ${responseData['error']}');
      }
    } else {
      throw Exception('Failed to insert profile: HTTP ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page',
        style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.green[200],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: profile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            _username = data['username'];
            _dAddress = data['Daddress'];
            _bAddress = data['Baddress'];
            _gender = data['gender'];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      initialValue: _username,
                      decoration: const InputDecoration(labelText: 'Username',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      initialValue: _dAddress,
                      decoration: const InputDecoration(labelText: 'Delivery Address',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold
                      )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a delivery address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _dAddress = value!;
                      },
                    ),
                    TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      initialValue: _bAddress,
                      decoration: const InputDecoration(labelText: 'Billing Address',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold
                      )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a billing address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _bAddress = value!;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: const InputDecoration(labelText: 'Gender',
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      items: ['Male', 'Female'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _gender = newValue!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a gender';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          await addProfileInfo({
                            'userId': widget.userId,
                            'username': _username,
                            'Daddress': _dAddress,
                            'Baddress': _bAddress,
                            'gender': _gender,
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green[300]),
                      child: const Text(
                          'Update Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
