---
marp: true
theme: A4-Manual
paginate: true
---

# MarkdownDesign

これは、Markdownの記述と閲覧体験を向上させるために設計された、**Markdown Preview Enhanced**および**Marp**対応のCSSテーマ群です。

## ✨ 特徴

- **2つのデザインテーマ**: 用途に応じて、プロフェッショナルなドキュメントスタイルと、モダンでインタラクティブなUIスタイルを使い分けられます。
- **インタラクティブな要素**: Markdown Preview Enhancedでは、コードブロックへのコピーボタンの追加や、スクロールに連動したアニメーションなど、動的な閲覧体験を提供します。
- **高い可読性**: 読みやすさを重視し、厳選されたフォント、行間、カラーコントラストを採用しています。

## 🎨 デザインテーマ一覧

### 1. A4 Manual for Marp

クリーンでプロフェッショナルなA4サイズの技術マニュアルやレポートを作成するためのMarp用テーマです。

**主な特徴:**

- **A4ページサイズ**: `width: 900px`, `height: 1273px`のA4相当のサイズでレイアウトされます。
- **教科書体フォント**: `Noto Sans JP`に加え、`UD デジタル 教科書体 NK`を使用し、明瞭で読みやすいタイポグラフィを実現しています。
- **構造的な見出し**: `h1`と`h2`には罫線が引かれ、文章の構造が一目でわかります。
- **整理されたスタイル**: テーブル、コードブロック、ヘッダー、フッターに専用のスタイルが定義されています。

**使用方法:**
Marpのフロントマターで`theme: A4-Manual`と指定します。

```markdown
---
marp: true
theme: A4-Manual
---

# ドキュメントタイトル

これはA4マニュアルテーマのサンプルです。
```

**関連ファイル:**

- `Marp/A4-Manual.scss`

---

### 2. Modern & Interactive UI for Markdown Preview Enhanced

Markdown Preview Enhanced (MPE)での閲覧・記述体験を向上させるために設計された、高機能でモダンなテーマです。

**主な特徴:**

- **🎨 デザイン**
  - クリーンな配色と、角丸や繊細な影を効果的に使用した、見やすく整理されたモダンなUIを提供します。

- **🚀 インタラクティブ機能**
  - **コードコピー**: コードブロック上にカーソルを合わせると「コピー」ボタンが表示され、ワンクリックで内容を取得できます。
  - **アニメーション**: ページの読み込み時やスクロールに合わせ、コンテンツが滑らかに表示されます。

- **🔧 閲覧サポート**
  - **テーブル**: 幅の広いテーブルは、レイアウトを崩さずに横スクロールで閲覧可能です。
  - **外部リンク**: 外部サイトへのリンクは自動的に新しいタブで開かれ、閲覧中のドキュメントから移動するのを防ぎます。

**関連ファイル:**

- `Markdown Preview Enhanced/style.less`
- `Markdown Preview Enhanced/head.html`

---

#### 🚀 インストール方法

このテーマを **Markdown Preview Enhanced** で利用するには、以下の手順でCSSとHTMLを設定します。

1. **カスタムCSSの設定**
    1. Visual Studio Codeに「[Markdown Preview Enhanced](https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced)」をインストールします。
    2. コマンドパレットを開き (`Shift + Ctrl + P` / macOS: `Shift + Cmd + P`)、`markdown` と入力後、`Markdown Preview Enhanced: Customize CSS (Global)` を選択します。
        ![width:700px](/Images/2025-06-30_22h13_29.png)
    3. `style.less` ファイルが開いたら、[style.less](/Markdown%20Preview%20Enhanced/Light%20theme/style.less) の内容をすべてコピーし、貼り付けて保存します。
        ![width:700px](/Images/2025-06-30_22h20_26.png)

---

2. **カスタムHTML Headの設定**
    1. 再度コマンドパレットを開き (`Shift + Ctrl + P` / macOS: `Shift + Cmd + P`)、`markdown` と入力後、`Markdown Preview Enhanced: Customize Preview Html Head (Global)` を選択します。
        ![width:700px](/Images/2025-06-30_22h22_35.png)
    2. `head.html` ファイルが開いたら、[head.html](/Markdown%20Preview%20Enhanced/Light%20theme/head.html) の内容をすべてコピーし、貼り付けて保存します。
        ![width:700px](/Images/2025-06-30_22h26_23.png)

これで設定は完了です。Markdownファイルのプレビューに新しいスタイルが適用されます。
