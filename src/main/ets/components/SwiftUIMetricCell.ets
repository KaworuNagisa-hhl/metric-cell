import {
  getSwiftUIGlassMaterial,
  getSwiftUIPalette,
  SWIFT_UI_RADIUS_CONTROL,
  SWIFT_UI_SPACING_EXTRA_SMALL,
  SWIFT_UI_SPACING_SMALL,
  SWIFT_UI_TEXT_PRIMARY,
  SWIFT_UI_TEXT_SECONDARY,
  swiftUIColorWithOpacity,
  SwiftUIMetricItem,
  SwiftUITone
} from 'theme'

@Component
export struct SwiftUIMetricCell {
  @Prop item: SwiftUIMetricItem = { title: '', value: '' }
  @Prop usesContrastFill: boolean = false
  @Prop tone: SwiftUITone = SwiftUITone.GlassBlack
  @Prop componentWidth: Length = '100%'
  @Prop componentHeight: Length = 34
  @Prop fillColor: ResourceColor = '#E6111111'
  @Prop tintColor: ResourceColor = '#00000000'
  @Prop customBorderColor: ResourceColor = '#00000000'
  @Prop customBorderWidth: number = 1
  @Prop cornerRadius: number = SWIFT_UI_RADIUS_CONTROL
  @Prop horizontalPadding: number = SWIFT_UI_SPACING_SMALL
  @Prop valueFontSize: number = 14
  @Prop titleFontSize: number = 10

  private getColor(): ResourceColor {
    if (this.item.color) {
      return this.item.color
    }
    return getSwiftUIPalette(this.tone).primary
  }

  private resolvedTintColor(): ResourceColor {
    return this.tintColor === '#00000000' ? getSwiftUIGlassMaterial(this.tone).tint : this.tintColor
  }

  private resolvedBorderColor(): ResourceColor {
    return this.customBorderColor === '#00000000' ? swiftUIColorWithOpacity(this.getColor(), 0.28) : this.customBorderColor
  }

  build() {
    Row({ space: SWIFT_UI_SPACING_EXTRA_SMALL }) {
      if (this.item.icon) {
        Text(this.item.icon)
          .fontSize(10)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColor())
          .maxLines(1)
      }

      Text(this.item.value)
        .fontSize(this.valueFontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(SWIFT_UI_TEXT_PRIMARY)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.item.title)
        .fontSize(this.titleFontSize)
        .fontWeight(FontWeight.Bold)
        .fontColor(SWIFT_UI_TEXT_SECONDARY)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(this.componentWidth)
    .height(this.componentHeight)
    .padding({ left: this.horizontalPadding, right: this.horizontalPadding, top: SWIFT_UI_SPACING_EXTRA_SMALL, bottom: SWIFT_UI_SPACING_EXTRA_SMALL })
    .backgroundColor(this.fillColor)
    .linearGradient({
      direction: GradientDirection.RightBottom,
      colors: [
        [this.fillColor, 0.0],
        [swiftUIColorWithOpacity(this.getColor(), this.usesContrastFill ? 0.10 : 0.18), 0.62],
        [this.resolvedTintColor(), 1.0]
      ]
    })
    .backgroundBlurStyle(BlurStyle.Thin)
    .borderRadius(this.cornerRadius)
    .border({ width: this.customBorderWidth, color: this.resolvedBorderColor() })
    .shadow({ radius: 8, color: swiftUIColorWithOpacity(this.getColor(), 0.08), offsetX: 0, offsetY: 3 })
    .justifyContent(FlexAlign.Center)
  }
}
