# metric-cell

`metric-cell` 是一个 OpenHarmony/HarmonyOS ArkUI like-ios 指标单元组件，适合展示完成率、数量、状态分值和轻量统计。默认是黑色优先的小尺寸纯色毛玻璃胶囊，可自定义颜色、宽高、圆角、边框、内边距和字号。

## 实际运行效果

下面展示指标单元在默认和自定义宽高状态下的毛玻璃效果：

![metric cell preview](https://cdn.jsdelivr.net/gh/KaworuNagisa-hhl/metric-cell@main/docs/metric-cell-preview.gif)

## 安装

```bash
ohpm install metric-cell
```


## 正常使用样式

```ts
import { SwiftUIMetricCell } from 'metric-cell'
import { SwiftUITone } from 'theme'

@Component
struct CompletionMetric {
  build() {
    SwiftUIMetricCell({
      tone: SwiftUITone.GlassBlack,
      item: {
        title: '完成率',
        value: '82%',
        icon: 'T',
        color: '#141414'
      }
    })
  }
}
```

## 自定义品牌样式

```ts
SwiftUIMetricCell({
  item: { title: '同步记录', value: '128', icon: 'R', color: '#141414' },
  componentWidth: 180,
  componentHeight: 42,
  fillColor: '#E6111111',
  tintColor: '#1FFFFFFF',
  customBorderColor: '#33FFFFFF',
  customBorderWidth: 1,
  cornerRadius: 8,
  horizontalPadding: 12,
  valueFontSize: 15,
  titleFontSize: 11
})
```

## SwiftUI 风格链式配置

```ts
import { swiftUIConfig, SwiftUITone } from 'theme'

const glassStyle = swiftUIConfig()
  .withTone(SwiftUITone.SystemGray)
  .withWidth('92%')
  .withHeight('auto')
  .withRadius(8)
  .withFillColor('#E6111111')
  .withTintColor('#22FFFFFF')
  .withBorder('#33FFFFFF', 1)
  .withShadow('#33000000', 16)
  .withPadding(12)

SwiftUIMetricCell({
  config: glassStyle
})
```

`config` 是可选入口，适合复用一组 SwiftUI modifier 风格的外观配置；原有直接传参方式仍然可用，且业务可以继续通过 Builder 注入自定义内容。

## 示例目录

完整最小示例见 `example/SwiftUIMetricCellUsage.ets`。该示例演示了标题、数值、图标和强调色的基础传参方式，适合数据概览卡片使用。

## 颜色与风格预设

`SwiftUITone` 继续保持三个基础颜色枚举：`GlassBlack`、`PureWhite`、`SystemGray`。如果业务希望更快套用品牌风格，可以从 `theme` 引入 `SwiftUIBrandStyle` 与 `swiftUIConfigForStyle()`，当前提供 `Graphite`、`Mist`、`Ocean`、`Mint`、`Amber`、`Rose`、`Lavender` 七组预设。预设只是快捷入口，仍可继续叠加 `withFillColor()`、`withTintColor()`、`withColor()`、`withAccentColor()`、`withBorder()`、`withShadow()`、`withRadius()`、`withPadding()`、`withSize()`、`withTitleFontSize()`、`withSubtitleFontSize()`、`withTextFontSize()`、`withIconSize()`、`withSpacing()` 等链式方法做高度自定义。

```ts
import { SwiftUIBrandStyle, swiftUIConfigForStyle } from 'theme'

const oceanStyle = swiftUIConfigForStyle(SwiftUIBrandStyle.Ocean)
  .withRadius(8)
  .withPadding(14)
  .withBorder('#6657C7F7', 1.2)
  .withShadow('#241D4ED8', 20)
```

## API

| 参数 | 类型 | 默认值 | 说明 |
| --- | --- | --- | --- |
| `config` | `SwiftUIComponentConfig` | 空配置 | SwiftUI modifier 风格链式配置，可覆盖宽高、圆角、颜色、边框、阴影、内边距等通用外观 |
| `item` | `SwiftUIMetricItem` | 空指标 | 指标标题、数值、图标和颜色 |
| `usesContrastFill` | `boolean` | `false` | 是否降低强调色填充强度 |
| `tone` | `SwiftUITone` | `GlassBlack` | 默认 like-ios 黑色毛玻璃色调 |
| `componentWidth` | `Length` | `'100%'` | 单元宽度 |
| `componentHeight` | `Length` | `34` | 单元高度 |
| `fillColor` | `ResourceColor` | `'#E6111111'` | 黑色毛玻璃底色 |
| `tintColor` | `ResourceColor` | 自动色调 | 渐变叠色 |
| `customBorderColor` | `ResourceColor` | 自动边框 | 自定义边框色 |
| `customBorderWidth` | `number` | `1` | 边框宽度 |
| `cornerRadius` | `number` | `12` | 圆角 |
| `horizontalPadding` | `number` | `8` | 横向内边距 |
| `valueFontSize` | `number` | `14` | 数值字号 |
| `titleFontSize` | `number` | `10` | 标题字号 |
