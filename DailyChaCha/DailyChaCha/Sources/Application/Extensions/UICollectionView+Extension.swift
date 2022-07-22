//
//  UICollectionView+Extension.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/14.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

public enum SupplementaryViewKind: String {
  case header, footer
  
  public init?(rawValue: String) {
    switch rawValue {
    case UICollectionView.elementKindSectionHeader: self = .header
    case UICollectionView.elementKindSectionFooter: self = .footer
    default: return nil
    }
  }
  
  public var rawValue: String {
    switch self {
    case .header: return UICollectionView.elementKindSectionHeader
    case .footer: return UICollectionView.elementKindSectionFooter
    }
  }
}

protocol CellType: AnyObject {
}

protocol ViewType: AnyObject {}

// MARK: UICollectionViewCell
extension UICollectionViewCell: CellType {
}

extension UICollectionReusableView: ViewType, CellType {}

// MARK: Cell

extension UICollectionView {
  func dequeue<T>(_ cellType: T.Type, indexPath: IndexPath) -> T where T: CellType {
    return self.dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
  }
  
  func register<T>(_ cellType: T.Type) where T: CellType {
    self.register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
  }
}

// MARK: Header & FooterView

extension UICollectionView {
  func dequeue<T>(_ cellType: T.Type, kind: SupplementaryViewKind, indexPath: IndexPath) -> T where T: CellType, T: ViewType {
    return self.dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
  }
  
  func register<T>(_ cellType: T.Type, kind: SupplementaryViewKind) where T: CellType, T: ViewType {
    self.register(T.self, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: String(describing: T.self))
  }
}
