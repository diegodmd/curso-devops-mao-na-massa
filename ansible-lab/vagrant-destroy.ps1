# Lista de diretórios onde o vagrant destroy será executado
$directories = @("app01", "control-node", "db01")

# Diretório atual
$currentDir = Get-Location

# Função para executar o vagrant destroy em um diretório
function Execute-VagrantDestroy {
    param (
        [string]$dir
    )
    
    Write-Host "Indo para o diretório $dir"
    Set-Location -Path $dir
    if ($?) {
        Write-Host "Executando 'vagrant destroy' em $dir"
        vagrant destroy
        if (-not $?) {
            Write-Host "Erro ao executar 'vagrant destroy' em $dir"
            exit 1
        }
    } else {
        Write-Host "Erro ao mudar para o diretório $dir"
        exit 1
    }

    Write-Host "Voltando para o diretório $currentDir"
    Set-Location -Path $currentDir
    if (-not $?) {
        Write-Host "Erro ao voltar para o diretório $currentDir"
        exit 1
    }
}

# Iterar sobre os diretórios e executar o vagrant destroy em cada um
foreach ($dir in $directories) {
    Execute-VagrantDestroy -dir $dir
}

Write-Host "Script concluído com sucesso"