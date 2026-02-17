import React from 'react';
import { useTranslation } from 'react-i18next';

const Dashboard = () => {
    const { t } = useTranslation();

    return (
        <div className="dashboard">
            <h1>{t('dashboard.title')}</h1>
            <div className="dashboard-content">
                <p>{t('dashboard.welcome')}</p>
            </div>
        </div>
    );
};

export default Dashboard;