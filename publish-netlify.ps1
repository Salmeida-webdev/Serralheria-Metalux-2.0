$ErrorActionPreference = 'Stop'

$ProjectRoot = $PSScriptRoot
$PublishDir = Join-Path $ProjectRoot 'public'
$VersionFile = Join-Path $ProjectRoot 'VERSION.txt'
$Version = (Get-Content -LiteralPath $VersionFile -Raw).Trim()
$OfferEnd = [DateTimeOffset]::Parse('2026-11-01T00:00:00-03:00')

if ([DateTimeOffset]::Now -ge $OfferEnd) {
    throw 'A promoção de outubro expirou. Atualize a oferta, o prazo e a versão antes de publicar.'
}
if (-not (Test-Path -LiteralPath (Join-Path $PublishDir 'index.html'))) {
    throw 'Não encontrei public\index.html. Execute o script a partir da pasta do projeto extraído.'
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw 'Git não encontrado. Instale o Git para Windows e execute este script novamente.'
}
if (-not (Get-Command netlify -ErrorAction SilentlyContinue)) {
    throw 'Netlify CLI não encontrado. Com Node.js 18.14 ou mais recente, instale com: npm install -g netlify-cli'
}

Push-Location $ProjectRoot
try {
    if (-not (Test-Path -LiteralPath (Join-Path $ProjectRoot '.git'))) {
        & git init
        if ($LASTEXITCODE -ne 0) { throw 'Não foi possível inicializar o repositório Git.' }
    }

    $GitName = (& git config --local user.name 2>$null | Out-String).Trim()
    if ([string]::IsNullOrWhiteSpace($GitName)) {
        $GitName = Read-Host 'Nome para registrar nos commits Git'
        if ([string]::IsNullOrWhiteSpace($GitName)) { throw 'Nome do autor é obrigatório para criar a versão.' }
        & git config --local user.name $GitName
    }

    $GitEmail = (& git config --local user.email 2>$null | Out-String).Trim()
    if ([string]::IsNullOrWhiteSpace($GitEmail)) {
        $GitEmail = Read-Host 'E-mail para registrar nos commits Git'
        if ([string]::IsNullOrWhiteSpace($GitEmail)) { throw 'E-mail do autor é obrigatório para criar a versão.' }
        & git config --local user.email $GitEmail
    }

    $Changes = (& git status --porcelain | Out-String).Trim()
    $ExistingTag = (& git tag --list $Version | Out-String).Trim()
    if (-not [string]::IsNullOrWhiteSpace($Changes)) {
        if (-not [string]::IsNullOrWhiteSpace($ExistingTag)) {
            throw "A versão $Version já existe. Atualize VERSION.txt e CHANGELOG.md antes de registrar novas mudanças."
        }
        & git add --all
        if ($LASTEXITCODE -ne 0) { throw 'Não foi possível preparar os arquivos no Git.' }
        & git commit -m "release: Metalux landing $Version"
        if ($LASTEXITCODE -ne 0) { throw 'O commit Git falhou.' }
    }
    if ([string]::IsNullOrWhiteSpace($ExistingTag)) {
        & git tag -a $Version -m "Metalux landing $Version"
        if ($LASTEXITCODE -ne 0) { throw 'Não foi possível criar a tag de versão.' }
    }

    Write-Host "Versão local registrada: $Version"
    Write-Host 'Gerando deploy de prévia para revisão...'
    & netlify deploy --dir $PublishDir
    if ($LASTEXITCODE -ne 0) { throw 'O deploy de prévia falhou. Confira o login e o projeto Netlify selecionado.' }

    $Approval = Read-Host 'Revise a URL de prévia acima. Digite PUBLICAR para atualizar o site de produção'
    if ($Approval -cne 'PUBLICAR') {
        Write-Host 'A prévia foi mantida. A produção não foi atualizada.'
        return
    }

    Write-Host 'Enviando versão para produção...'
    & netlify deploy --prod --dir $PublishDir
    if ($LASTEXITCODE -ne 0) { throw 'O deploy de produção falhou. Consulte o estado do projeto na Netlify antes de tentar novamente.' }
    Write-Host 'Deploy de produção concluído. Confirme a URL, o domínio e o formulário no navegador.'
}
finally {
    Pop-Location
}
