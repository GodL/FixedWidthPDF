// The Swift Programming Language
// https://docs.swift.org/swift-book

import PDFKit

open class FixedPDFDocument: PDFDocument {
    
    let fixedWidth: CGFloat
    
    let originalDocument: PDFDocument
    
    open override var pageClass: AnyClass {
        FixedPDFPage.self
    }
    
    public init(fixedWidth: CGFloat = 500, originalDocument: PDFDocument) {
        self.fixedWidth = fixedWidth
        self.originalDocument = originalDocument
        super.init()
        _makeFixed()
    }
    
    public override init?(url: URL) {
        fatalError()
    }
    
    public override init?(data: Data) {
        fatalError()
    }
}

extension FixedPDFDocument {
    private func _makeFixed() {
        for index in 0..<originalDocument.pageCount {
            let _class = pageClass as! FixedPDFPage.Type
            let fixedPage = _class.init()
            guard let originalPage = originalDocument.page(at: index) else {
                fixedPage.originalPage = PDFPage()
                super.insert(fixedPage, at: index)
                return
            }
            let rotate = originalPage.rotation
             var mediaBox = originalPage.bounds(for: .cropBox)
            if mediaBox == .zero {
                mediaBox = originalPage.bounds(for: .mediaBox)
            }
            mediaBox = mediaBox.applying(.init(rotationAngle: Double(rotate)*Double.pi/180))
            let scale = fixedWidth / mediaBox.width
            fixedPage.originalPage = originalPage
            fixedPage.scale = scale
            fixedPage.setBounds(CGRect(x: 0, y: 0, width: fixedWidth, height: mediaBox.height * scale), for: .mediaBox)
            super.insert(fixedPage, at: index)
        }
    }
}
