//
//  FilterChipViewContainer.swift
//  Filterchips
//
//  Created by skrr on 29.01.22.
//  Copyright © 2022 mic. All rights reserved.
//

import UIKit

/// Container holding and aligning `FilterChipView`s based on given `Configuration`.
public final class FilterChipViewContainer: UIView {

    /// The configuration to apply to the container.
    private let configuration: Configuration
    /// The chip views to show inside the container.
    ///
    /// Layout is updated with `chipViews` whenever set. Based on the `configuration` passed during initialization.
    public var chipViews: [FilterChipView] {
        didSet {
            addChipViews()
        }
    }

    /// The view's current width, set in `layoutSubviews`.
    private(set) var currentWidth: CGFloat?
    /// The constraint between the last chip's bottom and the container's bottom.
    private var bottomToChipConstraint: NSLayoutConstraint?
    /// The number of rows. Updated while laying out the chip views.
    private(set) var numberOfRows = 1
    /// Set `true` when no further layouting needs to be done.
    private var checkedAllElements = false
    /// The elements that are currently checked against layouting rules (line breaking and alignment)
    private var elementsToCheck: [FilterChipView]

    /// Creates an instance of `FilterChipViewContainer` with a given `Configuration` to setup the layout.
    /// - Parameters:
    ///   - filterChipViews: The chip views that are laid out.
    ///   - configuration: The configuration for laying out the `filterChipViews`.
    public init(filterChipViews: [FilterChipView] = [], configuration: Configuration) {
        self.chipViews = filterChipViews
        self.elementsToCheck = filterChipViews
        self.configuration = configuration
        super.init(frame: .zero)
        addChipViews()
    }

    /// Not supported. Always `nil`.
    required init?(coder: NSCoder) { nil }

    /// Resets the container.
    private func reset() {
        subviews.forEach { $0.removeFromSuperview() }
        numberOfRows = 1
        checkedAllElements = false
        elementsToCheck = chipViews
    }

    /// Resets container and adds all `chipViews`.
    private func addChipViews() {
        reset()
        var previousTrailingConstraint = leadingAnchor
        chipViews.enumerated().forEach { index, chipView in
            chipView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(chipView)

            chipView.betweenChipConstraint = chipView.leadingAnchor.constraint(
                equalTo: previousTrailingConstraint, constant: index == 0 ? 0 : configuration.horizontalMargin
            )
            chipView.betweenChipConstraint?.priority = .defaultHigh
            if index == 0 {
                chipView.leadingSuperViewConstraint = chipView.leadingAnchor.constraint(equalTo: leadingAnchor)
            }
            chipView.topSuperViewConstraint = chipView.topAnchor.constraint(equalTo: topAnchor)

            [
                chipView.topSuperViewConstraint,
                chipView.heightAnchor.constraint(equalToConstant: chipView.preferredSize.height),
                chipView.betweenChipConstraint,
                chipView.leadingSuperViewConstraint
            ].forEach { $0?.isActive = true }
            previousTrailingConstraint = chipView.trailingAnchor
        }
    }

    /// Updates the layout of the `chipViews` based on the `configuration`.
    /// Line-breaks are introduced by setting up additional constraints when necessary.
    private func updateLayout() {
        if !checkedAllElements {
            if let breakingChip = elementsToCheck.enumerated().first(where: { $0.element.frame.maxX > frame.maxX }) {
                numberOfRows += 1
                breakingChip.element.betweenChipConstraint?.isActive = false
                breakingChip.element.leadingSuperViewConstraint = breakingChip
                    .element
                    .leadingAnchor
                    .constraint(equalTo: leadingAnchor)
                breakingChip.element.leadingSuperViewConstraint?.constant = 0
                breakingChip.element.leadingSuperViewConstraint?.isActive = true
                if let height = chipViews.first?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height {
                    let breakingIndex = breakingChip.offset
                    let breakingChips = elementsToCheck.enumerated().filter { $0.offset >= breakingIndex }
                    breakingChips.forEach {
                        $0.element.row = numberOfRows - 1
                        $0.element.topSuperViewConstraint?.constant = (height + configuration.verticalMargin) * CGFloat(numberOfRows - 1)
                        $0.element.topSuperViewConstraint?.isActive = true
                    }
                    elementsToCheck = breakingChips.map { $0.element }
                }
                layoutIfNeeded()
            } else {
                updateForAlignment()
                checkedAllElements = true
                if let lastChip = chipViews.last {
                    bottomToChipConstraint = bottomAnchor.constraint(equalTo: lastChip.bottomAnchor)
                    bottomToChipConstraint?.priority = .defaultHigh
                    bottomToChipConstraint?.isActive = true
                }
            }
        }
    }

    /// Updates the laid out `chipViews` based on the given configuration.
    private func updateForAlignment() {
        if let maxRow = chipViews.map({ $0.row }).max() {
            (0...maxRow).forEach { row in
                let elementsOfRow = chipViews.filter { $0.row == row }
                if let lastElement = elementsOfRow.last {
                    let remainingSpace = frame.maxX - lastElement.frame.maxX
                    switch configuration.alignment {
                    case .left, .natural:
                        break
                    case .center:
                        elementsOfRow.first?.leadingSuperViewConstraint?.constant = remainingSpace / 2
                    case .right:
                        elementsOfRow.first?.leadingSuperViewConstraint?.constant = remainingSpace
                    case .justified:
                        elementsOfRow.first?.leadingSuperViewConstraint?.constant = 0
                        let numberOfGaps = CGFloat(elementsOfRow.count - 1)
                        let totalRemainingSpace = remainingSpace + numberOfGaps * configuration.horizontalMargin
                        elementsOfRow.dropFirst().forEach { $0.betweenChipConstraint?.constant = totalRemainingSpace / CGFloat(elementsOfRow.count - 1) }
                    @unknown default:
                        elementsOfRow.first?.leadingSuperViewConstraint?.constant = remainingSpace / 2
                    }
                }
            }
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        currentWidth = frame.width
        if window != nil {
            updateLayout()
        }
    }
}
