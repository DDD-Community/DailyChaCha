//
//  PickerButtonProxy.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/29.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


final class RxPickerButtonDelegateProxy: DelegateProxy<PickerButton, PickerButtonDelegate> {
    
    let done: PublishSubject<Date> = .init()
    
    init(pickerButton: PickerButton) {
        super.init(parentObject: pickerButton, delegateProxy: RxPickerButtonDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxPickerButtonDelegateProxy(pickerButton: $0) }
    }
    
    static func currentDelegate(for object: PickerButton) -> PickerButtonDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: PickerButtonDelegate?, to object: PickerButton) {
        object.delegate = delegate
    }
}

extension RxPickerButtonDelegateProxy: DelegateProxyType { }

extension RxPickerButtonDelegateProxy: PickerButtonDelegate {
    
    func pickerView(_ pickerView: UIDatePicker, date: Date) {
        done.onNext(date)
    }
}

extension Reactive where Base: PickerButton {
    private var delegate: RxPickerButtonDelegateProxy {
        return RxPickerButtonDelegateProxy.proxy(for: self.base)
    }
    
    public var done: ControlEvent<Date> {
        return .init(events: delegate.done.asObserver())
    }
}
