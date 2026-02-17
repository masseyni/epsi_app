from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework import status
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from .serializers import UserSerializer

@api_view(['POST'])
@permission_classes([AllowAny])
def register_user(request):
    name = request.data.get('name')
    email = request.data.get('email')
    password = request.data.get('password')
    confirm_password = request.data.get('confirm_password')
    
    # Validation des données
    if not all([name, email, password, confirm_password]):
        return Response({'error': 'Tous les champs sont requis'}, status=status.HTTP_400_BAD_REQUEST)
    
    # Vérifier si les mots de passe correspondent
    if password != confirm_password:
        return Response({'error': 'Les mots de passe ne correspondent pas'}, status=status.HTTP_400_BAD_REQUEST)
    
    # Vérifier si l'email existe déjà
    if User.objects.filter(email=email).exists():
        return Response({'error': 'Cet email est déjà utilisé'}, status=status.HTTP_400_BAD_REQUEST)
    
    # Créer l'utilisateur
    user = User.objects.create_user(
        username=email,  # Utiliser l'email comme nom d'utilisateur
        email=email,
        password=password,
        first_name=name
    )
    
    return Response({
        'success': True,
        'message': 'Compte créé avec succès',
        'user': UserSerializer(user).data
    }, status=status.HTTP_201_CREATED)

@api_view(['POST'])
@permission_classes([AllowAny])
def login_user(request):
    email = request.data.get('email')
    password = request.data.get('password')
    
    if not email or not password:
        return Response({
            'error': 'Email et mot de passe requis'
        }, status=status.HTTP_400_BAD_REQUEST)
    
    # Trouver l'utilisateur par email
    try:
        user = User.objects.get(email=email)
    except User.DoesNotExist:
        return Response({
            'error': 'Email ou mot de passe incorrect'
        }, status=status.HTTP_400_BAD_REQUEST)
    
    # Authentifier l'utilisateur
    user = authenticate(username=user.username, password=password)
    if user is not None:
        # Créer ou récupérer le token
        token, created = Token.objects.get_or_create(user=user)
        
        return Response({
            'success': True,
            'message': 'Connexion réussie',
            'token': token.key,
            'user': UserSerializer(user).data
        })
    else:
        return Response({
            'error': 'Email ou mot de passe incorrect'
        }, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def user_profile(request):
    if request.user.is_authenticated:
        serializer = UserSerializer(request.user)
        return Response(serializer.data)
    return Response({'error': 'Non authentifié'}, status=status.HTTP_401_UNAUTHORIZED)

@api_view(['GET'])
def user_list(request):
    users = User.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)
