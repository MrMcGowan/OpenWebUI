# -*- mode: python ; coding: utf-8 -*-
"""
PyInstaller spec file for building Open WebUI Windows executable.
This creates a single-directory bundle with all dependencies for Windows Server 2022.
"""

from PyInstaller.utils.hooks import collect_all, collect_data_files, collect_submodules
import os
import sys

block_cipher = None

# Collect all data files and dependencies
datas = []
binaries = []
hiddenimports = []

# Add backend package data
datas += collect_data_files('open_webui')
datas += collect_data_files('uvicorn')
datas += collect_data_files('fastapi')
datas += collect_data_files('tiktoken')
datas += collect_data_files('chromadb')
datas += collect_data_files('sentence_transformers')
datas += collect_data_files('transformers')
datas += collect_data_files('nltk')

# Add static files and templates
datas += [
    ('backend/open_webui/static', 'open_webui/static'),
    ('backend/open_webui/alembic.ini', 'open_webui'),
]

# Add built frontend (build directory should exist after npm run build)
if os.path.exists('build'):
    datas += [('build', 'build')]

# Hidden imports for dynamic modules
hiddenimports += [
    'uvicorn.logging',
    'uvicorn.loops',
    'uvicorn.loops.auto',
    'uvicorn.protocols',
    'uvicorn.protocols.http',
    'uvicorn.protocols.http.auto',
    'uvicorn.protocols.websockets',
    'uvicorn.protocols.websockets.auto',
    'uvicorn.lifespan',
    'uvicorn.lifespan.on',
    'sqlalchemy.ext.baked',
    'pydantic',
    'pydantic.json',
    'pydantic_core',
    'win32serviceutil',
    'win32service',
    'win32event',
    'servicemanager',
]

# Collect all submodules for key packages
hiddenimports += collect_submodules('open_webui')
hiddenimports += collect_submodules('langchain')
hiddenimports += collect_submodules('langchain_community')
hiddenimports += collect_submodules('chromadb')

a = Analysis(
    ['backend/open_webui/main.py'],
    pathex=[],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[
        'tkinter',
        'matplotlib',
        'jupyter',
        'notebook',
        'IPython',
        'conda',
    ],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='OpenWebUI',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='static/favicon.ico' if os.path.exists('static/favicon.ico') else None,
)

coll = COLLECT(
    exe,
    a.binaries,
    a.zipfiles,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='OpenWebUI',
)

