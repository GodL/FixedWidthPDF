//
//  FixedPDFView.swift
//
//
//  Created by L God on 2024/7/5.
//

import Foundation
import PDFKit

open class FixedPDFView: PDFView {
    
    let pressGesture = UILongPressGestureRecognizer()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(pressGesture)
        _setupPressGesture()
    }
    
    open override var document: PDFDocument? {
        willSet {
            precondition(newValue is FixedPDFDocument)
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func _setupPressGesture() {
        pressGesture.allowedTouchTypes = [UITouch.TouchType.direct.rawValue as NSNumber]
        pressGesture.minimumPressDuration = 0.1
        pressGesture.delegate = self
    }
}

extension FixedPDFView {
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == pressGesture {
            let point = gestureRecognizer.location(in: self)
            if let page = self.page(for: point, nearest: true) as? FixedPDFPage,
               let document = self.document as? FixedPDFDocument {
                page.replacePage(with: document.fixedWidth)
            }
            return false
        }
        return true
    }
}
