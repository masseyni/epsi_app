import 'package:flutter/material.dart';
import '../home_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/img/logo_epsi.jpg',
              height: 30,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 30,
                  child: Center(
                    child: Icon(Icons.school),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            const Text(
              'Actualités',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // News section
              const Text(
                'Dernières actualités',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              
              // News items
              _buildNewsItem(
                title: 'Nouveau campus',
                location: 'Paris',
                date: '15 janvier 2024',
                imageUrl: 'assets/img/nv_campus.jpg',
                content: 'EPSI ouvre un nouveau campus à Paris pour accueillir plus d\'étudiants et proposer de nouvelles formations.',
              ),
              const SizedBox(height: 16),
              
              _buildNewsItem(
                title: 'Élections BDE',
                location: 'Paris',
                date: '10 janvier 2024',
                imageUrl: 'assets/img/elections_bde.jpg',
                content: 'Les élections du Bureau Des Étudiants auront lieu le mois prochain. Préparez vos listes et vos programmes!',
              ),
              const SizedBox(height: 16),
              
              _buildNewsItem(
                title: 'Nouveaux partenariats',
                location: 'National',
                date: '5 janvier 2024',
                imageUrl: 'assets/img/partenariats.jpg',
                content: 'EPSI a signé de nouveaux partenariats avec des entreprises du secteur IT pour faciliter l\'insertion professionnelle des étudiants.',
              ),
              
              const SizedBox(height: 32),
              
              // Upcoming events section
              const Text(
                'Événements à venir',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              
              // Events items
              _buildEventItem(
                title: 'Journée portes ouvertes',
                date: '21 janvier 2024',
                location: 'Campus de Paris',
                imageUrl: 'assets/img/portesouvertes.jpg',
              ),
              const SizedBox(height: 16),
              
              _buildEventItem(
                title: 'Journée portes ouvertes',
                date: '17 février 2024',
                location: 'Campus de Lyon',
                imageUrl: 'assets/img/portesouvertes.jpg',
              ),
              const SizedBox(height: 16),
              
              _buildEventItem(
                title: 'Journée portes ouvertes',
                date: '16 mars 2024',
                location: 'Campus de Bordeaux',
                imageUrl: 'assets/img/portesouvertes.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNewsItem({
    required String title,
    required String location,
    required String date,
    required String imageUrl,
    required String content,
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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  content,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEventItem({
    required String title,
    required String date,
    required String location,
    required String imageUrl,
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}