//
//  Ex+Rx+UITableView.swift
//  DailyChaCha
//
//  Created by moon.kwon on 2022/06/24.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UITableView {
    /**
    CellModel과 바인딩 합니다. RxTableViewCell인 경우 bind(to:CellModel)을 호출합니다.
     
    - parameter source: Observable sequence of items.
    - returns: Disposable object that can be used to unbind.
     
     Example:

         let items: [CellModel] = []
         items.bind(to: tableView.rx.cells).disposed(by: disposeBag)
         
    */
    func cells<Sequence: Swift.Sequence, Source: ObservableType>
        (_ source: Source)
        -> Disposable
        where Source.Element == Sequence {
        return items(source)({ tv, row, element -> UITableViewCell in
            guard let model: CellModel = element as? CellModel,
                  let cell: UITableViewCell = tv.dequeueReusableCell(withIdentifier: model.cellID) else {
                return .init()
            }
            model.row = row
            if let cell = cell as? CellModelable {
                cell.bind(to: model)
            }

            return cell
        })
    }
    
    public var indexPathsForSelectedRows: ControlEvent<[IndexPath]?> {
        let rows = Observable.merge(
            itemSelected.asObservable(),
            itemDeselected.asObservable()
        )
            .map { _ in base.indexPathsForSelectedRows }
        
        return ControlEvent(events: rows)
    }
}

