import React from 'react';
import { MemoryRouter } from 'react-router-dom';
import { I18nextProvider } from 'react-i18next';
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';

i18n.use(initReactI18next).init({
    resources: {
        en: {
            translation: {
                login: {
                    title: 'Login',
                    username: 'Username',
                    password: 'Password',
                    submit: 'Login',
                    loggingIn: 'Logging in...'
                },
                dashboard: {
                    title: 'Dashboard',
                    welcome: 'Welcome to Dashboard'
                },
                nav: {
                    dashboard: 'Dashboard',
                    profile: 'Profile',
                    logout: 'Logout'
                },
                error: {
                    invalidCredentials: 'Invalid credentials'
                }
            }
        }
    },
    lng: 'en',
    fallbackLng: 'en',
    interpolation: {
        escapeValue: false
    },
    react: {
        useSuspense: false
    }
});

export const TestWrapper = ({ children, initialEntries = ['/'] }) => {
    return (
        <I18nextProvider i18n={i18n}>
            <MemoryRouter initialEntries={initialEntries}>
                {children}
            </MemoryRouter>
        </I18nextProvider>
    );
};