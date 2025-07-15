import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyhub/CommonClass/Utils.dart';
import 'package:image_picker/image_picker.dart';

import 'CommonClass/ApiClass.dart';

class Adddrone extends StatefulWidget {
  final String clickUrl;

  Adddrone({required this.clickUrl});

  @override
  State<Adddrone> createState() => _AdddroneState();
}

class _AdddroneState extends State<Adddrone> {
  final ApiClass _apiClass = ApiClass();

  final _formKey = GlobalKey<FormState>();

  String dgcaApproval = '';

  var dronePurposeList = [];
  String selectedPurposeName = '';

  int? selectedPurposeId;

  final picker = ImagePicker();

  Map<String, XFile?> images = {
    'top': null,
    'right': null,
    'left': null,
    'full': null,
  };

  final TextEditingController amountController = TextEditingController();
  final TextEditingController batteryController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController minutesController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController flyingTimeController = TextEditingController();
  final TextEditingController chargingTimeController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController c_minutesController = TextEditingController();
  final TextEditingController c_hoursController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPurpose();
  }

  Future<void> getPurpose() async {
    var response = await _apiClass.getPurpose();
    dronePurposeList = response["purpose_master"];
    setState(() {});
  }

  Future<void> pickImage(String key) async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        images[key] = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Add My Drone'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () async {
            Map<String, File?> fileImages = {
              for (var key in images.keys)
                key: images[key] != null ? File(images[key]!.path) : null,
            };

            var response = await _apiClass.addDrone(
              dgcaApproval,
              selectedPurposeId.toString(),
              amountController.text,
              batteryController.text,
              weightController.text,
              modelController.text,
              hoursController.text,
              minutesController.text,
              flyingTimeController.text,
              chargingTimeController.text,
              descriptionController.text,
              fileImages,
            );

            if (response["status"] == "success") {
              Utils.bottomtoast(context, "Added Successfully");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Continue",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 80),
        // Extra bottom padding for button
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Do you have DGCA Approval *"),
            Row(
              children: [
                Radio(
                  value: '1',
                  groupValue: dgcaApproval,
                  onChanged: (val) {
                    setState(() {
                      dgcaApproval = val!;
                    });
                  },
                ),
                Text("Yes"),
                Radio(
                  value: '0',
                  groupValue: dgcaApproval,
                  onChanged: (val) {
                    setState(() {
                      dgcaApproval = val!;
                    });
                  },
                ),
                Text("No"),
              ],
            ),

            SizedBox(height: 15),
            Text("Drone Purpose *"),
            Column(
              children: dronePurposeList.map<Widget>((item) {
                return buildRadioOption(item['cname'], item['id']);
              }).toList(),
            ),

            SizedBox(height: 15),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Price * ',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Unfocused label color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC2C2C2), // Focused border color
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: "",
                suffixText: "₹",
              ),
              maxLines: 1,
              maxLength: 7,
            ),

            SizedBox(height: 15),

            TextField(
              controller: batteryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Drone Battery Capacity *',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Unfocused label color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC2C2C2), // Focused border color
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: "",
                suffixText: "mAh",
              ),
              maxLines: 1,
              maxLength: 5,
            ),

            SizedBox(height: 15),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Drone Weight * ',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Unfocused label color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC2C2C2), // Focused border color
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: "",
                suffixText: "Kgs",
              ),
              maxLines: 1,
              maxLength: 2,
            ),

            SizedBox(height: 15),

            TextField(
              controller: modelController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Drone Model Name * ',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Unfocused label color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC2C2C2), // Focused border color
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: "",
              ),
              maxLines: 1,
              maxLength: 7,
            ),

            SizedBox(height: 15),

            Text("Drone Flying Time *"),

            SizedBox(height: 10),

            Row(
              children: [
                // Hours TextField
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: hoursController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 5),

                // 'h' label
                Text("hrs", style: TextStyle(fontWeight: FontWeight.bold)),

                SizedBox(width: 15),

                // Minutes TextField
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: minutesController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 5),

                // 'm' label
                Text("mins", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),

            SizedBox(height: 15),

            Text("Drone Charging Time *"),

            SizedBox(height: 10),

            Row(
              children: [
                // Hours TextField
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: c_hoursController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 5),

                // 'h' label
                Text("hrs", style: TextStyle(fontWeight: FontWeight.bold)),

                SizedBox(width: 15),

                // Minutes TextField
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: c_minutesController,
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                    decoration: InputDecoration(
                      counterText: "",
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                SizedBox(width: 5),

                // 'm' label
                Text("mins", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),

            SizedBox(height: 15),

            TextField(
              controller: descriptionController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Drone Description * ',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Unfocused label color
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFC2C2C2), // Focused border color
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                counterText: "",
              ),
              maxLines: 1,
              maxLength: 7,
            ),

            SizedBox(height: 15),

            Text(
              "Add Drone Photo *",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Text("Upload Drone Photos From all sides *"),

            SizedBox(height: 12),

            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                buildImageUploadBox('top', 'Top Angle Drone Image *'),
                buildImageUploadBox('right', 'Right Angle Drone Image *'),
                buildImageUploadBox('left', 'Left Angle Drone Image *'),
                buildImageUploadBox('full', 'Upload Drone Image *'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRadioOption(String label, int id) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      leading: Radio<String>(
        value: label,
        groupValue: selectedPurposeName,
        onChanged: (val) {
          setState(() {
            selectedPurposeName = val!;
            selectedPurposeId = id;
          });
        },
      ),
    );
  }

  Widget buildTextField(
    String hint, {
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    String? suffix,
    int maxLines = 1,
    int? maxLength,
    bool onlyDigits = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        maxLength: maxLength,

        inputFormatters: onlyDigits
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'This field is required';
          }

          // Example: prevent symbols in model name
          if (hint.contains("Model") &&
              !RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(value)) {
            return 'Only letters and numbers allowed';
          }

          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          suffixText: suffix,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget buildImageUploadBox(String key, String label) {
    return InkWell(
      onTap: () => pickImage(key),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: images[key] == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    size: 36,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 8),
                  Text("Upload", style: TextStyle(color: Colors.grey)),
                  Text(
                    label,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Image.file(File(images[key]!.path), fit: BoxFit.cover),
      ),
    );
  }
}

/*Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
buildTextField(
"Amount *",
controller: amountController,
inputType: TextInputType.number,
maxLength: 7,
onlyDigits: true,
),
buildTextField(
"Drone Battery Capacity *",
controller: batteryController,
inputType: TextInputType.number,
maxLength: 7,
onlyDigits: true,
),
buildTextField(
"Drone Weight *",
controller: weightController,
suffix: "Kgs",
inputType: TextInputType.number,
),
buildTextField(
"Drone Model Name *",
controller: modelController,
),
buildTextField(
"Drone Flying Time *",
controller: flyingTimeController,
suffix: "Mins",
inputType: TextInputType.number,
),
buildTextField(
"Drone Charging Time *",
controller: chargingTimeController,
suffix: "Mins",
inputType: TextInputType.number,
),
buildTextField(
"Drone Description *",
controller: descriptionController,
maxLines: 3,
maxLength: 250,
),
],
),
),*/
