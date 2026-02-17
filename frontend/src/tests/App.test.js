import React from 'react';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { TestWrapper } from './TestWrapper';
import App from '../App';
import { MockAuthProvider } from './mocks/authContext';
import { login as apiLogin } from '../api/auth';

// Mock the auth API
jest.mock('../api/auth', () => ({
    login: jest.fn(() => Promise.resolve({ token: 'fake-token' }))
}));

// Mock the original AuthContext
jest.mock('../contexts/AuthContext', () => ({
    useAuth: () => {
        const { useAuth } = jest.requireActual('./mocks/authContext');
        return useAuth();
    }
}));

const renderWithProviders = (ui, { route = '/' } = {}) => {
    return render(
        <TestWrapper initialEntries={[route]}>
            <MockAuthProvider>
                {ui}
            </MockAuthProvider>
        </TestWrapper>
    );
};

describe('Routing Tests', () => {
    beforeEach(() => {
        jest.clearAllMocks();
        localStorage.clear();
        window.history.pushState({}, '', '/');
    });

    test('redirects to login when not authenticated', () => {
        renderWithProviders(<App />);
        expect(screen.getByTestId('login-form')).toBeInTheDocument();
    });

    test('login form submission redirects to dashboard', async () => {
        renderWithProviders(<App />, { route: '/login' });

        fireEvent.change(screen.getByTestId('username-input'), {
            target: { value: 'testuser' }
        });
        fireEvent.change(screen.getByTestId('password-input'), {
            target: { value: 'password123' }
        });

        // Mock successful API response
        apiLogin.mockImplementationOnce(() => 
            Promise.resolve({ token: 'fake-token' })
        );

        fireEvent.submit(screen.getByTestId('login-form'));

        await waitFor(() => {
            expect(apiLogin).toHaveBeenCalledWith('testuser', 'password123');
        });

        await waitFor(() => {
            expect(screen.getByText('dashboard.welcome')).toBeInTheDocument();
        });
    });

    test('protected routes redirect to login when not authenticated', async () => {
        renderWithProviders(<App />, { route: '/dashboard' });
        await waitFor(() => {
            expect(screen.getByTestId('login-form')).toBeInTheDocument();
        });
    });
});