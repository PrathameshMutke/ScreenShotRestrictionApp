//
//  SecureView.swift
//  ScreenShotRestrictionApp
//
//  Created by Prathamesh on 09/04/26.
//

import Foundation
import UIKit

class SecureView: UIView {
    private let textField = UITextField()
    private let container = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupSecurity()
    }

    private func setupSecurity() {
        textField.isSecureTextEntry = true
        textField.isUserInteractionEnabled = false
        addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        if let canvas = textField.subviews.first(where: { type(of: $0).description().contains("Canvas") }) {
            subviews.forEach { view in
                if view != textField {
                    canvas.addSubview(view)
                    canvas.isUserInteractionEnabled = true
                }
            }
        }
    }
}
