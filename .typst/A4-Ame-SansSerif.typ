// A4-Ame-SansSerif

#import "A4-Ame-Common.typ": *

#let font_heading = ("Noto Sans", "Noto Sans JP")
#let font_body = ("Noto Sans", "Noto Sans JP")
#let font_latex = ("Noto Sans", "Noto Sans JP")
#let font_math = "Noto Sans Math"
#let font_mono = ("Monaspace Neon", "BIZ UDGothic")

#let a4_ame_init(body) = {
  a4_ame_common_init(
    font_heading,
    font_body,
    font_latex,
    font_math,
    font_mono,
    body,
  )
}
