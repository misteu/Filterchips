# Filterchips

Filterchips is a lightweight UI component that lets you add an aligned field of chips that can be used for filtering (or anything else). It has no other dependencies, supports Auto-Layout and is Swift only.

In a later release it will support laying out any view conforming to some protocol.

`FilterChipViewContainer` is instantiated with an array of `FilterChipView`s. These are aligned automatically in a line breaking layout based on a given configuration.

You can configure the layout via `FilterChipViewContainer.Configuration` which is currently pretty basic.
It supports configuring the alignment, vertical margin between the chips and the horizontal margins between rows.

![grafik](https://user-images.githubusercontent.com/35889530/153749776-a1a80d8c-ba79-48b8-9587-712877abca34.png)
![grafik](https://user-images.githubusercontent.com/35889530/153749803-0b5c0a44-e630-44b4-b9d7-23c9c186fdb8.png)
![grafik](https://user-images.githubusercontent.com/35889530/153749838-b5ebf340-9d3d-4352-998e-1256c3c3277c.png)
![grafik](https://user-images.githubusercontent.com/35889530/153749904-41663420-4487-427b-ac88-18078201a6c7.png)

![grafik](https://user-images.githubusercontent.com/35889530/153749740-4f4c8e13-7679-45c1-81d7-e7a6884dce8c.png)

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
