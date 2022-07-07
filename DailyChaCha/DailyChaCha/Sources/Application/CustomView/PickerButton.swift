//
//  PickerButton.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/29.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

public protocol PickerButtonDelegate: AnyObject {
    func pickerView(_ pickerView: UIDatePicker, date: Date)
}

public class PickerButton: UIButton {
    
    public let pickerView = UIDatePicker()
    
    public weak var delegate: PickerButtonDelegate?
    
    public override var inputView: UIView? {
        return pickerView
    }
    
    public override var inputAccessoryView: UIView? {
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 44)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let space = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: doneButtonTitle,
            style: .done,
            target: self,
            action: #selector(didTapDone(_:))
        )
        doneButton.tintColor = doneButtonTintColor
        
        let items = [space, doneButton]
        toolbar.setItems(items, animated: false)
        toolbar.sizeToFit()
        toolbar.updateConstraintsIfNeeded()
        
        return toolbar
    }
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // MARK: - Variables
    private var doneButtonTitle: String = "Done"
    private var doneButtonTintColor: UIColor = .systemBlue
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    public func setTitleForDoneButton(_ title: String, color: UIColor = .systemBlue) {
        doneButtonTitle = title
        doneButtonTintColor = color
    }
    
    public func setBackgroundColorForPicker(color: UIColor) {
        pickerView.backgroundColor = color
    }
    
}

// MARK: - Obj-C Methods
@objc
extension PickerButton {
    
    private func didTapDone(_ button: UIBarButtonItem) {
        delegate?.pickerView(pickerView, date: pickerView.date)
        closePickerView()
    }
    
    /// Open the picker view
    private func didTapButton() {
        becomeFirstResponder()
    }
    
}

// MARK: - Private Methods
extension PickerButton {
    
    private func configureView() {
        if #available(iOS 13.4, *) {
            pickerView.preferredDatePickerStyle = .wheels
        } else {
            
        }
        pickerView.datePickerMode = .time
        pickerView.timeZone = .autoupdatingCurrent
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func closePickerView() {
        resignFirstResponder()
    }
    
}
