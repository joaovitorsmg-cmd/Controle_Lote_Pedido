# Fluxo de trabalho padrão deste repositório

Quando o usuário pedir qualquer alteração/correção no código, execute o ciclo completo sem
pedir confirmação a cada etapa — o usuário só quer dar o pedido e receber o resultado pronto:

1. Implementar a mudança na branch de desenvolvimento da sessão.
2. Testar o que for razoável (ex.: checar sintaxe JS dos `<script>` do `index.html` com
   `node --check`) antes de commitar.
3. Commitar e dar push.
4. Abrir o Pull Request para `main` (owner `joaovitorsmg-cmd`, repo `Controle_Lote_Pedido`).
5. Mesclar o PR imediatamente (squash), sem esperar aprovação.
6. Apagar a branch da feature após o merge.

Isso é uma autorização permanente do usuário — não pergunte de novo "posso mesclar?" ou
"posso apagar a branch?" para pedidos normais de alteração. Só pare e pergunte se a mudança
pedida for destrutiva/ambígua o bastante para precisar de uma decisão humana (ex.: apagar
dados, mudar algo fora do escopo pedido).

## Observação técnica sobre apagar a branch

O proxy do ambiente de execução pode bloquear (`403`) um `git push origin --delete` feito
pela própria sessão sobre a branch de desenvolvimento dela mesma (a branch "ativa" da
sessão). Nesse caso:
- Primeira opção: confirmar se a opção do repositório **Settings → General → Pull Requests
  → "Automatically delete head branches"** está habilitada — com ela, o GitHub apaga a
  branch sozinho ao mesclar o PR, sem precisar de nenhuma chamada extra.
- Se não estiver habilitada e o `git push --delete` falhar, avise o usuário em vez de tentar
  contornar o bloqueio do proxy, e sugira habilitar a opção acima.
