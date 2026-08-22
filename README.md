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

## Normas Aplicadas

- **ABNT NBR 14724:2024** — Trabalhos acadêmicos
- **ABNT NBR 6023:2025** — Referências
- **ABNT NBR 10520:2023** — Citações em documentos
- **Manual de Normalização de Trabalhos Acadêmicos — Unipampa 2025**

## Licença

Uso livre para fins acadêmicos.
