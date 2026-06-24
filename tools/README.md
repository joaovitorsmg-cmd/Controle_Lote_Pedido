# Ferramentas — Base de Sazonalidade

## `gerar_base_sazonalidade.py`

Transforma o export bruto de vendas (arquivo `.xlsx` grande, com várias abas)
em um arquivo **pequeno** (`sazonal_base.json`) que alimenta a base de
sazonalidade do app. O arquivão de ~310 MB **nunca sai da sua máquina** — você
só envia/commita o JSON pequeno gerado.

### Passo a passo

1. Instale o Python 3.9+ (em https://www.python.org/downloads/ — marque **Add to PATH**).
2. Instale as dependências (uma vez só):

   ```
   py -m pip install pandas openpyxl lxml xlrd
   ```

   (`lxml`/`xlrd` cobrem exports de ERP em `.xls`, inclusive os que são **HTML
   disfarçado de `.xls`** — o script detecta o formato automaticamente.)

3. Rode apontando para o seu arquivo de vendas:

   ```
   python gerar_base_sazonalidade.py "C:\caminho\vendas_jan24_jun26.xlsx"
   ```

4. O script imprime as **colunas que detectou** e pede confirmação. Estando certo,
   gera `sazonal_base.json` na mesma pasta. Envie **só esse arquivo**.

Se a detecção automática errar alguma coluna, edite o bloco `COLUNAS_MANUAIS`
no topo do script com o nome **exato** da coluna do seu arquivo.

### Regras aplicadas (iguais às do app)

- **Conta como venda** (mês do faturamento): CFOP `5101 5102 5120 5405 6101 6102 5922 6922`.
  Os `5922/6922` são faturamento para entrega futura — é **venda**, conta no mês
  do faturamento (não no da entrega).
- **Exclui** remessa de entrega futura (não é venda): `5116 5117 6116 6117`.
- Mantém o período **Jan/2024 a Jun/2026** (configurável no topo do script).
- Sazonalidade em **unidades** (soma da quantidade), por mês e por filial.
- CFOP `5116 5117 6116 6117` (remessa de entrega futura) **não conta como venda**, mas é
  registrado num campo separado (`remessa`) no `sazonal_base.json` — serve para o app avisar
  na aba **Produtos sem Giro** quando um "dead stock" teve remessa registrada e por isso
  precisa de checagem manual antes de confirmar que o produto não movimentou estoque.
