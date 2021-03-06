#Prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme Bubbles
# Alias
Set-Alias ll ls
Set-Alias open ii
Set-Alias py python
Set-Alias grep findstr
Set-Alias reboot Restart-Computer
Set-Alias time Measure-Command
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias nano 'C:\Program Files\Git\usr\bin\nano.exe'
Set-Alias touch 'C:\Program Files\Git\usr\bin\touch.exe'
Set-Alias touch 'C:\Program Files\Git\usr\bin\ln.exe'
#Icons
Import-Module -Name Terminal-Icons
#PsReadLine
Set-PsReadLineOption -PredictionSource History
# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

#Utils
function which ($command){
        Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
function ln($dest, $src){
        New-Item -path $dest -itemType SymbolicLink -target $src
}
function ssh-copy-id(${IP-ADDRESS-OR-FQDN}){
        type $env:USERPROFILE\.ssh\id_rsa.pub | ssh ${IP-ADDRESS-OR-FQDN} "mkdir -p .ssh && cat >> .ssh/authorized_keys"
}
