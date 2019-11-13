; Script generated by the Inno Script Studio Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{70FF6811-4AE4-4198-A69B-10EFB736ACA6}
AppName=EncryptCompressMyDrive7 Software
AppVersion=v0.1.1.0-beta
;AppVerName=EncryptCompressMyDrive7 Program v0.1.1.0-beta
AppPublisher=Marnix 0810
AppPublisherURL=https://marnix0810.wordpress.com/
AppSupportURL=https://github.com/0810-software/encryptcompressmydrive7/issues
AppUpdatesURL=https://groups.google.com/forum/#!forum/encryptcompressmydrive7
DefaultDirName={autopf}\Marnix0810\EncryptCompressMyDrive7
DefaultGroupName=EncryptCompressMyDrive7
LicenseFile=C:\Users\marni\Documents\GitHub\encryptcompressmydrive7\LICENSE.txt
OutputDir=C:\Users\marni\Downloads
OutputBaseFilename=ecd7-setup
SetupIconFile=C:\Users\marni\Documents\GitHub\encryptcompressmydrive7\img\Icon1.ico
Compression=lzma
WizardStyle=modern
WizardImageFile=C:\Users\marni\Documents\GitHub\encryptcompressmydrive7\img\Setupbitmap1.bmp
SolidCompression=yes
AlwaysRestart=yes
[Files]
Source: "C:\Users\marni\Documents\GitHub\encryptcompressmydrive7\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\{cm:ProgramOnTheWeb,EncryptCompressMyDrive7 Program}"; Filename: "https://marnix0810.github.io/encryptcompressmydrive7/"
Name: "{group}\{cm:UninstallProgram,EncryptCompressMyDrive7 Program}"; Filename: "{uninstallexe}"
Name: "{group}\ecd7 formatting tool"; Filename: "{app}\ecd7-ft.cmd"

[Registry]
Root: "HKLM"; Subkey: "Software\Microsoft\Windows\CurrentVersion\Run"; ValueType: string; ValueName: "ecd7-launch"; ValueData: "{app}\ecd7-launcher.cmd"; Flags: createvalueifdoesntexist;
