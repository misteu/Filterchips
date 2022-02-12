//
//  FilterChipViewContainer+Configuration.swift
//  Filterchips
//
//  Created by misteu on 12.02.22.
//

import UIKit

extension FilterChipViewContainer {
    /// Configuration for the container
    public struct Configuration {
        /// The alignment of the chip views.
        let alignment: NSTextAlignment
        /// The horizontal margins between two neighboring chips.
        let horizontalMargin: CGFloat
        /// The vertical margin between two rows of chips.
        let verticalMargin: CGFloat

        public init(alignment: NSTextAlignment, horizontalMargin: CGFloat, verticalMargin: CGFloat) {
            self.alignment = alignment
            self.horizontalMargin = horizontalMargin
            self.verticalMargin = verticalMargin
        }
    }

}
