//
//  ViewController.swift
//  Demo
//
//  Created by L God on 2024/7/17.
//

import UIKit
import PDFKit
import FixedWidthPDF

class ViewController: UIViewController {
    let pdfView = FixedPDFView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(pdfView)
        let url = Bundle.main.url(forResource: "test", withExtension: "pdf")!
        let document = PDFDocument(url: url)!
        pdfView.document = FixedPDFDocument(fixedWidth: 1000, originalDocument: document)
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pdfView.frame = view.bounds
    }

}

