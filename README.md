# FixedWidthPDF
使PDFView以固定的宽度去显示所有PDFPage，即使PDFPage大小并不一样，
并且支持长按选择文字。

## Usage

```swift
    let pdfView = FixedPDFView(frame: .zero)
    let url = Bundle.main.url(forResource: "test", withExtension: "pdf")!
    let document = PDFDocument(url: url)!
    pdfView.document = FixedPDFDocument(fixedWidth: 1000, originalDocument: document)

```
## Installation
**Using the Swift Package Manager**
Add **Association** as a dependency to your `Package.swift` file. For more information, see the [Swift Package Manager documentation](https://github.com/apple/swift-package-manager/tree/master/Documentation).

```
.package(url: "https://github.com/GodL/FixedWidthPDF.git", from: "1.1.0")

```

## Help & Feedback
- [Open an issue](https://github.com/GodL/FixedWidthPDF/issues/new) if you need help, if you found a bug, or if you want to discuss a feature request.
- [Open a PR](https://github.com/GodL/FixedWidthPDF/pull/new/master) if you want to make some change to `FixedWidthPDF`.
- Contact [@GodL](547188371@qq.com) .
