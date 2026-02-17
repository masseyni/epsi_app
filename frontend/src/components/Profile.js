import React from 'react';
import { useTranslation } from 'react-i18next';

const Profile = () => {
    const { t } = useTranslation();

    return (
        <div className="profile">
            <h1>{t('profile.title')}</h1>
            <div className="profile-content">
                <p>{t('profile.welcome')}</p>
            </div>
        </div>
    );
};

export default Profile;