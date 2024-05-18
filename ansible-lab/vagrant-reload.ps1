# Lista de diretórios onde o vagrant reload será executado
$directories = @("app01", "control-node", "db01")

# Diretório atual
$currentDir = Get-Location

# Função para executar o vagrant reload em um diretório
function Execute-VagrantReload {
    param (
        [string]$dir
    )
    
    Write-Host "Indo para o diretório $dir"
    Set-Location -Path $dir
    if ($?) {
        Write-Host "Executando 'vagrant reload' em $dir"
        vagrant reload
        if (-not $?) {
            Write-Host "Erro ao executar 'vagrant reload' em $dir"
            exit 1
        }
    } else {
        Write-Host "Erro ao mudar para o diretório $dir"
        exit 1
    }

    Write-Host "Voltando para o diretório $currentDir"
    Set-Location -Path $currentDir
}

# Iterar sobre os diretórios e executar o vagrant reload em cada um
foreach ($dir in $directories) {
    Execute-VagrantReload -dir $dir
}

# Perguntar se deseja fazer conexão SSH no control-node
$response = Read-Host "Deseja fazer conexão SSH no control-node? (s/n)"
if ($response -eq 's') {
    Write-Host "Conectando via SSH no control-node..."
    Set-Location -Path "control-node"
    if ($?) {
        vagrant ssh
    } else {
        Write-Host "Erro ao mudar para o diretório control-node"
        exit 1
    }
} else {
    Write-Host "Continuando o script normalmente..."
}

Write-Host "Script concluído com sucesso"
