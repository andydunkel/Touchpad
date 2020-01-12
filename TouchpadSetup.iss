[Setup]
AppName=Touchpad Server
AppVersion=1.3
AppPublisher=Things & Stuff
AppPublisherURL="www.thingsstuff.com"
AppSupportURL="https://github.com/andydunkel/Touchpad/"
DefaultDirName={pf}\Things & Stuff\Touchpad Server
UninstallDisplayIcon="{app}\TouchpadServer.exe"
UninstallDisplayName=Touchpad Server
DefaultGroupName=Touchpad Server
SetupIconFile="Server\icon.ico"
Compression=lzma2
SolidCompression=yes
OutputBaseFilename=TouchpadSetup


SignTool=kSign /d $qTouchpad Server$q /du $qhttp://www.da-software$q /v $f
SignedUninstaller=yes
      
[Code]
function IsServerRunning() : Boolean;
var
  h : longint;
begin
  h := FindWindowByWindowName('Touchpad Server');
  Result := h <> 0;
end;

function CanContinue() : Boolean;
var
  r : integer;
begin
  Result := True;

  r := IDOK;

  while IsServerRunning() and (r <> IDCANCEL) do
  begin
    r := Msgbox('Touchpad Server is running. Please close Touchpad Server to continue setup.', mbError, MB_RETRYCANCEL)
  end;

  if r = IDCANCEL then 
  begin
    Result := False;
  end;
end; 

function InitializeSetup() : Boolean;
begin
  Result := CanContinue();
end;
         
function InitializeUninstall() : Boolean;
begin
  Result := CanContinue();
end;

[Files]
Source: "Release\TouchpadServer.exe"; DestDir: "{app}"

[Tasks]
Name: startup; Description: "Start Touchpad Server automatically when I Log in to Windows."; 

[Run]
Filename: "{app}\TouchpadServer.exe"; Description: "Launch Touchpad Server."; Flags: postinstall nowait

[Registry]
Root: HKCU; Subkey: "Software\Things & Stuff\Touchpad Server"; Flags: uninsdeletekey 

[Icons]
Name: "{group}\Touchpad Server"; Filename: "{app}\TouchpadServer.exe"
Name: "{userstartup}\Touchpad Server"; Filename: "{app}\TouchpadServer.exe"; Tasks: startup
