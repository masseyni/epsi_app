import i18n from '../utils/i18n';

const API_BASE_URL = 'http://localhost:8000/api';

const wait = (ms) => new Promise(resolve => setTimeout(resolve, ms));

const getErrorMessage = (key) => {
    return i18n.t(`error.${key}`);
};

const retryRequest = async (fn, retries = 3, delay = 1000) => {
    try {
        return await fn();
    } catch (error) {
        if (retries === 0 || error.message === getErrorMessage('session')) {
            throw error;
        }
        await wait(delay);
        return retryRequest(fn, retries - 1, delay * 2);
    }
};

export const fetchWithAuth = async (endpoint, options = {}) => {
    const token = localStorage.getItem('authToken');
    const currentLang = i18n.language;
    
    const makeRequest = async () => {
        const response = await fetch(`${API_BASE_URL}${endpoint}`, {
            ...options,
            headers: {
                'Content-Type': 'application/json',
                'Accept-Language': currentLang,
                ...(token && { 'Authorization': `Token ${token}` }),
                ...options.headers,
            },
        });
        
        if (!navigator.onLine) {
            throw new Error(getErrorMessage('offline'));
        }

        if (!response) {
            throw new Error(getErrorMessage('timeout'));
        }

        if (!response.ok) {
            if (response.status === 401) {
                try {
                    const newToken = await refreshToken();
                    return retryRequest(async () => {
                        const retryResponse = await fetch(`${API_BASE_URL}${endpoint}`, {
                            ...options,
                            headers: {
                                'Content-Type': 'application/json',
                                'Authorization': `Token ${newToken}`,
                                ...options.headers,
                            },
                        });
                        
                        if (!retryResponse.ok) {
                            throw new Error(`HTTP error! status: ${retryResponse.status}`);
                        }
                        return retryResponse.json();
                    });
                } catch (refreshError) {
                    window.location.href = '/login';
                    throw new Error('Session expired');
                }
            }
            
            const errorData = await response.json().catch(() => ({}));
            throw new Error(errorData.message || `HTTP error! status: ${response.status}`);
        }
        
        return response.json();
    };

    try {
        return await retryRequest(makeRequest);
    } catch (error) {
        if (error.name === 'AbortError') {
            throw new Error(getErrorMessage('timeout'));
        }
        if (!navigator.onLine) {
            throw new Error(getErrorMessage('offline'));
        }
        if (error instanceof TypeError) {
            throw new Error(getErrorMessage('network'));
        }
        console.error('API Error:', error);
        throw error;
    }
};

export const fetchWithTimeout = (promise, timeout = 8000) => {
    return Promise.race([
        promise,
        new Promise((_, reject) => 
            setTimeout(() => reject(new Error('Request timed out')), timeout)
        )
    ]);
};