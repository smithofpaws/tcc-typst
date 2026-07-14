# Template Typst TCC — Unipampa

Template em [Typst](https://typst.app/) para formatação de Trabalhos de Conclusão de Curso (TCC) da **Universidade Federal do Pampa (Unipampa)**, seguindo as normas da ABNT.

## Download

Baixe o arquivo `.zip` da última versão na aba [Releases](https://github.com/smithofpaws/tcc-typst/releases). O zip contém todos os arquivos necessários para começar a escrever seu TCC.

## Estrutura de Arquivos

| Arquivo | Descrição |
|---|---|
| `main.typ` | Documento principal — edite aqui o conteúdo do seu TCC |
| `unipampa.typ` | Template de formatação institucional (capa, folha de rosto, margens, fontes, espaçamentos) |
| `abnt-unipampa-nbr6023-2025.csl` | Estilo CSL para referências bibliográficas conforme NBR 6023:2025 |
| `referencias.bib` | Arquivo BibTeX para suas referências bibliográficas |
| `watch.bat` | Script para compilação automática com `typst watch` |

## Como Usar

1. Baixe e instale o [Typst](https://github.com/typst/typst/releases) ou utilize o [editor online](https://typst.app/).
2. Edite o `main.typ` com o conteúdo do seu TCC.
3. Adicione suas referências em `referencias.bib`.
4. Para compilar localmente, execute `watch.bat` ou use o comando:
   ```
   typst watch main.typ
   ```

## Normas Aplicadas

- **ABNT NBR 14724:2024** — Trabalhos acadêmicos
- **ABNT NBR 6023:2025** — Referências
- **ABNT NBR 10520:2023** — Citações em documentos
- **Manual de Normalização de Trabalhos Acadêmicos — Unipampa 2025**

## Licença

Uso livre para fins acadêmicos.
