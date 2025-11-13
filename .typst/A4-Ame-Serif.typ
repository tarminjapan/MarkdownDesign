// A4-Ame-Serif

#import "A4-Ame-Common.typ": *

#let font_heading = "Noto Sans JP"
#let font_body = "Noto Serif JP"
#let font_latex = "Noto Serif JP"
#let font_math = "Noto Sans Math"
#let font_mono = ("Monaspace Xenon", "BIZ UDMincho")

#let a4_ame_serif_init(body) = {
  a4_ame_common_init(
    font_heading,
    font_body,
    font_latex,
    font_math,
    font_mono,
    body,
  )
}
