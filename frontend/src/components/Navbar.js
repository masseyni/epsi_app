import React from 'react';
import { useTranslation } from 'react-i18next';
import { useAuth } from '../contexts/AuthContext';
import LanguageSwitcher from './LanguageSwitcher';
import '../styles/LanguageSwitcher.css';

const Navbar = () => {
    const { t } = useTranslation();
    const { logout } = useAuth();

    return (
        <nav className="navbar">
            <div className="navbar-brand">
                <h1>EPSI</h1>
            </div>
            <div className="navbar-menu">
                <a href="/dashboard">{t('dashboard')}</a>
                <a href="/profile">{t('profile')}</a>
            </div>
            <div className="navbar-end">
                <LanguageSwitcher />
                <button onClick={logout}>{t('logout')}</button>
            </div>
        </nav>
    );
};

export default Navbar;