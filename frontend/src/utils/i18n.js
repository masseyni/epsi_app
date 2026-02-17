import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

const resources = {
  en: {
    translation: {
      'login': 'Login',
      'logout': 'Logout',
      'username': 'Username',
      'password': 'Password',
      'error.network': 'Network error',
      'error.timeout': 'Request timed out',
      'error.offline': 'No internet connection',
      'error.session': 'Session expired',
      // Add more translations
    }
  },
  fr: {
    translation: {
      'login': 'Connexion',
      'logout': 'Déconnexion',
      'username': 'Nom d\'utilisateur',
      'password': 'Mot de passe',
      'error.network': 'Erreur réseau',
      'error.timeout': 'Délai de requête dépassé',
      'error.offline': 'Pas de connexion Internet',
      'error.session': 'Session expirée',
      // Add more translations
    }
  }
};

i18n
  .use(initReactI18next)
  .init({
    resources,
    lng: localStorage.getItem('language') || navigator.language.split('-')[0] || 'en',
    fallbackLng: 'en',
    interpolation: {
      escapeValue: false
    }
  });

export default i18n;