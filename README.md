# Template Typst TCC — Unipampa

Template em [Typst](https://typst.app/) para formatação de Trabalhos de Conclusão de Curso (TCC) da **Universidade Federal do Pampa (Unipampa)**, seguindo as normas da ABNT.

## Download

Clique em **Code → Download ZIP** na [página do repositório](https://github.com/smithofpaws/tcc-typst),
ou clone com `git clone https://github.com/smithofpaws/tcc-typst.git`.

O pacote já vem com o compilador `typst.exe` incluído: extraia, execute o
`watch.bat` e comece a escrever. Não é preciso instalar nada.

## Estrutura de Arquivos

| Arquivo | Descrição |
|---|---|
| `main.typ` | Documento principal — edite aqui o conteúdo do seu TCC |
| `unipampa.typ` | Template de formatação institucional (capa, folha de rosto, margens, fontes, espaçamentos) |
| `abnt-unipampa-nbr6023-2025.csl` | Estilo CSL para referências bibliográficas conforme NBR 6023:2025 |
| `referencias.bib` | Arquivo BibTeX para suas referências bibliográficas |
| `watch.bat` | Script para compilação automática com `typst watch` |
| `typst.exe` | Compilador Typst 0.15.1 para Windows (x86-64) — já incluído, não precisa instalar nada |
| `typst-LICENSE`, `typst-NOTICE` | Licença Apache 2.0 do Typst (obrigatória por acompanhar o binário) |

## Como Usar

1. Edite o `main.typ` com o conteúdo do seu TCC.
2. Adicione suas referências em `referencias.bib`.
3. Execute o `watch.bat` — ele usa o `typst.exe` que já vem junto e recompila
   o PDF automaticamente a cada vez que você salva o arquivo.

> **Windows:** o `typst.exe` incluído é o compilador para Windows 64 bits, então
> não é preciso instalar nada.
>
> **Linux/macOS:** o `.exe` não funciona no seu sistema. Baixe o Typst para a sua
> plataforma em [typst/typst/releases](https://github.com/typst/typst/releases)
> (ou via `brew install typst` / gerenciador de pacotes) e compile com
> `typst watch main.typ`. Alternativa sem instalar nada: o
> [editor online](https://typst.app/).

## Opções do Template

Os dados do trabalho são informados em `unipampa(...)`, no início do `main.typ`.
Além dos campos já preenchidos no exemplo, há estas opções:

| Parâmetro | Descrição |
|---|---|
| `campus` | Nome do campus, abaixo do nome da universidade na capa |
| `logo` | Caminho de uma imagem para o topo da capa |
| `linha_pesquisa` | Linha de pesquisa, na folha de rosto |
| `ficha_catalografica` | PDF da ficha gerada no Sistema GURI. Sem ele, a página fica reservada; use `none` para omiti-la. A ficha não entra na contagem das páginas |
| `folha_aprovacao` | PDF da folha de aprovação assinada, que substitui a folha gerada pelo template |
| `frente_verso` | `true` para impressão em frente e verso: margens espelhadas e número da página no canto externo |
| `banca` | Cada membro tem `nome` e `instituicao`. O primeiro recebe a função "Orientador"; use `funcao` para indicar outra |

Funções disponíveis no texto:

| Função | Uso |
|---|---|
| `#fonte[...]` e `#nota[...]` | Linhas "Fonte:" e "Nota:" abaixo de figuras, quadros e tabelas |
| `#quadro(...)` | Quadro, com os mesmos argumentos de `figure`. Gera a Lista de Quadros |
| `#citacao_longa[...]` | Citação direta com mais de três linhas |
| `#apud(autor, ano, <chave>)` | Citação de citação. Apenas a obra consultada entra nas referências |
| `#glossario(("termo", "definição"), ...)` | Glossário, após as referências |
| `#show: apendices` e `#show: anexos` | A partir deles, cada título `=` sai como "APÊNDICE A – TÍTULO" ou "ANEXO A – TÍTULO" |

As listas de figuras, quadros, tabelas, abreviaturas, siglas e símbolos são
geradas automaticamente quando houver itens.

## Referências

O `referencias.bib` traz exemplos comentados de livro, capítulo, artigo,
evento, TCC, dissertação, legislação, norma técnica, software e documento
online. Algumas convenções do estilo:

- Subtítulo no campo `note`: o estilo imprime "**Título**: subtítulo".
- Data de acesso em `urldate`, no formato `AAAA-MM-DD`.
- Sem local ou sem editora, omita o campo: o estilo imprime *[S. l.]* e *[s. n.]*.
- Para o *et al.*, informe todos os autores. O Typst não reconhece `and others`.

## Normas Aplicadas

- **ABNT NBR 14724:2024** — Trabalhos acadêmicos
- **ABNT NBR 6023:2025** — Referências
- **ABNT NBR 10520:2023** — Citações em documentos
- **Manual de Normalização de Trabalhos Acadêmicos — Unipampa 2025**

## Licença

Uso livre para fins acadêmicos.
