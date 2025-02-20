import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final String defaultText = 'Your Awesome Personal Data will show here!';
  String displayedText = 'Your Awesome Personal Data will show here!';

  String _contactPreference = 'Email';

  /// Sets values to default
  void _resetForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _dobController.clear();
      _phoneController.clear();
      _contactPreference = 'Email';
      displayedText = defaultText;
    });
  }

  /// Validates the form and displays the data
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        displayedText =
            'Name: ${_nameController.text}\n'
            'Email: ${_emailController.text}\n'
            'DOB: ${_dobController.text}\n'
            'Phone: ${_phoneController.text}\n'
            'Contact Preference: $_contactPreference';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text(
                'Welcome to your Doom!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.all(8),
                width: width,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(displayedText, style: TextStyle(fontSize: 16)),
              ),
              const Text(
                'Enter your information to get the latest news on our awesome game!',
                style: TextStyle(fontSize: 16),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Name
                    _buildInputField(
                      Icons.person,
                      'Name',
                      _nameController,
                      keyboardType: TextInputType.name,
                    ),
                    // Email
                    _buildInputField(
                      Icons.email,
                      'Email',
                      _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    // Date of Birth
                    _buildInputField(
                      Icons.date_range,
                      'Date of Birth',
                      _dobController,
                      keyboardType: TextInputType.datetime,
                    ),
                    // Phone
                    _buildInputField(
                      Icons.phone,
                      'Phone',
                      _phoneController,
                      keyboardType: TextInputType.phone,
                    ),
                    // Contact Preference
                    _buildDropdownField(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Reset Button
                  ElevatedButton.icon(
                    onPressed: _resetForm,
                    icon: Icon(Icons.refresh, size: 20),
                    label: Text('Reset Form'),
                    style: _buttonStyle(),
                  ),
                  // Submit Button
                  ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(Icons.check, size: 20),
                    label: Text('Submit Form'),
                    style: _buttonStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Helper method to build the input field
  Widget _buildInputField(
    IconData icon,
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              keyboardType: keyboardType,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: label,
                labelText: label,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '$label is required';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build the dropdown field
  Widget _buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.contact_phone),
          const SizedBox(width: 8),
          Expanded(
            child: DropdownButtonFormField<String>(
              value: _contactPreference,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Preferred Contact Method',
              ),
              items:
                  ['Email', 'In-Person', 'Voice Call', 'Text Message']
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(method),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _contactPreference = value!;
                });
              },
              validator:
                  (value) =>
                      value == null
                          ? 'Please select a contact preference'
                          : null,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to create a consistent button style
  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}

/// Custom AppBar widget
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'My Cool Game Beta Signup Form',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
