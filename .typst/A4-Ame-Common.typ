// A4-Ame-Common

// パッケージをインポート
#import "@preview/equate:0.2.1": equate
#import "@preview/enja-bib:0.1.0": *
#import bib-setting-jsme: *

// フォントサイズ設定
#let font_size_body = 10pt
#let font_size_heading_1 = 20pt
#let font_size_heading_2 = 15pt
#let font_size_heading_3 = 13pt
#let font_size_heading_4 = 12pt
#let font_size_heading_5 = 11pt
#let font_size_heading_6 = 10pt
#let font_size_mono = 9pt

// 現在の日付設定
#let nowdate = {
  [#datetime.today().year()年#datetime.today().month()月#datetime.today().day()日]
}

// 日本語コード設定
#let cjkre = regex(
  "([\u3000-\u303F\u3040-\u30FF\u31F0-\u31FF\u3200-\u9FFF\uFF00-\uFFEF][　！”＃＄％＆’（）*+，−．／：；＜＝＞？＠［＼］＾＿｀｛｜｝〜、。￥・]*)[ ]+([\u3000-\u303F\u3040-\u30FF\u31F0-\u31FF\u3200-\u9FFF\uFF00-\uFFEF])[ ]*",
)

#let a4_ame_common_init(
  font_heading,
  font_body,
  font_latex,
  font_math,
  font_mono,
  body,
) = {
  // 日本語を設定
  set text(lang: "ja")
  // ページサイズを設定
  set page(
    paper: "a4",
    margin: (left: 20mm, right: 20mm, top: 20mm, bottom: 20mm),
    numbering: "1",
    number-align: center,
  )

  // ── コアカラー（CSS "Markdown Preview Enhanced" デザイン反映）──
  let accent = rgb("#0f62fe") // --accent
  let accent_hover = rgb("#0043ce") // --accent-hover
  let accent_soft = rgb(15, 98, 254, 31) // --accent-soft (alpha ≈ 12%)

  let bg_color = rgb("#fcfcfd") // --bg-color
  let surface = rgb("#ffffff") // --surface
  let surface_muted = rgb("#f6f8fb") // --surface-muted
  let text_color = rgb("#1f2937") // --text-color
  let text_muted = rgb("#4b5563") // --text-muted
  let heading_color = rgb("#111827") // --heading-color
  let border_color = rgb("#d0d7e2") // --border
  let border_strong = rgb("#b6c2d2") // --border-strong

  let link_color = rgb("#0b57d0") // --link
  let link_visited = rgb("#6b46c1") // --link-visited

  let code_bg = rgb("#f5f7fb") // --code-bg
  let code_inline_bg = rgb("#eef2ff") // --code-inline-bg
  let code_text = rgb("#9f1239") // --code-text

  let quote_bg = rgb("#f8fbff") // --quote-bg
  let table_stripe = rgb("#f9fbff") // --table-stripe

  // 後方互換のためのエイリアス
  let darkest_blue = heading_color
  let dark_blue = accent
  let core_blue = accent
  let light_blue = accent_soft
  let lightest_blue = surface_muted
  let link_text_blue = link_color

  // 標準フォントを設定
  set text(font: font_body, size: font_size_body, cjk-latin-spacing: auto, fill: text_color)

  // 行間を設定
  set par(leading: 0.8em)
  set par(spacing: 1.5em)

  // 数式フォントを設定
  show math.equation: set text(font: font_math)

  // リンクのスタイル設定（CSS: --link + underline offset）
  show link: it => {
    set text(fill: link_color)
    box(
      underline(
        extent: 0.15em,
        stroke: (paint: link_color, thickness: 0.5pt),
        it,
      ),
    )
  }

  // 見出しを設定
  show heading: it => [
    #let font_size = if (it.level == 1) {
      font_size_heading_1
    } else if (it.level == 2) {
      font_size_heading_2
    } else if (it.level == 3) {
      font_size_heading_3
    } else if (it.level == 4) {
      font_size_heading_4
    } else if (it.level == 5) {
      font_size_heading_5
    } else {
      font_size_heading_6
    }

    #set par(first-line-indent: 0em)
    #v(font_size)

    #set text(font: font_heading, weight: "bold", size: font_size)

    // 好みで調整できるパラメータ
    #let rule_thickness_main = 1.2pt      // 下線の太さ
    #let rule_thickness_sub = 0.8pt      // 下線の太さ
    #let rule_gap = 0.5em           // 文字と下線の間隔（"下線のオフセット"に相当）
    #let after_rule_gap = 0.5em      // 下線より下の余白

    // === レベル1：CSS h1 スタイル — 下線 + アクセントバー ===
    #if it.level == 1 [
      // フル幅のボックスに下線（ボトムボーダー）を引く
      #box(
        width: 100%,
        // コンテンツとボーダーの距離
        inset: (bottom: rule_gap),
        // 下側にメインの線
        stroke: (bottom: (paint: accent, thickness: rule_thickness_main)),
      )[
        // 中央揃えで見出しを出力

        // 番号（必要なら表示）
        #if counter(heading).display() != "0" and it.numbering != none {
          context counter(heading).display(it.numbering)
          h(font_size_body)
        }

        // 見出し本文
        #align(center)[#it.body]
      ]

      // 下線の下に少し余白
      #v(after_rule_gap)

    ] else if it.level == 2 [
      // === レベル2：CSS h2 スタイル — 下線のみ ===
      #let h2_after_gap = 0.5em

      // フル幅のボックスに下線（ボトムボーダー）を引く
      #box(
        width: 100%,
        inset: (bottom: rule_gap),
        stroke: (bottom: (paint: border_color, thickness: rule_thickness_sub)),
      )[
        // 番号（必要なら表示）
        #if counter(heading).display() != "0" and it.numbering != none {
          context counter(heading).display(it.numbering)
          h(font_size_body)
        }

        // 見出し本文
        #it.body
      ]

    ] else [
      // === それ以外のレベルは従来どおり ===
      #if counter(heading).display() != "0" and it.numbering != none {
        context counter(heading).display(it.numbering)
        h(font_size_body)
      }
      #it.body
    ]
  ]

  // 段落のインデントを設定
  //set par(first-line-indent: 1em)

  // 数式の設定
  show: equate.with(breakable: true, number-mode: "line")
  show math.equation.where(block: false): it => {
    let ghost = hide(text(font: "Adobe Blank", "\u{375}")) // 欧文ゴースト
    ghost
    it
    ghost
  }

  // 数式番号の設定
  show math.equation: set block(spacing: 2em)
  set math.equation(numbering: "(1)")
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  set math.equation(numbering: num => "(" + (str(counter(heading).get().at(0)) + "." + str(num)) + ")")

  // 図表番号の設定
  set figure(numbering: num => str(counter(heading).get().at(0)) + "." + str(num))
  set figure.caption(separator: [ ])

  // リストの設定 — CSS: マーカーにアクセントカラー
  set list(indent: 1.5em, marker: (
    text(size: 1em, fill: accent)[•],
    text(size: 1em, fill: accent)[◦],
    text(size: 1em, fill: accent)[▪],
  ))

  // 章の設定
  // 表示ルールを作成して要素関数をエミュレート
  show figure.where(kind: "chapter"): it => {
    set par(first-line-indent: 0pt)
    set text(1.5em, font: font_heading, weight: "bold")

    align(left)[
      //#counter(heading).update(0)
      #if it.numbering != none {
        [第]
        context it.counter.display(it.numbering)
        [部]
        v(0.25em)
      }
      #text(1.25em, font: font_heading, weight: "bold", it.body)
    ]
  }

  // outline(indent: it => ...) では要素にアクセスできないため、outline の代わりにここでインデントを行う必要があります
  show outline.entry: it => {
    set par(first-line-indent: 0em)
    if it.element.func() == figure {
      // ここでは章の印刷を設定しており、デフォルトの表示実装をわずかな調整で効果的に再作成しています
      let res = link(
        it.element.location(),
        // 上記の表示ルールの一部を再度作成する必要があります
        if it.element.numbering != none {
          linebreak()
          text(font: font_heading, size: 1em, weight: "bold", "第")
          text(font: font_heading, size: 1em, weight: "bold", numbering(it.element.numbering, ..it.element.counter.at(
            it.element.location(),
          )))
          text(font: font_heading, size: 1em, weight: "bold", "部")
          h(1em)
        }
          + text(font: font_heading, size: 1em, weight: "bold", it.element.body),
      )

      res += h(1fr)

      res += link(it.element.location(), it.page())
      text(font: font_heading, size: 1.2em, weight: "bold", res)
      v(0.5em)
    } else {
      // ここでインデントを行っています
      it
      v(0.5em)
    }
  }

  // 章の「表示ルール」の例
  // .with() を使用した後は要素ではなくなるため、chapter は使用できません
  show figure.where(kind: "chapter"): set text(black)

  // インラインコード (raw) のフォント設定
  // CSS: --code-inline-bg + --code-text + border + border-radius
  show raw.where(block: false): it => {
    box(
      fill: code_inline_bg,
      inset: (x: 4pt, y: 0pt),
      outset: (x: 0pt, y: 3pt),
      radius: 3pt,
      stroke: (paint: border_color, thickness: 0.5pt),
      text(font: font_mono, size: font_size_mono, fill: code_text, it),
    )
  }

  // コードブロック (raw) のモダンなデザイン設定
  // CSS: --code-bg + border + border-radius + shadow
  show raw.where(block: true): it => {
    let lang = if it.lang != none { it.lang } else { "" }

    block(
      fill: code_bg,
      radius: 6pt,
      stroke: (paint: border_color, thickness: 0.75pt),
      inset: (x: 10pt, y: 10pt),
      width: 100%,
      above: 1.2em,
      below: 1.2em,
      {
        // コード本文のフォントを設定
        set text(font: font_mono, size: font_size_mono, fill: text_color)
        it
      },
    )
  }

  // 引用 (quote) のモダンなデザイン設定
  // CSS: --quote-bg + border + border-left accent + border-radius
  show quote: it => {
    // 引用ブロック全体のスタイルを定義
    block(
      fill: quote_bg,
      // 全体にボーダー + 左側にアクセント縦線
      stroke: (
        top: (paint: border_color, thickness: 0.75pt),
        bottom: (paint: border_color, thickness: 0.75pt),
        right: (paint: border_color, thickness: 0.75pt),
        left: (paint: accent, thickness: 4pt),
      ),
      radius: (top-right: 6pt, bottom-right: 6pt),
      // ブロックの上下に少し余白を設ける
      above: 1.2em,
      below: 1.2em,
      // ブロック内のコンテンツの余白
      inset: (left: 1.2em, right: 1.0em, top: 0.8em, bottom: 0.8em),
      width: 100%,
      {
        // 引用内のテキストスタイルを設定 (イタリック体、少し薄い色)
        set text(style: "italic", fill: text_muted)

        // 引用の本文を表示
        it.body

        // 引用元 (attribution) があれば右寄せで表示
        if it.attribution != none {
          v(0.5em) // 本文との間に少しスペース
          align(right)[— #it.attribution]
        }
      },
    )
  }

  // Style table cells with a bottom border.
  show table.cell: it => {
    box(width: 100%, inset: it.inset, it)
  }

  // Style text within a table header.
  // CSS: --surface-muted bg + --heading-color text + bold + left-align
  show table.header: it => {
    // Apply fill and alignment to the header cell itself.
    box(
      fill: surface_muted,
      width: 100%,
      align(left, {
        show text: t => text(weight: "bold", fill: heading_color, t.body)
        it
      }),
    )
  }

  // 図キャプションの設定
  show figure.where(
    // 図の種類が表の場合...
    kind: table,
  ): set figure.caption(position: top)
  show figure.caption: it => {
    // 図のキャプションが画像の場合...
    v(0.5em)
    grid(
      columns: 2,
      align(top)[#it.supplement #context it.counter.display() #h(1em)], align(left)[#it.body],
    )
  }
  // 日本語文字間の改行を無効化
  show cjkre: it => it.text.match(cjkre).captures.sum()

  // 参考文献の設定
  show: bib-init

  // --------------------------------------------------
  // 作者: tinger
  let chapter = figure.with(
    kind: "chapter",
    // 見出しと同じ
    numbering: none,
    // 見出しのように自動で翻訳するために auto を使用することはできません。auto は図に対しては異なる意味を持ちます
    supplement: [chapter],
    // アウトラインに含めるには空のキャプションが必要です
    caption: "",
  )

  // デフォルトアウトラインの新しいターゲットセレクター
  let chapters-and-headings = figure.where(kind: "chapter", outlined: true).or(heading.where(outlined: true))

  // set は使えないので、デフォルト引数で再代入します
  let chapter = chapter.with(numbering: "I")

  let jcls_appendix(body) = {
    counter(heading).update(0)
    counter("chapter").update(0)
    set heading(numbering: "A.1", outlined: false)
    show heading.where(level: 1): set heading(outlined: true)
    set math.equation(numbering: num => (
      "(" + (str(numbering("A", counter(heading).get().at(0))) + "." + str(num)) + ")"
    ))
    set figure(numbering: num => str(numbering("A", counter(heading).get().at(0))) + "." + str(num))
    body
  }

  let author-print(authors) = {
    let output-arguments = ()

    let tmp_list = ()
    for author in authors {
      let tmp = text(1.2em, [#author.name])

      let tmp2 = []
      if author.at("affiliation", default: []) != [] {
        if author.at("email", default: "") != "" {
          tmp2 = [#author.affiliation (#author.email)]
        } else {
          tmp2 = [#author.affiliation]
        }
      } else {
        if author.at("email", default: "") != "" {
          tmp2 = [#author.email]
        }
      }

      if tmp2 != [] {
        // 著者に所属またはメールアドレスがある場合
        if tmp_list.contains(tmp2) {
          // 所属またはメールアドレスが既にリストにある場合
          let num = 0
          for val in tmp_list {
            // 同じ所属またはメールアドレスの数を確認
            if val != tmp2 {
              num += 1
            } else {
              break
            }
          }
          // 所属またはメールアドレスに番号を追加
          tmp += super(str(num + 1))
        } else {
          // 所属またはメールアドレスをリストに追加
          tmp += footnote(tmp2)
          tmp_list.push(tmp2)
        }
      }

      output-arguments.push(tmp)
    }

    return output-arguments
  }

  let maketitle(
    title: [],
    abstract: [],
    keywords: (),
    authors: (),
    date: true,
    tableofcontents: false,
    body,
  ) = {
    //set document(author: authors.map(a => a.name), title: title)
    // タイトルを設定
    pad(
      bottom: 4pt,
      top: 2cm,
      align(center)[
        #set text(font: (font_latex, font_body))
        #block(text(1.75em, title))
        #v(1em, weak: true)
      ],
    )
    // 著者情報を設定
    pad(
      top: 1em,
      x: 2em,
      bottom: 1.5em,
      grid(
        align: center,
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..author-print(authors),
      ),
    )
    // 日付を設定
    if date {
      v(-1em)
      align(center)[#text(1.2em, [#nowdate])]
    }
    // 要旨を設定
    if abstract != [] {
      pad(
        top: 1em,
        x: 3em,
        bottom: 0.4em,
        [
          #align(center)[
            #text(1.0em, emph(smallcaps[Abstract]), font: font_latex)
          ]
          #set par(justify: true)
          #set text(hyphenate: false)
          #abstract
        ],
      )
    } else {
      v(1.2cm, weak: true)
    }
    // 目次の表示
    if tableofcontents {
      v(0.5cm)
      line(length: 100%, stroke: 0.5pt)
      outline(
        indent: auto,
        //fill: box(width: 1fr, repeat(h(2pt) + "." + h(2pt))) + h(8pt),
        target: chapters-and-headings,
        title: [#h(-0.7em) 目次],
      )
      pagebreak()
    }
    body
  }

  let latex = {
    set text(font: font_latex)
    box(width: 2.55em, {
      [L]
      place(top, dx: 0.3em, text(size: 0.7em)[A])
      place(top, dx: 0.7em)[T]
      place(top, dx: 1.26em, dy: 0.22em)[E]
      place(top, dx: 1.8em)[X]
    })
  }

  let nonumber = <equate:revoke>

  body
}
