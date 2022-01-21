winget install -e --id Microsoft.PowerShell
Start-Process pwsh -Verb RunAs -ArgumentList "-file $($MyInvocation.MyCommand.Path)"
exit

Set-ExecutionPolicy RemoteSigned -scope CurrentUser
$WorkingPath=$env:TEMP+"\uwu"
mkdir $WorkingPath
cd $WorkingPath
#scoop
iwr -useb get.scoop.sh | iex
scoop install jq
# Font
$FontName = "Hack"
$TempFontZip = "$FontName.zip"
curl "https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest" -OutFile "repo.json"
$FontUrl = (cat repo.json |
jq |
findstr "browser_download_url" |
findstr $FontName).Trim('      "browser_download_url":')
curl $FontUrl -OutFile $TempFontZip
Expand-Archive $TempFontZip
# Delete Font Zip
rm $TempFontZip
$SourceDir   = "$WorkingPath\$FontName"
$Source      = "$WorkingPath\$FontName\*"
$Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
$TempFolder  = "$WorkingPath\Fonts"

# Create the source directory if it doesn't already exist
New-Item -ItemType Directory -Force -Path $SourceDir

New-Item $TempFolder -Type Directory -Force | Out-Null

Get-ChildItem -Path $Source -Include '*.ttf','*.ttc','*.otf' -Recurse | ForEach {
    If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {

        $Font = "$TempFolder\$($_.Name)"
        
        # Copy font to local temporary folder
        Copy-Item $($_.FullName) -Destination $TempFolder
        
        # Install font
        $Destination.CopyHere($Font,0x10)
    }
}
#Programming Tools + Terminal
scoop install sudo
scoop install nvm
nvm install latest
sudo nvm use latest
scoop install python
winget install -e --id Git.Git
winget install -e --id Microsoft.WindowsTerminal

#Terminal stuff
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
Install-Module posh-git -Scope CurrentUser -Force
Install-Module oh-my-posh -Scope CurrentUser -Force
Install-Module -Name PSReadLine -Scope CurrentUser -Force
#Configuring Poweshell Profile
mkdir ~/.config/powershell
#Use git repo cdn
curl "https://cdn.jsdelivr.net/gh/vanelk/DevMe/user_profile.ps1" -OutFile ~/.config/powershell/user_profile.ps1
mkdir ([system.io.path]::GetDirectoryName($PROFILE.CurrentUserCurrentHost))
echo ". $env:USERPROFILE\.config\powershell\user_profile.ps1" >> $PROFILE.CurrentUserCurrentHost
#Office Tools
function show_install_prompt($app_names, $app_install_commands){
    for($i=0;($i -lt $app_names.Length); $i++){
        $should_install = Read-Host "Do you want to install $($app_names[$i])?
[yes:y]          [no:n]"
        if($should_install -eq "y"){
            Invoke-Expression -Command $app_install_commands[$i]
        }
    }
}
$app_names = "vscode","Figma","Slack","Bitwarden","PowerToys","Brave","wsl"
$app_install_commands = "winget install -e --id Microsoft.VisualStudioCode",
"winget install -e --id Figma.Figma",
"winget install -e --id SlackTechnologies.Slack", 
"winget install -e --id Bitwarden.Bitwarden",
"winget install -e --id Microsoft.PowerToys",
"curl 'https://brave-browser-downloads.s3.brave.com/latest/brave_installer-x64.exe' -OutFile brave.exe
& ./brave.exe --install --system-level --silent",
"sudo wsl --install -d Ubuntu"

show_install_prompt $app_names $app_install_commands
cd ~
rm -r $WorkingPath