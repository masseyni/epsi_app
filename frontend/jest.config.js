module.exports = {
    moduleNameMapper: {
        '\\.(css|less|scss|sass)$': '<rootDir>/src/setupTests.js',
    },
    setupFilesAfterEnv: ['<rootDir>/src/setupTests.js'],
    testEnvironment: 'jsdom',
};