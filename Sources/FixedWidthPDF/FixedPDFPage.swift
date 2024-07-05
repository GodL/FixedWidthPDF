//
//  FixedPDFPage.swift
//
//
//  Created by L God on 2024/7/5.
//

import Foundation
import PDFKit

open class FixedPDFPage: PDFPage {
    public var originalPage: PDFPage!

    public var scale: CGFloat = 1.0
    
    var renderPage: PDFPage?
    
    required
    public override init() {
        super.init()
    }
    
    open override func draw(with box: PDFDisplayBox, to context: CGContext) {
        if let originalPage {
            context.scaleBy(x: scale, y: scale)
            originalPage.draw(with: box, to: context)
            for annotation in originalPage.annotations {
                annotation.draw(with: box, in: context)
            }
        }
    }
}

extension FixedPDFPage {
    public func replacePage(with width: CGFloat) {
        guard renderPage == nil else { return }
        if let _renderPage = replaceRenderFixedPage(to: width) {
            self.renderPage = _renderPage
            if self.responds(to: NSSelectorFromString("setPageRef:")), let pageRef = _renderPage.pageRef {
                self.perform(NSSelectorFromString("setPageRef:"), with: pageRef)
            }
        }
        
    }
}

extension PDFPage {
    public func replaceRenderFixedPage<T: PDFDocument>(to width: CGFloat, documentClass: T.Type = PDFDocument.self) -> PDFPage? {
        let pdfData = UIGraphicsPDFRenderer().pdfData { context in
            let rotate = self.rotation
            var mediaBox = self.bounds(for: .cropBox)
            if mediaBox == .zero {
                mediaBox = self.bounds(for: .mediaBox)
            }
            mediaBox = mediaBox.applying(.init(rotationAngle: Double(rotate)*Double.pi/180))
            let scale = width / mediaBox.width
            mediaBox = CGRect(
                x: 0, y: 0, width: width, height: mediaBox.height * scale)
            context.cgContext.beginPage(mediaBox: &mediaBox)
            context.cgContext.scaleBy(x: scale, y: scale)
            self.draw(with: .mediaBox, to: context.cgContext)
            context.cgContext.endPDFPage()
            context.cgContext.closePDF()
        }
        if let document = documentClass.init(data: pdfData),
           let newPage = document.page(at: 0) {
            return newPage
        }
        return nil
    }
}
