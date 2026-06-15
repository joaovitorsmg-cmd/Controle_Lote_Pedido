# 📘 Guia: alimentar o Ranking (modelo "1 publicador central")

Este guia explica como os dados das auditorias chegam ao **Ranking Geral de
Auditorias** usando o modelo escolhido: **JSONBin com uma pessoa central
publicando**. Os auditores apenas geram arquivos; só a pessoa central edita,
apaga e publica. Assim ninguém sobrescreve o trabalho de ninguém.

---

## 🧩 Como funciona (visão geral)

- **Auditores** → só **geram um arquivo** no app e mandam para a pessoa central
  (WhatsApp / e-mail).
- **Pessoa central** → **importa** no Ranking, **corrige se precisar** e
  **publica** na nuvem.
- **Todo mundo** → abre o **link** e vê o ranking atualizado (somente leitura).

A segurança vem disto: **só a pessoa central tem a Master Key** configurada.
Sem ela, ninguém escreve na nuvem — só lê. Por isso ninguém sobrescreve o
trabalho de ninguém.

### Fluxo de dados

| Origem | Botão | Arquivo gerado | Onde entra no Ranking |
|---|---|---|---|
| App de **Lotes/Vencidos** (este repositório) | **Exportar p/ Ranking (JSON padrão)** | `FILIAL_VENCIDOS_AUDT_MM_AAAA.json` (`tipo: VENCIDOS_AUDT`) | componente **Vencidos** |
| App de **Pedido/Canhoto** (separado) | **Salvar Histórico (.json)** | histórico de pedido/canhoto/sementes | componentes **Pedido**, **Canhoto**, **Sementes** |
| Relatório **Resumo CFOP** (.xls) | (arrastar no Ranking) | planilha de vendas por CFOP | **Faturamento** das filiais |

---

## ⚙️ PARTE 1 — Configuração inicial (só uma vez, feita pela pessoa central)

1. Entre em **jsonbin.io** e faça login (gratuito).
2. Clique no seu nome → **API Keys** → copie a **Master Key** (começa com
   `$2a$10$...`).
3. Abra o **Ranking** → botão **⚙ Configurações** (pede senha de operador —
   padrão **`Rank@2026`**).
4. Cole a Master Key no campo e clique em **➕ Criar Bin**. Vai aparecer um
   **Bin ID**.
5. Clique em **🔌 Testar Conexão** para confirmar (deve dizer "Conexão OK").
6. Clique em **📤 Publicar para todos** → baixa um arquivo
   `Ranking_..._PUBLICADO.html`.
7. **Suba esse HTML na sua hospedagem** (o GitHub Pages `Ranking-Auditoria`).
   Esse vira o **link oficial** que todo mundo abre.

> A partir daqui, quem abrir o link **lê a nuvem automaticamente**. Quem não
> tem a Master Key **só vê**, não altera. ✅

---

## 👷 PARTE 2 — Rotina do auditor (a cada auditoria)

**No app de Lotes/Vencidos (este):**

1. Importa o relatório da filial e faz a auditoria normal.
2. Clica em **"Exportar p/ Ranking (JSON padrão)"** → baixa
   `FILIAL_VENCIDOS_AUDT_MM_AAAA.json`.

**No app de Pedido/Canhoto (o outro):**

3. Clica em **"Salvar Histórico (.json)"** → baixa o arquivo do pedido/canhoto.

4. **Manda os dois arquivos** para a pessoa central. Fim — o auditor não mexe no
   Ranking.

---

## 🧑‍💼 PARTE 3 — Rotina da pessoa central (consolidar e publicar)

1. Abre o **link do Ranking** (a versão publicada).
2. Botão **📂 Selecionar Arquivos** (ou arrasta) → solta os `.json` recebidos
   (vencidos + pedido/canhoto). Pede a **senha de operador**.
3. *(Opcional)* Arrasta o **Resumo CFOP (.xls)** para preencher o
   **faturamento** automático.
4. Clica em **⚡ Gerar Ranking**.
5. Como a Master Key está configurada, ele **publica sozinho na nuvem** (se
   quiser forçar, há o botão **☁ Publicar**). Todo mundo já vê.

---

## ✏️ PARTE 4 — Corrigir ou apagar um registro errado

- **Corrigir um número:** o auditor reexporta o arquivo certo (mesma filial +
  mês) e te manda; você **reimporta** → o registro daquela filial/período é
  **sobrescrito** pelo novo. Republica.
- **Apagar um arquivo específico:** na tela de importação, cada arquivo tem um
  **🗑 (excluir)** — pede senha. Remove e clica em **Gerar Ranking** de novo.
- **Recomeçar do zero:** botão **✕ Limpar** (pede senha) zera tudo.
- **Backup de segurança:** botão **💾 Salvar (.json)** guarda uma cópia
  completa; **📂 Carregar (.json)** restaura. Recomendado salvar um backup antes
  de grandes mudanças.

> Toda edição/exclusão feita pela pessoa central **republica automaticamente** —
> a correção aparece para todos na hora.

---

## 🔐 Dicas de segurança

- **Troque a senha padrão** `Rank@2026` por uma sua.
- **Só a pessoa central** deve ter a Master Key e a senha de operador. Os
  auditores **não precisam** de nenhuma das duas.
- **Limite grátis:** ~100KB por bin, mas os dados são comprimidos (LZString) —
  cabe bastante histórico do ano.
