import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/exchangeProvider.dart' show ExchangeProvider, Student;

class FormScreen extends StatefulWidget {
  final Student? student;

  const FormScreen({super.key, this.student});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _universityController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _universityController = TextEditingController(text: widget.student?.university ?? '');
    _countryController = TextEditingController(text: widget.student?.country ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _universityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveStudent(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final exchangeProvider = Provider.of<ExchangeProvider>(context, listen: false);
      final studentData = {
        'name': _nameController.text,
        'university': _universityController.text,
        'country': _countryController.text,
      };

      if (widget.student == null) {
        exchangeProvider.addStudent(studentData);
        print('Saving new student: ${studentData['name']}');
      } else {
        exchangeProvider.updateStudent(widget.student!, studentData);
        print('Updating student: ${widget.student!.name} to ${studentData['name']}');
      }

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.student == null ? 'Student Added Successfully!' : 'Student Updated Successfully!',
            style: const TextStyle(fontSize: 16),
          ),
          backgroundColor: Colors.teal,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.teal, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      widget.student == null ? 'Add Student' : 'Edit Student',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade900,
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
                const SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        icon: Icons.person_rounded,
                        validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _universityController,
                        label: 'University',
                        icon: Icons.school_rounded,
                        validator: (value) => value!.isEmpty ? 'Enter a university' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                        controller: _countryController,
                        label: 'Country',
                        icon: Icons.public_rounded,
                        validator: (value) => value!.isEmpty ? 'Enter a country' : null,
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () => _saveStudent(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                          backgroundColor: Colors.tealAccent.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                        ),
                        child: Text(
                          widget.student == null ? 'Save Student' : 'Update Student',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal.shade700),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.tealAccent.shade700, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.teal.shade800),
      ),
      validator: validator,
    );
  }
}