import { describe, it, expect } from '@ohos/hypium'
import { getSwiftUIGlassMaterial, SwiftUIMetricItem } from 'theme'

export default function localUnitTest() {
  describe('SwiftUIMetricCell', () => {
    it('accepts_metric_item_contract', 0, () => {
      const item: SwiftUIMetricItem = { title: 'Today', value: '82%', color: '#0B7063', icon: 'A' }
      expect(item.title.toString()).assertEqual('Today')
      expect(item.value.toString()).assertEqual('82%')
      expect(item.icon?.toString()).assertEqual('A')
    })

    it('uses_glass_fill_for_metric_chip', 0, () => {
      expect(getSwiftUIGlassMaterial().fillStrong.toString()).assertContain('#')
    })
  })
}
