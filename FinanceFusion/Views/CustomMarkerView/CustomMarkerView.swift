//
//  CustomMarkerView.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 9.09.2023.
//

import Foundation
import DGCharts
import UIKit

class CustomMarkerView: MarkerView {
    private var label: UILabel = UILabel()

    // MARK: - Refresh Content

      override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
          // Update the label's text with the entry's y-value
          label.text = "\(entry.y)"
          label.textColor = .white
          label.layer.zPosition = 10
          super.refreshContent(entry: entry, highlight: highlight)
      }

      // MARK: - Draw Marker

      override func draw(context: CGContext, point: CGPoint) {
          super.draw(context: context, point: point)

          // Set the size and position of the label
          let markerSize = CGSize(width: 120, height: 80)
          label.frame = CGRect(x: -70, y: -70, width: markerSize.width, height: markerSize.height)
          addSubview(label)
      }

      // MARK: - Offset for Drawing

      override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint {
          // Calculate the offset to properly position the marker
          let offset = CGPoint(x: -self.bounds.size.width / 2, y: -self.bounds.size.height)
          return offset
      }
  }
