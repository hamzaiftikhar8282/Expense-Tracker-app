import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Expenses: \$730.00',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpenseScreen()),
                );
              },
              child: Text(' please new Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddExpenseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' please Add Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: ExpenseForm(),
      ),
    );
  }
}

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  String _category = '';
  double _amount = 0.0;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Date'),
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null && pickedDate != _selectedDate)
                setState(() {
                  _selectedDate = pickedDate;
                });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Category'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a category';
              }
              return null;
            },
            onSaved: (value) {
              _category = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
            onSaved: (value) {
              _amount = double.parse(value!);
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Description'),
            onSaved: (value) {
              _description = value!;
            },
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Save the expense to the database here
                // You can also use a state management solution to manage expenses
                Navigator.pop(context); // Close the form
              }
            },
            child: Text('Save Expense'),
          ),
        ],
      ),
    );
  }
}

class Expense {
  final DateTime date;
  final String category;
  final double amount;
  final String description;

  Expense({
    required this.date,
    required this.category,
    required this.amount,
    required this.description,
  });
}

// Define other classes (ExpenseCategory, Budget, Reminder) and widgets here...
