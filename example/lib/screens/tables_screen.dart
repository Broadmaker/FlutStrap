// tables_screen.dart
import 'package:flutter/material.dart';
import 'package:master_flutstrap/flutstrap.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String role;
  final String department;
  final DateTime joinDate;
  final double salary;
  final String location;
  final bool active;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.department,
    required this.joinDate,
    required this.salary,
    required this.location,
    required this.active,
  });

  // Simple toJson for the table
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'department': department,
      'joinDate': joinDate,
      'salary': salary,
      'location': location,
      'active': active,
    };
  }
}

class TablesScreen extends StatefulWidget {
  const TablesScreen({super.key});

  @override
  State<TablesScreen> createState() => _TablesScreenState();
}

class _TablesScreenState extends State<TablesScreen> {
  final List<User> _users = [
    User(
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      role: 'Admin',
      department: 'IT',
      joinDate: DateTime(2023, 1, 15),
      salary: 75000,
      location: 'New York',
      active: true,
    ),
    User(
      id: 2,
      name: 'Jane Smith',
      email: 'jane@example.com',
      role: 'Developer',
      department: 'Engineering',
      joinDate: DateTime(2023, 3, 22),
      salary: 85000,
      location: 'San Francisco',
      active: true,
    ),
    User(
      id: 3,
      name: 'Bob Johnson',
      email: 'bob@example.com',
      role: 'Designer',
      department: 'Design',
      joinDate: DateTime(2023, 6, 10),
      salary: 65000,
      location: 'Chicago',
      active: false,
    ),
    User(
      id: 4,
      name: 'Alice Brown',
      email: 'alice@example.com',
      role: 'Manager',
      department: 'Operations',
      joinDate: DateTime(2022, 11, 5),
      salary: 95000,
      location: 'Boston',
      active: true,
    ),
    User(
      id: 5,
      name: 'Charlie Wilson',
      email: 'charlie@example.com',
      role: 'Analyst',
      department: 'Finance',
      joinDate: DateTime(2023, 8, 30),
      salary: 70000,
      location: 'Austin',
      active: true,
    ),
  ];

  // Helper method to get role color
  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.purple;
      case 'developer':
        return Colors.blue;
      case 'designer':
        return Colors.orange;
      case 'manager':
        return Colors.green;
      case 'analyst':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }

  // Helper method to create role badge
  Widget _buildRoleBadge(String role) {
    final color = _getRoleColor(role);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Helper method to create status badge
  Widget _buildStatusBadge(bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: active
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Text(
        active ? 'Active' : 'Inactive',
        style: TextStyle(
          color: active ? Colors.green : Colors.red,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }

  // Initialize columns in the state, not as final field
  late final List<FSTableColumn<User>> _columns = [
    FSTableColumn<User>(
      header: 'ID',
      accessor: 'id',
      sortable: true,
      width: 60,
      cellAlign: TextAlign.center,
      cellBuilder: (User user) => Text(
        user.id.toString(),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    FSTableColumn<User>(
      header: 'Name',
      accessor: 'name',
      sortable: true,
      width: 120,
      cellBuilder: (User user) => Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    FSTableColumn<User>(
      header: 'Email',
      accessor: 'email',
      sortable: true,
      width: 180,
      cellBuilder: (User user) => Text(
        user.email,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ),
    FSTableColumn<User>(
      header: 'Role',
      accessor: 'role',
      sortable: true,
      width: 100,
      cellBuilder: (User user) => _buildRoleBadge(user.role),
    ),
    FSTableColumn<User>(
      header: 'Department',
      accessor: 'department',
      sortable: true,
      width: 110,
      cellBuilder: (User user) => Text(user.department),
    ),
    FSTableColumn<User>(
      header: 'Join Date',
      accessor: 'joinDate',
      sortable: true,
      width: 100,
      cellBuilder: (User user) => Text(
        '${user.joinDate.month}/${user.joinDate.day}/${user.joinDate.year}',
        style: const TextStyle(fontSize: 12),
      ),
    ),
    FSTableColumn<User>(
      header: 'Salary',
      accessor: 'salary',
      sortable: true,
      width: 90,
      cellAlign: TextAlign.right,
      cellBuilder: (User user) => Text(
        '\$${user.salary.toStringAsFixed(0)}',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
    FSTableColumn<User>(
      header: 'Location',
      accessor: 'location',
      sortable: true,
      width: 100,
      cellBuilder: (User user) => Text(user.location),
    ),
    FSTableColumn<User>(
      header: 'Status',
      accessor: 'active',
      sortable: true,
      width: 80,
      cellAlign: TextAlign.center,
      cellBuilder: (User user) => _buildStatusBadge(user.active),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutstrap Tables'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Flutstrap Table Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Explore different table variants, sizes, and responsive behaviors.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),

            // Table Variants Section
            _buildSectionTitle('Table Variants'),
            const SizedBox(height: 16),

            Expanded(
              child: ListView(
                children: [
                  // Basic Table
                  _buildTableExample(
                    title: '1. Basic Table',
                    description: 'Simple table with default styling',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(
                          0, 4), // Show only first 4 columns for demo
                      data: _users,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Striped Table
                  _buildTableExample(
                    title: '2. Striped Table',
                    description:
                        'Alternating row colors for better readability',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(0, 4),
                      data: _users,
                      striped: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Bordered Table
                  _buildTableExample(
                    title: '3. Bordered Table',
                    description: 'Table with borders around cells and headers',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(0, 4),
                      data: _users,
                      bordered: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Striped & Bordered Table
                  _buildTableExample(
                    title: '4. Striped & Bordered Table',
                    description: 'Combination of striped and bordered styles',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(0, 4),
                      data: _users,
                      striped: true,
                      bordered: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Hover Table
                  _buildTableExample(
                    title: '5. Hover Table',
                    description: 'Rows highlight on hover (desktop only)',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(0, 4),
                      data: _users,
                      hover: true,
                      striped: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Table Sizes Section
                  _buildSectionTitle('Table Sizes'),
                  const SizedBox(height: 16),

                  // Small Table
                  _buildTableExample(
                    title: '6. Small Size',
                    description:
                        'Compact table with smaller padding and font size',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(0, 4),
                      data: _users,
                      size: FSTableSize.sm,
                      striped: true,
                      bordered: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Large Table
                  _buildTableExample(
                    title: '7. Large Size',
                    description:
                        'Spacious table with larger padding and font size',
                    table: FlutstrapTable<User>(
                      columns: _columns.sublist(0, 4),
                      data: _users,
                      size: FSTableSize.lg,
                      striped: true,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Responsive Tables Section
                  _buildSectionTitle('Responsive Behavior'),
                  const SizedBox(height: 16),

                  // Scroll Table
                  _buildTableExample(
                    title: '8. Scroll Responsive',
                    description: 'Horizontal scrolling on small screens',
                    table: SizedBox(
                      height: 200, // Fixed height to demonstrate scrolling
                      child: FlutstrapTable<User>(
                        columns:
                            _columns, // Show all columns to demonstrate scrolling
                        data: _users,
                        responsive: FSTableResponsive.scroll,
                        striped: true,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Full Featured Table
                  _buildTableExample(
                    title: '9. Full Featured Table',
                    description: 'Complete table with all features enabled',
                    table: FlutstrapTable<User>(
                      columns: _columns,
                      data: _users,
                      variant: FSTableVariant.primary,
                      striped: true,
                      bordered: true,
                      hover: true,
                      responsive: FSTableResponsive.scroll,
                      onRowTap: (user) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Selected: ${user.name}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildTableExample({
    required String title,
    required String description,
    required Widget table,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            table,
          ],
        ),
      ),
    );
  }
}
