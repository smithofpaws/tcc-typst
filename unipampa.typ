// Rótulos dos títulos de apêndices e anexos (ver `apendices` e `anexos`)
#let rotulos-anexos = ([APÊNDICE], [ANEXO])

// Aceita o caminho de um arquivo (PDF ou imagem) ou um conteúdo pronto,
// como `image("documentos/ficha.pdf")`
#let arquivo-ou-conteudo(arquivo, ..args) = if type(arquivo) == str {
  image(arquivo, ..args)
} else {
  arquivo
}

#let unipampa(
  titulo: "",
  subtitulo: "",
  autor: "",
  curso: "",
  campus: "",
  logo: none,
  orientador: "",
  coorientador: "",
  local: "",
  ano: "",
  natureza: "",
  area_concentracao: "",
  linha_pesquisa: "",
  data_defesa: "",
  banca: (),
  ficha_catalografica: auto,
  folha_aprovacao: none,
  frente_verso: false,
  dedicatoria: none,
  agradecimento: none,
  epigrafe: none,
  epigrafe_autor: none,
  resumo: none,
  palavras_chave: (),
  abstract: none,
  keywords: (),
  lista_abreviaturas: (),
  lista_siglas: (),
  lista_simbolos: (),
  body,
) = {
  set document(title: titulo, author: autor)

  // Frente e verso: margem interna de 3 cm e externa de 2 cm, espelhadas
  // conforme a página física (manual Unipampa, 2.5)
  set page(
    paper: "a4",
    margin: if frente_verso {
      (top: 3cm, inside: 3cm, bottom: 2cm, outside: 2cm)
    } else {
      (top: 3cm, left: 3cm, bottom: 2cm, right: 2cm)
    },
  )

  set text(
    font: ("Arial", "Times New Roman"),
    size: 12pt,
    lang: "pt",
    region: "BR",
  )

  set par(
    justify: true,
    first-line-indent: 1.25cm,
    leading: 1em,
  )

// --- REGRA DO ET AL. EM ITÁLICO (Geral, Citações e Bibliografia) ---
  // O emph alterna o itálico. Em citações e referências o CSL já aplica o
  // itálico, e a segunda regra desfaz a alternância da regra geral.
  show regex("et\\s+al\\."): emph

  show cite: it => {
    show regex("et\\s+al\\."): emph
    it
  }

  show bibliography: it => {
    show regex("et\\s+al\\."): emph
    // NBR 6023: referências alinhadas somente à margem esquerda
    set par(justify: false)
    // NBR 6023: intervalos com hífen (p. 7-18) e sem ponto após "?" ou "!"
    show regex("\\d–\\d"): r => r.text.replace("–", "-")
    show regex("[?!]\\."): r => r.text.slice(0, -1)
    it
  }

  // --- NOTAS DE RODAPÉ ---
  // Fonte 10, espaço simples, filete de 5 cm e, a partir da segunda linha,
  // alinhamento abaixo da primeira letra da nota (NBR 14724, 5.2.1)
  set footnote.entry(separator: line(length: 5cm, stroke: 0.5pt), indent: 0pt)
  show footnote.entry: it => {
    let loc = it.note.location()
    let num = numbering(it.note.numbering, ..counter(footnote).at(loc))
    set text(size: 10pt)
    set par(leading: 0.65em, first-line-indent: 0pt)
    grid(columns: (auto, 1fr), link(loc, super(num)), it.note.body)
  }

  set enum(
    numbering: "a)",
    indent: 1.25cm,
  )

  set list(
    marker: [--],
    indent: 1.25cm,
  )

  // --- CONFIGURAÇÃO DE EQUAÇÕES ---
  set math.equation(numbering: "(1)")
  show math.equation.where(block: true): set block(above: 1em, below: 1em)

  show math.equation.where(block: true): it => {
    it
  // Truque invisível para forçar o recuo do parágrafo seguinte
    par(text(size:0pt, ""))
  }

  // --- REGRA PARA TÍTULO DA FIGURA NA PARTE SUPERIOR ---
let espaco-simples = 0.65em
let espaco-linha-e-meia = 1em

// --- REGRA PARA TÍTULO DA FIGURA/TABELA/QUADRO NA PARTE SUPERIOR ---
set figure.caption(separator: [ -- ])
show figure.caption: set align(left)

let tabelas-e-quadros = figure.where(kind: table).or(figure.where(kind: "quadro"))
show tabelas-e-quadros: set figure.caption(position: top)
show tabelas-e-quadros: set figure(gap: espaco-simples) // título ↔️ tabela
show tabelas-e-quadros: set block(
  above: espaco-linha-e-meia, // texto ↔️ título
  below: espaco-simples,      // tabela ↔️ fonte
)

show figure.where(kind: image): it => {
  block(
    breakable: false,
    width: 100%,
    above: espaco-linha-e-meia, // texto ↔️ título
    below: espaco-simples,      // figura ↔️ fonte
  )[
    #set par(first-line-indent: 0pt)

    #if it.has("caption") [
      #it.caption
      #v(espaco-simples) // título ↔️ figura
    ]

    #align(center)[#it.body]
  ]

  par(text(size: 0pt, ""))
}

  // --- CAPA ---
  align(center)[
    #if logo != none [
      #arquivo-ou-conteudo(logo, height: 1.7cm)
      #v(0.7em)
    ]
    #text(weight: "bold")[
      UNIVERSIDADE FEDERAL DO PAMPA\
      #if campus != "" [#upper(campus)\ ]
      #upper(curso)
    ]
    #v(1fr)
    #text(weight: "bold")[#upper(autor)]
    #v(1fr)
    #text(weight: "bold")[
      #upper(titulo)#if subtitulo != "" [: #upper(subtitulo)]
    ]
    #v(1fr)
    #text(weight: "bold")[#local\ #ano]
  ]
  pagebreak()

  // --- FOLHA DE ROSTO ---
  // A capa entra na contagem das páginas, como no template LaTeX e no modelo
  // Word da Unipampa; a ficha catalográfica não
  align(center)[
    #text(weight: "bold")[#upper(autor)]
    #v(1fr)
    #text(weight: "bold")[
      #upper(titulo)#if subtitulo != "" [: #upper(subtitulo)]
    ]
    #v(2cm)
    #align(right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.65em, first-line-indent: 0pt)
        #set text(weight: "regular", size: 12pt)
        #natureza
        #if area_concentracao != "" [
          \ \ Área de concentração: #area_concentracao
        ]
        #if linha_pesquisa != "" [
          \ Linha de pesquisa: #linha_pesquisa
        ]
        #v(1em)
        Orientador(a): #orientador
        #if coorientador != "" [\ Coorientador(a): #coorientador]
      ])
    ]
    #v(1fr)
    #text(weight: "bold")[#local\ #ano]
  ]
  pagebreak()

  // --- FICHA CATALOGRÁFICA ---
  // Verso da folha de rosto, sem contar na paginação (manual Unipampa, 2.5).
  // auto: página reservada; caminho ou conteúdo: página gerada no GURI.
  if ficha_catalografica == auto {
    counter(page).update(n => n - 1)
    v(52%)
    align(center, block(width: 82%)[
      #set text(size: 10pt)
      #set par(leading: 0.65em, first-line-indent: 0pt, justify: false)
      ESPAÇO RESERVADO PARA A FICHA CATALOGRÁFICA
      #v(1em)
      Informe em `ficha_catalografica` o PDF gerado no Sistema GURI.
    ])
    pagebreak()
  } else if ficha_catalografica != none {
    page(margin: 0pt, header: none)[
      #counter(page).update(n => n - 1)
      #arquivo-ou-conteudo(ficha_catalografica, width: 100%, height: 100%, fit: "contain")
    ]
  }

  // --- FOLHA DE APROVAÇÃO ---
  // Para o depósito final, `folha_aprovacao` recebe a página assinada em PDF
  if folha_aprovacao != none {
    page(margin: 0pt, header: none)[
      #arquivo-ou-conteudo(folha_aprovacao, width: 100%, height: 100%, fit: "contain")
    ]
  } else {
    align(center)[
      #text(weight: "bold")[#upper(autor)]
      #v(1fr)
      #text(weight: "bold")[
        #upper(titulo)#if subtitulo != "" [: #upper(subtitulo)]
      ]
      #v(1cm)
      #align(right)[
        #block(width: 50%, align(left)[
          #set par(leading: 0.65em, first-line-indent: 0pt)
          #set text(weight: "regular", size: 12pt)
          #natureza
          #if area_concentracao != "" [
            \ \ Área de concentração: #area_concentracao
          ]
        ])
      ]
      #v(1cm)
      #if data_defesa != "" [
        #align(left)[Trabalho de Conclusão de Curso defendido e aprovado em: #data_defesa.]
      ]
      #v(1cm)
      Banca examinadora:
      #v(1cm)

      // Banca dinâmica: o primeiro membro é o orientador, salvo se `funcao`
      // for informada
      #for (i, membro) in banca.enumerate() [
        #line(length: 80%, stroke: 0.5pt)
        #membro.nome\
        #let funcao = membro.at("funcao", default: if i == 0 { "Orientador" } else { none })
        #if funcao != none [#funcao\ ]
        #membro.instituicao \
        #v(1cm)
      ]
    ]
    pagebreak()
  }

  // --- DEDICATÓRIA ---
  if dedicatoria != none {
    align(bottom + right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.26em, first-line-indent: 0pt)
        #dedicatoria
      ])
    ]
    pagebreak()
  }

  // --- AGRADECIMENTOS ---
  if agradecimento != none {
    align(center)[#text(weight: "bold")[AGRADECIMENTO]]
    v(1cm)
    set par(first-line-indent: 0pt)
    agradecimento
    pagebreak()
  }

  // --- EPÍGRAFE ---
  if epigrafe != none {
    align(bottom + right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.26em, first-line-indent: 0pt)
        "#epigrafe"\
        #align(right)[#epigrafe_autor]
      ])
    ]
    pagebreak()
  }

  // --- RESUMO ---
  if resumo != none {
    align(center)[#text(weight: "bold")[RESUMO]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 0.65em)
    resumo
    v(0.65em)
    [*Palavras-Chave:* #palavras_chave.join("; ").]
    pagebreak()
  }

  // --- ABSTRACT ---
  if abstract != none {
    align(center)[#text(weight: "bold")[ABSTRACT]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 0.65em)
    abstract
    v(0.65em)
    [*Keywords:* #keywords.join("; ").]
    pagebreak()
  }

  // --- LISTAS DE FIGURAS, QUADROS E TABELAS ---
  // Cada lista só é gerada se houver itens com legenda (caption) no documento
  let lista-de(tipo, titulo, rotulo) = context {
    let itens = query(figure.where(kind: tipo)).filter(f => f.caption != none)
    if itens.len() > 0 {
      align(center)[#text(weight: "bold")[#titulo]]
      v(1cm)

      for item in itens {
        let loc = item.location()
        let num = item.counter.at(loc).first()
        let page_num = counter(page).at(loc).first()

        box(width: 100%)[
          #set par(leading: 0.52em, first-line-indent: 0pt)
          #link(loc)[#rotulo #num -- #item.caption.body #box(width: 1fr, repeat[ . ]) #page_num]
        ]
      }
      pagebreak()
    }
  }
  lista-de(image, "LISTA DE FIGURAS", "Figura")
  lista-de("quadro", "LISTA DE QUADROS", "Quadro")
  lista-de(table, "LISTA DE TABELAS", "Tabela")

  // --- LISTA DE ABREVIATURAS ---
  if lista_abreviaturas.len() > 0 {
    align(center)[#text(weight: "bold")[LISTA DE ABREVIATURAS]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 1em)
    grid(
      columns: (2.5cm, 1fr),
      row-gutter: 1em,
      ..lista_abreviaturas.flatten()
    )
    pagebreak()
  }

  // --- LISTA DE SIGLAS ---
  if lista_siglas.len() > 0 {
    align(center)[#text(weight: "bold")[LISTA DE SIGLAS]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 1em)
    grid(
      columns: (2.5cm, 1fr),
      row-gutter: 1em,
      ..lista_siglas.flatten()
    )
    pagebreak()
  }

  // --- LISTA DE SÍMBOLOS ---
  if lista_simbolos.len() > 0 {
    align(center)[#text(weight: "bold")[LISTA DE SÍMBOLOS]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 1em)
    grid(
      columns: (2.5cm, 1fr),
      row-gutter: 1em,
      ..lista_simbolos.flatten()
    )
    pagebreak()
  }

  // --- SUMÁRIO ---
  // Mesma tipografia dos títulos no texto (negrito; nível 1 em caixa alta) e
  // títulos alinhados pela margem do indicativo mais extenso, inclusive os
  // pós-textuais (NBR 6027, 5.2 e 6.2)
  align(center)[#text(weight: "bold")[SUMÁRIO]]
  v(1cm)
  context {
    let e-anexo(h) = h.level == 1 and h.supplement in rotulos-anexos
    let indicativos = query(heading.where(outlined: true))
      .filter(h => h.numbering != none and not e-anexo(h))
      .map(h => numbering(h.numbering, ..counter(heading).at(h.location())))
    let largura = calc.max(0pt, ..indicativos.map(n => measure(text(weight: "bold", n)).width))

    show outline.entry: it => {
      let h = it.element
      let titulo = if e-anexo(h) {
        [#h.supplement #numbering("A", ..counter(heading).at(h.location())) -- #h.body]
      } else {
        h.body
      }
      if it.level == 1 { titulo = upper(titulo) }

      set text(weight: "bold")
      link(h.location(), grid(
        columns: (largura, 1fr),
        column-gutter: 0.6em,
        if not e-anexo(h) { it.prefix() },
        [#titulo #box(width: 1fr, it.fill) #it.page()],
      ))
    }
    outline(title: none, indent: 0pt)
  }
  pagebreak()

  // --- INÍCIO DA PARTE TEXTUAL ---
  // A partir daqui a paginação aparece: no canto superior direito ou, no
  // verso das folhas em frente e verso, no canto superior esquerdo
  set page(
    header: context {
      let page_num = text(size: 10pt)[#counter(page).display()]
      if frente_verso and calc.even(here().page()) {
        align(left, page_num)
      } else {
        align(right, page_num)
      }
    }
  )

  // Configuração visual dos Títulos (Seções Numéricas)
  set heading(numbering: "1.1")

  show heading: it => {
    if it.level == 1 {
      pagebreak(weak: true)
    }
    block(
      width: 100%,
      above: 1.3em,
      below: 1em,
      {
        set text(weight: "bold", size: 12pt)
        if it.level == 1 and it.supplement in rotulos-anexos {
          // APÊNDICE A -- TÍTULO, centralizado
          let letra = numbering("A", ..counter(heading).at(it.location()))
          align(center, upper[#it.supplement #letra -- #it.body])
        } else if it.level == 1 {
          upper(it)
        } else {
          it
        }
      }
    )
  }

  show heading: it => {
    it
    par(text(size:0pt, ""))
  }

  body
}

// Citação Longa
#let citacao_longa(texto) = {
  pad(
    left: 4cm,
    block(
      width: 100%,
      {
        set text(size: 10pt)
        set par(leading: 0.26em, justify: true, first-line-indent: 0pt)
        texto
      }
    )
  )
}

// Título Sem Numeração (para Referências, Apêndices, Anexos)
#let titulo_sem_numeracao(titulo) = {
  show heading: set align(center)
  heading(numbering: none, outlined: true)[#titulo]
}

// Linha abaixo de ilustrações e tabelas: fonte 10, espaço simples. É um
// parágrafo (e não um bloco) para que o parágrafo seguinte mantenha o recuo.
#let linha-inferior(rotulo, texto) = {
  set align(left)
  set text(size: 10pt)
  par(leading: 0.65em, spacing: 0.65em, first-line-indent: 0pt)[#rotulo: #texto.]
}

// Fonte de figuras, quadros e tabelas. Ex.: #fonte[elaboração própria]
#let fonte(texto) = linha-inferior("Fonte", texto)

// Nota de figuras, quadros e tabelas. Ex.: #nota[dados preliminares]
#let nota(texto) = linha-inferior("Nota", texto)

// Quadro: ilustração com informações textuais, listada na LISTA DE QUADROS
#let quadro(..args) = figure(kind: "quadro", supplement: [Quadro], ..args)

// Glossário: termos em ordem alfabética, cada um como ("termo", "definição")
#let glossario(..termos) = {
  heading(numbering: none)[GLOSSÁRIO]
  set par(first-line-indent: 0pt, leading: 1em, justify: true)
  grid(
    columns: (4cm, 1fr),
    row-gutter: 1em,
    ..termos.pos().flatten()
  )
}

// Apêndices e anexos: use `#show: apendices` (ou `#show: anexos`) e, em
// seguida, um título `=` para cada um, que sai como "APÊNDICE A -- TÍTULO"
#let apendices(body) = {
  set heading(numbering: "A.1", supplement: [APÊNDICE])
  counter(heading).update(0)
  body
}

#let anexos(body) = {
  set heading(numbering: "A.1", supplement: [ANEXO])
  counter(heading).update(0)
  body
}

// Citação de citação: só a obra consultada entra nas referências
// (NBR 10520, 7.3). Ex.: #apud("Lacerda", "1998", <mariano2005>, pagina: "p. 89")
#let apud(autor, ano, consultada, pagina_original: none, pagina: none, prosa: false) = {
  let original = (ano, pagina_original).filter(x => x != none).join(", ")
  let obra = (cite(consultada, form: "author"), cite(consultada, form: "year"), pagina)
    .filter(x => x != none)
    .join(", ")
  if prosa {
    [#autor (#original _apud_ #obra)]
  } else {
    [(#autor, #original _apud_ #obra)]
  }
}
