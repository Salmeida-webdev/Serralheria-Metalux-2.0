# Metalux Serralheria — landing page de lançamento

**Versão 1.1.7 · 23/10/2026**

Landing page estática, mobile-first e sem dependências externas de JavaScript. O conteúdo público fica em `public/`; documentação e scripts de operação permanecem fora da pasta publicada.

## Briefing usado

- Marca: Metalux Serralheria — `@metalux._.serralheria`.
- Região: Mauá e região, SP.
- WhatsApp atualizado: **(11) 94228-1355**.
- Oferta: **10% de desconto em tudo durante outubro**, até 31/10/2026; condições devem ser consultadas com a empresa.
- Serviços apresentados: portões, grades e proteções, corrimãos, projetos em metal e armários em alumínio.
- Direção visual: logo original, preto e dourado, fotos de trabalhos enviadas pelo usuário.
- CTA: informar nome, cidade/bairro e serviço; a página prepara a mensagem e abre o WhatsApp.
- Crédito no rodapé: **Desenvolvido por LMX Soluções Digitais/Segundo Almeida**.

Os fatos, premissas e pontos que precisam de validação do cliente estão detalhados em `BRIEFING.md`.

## Instalar e abrir pelo PowerShell

Baixe o ZIP para a pasta Downloads e rode este bloco no PowerShell:

~~~powershell
$zip = Join-Path $env:USERPROFILE 'Downloads\Metalux-Landing-Outubro-v1.1.7.zip'
$dest = Join-Path $env:USERPROFILE 'Downloads\Metalux-Landing-Outubro-v1.1.7'
Expand-Archive -LiteralPath $zip -DestinationPath $dest -Force
$project = Join-Path $dest 'metalux-landing-outubro'
Start-Process (Join-Path $project 'public\index.html')
~~~

O preview local serve para revisar layout e textos. Para revisar a abertura do WhatsApp em uma publicação real, use uma URL HTTPS.

## Revisar, versionar e publicar

O script `publish-netlify.ps1` versiona os arquivos com Git, cria uma tag com o conteúdo de `VERSION.txt`, publica primeiro um deploy de prévia e só atualiza produção se a pessoa digitar `PUBLICAR` depois de conferir a prévia. Se não houver Git configurado, o script pergunta nome e e-mail para o commit. Se ainda não houver um site vinculado, a Netlify CLI oferece a opção de escolher um site ou criar um.

Requisitos no computador: Git, Node.js 18.14 ou mais recente e Netlify CLI. Instale a CLI com `npm install -g netlify-cli`, entre na conta com `netlify login` e execute:

~~~powershell
Set-Location (Join-Path $env:USERPROFILE 'Downloads\Metalux-Landing-Outubro-v1.1.7\metalux-landing-outubro')
.\publish-netlify.ps1
~~~

O comando `netlify deploy --dir public` cria a prévia; `netlify deploy --prod --dir public` publica a produção. Na primeira execução, a CLI pode pedir para selecionar ou criar o projeto. Consulte a documentação oficial de [instalação e deploy com a Netlify CLI](https://docs.netlify.com/api-and-cli-guides/cli-guides/get-started-with-cli/).

O script bloqueia a publicação da oferta depois de 31/10/2026 para evitar que a página continue anunciando uma promoção expirada. Para usar outra oferta, atualize briefing, copy, metadados e data de validade antes de publicar uma nova versão.

## Funil e medição

1. A pessoa chega pelo anúncio ou link com UTMs.
2. Vê a oferta e trabalhos reais da Metalux.
3. Informa nome, local e serviço; detalhes do projeto são opcionais.
4. Confere a mensagem preenchida e escolhe enviá-la no WhatsApp.

O evento `metalux_whatsapp_click` é enviado ao `dataLayer` com local do CTA, tipo de serviço e UTMs, sem nome, telefone ou texto livre. O evento mede clique/intenção de contato; não comprova que a mensagem foi enviada ou que houve conversão. Nenhum ID de Meta Pixel, GTM ou GA4 foi fornecido, então essas ferramentas não estão embutidas.

## Dados e privacidade

Não há backend, banco de dados, cookies de analytics ou gravação dos campos nesta página. Ao abrir o WhatsApp, os dados informados seguem na mensagem pré-preenchida; a pessoa precisa confirmar o envio para a Metalux. O WhatsApp/Meta processa a abertura do link conforme seus próprios termos. O aviso aparece junto ao formulário. Uma política de privacidade completa depende da identificação jurídica e das práticas de atendimento/retensão da empresa.

## Antes de publicar

Revise `CHECKLIST.md`. O domínio final ainda não foi definido; após o deploy, configure URL canônica e URLs absolutas de Open Graph para o domínio escolhido. As condições da oferta, telefone, alcance geográfico e autorização de uso das fotos precisam ser confirmados pela Metalux.
