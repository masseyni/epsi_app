import React, { createContext, useContext, useState } from 'react';

const AuthContext = createContext();

export const useAuth = () => {
    const context = useContext(AuthContext);
    if (!context) {
        throw new Error('useAuth must be used within an AuthProvider');
    }
    return context;
};

export const MockAuthProvider = ({ children }) => {
    const [isAuth, setIsAuth] = useState(false);
    const [token, setToken] = useState(null);

    const login = async (newToken) => {
        setToken(newToken);
        setIsAuth(true);
    };

    const logout = () => {
        setToken(null);
        setIsAuth(false);
    };

    return (
        <AuthContext.Provider value={{ isAuth, token, login, logout }}>
            {children}
        </AuthContext.Provider>
    );
};