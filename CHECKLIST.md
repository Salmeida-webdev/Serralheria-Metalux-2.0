# Revisão e aceite

## Implementado e verificado localmente

- [x] Atualizado para WhatsApp (11) 94228-1355 nos links, mensagem, botão flutuante, rodapé e dados estruturados.
- [x] Crédito de desenvolvimento incluído no rodapé.
- [x] Perfil `@metalux._.serralheria` visível no rodapé e vinculado ao Instagram.
- [x] Botão flutuante do WhatsApp com rótulo acessível, mensagem inicial e registro do clique.
- [x] Legenda do projeto principal separada da foto em faixa de alto contraste.
- [x] Oferta consistente: 10% de desconto em tudo, durante outubro, até 31/10/2026; condições para consultar.
- [x] Formulário exige nome, cidade/bairro e serviço; detalhes são opcionais.
- [x] Mensagem WhatsApp codificada corretamente, com UTMs quando existentes.
- [x] O `dataLayer` registra o clique e não recebe nome, telefone nem descrição livre.
- [x] Links locais das imagens existem; HTML tem um único H1, IDs únicos e rótulos ligados aos campos.
- [x] Fotos reais exibidas inteiras em caixas 4:3 responsivas com `object-fit: contain`, sem cortes nem deformação; cantos arredondados nos quadros e cards.
- [x] Fundo de preenchimento visual derivado das próprias fotos, sem substituir ou inventar conteúdo.
- [x] Fotos convertidas para WebP para reduzir transferência; imagens fora da primeira dobra usam carregamento lazy.
- [x] Validadas sintaxe do JavaScript e rota do formulário para WhatsApp com dados de teste simulados.

## Pendente antes do anúncio e da publicação

- [ ] Conferir visualmente em navegador real no celular e desktop; Chromium/Lighthouse não está disponível no ambiente de edição atual.
- [ ] Medir PageSpeed Insights/Lighthouse depois de hospedar; nenhum resultado de Core Web Vitals foi presumido.
- [ ] Confirmar com a Metalux telefone, condições e validade da promoção, cidades atendidas e direitos das fotos.
- [ ] Após definir o domínio, configurar canonical e Open Graph absoluto e testar o preview do link.
- [ ] Se usar GTM/GA4/Meta Pixel, instalar os IDs oficiais, configurar consentimento aplicável e testar eventos sem enviar dados pessoais.
- [ ] Fazer deploy de prévia no projeto correto, revisar, e somente então autorizar o deploy de produção pelo script.

## Critério de conversão

`metalux_whatsapp_click` é intenção/clique para abrir o WhatsApp. A conversão real exige que a pessoa envie a mensagem; acompanhar esse resultado no WhatsApp ou CRM. Não interpretar clique como lead fechado.
