import { SwiftUIMetricCell } from 'metric-cell'

@Component
export struct SwiftUIMetricCellUsage {
  build() {
    SwiftUIMetricCell({
      item: {
        title: 'Completion',
        value: '92%',
        color: '#0B7063',
        icon: 'OK'
      }
    })
  }
}
