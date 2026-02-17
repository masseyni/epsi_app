import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAuth } from '../contexts/AuthContext';
import { login } from '../api/auth';
import LanguageSwitcher from './LanguageSwitcher';
import '../styles/Login.css';

const Login = () => {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(false);
    const navigate = useNavigate();
    const { t } = useTranslation();
    const { login: authLogin } = useAuth();

    const handleSubmit = async (e) => {
        e.preventDefault();
        setError('');
        setLoading(true);
        
        try {
            const response = await login(username, password);
            authLogin(response.token);
            navigate('/dashboard');
        } catch (err) {
            setError(t('error.invalidCredentials'));
        } finally {
            setLoading(false);
        }
    };

    return (
        <div className="login-container">
            <div className="language-switcher-container">
                <LanguageSwitcher />
            </div>
            <div className="login-form-container">
                <h2>{t('login.title')}</h2>
                <form onSubmit={handleSubmit} data-testid="login-form">
                    <div className="form-group">
                        <input
                            type="text"
                            value={username}
                            onChange={(e) => setUsername(e.target.value)}
                            placeholder={t('login.username')}
                            disabled={loading}
                            data-testid="username-input"
                        />
                    </div>
                    <div className="form-group">
                        <input
                            type="password"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            placeholder={t('login.password')}
                            disabled={loading}
                            data-testid="password-input"
                        />
                    </div>
                    {error && <p className="error-message">{error}</p>}
                    <button type="submit" disabled={loading} data-testid="login-button">
                        {loading ? t('login.loggingIn') : t('login.submit')}
                    </button>
                </form>
            </div>
        </div>
    );
};

export default Login;