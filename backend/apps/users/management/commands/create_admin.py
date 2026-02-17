# users/management/commands/create_admin.py
from django.core.management.base import BaseCommand
from django.contrib.auth.models import User
from django.db import IntegrityError

class Command(BaseCommand):
    help = 'Creates an admin user with predefined credentials'

    def handle(self, *args, **options):
        email = 'admin@test.com'
        password = 'admin'
        username = 'admin'

        try:
            # Check if admin user already exists
            if User.objects.filter(email=email).exists():
                self.stdout.write(self.style.WARNING(f'Admin user with email {email} already exists'))
                return

            # Create superuser
            admin = User.objects.create_superuser(
                username=username,
                email=email,
                password=password
            )
            
            self.stdout.write(self.style.SUCCESS(f'Admin user created successfully with email: {email} and password: {password}'))
        
        except IntegrityError:
            self.stdout.write(self.style.ERROR('Error creating admin user: username already exists'))
        except Exception as e:
            self.stdout.write(self.style.ERROR(f'Error creating admin user: {str(e)}'))