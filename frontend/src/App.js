import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import { useAuth } from './contexts/AuthContext';
import Login from './components/Login';
import Dashboard from './components/Dashboard';
import Profile from './components/Profile';
import Navbar from './components/Navbar';
import ProtectedRoute from './components/ProtectedRoute';

function App() {
    const { isAuth } = useAuth();

    return (
        <>
            {isAuth && <Navbar />}
            <div className="app-container">
                <Routes>
                    <Route path="/login" element={!isAuth ? <Login /> : <Navigate to="/dashboard" />} />
                    <Route element={<ProtectedRoute />}>
                        <Route path="/dashboard" element={<Dashboard />} />
                        <Route path="/profile" element={<Profile />} />
                    </Route>
                    <Route path="/" element={<Navigate to={isAuth ? "/dashboard" : "/login"} />} />
                    <Route path="*" element={<Navigate to="/" />} />
                </Routes>
            </div>
        </>
    );
}

export default App;