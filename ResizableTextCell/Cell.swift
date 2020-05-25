//
//  Cell.swift
//  ResizableTextCell
//
//  Created by adrian.szymanowski on 25/05/2020.
//  Copyright © 2020 adrian.szymanowski. All rights reserved.
//

import UIKit

protocol CellDelegate: class {
    func updateLayout(_ cell: Cell)
}

class Cell: UICollectionViewCell {
    
    weak var delegate: CellDelegate?
    
    var computedSize: CGSize = .zero
    
    private lazy var textview: CustomTextView = {
        let t = CustomTextView()
        t.customDelegate = self
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textview)
        textview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textview.topAnchor.constraint(equalTo: topAnchor),
            textview.leadingAnchor.constraint(equalTo: leadingAnchor),
            textview.trailingAnchor.constraint(equalTo: trailingAnchor),
            textview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension Cell: CustomTextViewDelegate {
    func updateFrame(_ textView: UITextView) {
        computedSize = textView.contentSize
        delegate?.updateLayout(self)
    }
}


protocol CustomTextViewDelegate: class {
    func updateFrame(_ textView: UITextView)
}

class CustomTextView: UITextView {
    weak var customDelegate: CustomTextViewDelegate?
    
    override var contentSize: CGSize {
        didSet {
            customDelegate?.updateFrame(self)
        }
    }
}
