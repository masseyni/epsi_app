import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // User information variables
  String email = '';
  String phone = '';
  String birthDate = '';
  String address = '';
  String name = '';
  String studentId = '';
  String year = '';
  String campus = '';
  String formation = '';
  String entryYear = '';
  String internship = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      // ✅ ENTÊTE "comme Guide" : blanc, titre centré, logo en haut à droite
            appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Show banner if profile is incomplete
            if (name.isEmpty || email.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.amber[700]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber[800]),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Veuillez compléter votre profil en renseignant au moins votre nom et email.',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),

            // Profile Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Profile Image
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF4A2A82),
                        width: 3,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img/logo_epsi.jpg',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const CircleAvatar(
                            backgroundColor: Color(0xFF4A2A82),
                            radius: 60,
                            child: Icon(Icons.person,
                                color: Colors.white, size: 60),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Name
                  Text(
                    name.isEmpty ? 'Votre nom' : name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Student ID
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A2A82).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      studentId.isEmpty ? 'ID: Non renseigné' : 'ID: $studentId',
                      style: const TextStyle(
                        color: Color(0xFF4A2A82),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Quick Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStatItem('Année', year.isEmpty ? 'Non renseigné' : year),
                      _buildDivider(),
                      _buildStatItem('Campus', campus.isEmpty ? 'Non renseigné' : campus),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Information Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildInfoSection(
                    'Informations personnelles',
                    [
                      _buildInfoItem(Icons.email, 'Email',
                          email.isEmpty ? 'À renseigner' : email),
                      _buildInfoItem(Icons.phone, 'Téléphone',
                          phone.isEmpty ? 'Non renseigné' : phone),
                      _buildInfoItem(Icons.cake, 'Date de naissance',
                          birthDate.isEmpty ? 'Non renseigné' : birthDate),
                      _buildInfoItem(Icons.location_on, 'Adresse',
                          address.isEmpty ? 'Non renseigné' : address),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildInfoSection(
                    'Parcours académique',
                    [
                      _buildInfoItem(Icons.school, 'Formation actuelle',
                          formation.isEmpty ? 'Non renseigné' : formation),
                      _buildInfoItem(Icons.calendar_today, 'Année d\'entrée',
                          entryYear.isEmpty ? 'Non renseigné' : entryYear),
                      _buildInfoItem(Icons.work, 'Stage actuel',
                          internship.isEmpty ? 'Non renseigné' : internship),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showEditProfileDialog(context);
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text('Modifier le profil'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A2A82),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Show dialog to edit profile information (ton code d'origine, inchangé)
  void _showEditProfileDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController emailController = TextEditingController(text: email);
    final TextEditingController phoneController = TextEditingController(text: phone);
    final TextEditingController birthDateController =
        TextEditingController(text: birthDate);
    final TextEditingController addressController =
        TextEditingController(text: address);
    final TextEditingController formationController =
        TextEditingController(text: formation);
    final TextEditingController yearController = TextEditingController(text: year);
    final TextEditingController campusController =
        TextEditingController(text: campus);
    final TextEditingController entryYearController =
        TextEditingController(text: entryYear);
    final TextEditingController internshipController =
        TextEditingController(text: internship);

    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifier le profil'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Informations personnelles',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A2A82))),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nom *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre nom';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre email';
                      }
                      if (!value.contains('@')) {
                        return 'Veuillez entrer un email valide';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Téléphone *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: birthDateController,
                    decoration: const InputDecoration(
                      labelText: 'Date de naissance *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre date de naissance';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: 'Adresse',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text('Parcours académique',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A2A82))),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: yearController,
                    decoration: const InputDecoration(
                      labelText: 'Année *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre année d\'études';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: campusController,
                    decoration: const InputDecoration(
                      labelText: 'Campus *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre campus';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: formationController,
                    decoration: const InputDecoration(
                      labelText: 'Formation actuelle *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre formation';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: entryYearController,
                    decoration: const InputDecoration(
                      labelText: 'Année d\'entrée *',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre année d\'entrée';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: internshipController,
                    decoration: const InputDecoration(
                      labelText: 'Stage actuel',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4A2A82),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    name = nameController.text;
                    email = emailController.text;
                    phone = phoneController.text;
                    birthDate = birthDateController.text;
                    address = addressController.text;
                    formation = formationController.text;
                    year = yearController.text;
                    campus = campusController.text;
                    entryYear = entryYearController.text;
                    internship = internshipController.text;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 25,
      width: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.symmetric(horizontal: 15),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A2A82),
            ),
          ),
          const SizedBox(height: 15),
          ...items,
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF4A2A82).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF4A2A82),
              size: 20,
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
