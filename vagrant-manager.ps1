# Script PowerShell para encontrar diretórios com Vagrantfile, perguntar qual comando 'vagrant' usar, e depois executar os comandos

# Defina o diretório raiz para iniciar a busca. Pode ser alterado conforme necessário.
$rootDir = "C:\Users\diego\OneDrive\Área de Trabalho\diego\estudo\udemy\devops-mao-na-massa"

# Defina o diretório que você deseja excluir
$excludeDir = "C:\Users\diego\OneDrive\Área de Trabalho\diego\estudo\udemy\devops-mao-na-massa\repositorio original"

# Normalizar o caminho do diretório a ser excluído
$excludeDir = [System.IO.Path]::GetFullPath($excludeDir)

# Encontre todos os arquivos Vagrantfile
$vagrantFiles = Get-ChildItem -Path $rootDir -Recurse -Filter "Vagrantfile" | Where-Object { $_.DirectoryName -notlike "$excludeDir\*" }

# Extrair diretórios pai dos Vagrantfiles
$vagrantDirs = $vagrantFiles | ForEach-Object { $_.DirectoryName }

# Remover duplicatas
$vagrantDirs = $vagrantDirs | Select-Object -Unique

# Armazenar as respostas do usuário
$responses = @{}

# Perguntar ao usuário sobre cada diretório
foreach ($dir in $vagrantDirs) {
    # Exibe a pergunta com o nome do diretório
    $dirName = (Get-Item $dir).Name
    $response = Read-Host "Qual comando 'vagrant' deseja executar no diretório: $($dirName) ? (u: up, h: halt, d: destroy, enter: nada)"
    $responses[$dir] = $response
}

# Executar comandos 'vagrant' conforme as respostas do usuário
foreach ($dir in $responses.Keys) {
    $command = ""
    switch ($responses[$dir]) {
        'u' { $command = "up" }
        'h' { $command = "halt" }
        'd' { $command = "destroy" }
    }
    if ($command) {
        $fullCommand = "cd '$dir'; vagrant $command"
        Write-Output "Executando comando: $fullCommand"
        Invoke-Expression $fullCommand
    } else {
        Write-Output "Nenhum comando 'vagrant' executado no diretório: $dir"
    }
}

# Voltar ao diretório raiz
Set-Location -Path $rootDir

Write-Output "Processo concluído."
