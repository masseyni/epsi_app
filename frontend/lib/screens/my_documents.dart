import 'package:flutter/material.dart';

class MyDocs extends StatelessWidget {
  const MyDocs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove back button
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Guide',
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
              // Documents essentiels section
              const Text(
                'Documents essentiels',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildGuideCard(
                title: 'Assurance maladie & Sécurité sociale',
                description: 'Informations sur la carte vitale, l\'affiliation à la sécurité sociale et les démarches à suivre pour les étudiants français et internationaux.',
                imageUrl: 'assets/img/securite_sociale.jpg',
                onTap: () {
                  // Navigate to detailed health insurance guide
                },
              ),
              const SizedBox(height: 16),
              
              _buildGuideCard(
                title: 'CVEC & Mutuelles étudiantes',
                description: 'Tout savoir sur la Contribution Vie Étudiante et Campus (CVEC) et les complémentaires santé adaptées aux besoins des étudiants.',
                imageUrl: 'assets/img/cvec.jpg',
                onTap: () {
                  // Navigate to detailed CVEC guide
                },
              ),
              const SizedBox(height: 16),
              
              _buildGuideCard(
                title: 'Guide pour étudiants internationaux',
                description: 'Documents nécessaires, démarches administratives et conseils pratiques pour faciliter votre installation en France en tant qu\'étudiant étranger.',
                imageUrl: 'assets/img/guide.jpg',
                onTap: () {
                  // Navigate to international student guide
                },
              ),
              
              const SizedBox(height: 32),
              
              // Guide cards section title
              const Text(
                'Guides pratiques',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              
              // Guide cards
              _buildGuideCard(
                title: 'Le logement',
                description: 'Besoin d\'un coup de pouce pour votre logement? Que vous soyez étudiant français ou étranger, plusieurs aides peuvent alléger vos dépenses. L\'ALS couvre jusqu\'à 40% de la garantie sociale pour les étudiants...',
                imageUrl: 'assets/img/logement.jpg',
                onTap: () {
                  // Navigate to detailed housing guide
                },
              ),
              
              // Rest of the existing guide cards...
              const SizedBox(height: 16),
              
              _buildGuideCard(
                title: 'Les Transports',
                description: 'Simplifiez vos trajets vers le campus! Explorez les réductions étudiantes, les abonnements transports et les aides pour faciliter vos déplacements, même si vous venez de l\'étranger.',
                imageUrl: 'assets/img/transport.jpg',
                onTap: () {
                  // Navigate to detailed transportation guide
                },
              ),
              const SizedBox(height: 16),
              
              _buildGuideCard(
                title: 'La restauration',
                description: 'Besoin d\'un coup de pouce pour votre budget repas? Que vous soyez étudiant français ou étranger, plusieurs aides peuvent alléger vos dépenses. Le CROUS propose des repas à tarif réduit pour les étudiants.',
                imageUrl: 'assets/img/restauration.jpg',
                onTap: () {
                  // Navigate to detailed food guide
                },
              ),
              const SizedBox(height: 16),
              
              _buildGuideCard(
                title: 'Aides financières',
                description: 'Simplifiez vos trajets vers le campus! Explorez les réductions étudiantes, les abonnements transports et les aides pour faciliter vos déplacements, même si vous venez de l\'étranger.',
                imageUrl: 'assets/img/finance.jpg',
                onTap: () {
                  // Navigate to detailed financial aid guide
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildGuideCard({
    required String title,
    required String description,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        description,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4A2A82),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'En savoir plus',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: 120,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}