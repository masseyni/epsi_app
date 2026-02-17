# Accès Administrateur EPSI

Ce document contient les informations d'accès pour le compte administrateur de l'application EPSI.

## Identifiants Administrateur

- **Email**: admin@test.com
- **Mot de passe**: admin
- **Nom d'utilisateur**: admin

## Utilisation

Ces identifiants peuvent être utilisés pour:

1. Se connecter à l'interface d'administration Django à l'URL `/admin`
2. Accéder aux API protégées nécessitant des privilèges administrateur
3. Gérer les utilisateurs, les actualités, les événements et les cours

## Sécurité

**Note importante**: Ces identifiants sont destinés uniquement à des fins de développement et de test. Pour un environnement de production, veuillez modifier ces identifiants par défaut et utiliser des mots de passe forts.

## Comment changer les identifiants administrateur

Pour changer les identifiants administrateur, vous pouvez:

1. Utiliser l'interface d'administration Django
2. Exécuter la commande suivante avec vos propres valeurs:
   ```
   python manage.py shell
   from django.contrib.auth.models import User
   admin = User.objects.get(username='admin')
   admin.set_password('nouveau_mot_de_passe')
   admin.save()
   ```