import 'package:flutter/material.dart';

class ProgrammeScreen extends StatelessWidget {
  const ProgrammeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Programme',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF4A2A82), width: 2),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/img/logo_epsi.jpg',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const CircleAvatar(
                    backgroundColor: Color(0xFF4A2A82),
                    radius: 20,
                    child: Icon(Icons.person, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Votre programme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              
              // Programme cards
              _buildProgrammeCard(
                title: 'I1',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C8AD9), Color(0xFF7C67C9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 16),
              _buildProgrammeCard(
                title: 'I2',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C8AD9), Color(0xFF7C67C9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 16),
              _buildProgrammeCard(
                title: 'B3',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C8AD9), Color(0xFF7C67C9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 16),
              _buildProgrammeCard(
                title: 'M1',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C8AD9), Color(0xFF7C67C9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              const SizedBox(height: 16),
              _buildProgrammeCard(
                title: 'M2',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C8AD9), Color(0xFF7C67C9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgrammeCard({
    required String title,
    required LinearGradient gradient,
  }) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: gradient,
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}