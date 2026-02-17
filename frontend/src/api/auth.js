import { API_BASE_URL } from './config';

export const login = async (username, password) => {
    try {
        const response = await fetch(`${API_BASE_URL}/auth/login/`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ username, password }),
        });
        const data = await response.json();
        if (response.ok) {
            localStorage.setItem('authToken', data.token);
            return data;
        }
        throw new Error(data.message || 'Login failed');
    } catch (error) {
        throw error;
    }
};

export const logout = () => {
    localStorage.removeItem('authToken');
};

export const isAuthenticated = () => {
    return !!localStorage.getItem('authToken');
};

export const getAuthHeader = () => {
    const token = localStorage.getItem('authToken');
    return token ? { 'Authorization': `Token ${token}` } : {};
};

const REFRESH_TOKEN_URL = `${API_BASE_URL}/auth/refresh-token/`;

export const refreshToken = async () => {
    try {
        const response = await fetch(REFRESH_TOKEN_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Token ${localStorage.getItem('authToken')}`
            },
        });
        
        if (response.ok) {
            const data = await response.json();
            localStorage.setItem('authToken', data.token);
            return data.token;
        }
        throw new Error('Token refresh failed');
    } catch (error) {
        localStorage.removeItem('authToken');
        throw error;
    }
};