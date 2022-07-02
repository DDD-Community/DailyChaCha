//
//  Ex+UITableView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/07/02.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

extension UITableView {
    func register(type: UITableViewCell.Type) {
        let typeName: String = String(describing: type.self)
        self.register(.init(nibName: typeName, bundle: nil), forCellReuseIdentifier: typeName)
    }

    func register(identifier: String) {
        self.register(.init(nibName: identifier, bundle: .main), forCellReuseIdentifier: identifier)
    }

    func dequeue<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type.self), for: indexPath) as? T
    }

    func dequeue<T: UITableViewCell>(type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: String(describing: type.self)) as? T
    }

    func dequeue(identifier: String) -> UITableViewCell? {
        return dequeueReusableCell(withIdentifier: identifier)
    }
}
