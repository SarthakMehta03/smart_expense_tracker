import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {

  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String selectedCategory = 'Food';

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    'Food',
    'Travel',
    'Shopping',
    'Bills',
    'Others',
  ];

  Future<void> pickDate() async {

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2035)
    );

    if (pickedDate != null){
      setState(() {
        selectedDate = pickedDate;
      });
    }

  }

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Expense"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15,),

            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            
            const SizedBox(height: 15,),
            
            DropdownButtonFormField<String>(

              value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder()
                ),
                items: categories.map((category){
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value){
                setState(() {
                  selectedCategory = value!;
                });
                }
            ),

            const SizedBox(height: 15,),

            ListTile(
              title: Text(
                "Date : ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
              ),
              trailing: const Icon(Icons.calendar_month),
              onTap: pickDate,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () async {

                print("Save button clicked");

                await firestoreService.addExpense(
                    title: titleController.text.trim(),
                    amount: double.parse(amountController.text.trim()),
                    category: selectedCategory,
                    date: selectedDate);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense Saved'))
                );

                Navigator.pop(context);
              }, child: const Text("Save Expense")),
            )

          ],
        ),
      ),
    );
  }
}
