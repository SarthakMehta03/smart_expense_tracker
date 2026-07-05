import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';

class AddIncomeScreen extends StatefulWidget {
  final String? docId;
  final String? title;
  final double? amount;
  final String? source;
  final DateTime? date;

  const AddIncomeScreen({
    super.key,
    this.docId,
    this.title,
    this.amount,
    this.source,
    this.date,
  });

  @override
  State<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends State<AddIncomeScreen> {
  bool isLoading = false;

  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  String selectedSource = 'Salary';
  DateTime selectedDate = DateTime.now();

  final List<String> sources = [
    'Salary',
    'Freelancing',
    'Business',
    'Bonus',
    'Investment',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.docId != null) {
      titleController.text = widget.title!;
      amountController.text = widget.amount.toString();
      selectedSource = widget.source!;
      selectedDate = widget.date!;
    }
  }

  Future<void> pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> saveIncome() async {
    if (titleController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    double? amount = double.tryParse(
      amountController.text.trim(),
    );

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Enter a valid amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      if (widget.docId == null) {
        await firestoreService.addIncome(
          title: titleController.text.trim(),
          amount: amount,
          source: selectedSource,
          date: selectedDate,
        );
      } else {
        await firestoreService.updateIncome(
          docId: widget.docId!,
          title: titleController.text.trim(),
          amount: amount,
          source: selectedSource,
          date: selectedDate,
        );
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.docId == null
                ? "Income Added Successfully"
                : "Income Updated Successfully",
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to save income"),
          backgroundColor: Colors.red,
        ),
      );
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
        title: Text(
          widget.docId == null
              ? "Add Income"
              : "Edit Income",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Income Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: selectedSource,
              decoration: const InputDecoration(
                labelText: "Source",
                border: OutlineInputBorder(),
              ),
              items: sources.map((source) {
                return DropdownMenuItem(
                  value: source,
                  child: Text(source),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSource = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            ListTile(
              title: Text(
                "Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
              ),
              trailing: const Icon(
                Icons.calendar_month,
              ),
              onTap: pickDate,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                isLoading ? null : saveIncome,
                child: isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : Text(
                  widget.docId == null
                      ? "Save Income"
                      : "Update Income",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}