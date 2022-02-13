# Filterchips

![grafik](https://user-images.githubusercontent.com/35889530/153731719-050e4ed6-a06d-4cc7-8b1a-a557471c6726.png)

Filterchips is a UI component that lets you add an aligned field of chips that can be used for filtering.

`FilterChipViewContainer` is instantiated with an array of `FilterChipView`s. These are aligned automatically in a line breaking layout based on a given configuration.

Currently, the `FilterChipViewContainer.Configuration` is pretty basic.
It supports configuring the alignment, vertical margin between the chips and the horizontal margins between rows.

## Example

A `FilterChipViewContainer` manages any number of `FilterChipView`s.
Currently, only adding `FilterChipView`s is possible, in a later update a protocol will be added, conforming views can be added and laid out to `FilterChipViewContainer` as well.

You can create a `FilterChipViewContainer` and later set its `chipViews` property or fill it with `FilterChipView` during initializing.

```swift
/// Initialize a `FilterChipViewContainer` with a `FilterChipViewContainer.Configuration`
let chipsContainer = FilterChipViewContainer(
    configuration: .init(
        alignment: .center,
        horizontalMargin: 8,
        verticalMargin: 8
    )
)

/// Add `FilterChipView`s
chipsContainer.chipViews = [
    "Hello!",
    "We",
    "are",
    "FilterChipViews!",
    "Let's",
    "create",
    "funky",
    "filters!"
].map {
    FilterChipView(text: $0,
                   selectedColor: .systemGreen,
                   tapHandler: nil)
}

/// Adding `FilterChipView`s during initialization
let chipsContainer = FilterChipViewContainer(
    filterChipViews: [
        .init(text: "Hello", selectedColor: .systemGreen, tapHandler: nil),
        .init(text: "🚀", selectedColor: .systemRed, tapHandler: nil),
        .init(text: "🚂", selectedColor: .systemBlue, tapHandler: nil)
    ],
    configuration: .init(
        alignment: .center,
        horizontalMargin: 8,
        verticalMargin: 8
    )
)
```

## Changelog
*0.0.1 - initial version with basic configuration*
