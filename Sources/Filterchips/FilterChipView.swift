//
//  FilterChipView.swift
//  Filterchips
//
//  Created by misteu on 26.01.22.
//

import UIKit

/// Chip view with rounded corners, showing a checkmark icon when selected.
public class FilterChipView: UIControl {

    /// The top constraint between this `FilterChipView` and its superview (`FilterChipViewContainer`).
    /// Is used for re-aligning chipviews after a linebreak.
    var topSuperViewConstraint: NSLayoutConstraint?
    /// The leading constraint between this `FilterChipView` and its superview (`FilterChipViewContainer`).
    /// Is used for re-aligning the `FilterChipView` horizontally after a line break.
    /// This has priority `.required` to overwrite the constraint between two chipviews.
    var leadingSuperViewConstraint: NSLayoutConstraint?
    /// Constraint between trailing and leading constraint of two neighbor chips.
    var betweenChipConstraint: NSLayoutConstraint?
    /// The height of a chip, used for measuring.
    private(set) var heightConstraint: NSLayoutConstraint?
    /// Current row of the chip, is changed based on surrounding chips.
    var row = 0
    /// The text on the chip.
    let text: String
    /// The label of the chip.
    let label = Label()
    /// The `UIImageView` showing the checkmark when the chip is in a selected state.
    let checkmarkView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(textStyle: .body)
        let view = UIImageView(image: UIImage(systemName: "checkmark.circle.fill",
                                              withConfiguration: configuration))
        return view
    }()
    /// The tap handler triggered when tapping on a chip.
    private var tapHandler: ((Bool) -> Void)?

    private var selectedColor: UIColor

    /// Creates a new instance of `FilterChipView`.
    /// - Parameters:
    ///   - text: The text to display.
    ///   - isSelected: The state of the chip view when initializing.
    ///   - selectedColor: The color for the selected state.
    ///   - tapHandler: The tap handler triggered when tapping on the chip.
    public init(text: String, selectedColor: UIColor, isSelected: Bool = false, tapHandler: ((Bool) -> Void)?) {
        self.text = text
        self.selectedColor = selectedColor
        checkmarkView.tintColor = selectedColor
        super.init(frame: .zero)
        self.isSelected = isSelected
        self.tapHandler = tapHandler
        label.set(text: text, style: .buttonText)
        setup()
    }

    /// Not supported. Always `nil`.
    required init?(coder: NSCoder) { nil }

    /// Calls all the setup methods.
    private func setup() {
        setTapHandler()
        setView()
        updateCheckmark()
        updateText()
        layer.borderWidth = 2
        layer.cornerRadius = 16
        updateBorder()
    }

    /// Sets view hierarchy and constraints.
    private func setView() {
        label.translatesAutoresizingMaskIntoConstraints = false
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(checkmarkView)
        NSLayoutConstraint.activate([

            checkmarkView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            checkmarkView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Layout.defaultMargin / 2),
            checkmarkView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -Layout.defaultMargin / 4),
            checkmarkView.widthAnchor.constraint(equalToConstant: checkmarkView.intrinsicContentSize.width),

            label.topAnchor.constraint(equalTo: topAnchor, constant: Layout.defaultMargin / 2),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.defaultMargin / 2),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Layout.defaultMargin / 2)
        ])
        heightConstraint = self.heightAnchor.constraint(greaterThanOrEqualToConstant: .zero)
    }

    /// Sets tap handler.
    private func setTapHandler() {
        addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }

    /// Tap handler. Triggered when tapping the chip.
    @objc func didTap() {
        UIDevice.vibrate(.soft)
        isSelected.toggle()
        updateCheckmark()
        updateBorder()
        updateText()
        tapHandler?(isSelected)
    }

    /// Updates the text based on selection state.
    private func updateText() {
        UIView.animate(withDuration: 0.3) {
            self.label.textColor = self.isSelected ? self.selectedColor : .darkGray.withAlphaComponent(0.8)
        }
    }

    /// Updates the border based on selection state.
    private func updateBorder() {
        UIView.animate(withDuration: 0.3) {
            if self.isSelected {
                self.layer.borderColor = self.selectedColor.cgColor
            } else {
                self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
            }
        }
    }

    /// Updates the checkmark based on selection state.
    private func updateCheckmark() {
        checkmarkView.image = isSelected ? Images.selected : Images.notSelected
        checkmarkView.tintColor = isSelected ? selectedColor : .lightGray.withAlphaComponent(0.5)
    }

    /// The images used for selected or non selected state.
    enum Images {
        static let selected = UIImage(systemName: "checkmark.circle.fill")
        static let notSelected = UIImage(systemName: "circle")
    }
}
