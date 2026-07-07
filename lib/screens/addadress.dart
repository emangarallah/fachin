import 'package:flutter/material.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class Addadress extends StatefulWidget {
  const Addadress({super.key, this.editData});
  final dynamic editData;

  @override
  State<Addadress> createState() => _AddadressState();
}

class _AddadressState extends State<Addadress> {





  // 1. Declare the controllers for each input field
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 2. Clean up the controllers when the widget is disposed
    firstNameController.dispose();
    lastNameController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    if(widget.editData != null){
      firstNameController.text = widget.editData['first'] ?? "";
      lastNameController.text = widget.editData['last'] ?? "";
      addressController.text = widget.editData['address'] ?? "";
      cityController.text = widget.editData['city'] ?? "";
      stateController.text = widget.editData['state'] ?? "";
      zipCodeController.text = widget.editData['zipe'] ?? "";
      phoneController.text = widget.editData['phone'] ?? "";



    }

    super.initState();
  }

  void _submitData() {
    // Easily access the text values using the controllers
    print('First Name: ${firstNameController.text}');
    print('Last Name: ${lastNameController.text}');
    print('Address: ${addressController.text}');
    print('City: ${cityController.text}');
    print('State: ${stateController.text}');
    print('ZIP Code: ${zipCodeController.text}');
    print('Phone: ${phoneController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        title: Text(
          'Open\nFashion',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'serif',
            fontSize: 20,
            letterSpacing: 2,
            height: 1.1,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'ADD SHIPPING ADDRESS',
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(width: 60, height: 1, color: Colors.black26),
                      const SizedBox(height: 32),

                      // First Name & Last Name Row
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "First Name",

                              controller:
                                  firstNameController, // Pass controller here
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: "Last Name",

                              controller:
                                  lastNameController, // Pass controller here
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Address Field
                      CustomTextField(
                        label: "Addres",

                        controller: addressController,
                      ),
                      const SizedBox(height: 24),

                      // City Field
                      CustomTextField(
                        label: "City",
                        controller: cityController,
                      ),
                      const SizedBox(height: 24),

                      // State & ZIP Code Row
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: "State",
                              controller: stateController,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomTextField(
                              label: "Zipe Code",
                              controller: zipCodeController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Phone Number Field
                      CustomTextField(
                        label: "Phone Number",
                        controller: phoneController,
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom "ADD NOW" Button
              Button(
                isSvgg: false,
                title: 'Place order',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    return;
                  } else {
                    final data = {
                      'first': firstNameController.text,
                      'last': lastNameController.text,
                      'address': addressController.text,
                      'city': cityController.text,
                      'zipe': phoneController.text,
                      'phone': phoneController.text,
                    };
                    Navigator.pop(context, data);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
