import React, { createContext, useState, useContext, useEffect } from 'react';
import { isAuthenticated, refreshToken } from '../api/auth';

const AuthContext = createContext(null);

export const AuthProvider = ({ children }) => {
    const [isAuth, setIsAuth] = useState(isAuthenticated());
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        let refreshInterval;

        const setupTokenRefresh = () => {
            // Refresh token every 14 minutes (assuming 15-minute token expiry)
            refreshInterval = setInterval(async () => {
                try {
                    if (isAuth) {
                        await refreshToken();
                    }
                } catch (error) {
                    setIsAuth(false);
                    window.location.href = '/login';
                }
            }, 14 * 60 * 1000);
        };

        if (isAuth) {
            setupTokenRefresh();
        }

        setLoading(false);

        return () => {
            if (refreshInterval) {
                clearInterval(refreshInterval);
            }
        };
    }, [isAuth]);

    const login = (token) => {
        localStorage.setItem('authToken', token);
        setIsAuth(true);
    };

    const logout = () => {
        localStorage.removeItem('authToken');
        setIsAuth(false);
    };

    if (loading) {
        return <div>Loading...</div>;
    }

    return (
        <AuthContext.Provider value={{ isAuth, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};

export const useAuth = () => useContext(AuthContext);