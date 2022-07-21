//
//  HomeViewController.swift
//  DailyChaCha
//
//  Created by Jaewook Hwang on 2022/07/10.
//  Copyright © 2022 DailyChaCha. All rights reserved.
//

import UIKit

import RIBs
import ReactorKit
import RxCocoa
import RxDataSources
import RxSwift
import SnapKit
import Then
import Kingfisher

enum HomeAction {
  case fetchHomeComponents
  case fetchNextExerciseInfo
  case fetchUserLevelInfo
  case bottomSheetSwipeBegan(yValue: CGFloat)
  case bottomSheetSwipeEnded(yValue: CGFloat)
}

protocol HomePresentableListener: AnyObject {
  typealias Action = HomeAction
  typealias State = HomeState
  
  var action: ActionSubject<Action> { get }
  var state: Observable<State> { get }
  var currentState: State { get }
}

final class HomeViewController:
  UIViewController,
  HomePresentable,
  HomeViewControllable
{
  
  typealias BackgroundSection = RxCollectionViewSectionedAnimatedDataSource<HomeBackgroundModel>
  
  typealias ObjectsSection = RxCollectionViewSectionedAnimatedDataSource<HomeObjectModel>
  
  // MARK: - UI Components
  
  private let backgroundCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  .then {
    $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.minimumInteritemSpacing = 0
    $0.minimumLineSpacing = 0
    }
  ).then {
    $0.backgroundColor = .white
    $0.register(HomeBackgroundCell.self)
    $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    $0.showsVerticalScrollIndicator = false
  }
  
  private lazy var itemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
    $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.scrollDirection = .vertical
    $0.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
    $0.minimumInteritemSpacing = 0
    $0.minimumLineSpacing = 0
  }).then {
    $0.backgroundColor = .clear
    $0.bounces = false
    $0.register(HomeObjectCell.self)
    $0.register(ChageuneeCharacterHeader.self, kind: .header)
    $0.delegate = self
    $0.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 40, right: 0)
    $0.showsVerticalScrollIndicator = false
  }
  
  private let messageView = OneLineMessageView()
  
  private let bottomSheetView = HomeTransformableBottomView()
  
  private let whiteCoverView = UIView().then {
    $0.backgroundColor = .white
  }
  
  func present(viewController: ViewControllable) {
    
  }
  
  func push(viewControllable: ViewControllable, animated: Bool) {
    
  }
  
  // MARK: Properties
  
  var listener: HomePresentableListener?
  
  private let disposeBag = DisposeBag()
  
  lazy var backgroundDataSource = BackgroundSection(
    configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
      
      let cell = collectionView.dequeue(HomeBackgroundCell.self, indexPath: indexPath)
      
      cell.configure(imageURLString: item.imageURLString)
      
      return cell
    }
  )
  
  lazy var objectsDataSource = ObjectsSection(
    configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
      
      let cell = collectionView.dequeue(HomeObjectCell.self, indexPath: indexPath)
      
      cell.configure(imageURLString: item.imageURLString)
      
      return cell
    }, configureSupplementaryView: { model, collectionView, kind, indexPath in
      
      switch kind {
      case UICollectionView.elementKindSectionFooter:
        return UICollectionReusableView()
      case UICollectionView.elementKindSectionHeader:
        let header = collectionView.dequeue(ChageuneeCharacterHeader.self, kind: .header, indexPath: indexPath)
        header.tapGesture.rx.event.bind { _ in
          
          header.displayTurningAnmiation()
        }
        .disposed(by: header.disposeBag)
        
        return header
      default:
        return UICollectionReusableView()
      }
    }
  )
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bind(listener: listener)
  }
}

extension HomeViewController {
  private func bind(listener: HomePresentableListener?) {
    guard let listener = listener else {
      return
    }
    bindAction(to: listener)
    bindState(from: listener)
  }
  
  private func bindAction(to listener: HomePresentableListener) {
    
    let viewWillAppear = rx.viewWillAppear.share()
    
    viewWillAppear
      .map { _ in HomeAction.fetchHomeComponents}
      .bind(to: listener.action)
      .disposed(by: disposeBag)
    
    viewWillAppear
      .map { _ in HomeAction.fetchUserLevelInfo}
      .bind(to: listener.action)
      .disposed(by: disposeBag)
    
    viewWillAppear
      .map { _ in HomeAction.fetchNextExerciseInfo }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
    
    bottomSheetView.panGesture.rx.event
      .flatMap { gesture -> Observable<HomeAction> in
        switch gesture.state {
        case .began:
          let point = gesture.translation(in: nil)
          return Observable<HomeAction>.just(.bottomSheetSwipeBegan(yValue: point.y))
        case .ended:
          let point = gesture.translation(in: nil)
          return Observable<HomeAction>.just(.bottomSheetSwipeEnded(yValue: point.y))
        default:
          return Observable<HomeAction>.empty()
        }
      }
      .bind(to: listener.action)
      .disposed(by: disposeBag)
  }
  
  private func bindState(from listener: HomePresentableListener) {
    
    listener.state
      .map { $0.backgroundsModel }
      .bind(to: backgroundCollectionView.rx.items(dataSource: backgroundDataSource))
      .disposed(by: disposeBag)
    
    listener.state
      .map { $0.objectsModel }
      .bind(to: itemsCollectionView.rx.items(dataSource: objectsDataSource))
      .disposed(by: disposeBag)
    
    listener.state.compactMap { $0.userLevelInfo }
      .asDriver(onErrorJustReturn: UserLevelInfo(goal: nil, level: 1))
      .drive { [weak self] userInfo in
        self?.messageView.configure(with: userInfo)
      }
      .disposed(by: disposeBag)
    
    listener.state.compactMap { $0.nextExerciseInfo }
      .asDriver(onErrorJustReturn:NextExerciseInfo(exerciseDaysInSuccession: 100, exerciseRemainTime: 100, objectImageURLString: nil))
      .drive { [weak self] nextExerciseInfo in
        self?.bottomSheetView.configure(with: nextExerciseInfo)
      }
      .disposed(by: disposeBag)
    
    listener.state.map { $0.bottomSheetSwipeDirection }
      .compactMap { $0 }
      .asDriver(onErrorJustReturn: .downward)
      .drive { [weak self] direction in
        switch direction {
        case .upward:
          self?.bottomSheetView.updateLayout(mode: .unfolded)
        case .downward:
          self?.bottomSheetView.updateLayout(mode: .folded)
        }
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - SetupUI
extension HomeViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubviews(
      backgroundCollectionView,
      itemsCollectionView,
      messageView,
      whiteCoverView,
      bottomSheetView
    )
    
    backgroundCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    itemsCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    messageView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(20)
      $0.top.equalToSuperview().inset(40)
      $0.height.equalTo(44)
    }
    
    whiteCoverView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(40)
    }
    
    bottomSheetView.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
    }
  }
}

extension HomeViewController: UIScrollViewDelegate, UICollectionViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offset = scrollView.contentOffset
    print(offset)
    let newOffset = CGPoint(x: offset.x, y:  offset.y / 5.0)
    if newOffset.y > 0 {
      backgroundCollectionView.setContentOffset(newOffset, animated: false)
      if bottomSheetView.currentMode == .unfolded {
        bottomSheetView.updateLayout(mode: .folded)
      }
    }
  }
}
