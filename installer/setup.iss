; Inno Setup Script for Open WebUI - Windows Server 2022
; This script creates a setup.exe installer for Open WebUI

#define MyAppName "Open WebUI"
#define MyAppVersion "0.6.43"
#define MyAppPublisher "Open WebUI Team"
#define MyAppURL "https://openwebui.com/"
#define MyAppExeName "OpenWebUI.exe"

[Setup]
AppId={{8D7F9A3B-4E2C-4F1A-9B3D-1E2F3A4B5C6D}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
LicenseFile=..\LICENSE
OutputDir=output
OutputBaseFilename=OpenWebUI-Setup-{#MyAppVersion}-Win64
SetupIconFile=..\static\favicon.ico
Compression=lzma2/ultra64
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
MinVersion=10.0.20348
VersionInfoVersion={#MyAppVersion}
VersionInfoCompany={#MyAppPublisher}
VersionInfoDescription={#MyAppName} Setup
UninstallDisplayIcon={app}\{#MyAppExeName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "startmenuicon"; Description: "Create Start Menu icon"; GroupDescription: "{cm:AdditionalIcons}"
Name: "startservice"; Description: "Start Open WebUI service after installation"; GroupDescription: "Service Options:"; Flags: checkedonce
Name: "autostart"; Description: "Configure Open WebUI to start automatically with Windows"; GroupDescription: "Service Options:"; Flags: checkedonce

[Files]
Source: "..\dist\OpenWebUI.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\dist\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\build\*"; DestDir: "{app}\webui"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "..\README.md"; DestDir: "{app}"; Flags: ignoreversion
Source: "..\LICENSE"; DestDir: "{app}"; Flags: ignoreversion

[Dirs]
Name: "{app}\data"; Permissions: users-full
Name: "{app}\data\uploads"; Permissions: users-full
Name: "{app}\data\cache"; Permissions: users-full
Name: "{app}\data\vector_db"; Permissions: users-full
Name: "{app}\logs"; Permissions: users-full

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{autostartmenu}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: startmenuicon

[Run]
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""Open WebUI"" dir=in action=allow protocol=TCP localport=8080"; Flags: runhidden; StatusMsg: "Configuring Windows Firewall..."
Filename: "{app}\{#MyAppExeName}"; Parameters: "install-service"; Flags: runhidden waituntilterminated; StatusMsg: "Installing Open WebUI Windows Service..."; Tasks: autostart
Filename: "{app}\{#MyAppExeName}"; Parameters: "start-service"; Flags: runhidden waituntilterminated; StatusMsg: "Starting Open WebUI Service..."; Tasks: startservice
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

[UninstallRun]
Filename: "{app}\{#MyAppExeName}"; Parameters: "stop-service"; Flags: runhidden waituntilterminated; RunOnceId: "StopService"
Filename: "{app}\{#MyAppExeName}"; Parameters: "uninstall-service"; Flags: runhidden waituntilterminated; RunOnceId: "UninstallService"
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Open WebUI"""; Flags: runhidden; RunOnceId: "RemoveFirewallRule"

[Code]
function InitializeSetup(): Boolean;
var
  ResultCode: Integer;
  OSVersion: TWindowsVersion;
begin
  GetWindowsVersionEx(OSVersion);

  // Check for Windows Server 2022 or Windows 10/11 (minimum build 20348)
  if (OSVersion.Major < 10) or ((OSVersion.Major = 10) and (OSVersion.Build < 20348)) then
  begin
    MsgBox('This application requires Windows Server 2022 (Build 20348) or later.' + #13#10 +
           'Your current Windows version is not supported.', mbError, MB_OK);
    Result := False;
  end
  else
    Result := True;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  ResultCode: Integer;
begin
  if CurStep = ssPostInstall then
  begin
    // Create default configuration file
    SaveStringToFile(ExpandConstant('{app}\data\.env'),
      'WEBUI_HOST=0.0.0.0' + #13#10 +
      'WEBUI_PORT=8080' + #13#10 +
      'DATA_DIR=.\data' + #13#10 +
      'WEBUI_SECRET_KEY=' + GetRandomString(32) + #13#10,
      False);
  end;
end;

function GetRandomString(Length: Integer): String;
var
  i: Integer;
  Chars: String;
begin
  Chars := 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Result := '';
  for i := 1 to Length do
    Result := Result + Chars[Random(Length(Chars)) + 1];
end;

