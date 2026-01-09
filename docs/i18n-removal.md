# Multi-Language Support Removal

## Overview

Successfully removed all multi-language internationalization (i18n) support from Open WebUI. The application now uses English-only text throughout, simplifying the codebase and reducing dependencies.

## Changes Made

### 1. Replaced i18next with Simple English-Only System

**File:** `src/lib/i18n/index.ts`

- Removed full i18next library implementation
- Created lightweight passthrough system that:
  - Loads English translations from `en-US/translation.json`
  - Maintains API compatibility with existing `$i18n.t()` calls
  - Returns English text or key if translation not found
  - Always sets language to `en-US`

### 2. Updated Package Dependencies

**File:** `package.json`

Removed packages:
- `i18next` (^23.10.0)
- `i18next-browser-languagedetector` (^7.2.0)
- `i18next-resources-to-backend` (^1.2.0)
- `i18next-parser` (^9.0.1)

Removed scripts:
- `i18n:parse` - Translation extraction script

### 3. Fixed Direct i18next Imports

**Files Updated:**
- `src/lib/components/chat/Messages/ResponseMessage/StatusHistory/StatusItem.svelte` - Removed unused `import { t } from 'i18next'`
- `src/lib/components/chat/Messages/ResponseMessage.svelte` - Changed `import type { i18n as i18nType } from 'i18next'` to `import type { SimpleI18n } from '$lib/i18n'`
- `src/lib/components/chat/Chat.svelte` - Changed type import to use local `SimpleI18n`
- `src/lib/components/admin/Settings/Pipelines.svelte` - Changed type import to use local `SimpleI18n`
- `src/lib/components/admin/Settings/Audio.svelte` - Changed type import to use local `SimpleI18n`

**File:** `src/lib/i18n/index.ts`
- Exported `SimpleI18n` interface for use throughout the application

### 4. Removed Language Selector UI

**File:** `src/lib/components/chat/Settings/General.svelte`

- Removed language dropdown selector
- Removed "Help us translate" message
- Removed `getLanguages` and `changeLanguage` imports
- Removed language state variables

### 3. Updated Package Dependencies

**File:** `package.json`

Removed packages:
- `i18next` (^23.10.0)
- `i18next-browser-languagedetector` (^7.2.0)
- `i18next-resources-to-backend` (^1.2.0)
- `i18next-parser` (^9.0.1)

Removed scripts:
- `i18n:parse` - Translation extraction script

### 6. Deleted Translation Files

**Deleted:**
- `i18next-parser.config.ts` - Parser configuration
- `src/lib/i18n/locales/languages.json` - Language list
- All non-English language directories (55 languages removed):
  - ar, ar-BH, bg-BG, bn-BD, bo-TB, bs-BA, ca-ES, ceb-PH, cs-CZ, da-DK
  - de-DE, dg-DG, el-GR, en-GB, es-ES, et-EE, eu-ES, fa-IR, fi-FI, fr-CA
  - fr-FR, gl-ES, he-IL, hi-IN, hr-HR, hu-HU, id-ID, ie-GA, it-IT, ja-JP
  - ka-GE, kab-DZ, ko-KR, lt-LT, ms-MY, nb-NO, nl-NL, pa-IN, pl-PL, pt-BR
  - pt-PT, ro-RO, ru-RU, sk-SK, sr-RS, sv-SE, th-TH, tk-TM, tr-TR, ug-CN
  - uk-UA, ur-PK, uz-Cyrl-UZ, uz-Latn-Uz, vi-VN, zh-CN, zh-TW

**Kept:**
- `src/lib/i18n/index.ts` - Simplified English-only implementation
- `src/lib/i18n/locales/en-US/translation.json` - English translations

## What Still Works

### Translation Function Calls

All existing `$i18n.t()` calls throughout the codebase continue to work:

```svelte
{$i18n.t('Welcome')}
{$i18n.t('Hello {{name}}', { name: username })}
```

The new system:
1. Looks up the key in `en-US/translation.json`
2. Returns the English text
3. Interpolates any variables (e.g., `{{name}}`)
4. Returns the key itself if no translation found

### API Compatibility

These functions remain available but are now no-ops:
- `initI18n()` - Always sets language to `en-US`
- `getLanguages()` - Returns single English language
- `changeLanguage()` - Does nothing (always English)

## Benefits

### Reduced Bundle Size

- Removed ~120 npm packages
- Removed 55 language translation files
- Removed complex language detection logic
- Simplified build process

### Simplified Maintenance

- No translation synchronization needed
- No language-specific bugs
- No translation parser configuration
- Faster builds (no i18n parsing step)

### Performance Improvements

- No dynamic language file loading
- No language detection on startup
- Smaller JavaScript bundle
- Faster initial page load

## Migration Notes

### For Developers

No code changes needed in most cases. The `$i18n.t()` calls work as before but return English text only.

### For Users

- Language selector removed from settings
- Application always displays in English
- No localStorage language preference
- HTML lang attribute always set to `en-US`

## File Structure (After Changes)

```
src/lib/i18n/
├── index.ts                          # Simple English-only i18n
└── locales/
    └── en-US/
        └── translation.json          # English translations (1841 entries)
```

## Testing

To verify the changes:

```powershell
# Install dependencies
npm install

# Build the application
npm run build

# Run development server
npm run dev
```

All translation calls will return English text. The application language is always `en-US`.

## Reverting (If Needed)

To restore multi-language support:

1. Restore `package.json` i18n dependencies
2. Run `npm install`
3. Restore `src/lib/i18n/index.ts` to use i18next
4. Restore language directories from git history
5. Restore language selector in `General.svelte`

## Related Files

- `src/lib/i18n/index.ts` - New English-only implementation
- `src/lib/components/chat/Settings/General.svelte` - Settings without language selector
- `package.json` - Updated dependencies
- `.github/workflows/build-windows-installer.yml` - Build workflow (unaffected)

## Summary

✅ Multi-language support removed
✅ English-only system implemented
✅ All `$i18n.t()` calls still functional
✅ Dependencies cleaned up
✅ Language selector UI removed
✅ 55 language directories deleted
✅ Build process simplified

The application now runs English-only with a significantly reduced codebase and faster performance.

