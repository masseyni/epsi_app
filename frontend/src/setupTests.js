import '@testing-library/jest-dom';

// Mock CSS imports
module.exports = {
    process() {
        return 'module.exports = {};';
    },
};