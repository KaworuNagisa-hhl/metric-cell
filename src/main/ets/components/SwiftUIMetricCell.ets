import {
  getSwiftUIGlassMaterial,
  getSwiftUIPalette,
  SWIFT_UI_RADIUS_CONTROL,
  SWIFT_UI_SPACING_EXTRA_SMALL,
  SWIFT_UI_SPACING_SMALL,
  SWIFT_UI_TEXT_PRIMARY,
  SWIFT_UI_TEXT_SECONDARY,
  swiftUIColorWithOpacity,
  SwiftUIComponentConfig,
  SwiftUIMetricItem,
  SwiftUITone
} from 'theme'

@Component
export struct SwiftUIMetricCell {
  @Prop item: SwiftUIMetricItem = { title: '', value: '' }
  @Prop config: SwiftUIComponentConfig = new SwiftUIComponentConfig()
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

  private resolvedTone(): SwiftUITone {
    return this.config.tone === undefined ? this.tone : this.config.tone
  }

  private resolvedWidth(): Length {
    return this.config.width === undefined ? this.componentWidth : this.config.width
  }

  private resolvedHeight(): Length {
    return this.config.height === undefined ? this.componentHeight : this.config.height
  }

  private resolvedFillColor(): ResourceColor {
    return this.config.fillColor === undefined ? this.fillColor : this.config.fillColor
  }

  private resolvedCornerRadius(): number {
    return this.config.cornerRadius === undefined ? this.cornerRadius : this.config.cornerRadius
  }

  private resolvedBorderWidth(): number {
    return this.config.borderWidth === undefined ? this.customBorderWidth : this.config.borderWidth
  }

  private resolvedHorizontalPadding(): number {
    return this.config.contentPadding === undefined ? this.horizontalPadding : this.config.contentPadding
  }

  private resolvedValueFontSize(): number {
    return this.config.titleFontSize === undefined ? this.valueFontSize : this.config.titleFontSize
  }

  private resolvedTitleFontSize(): number {
    return this.config.subtitleFontSize === undefined ? this.titleFontSize : this.config.subtitleFontSize
  }

  private getColor(): ResourceColor {
    if (this.item.color) {
      return this.item.color
    }
    if (this.config.color) {
      return this.config.color
    }
    return getSwiftUIPalette(this.resolvedTone()).primary
  }

  private resolvedTintColor(): ResourceColor {
    if (this.config.tintColor) {
      return this.config.tintColor
    }
    return this.tintColor === '#00000000' ? getSwiftUIGlassMaterial(this.resolvedTone()).tint : this.tintColor
  }

  private resolvedBorderColor(): ResourceColor {
    if (this.config.borderColor) {
      return this.config.borderColor
    }
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
        .fontSize(this.resolvedValueFontSize())
        .fontWeight(FontWeight.Bold)
        .fontColor(SWIFT_UI_TEXT_PRIMARY)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(this.item.title)
        .fontSize(this.resolvedTitleFontSize())
        .fontWeight(FontWeight.Bold)
        .fontColor(SWIFT_UI_TEXT_SECONDARY)
        .layoutWeight(1)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
    }
    .width(this.resolvedWidth())
    .height(this.resolvedHeight())
    .padding({ left: this.resolvedHorizontalPadding(), right: this.resolvedHorizontalPadding(), top: SWIFT_UI_SPACING_EXTRA_SMALL, bottom: SWIFT_UI_SPACING_EXTRA_SMALL })
    .backgroundColor(this.resolvedFillColor())
    .linearGradient({
      direction: GradientDirection.RightBottom,
      colors: [
        [this.resolvedFillColor(), 0.0],
        [swiftUIColorWithOpacity(this.getColor(), this.usesContrastFill ? 0.10 : 0.18), 0.62],
        [this.resolvedTintColor(), 1.0]
      ]
    })
    .backgroundBlurStyle(BlurStyle.Thin)
    .borderRadius(this.resolvedCornerRadius())
    .border({ width: this.resolvedBorderWidth(), color: this.resolvedBorderColor() })
    .shadow({ radius: 8, color: swiftUIColorWithOpacity(this.getColor(), 0.08), offsetX: 0, offsetY: 3 })
    .justifyContent(FlexAlign.Center)
  }
}
