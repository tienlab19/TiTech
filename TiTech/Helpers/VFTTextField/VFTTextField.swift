//
//  TPPlanTextField.swift
//  iosTopi
//
//  Created by thanhhm on 10/28/21.
//  Copyright © 2021 Vega. All rights reserved.
//

import UIKit

class VFTTextField: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightTextLabel: UILabel!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet weak var topOfTextField: NSLayoutConstraint!
    @IBOutlet weak var leadingOfRightText: NSLayoutConstraint!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var trailingOfTextField: NSLayoutConstraint!
    
    @IBInspectable var placeHolderText: String = "" {
        didSet {
            textField.placeholder = placeHolderText
            placeHolderLabel.text = placeHolderText
        }
    }
    
    @IBInspectable var rightText: String = "" {
        didSet {
            rightTextLabel.text = rightText
        }
    }
    
    @IBInspectable var text: String = "" {
        didSet {
            textField.text = text
            placeHolderLabel.alpha = textField.text != "" ? 1 : 0
            topOfTextField.constant = (textField.text != "" && placeHolderText != "") ? 20 : 0
            textField.attributedPlaceholder = NSAttributedString.init(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "929EAD")])
        }
    }
    
    @IBInspectable var keyboardType: Int {
         get {
             return textField.keyboardType.rawValue
         } set {
             if let keyboardType = UIKeyboardType.init(rawValue: newValue) {
                 textField.keyboardType = keyboardType
             }
         }
    }
    
    @IBInspectable var borderColor: UIColor {
         get {
             return UIColor.init(cgColor: contentView.layer.borderColor ?? UIColor.clear.cgColor)
         } set {
             contentView.layer.borderColor = newValue.cgColor
         }
    }
    
    @IBInspectable var placeHolderColor: UIColor = .black {
        didSet {
            self.placeHolderLabel.textColor = placeHolderColor
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1) {
                self.textField.attributedPlaceholder = NSAttributedString.init(string: self.textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : self.placeHolderColor])
            }
        }
    }

    @IBInspectable var highlightBorder: Bool = false
    @IBInspectable var showClearButton: Bool = false
    @IBInspectable var secureText: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leadingOfRightText.constant = rightTextLabel.text != "" ? 8 : 0
        placeHolderLabel.alpha = textField.text != "" ? 1 : 0
        topOfTextField.constant = (textField.text != "" && placeHolderText != "") ? 20 : 0
        textField.attributedPlaceholder = NSAttributedString.init(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "929EAD")])
        trailingOfTextField.constant = showClearButton ? 24 : 8
        textField.isSecureTextEntry = secureText
    }
    
    func commonInit() {
        // Ensure your XIB file is named correctly and is added to the target
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed("VFTTextField", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.init(hexString: "919191").cgColor
        contentView.layer.borderWidth = 1
        textField.layer.borderWidth = 0
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.addTarget(self, action: #selector(textFieldBeginEdit(_:)), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(textFieldEndEdit(_:)), for: .editingDidEnd)
        placeHolderLabel.alpha = 0
    }
    
    @objc func cleacAction(_ textField: UITextField) {
        textField.text = ""
    }
    
    @objc func textFieldBeginEdit(_ textField: UITextField) {
        if highlightBorder {
            contentView.layer.borderColor = UIColor.init(hexString: "A8D2F1").cgColor
            contentView.layer.borderWidth = 1
        }
        if showClearButton {
            if (textField.text ?? "").count > 0 {
                clearButton.isHidden = false
            }
        }
    }
    
    @objc func textFieldEndEdit(_ textField: UITextField) {
        if highlightBorder {
            contentView.layer.borderColor = UIColor.init(hexString: "E5EAF1").cgColor
            contentView.layer.borderWidth = 1
        }
        clearButton.isHidden = true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            if showClearButton {
                clearButton.isHidden = false
                trailingOfTextField.constant = 24
            }
            topOfTextField.constant = placeHolderText != "" ? 20 : 0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.placeHolderLabel.alpha = 1
            } completion: { _ in
                
            }

        } else {
            clearButton.isHidden = true
            trailingOfTextField.constant = 8
            topOfTextField.constant = 0
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                self.placeHolderLabel.alpha = 0
            } completion: { _ in
                
            }
        }
    }
    
    @IBAction func onTapClear(_ sender: UIButton) {
        text = ""
        clearButton.isHidden = true
        trailingOfTextField.constant = 8
    }
}
