import { writable, type Writable } from 'svelte/store';
import translations from './locales/en-US/translation.json';

// Simple English-only i18n implementation
// This replaces the full i18next library with a lightweight passthrough

export interface SimpleI18n {
	t: (key: string, options?: Record<string, any>) => string;
	language: string;
}

// Template string interpolation helper
const interpolate = (str: string, params?: Record<string, any>): string => {
	if (!params) return str;
	return str.replace(/\{\{(\w+)\}\}/g, (match, key) => {
		return params[key] !== undefined ? String(params[key]) : match;
	});
};

// Translation function - uses en-US translations or returns key if not found
const translate = (key: string, options?: Record<string, any>): string => {
	const translation = translations[key as keyof typeof translations];
	const text = translation || key;
	return interpolate(text, options);
};

// Create a simple i18n object that mimics the i18next API
const simpleI18n: SimpleI18n = {
	t: translate,
	language: 'en-US'
};

// Create a Svelte store
const i18nStore: Writable<SimpleI18n> = writable(simpleI18n);

export const initI18n = (defaultLocale?: string | undefined) => {
	// Always use en-US
	document.documentElement.setAttribute('lang', 'en-US');
};

// Stub function for compatibility
export const getLanguages = async () => {
	return [{ code: 'en-US', title: 'English (US)' }];
};

// Stub function for compatibility
export const changeLanguage = (lang: string) => {
	// No-op - always English
	document.documentElement.setAttribute('lang', 'en-US');
};

export default i18nStore;
export const isLoading = writable(false);
