# Lista de diretórios
$directories = @("app01", "control-node", "db01")

# Função para executar os comandos via vagrant ssh
function Execute-Commands {
    param (
        [string]$directory
    )

    Write-Host "Entrando no diretório $directory"
    Set-Location $directory

    Write-Host "Acessando a VM via vagrant ssh"

    # Transfere o script para a VM e executa
    $vagrantCommand = @"
vagrant ssh -c "echo '$(Get-Content -Raw ..\set-timezone.sh)' | sudo bash"
"@

    Invoke-Expression $vagrantCommand

    Write-Host "Saindo do diretório $directory"
    Set-Location ..
}

# Loop pelos diretórios e executa os comandos
foreach ($dir in $directories) {
    Execute-Commands -directory $dir
}

Write-Host "Comandos executados em todas as VMs."
