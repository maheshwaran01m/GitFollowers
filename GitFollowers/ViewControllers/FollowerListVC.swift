//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

class FollowerListVC: UIViewController {
  
  private var viewModel: FollowerListViewModel
  private var collectionView: UICollectionView?
  private var collectionViewDataSource: UICollectionViewDiffableDataSource<Section, Follower>?
  
  init(_ userName: String) {
    viewModel = .init(userName)
    super.init(nibName: nil, bundle: nil)
    self.title = userName
    viewModel.alertDelegate = self
    viewModel.delegate = self
  }
  
  required init?(coder: NSCoder) {
    viewModel = .init("")
    super.init(coder: coder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  private func setup() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    setupCollectionView()
  }
}

// MARK: - Collection View

extension FollowerListVC {
  
  private func setupCollectionView() {
    collectionView = .init(frame: view.bounds, collectionViewLayout: customFlowLayout)
    guard let collectionView else { return }
    view.addSubview(collectionView)
    
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    configureCollectionViewDataSource()
  }
  
  private var customFlowLayout: UICollectionViewFlowLayout {
    let width = view.bounds.width
    let padding: CGFloat = 12
    let minimumItemSpacing: CGFloat = 10
    
    let finalWidth = width - (padding * 2) - (minimumItemSpacing * 2)
    
    let itemWidth = finalWidth/3
    
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
    layout.itemSize = .init(width: itemWidth, height: itemWidth + 40)
    
    return layout
  }
}

extension FollowerListVC {
  
  enum Section {
    case main
  }
  
  private func configureCollectionViewDataSource() {
    guard let collectionView else { return }
    collectionViewDataSource = UICollectionViewDiffableDataSource(
      collectionView: collectionView) { collectionView, indexPath, follower in
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as? FollowerCell else {
          return .init()
        }
        cell.configure(follower)
        return cell
      }
  }
  
  private func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(viewModel.followers)
    DispatchQueue.main.async { [weak self] in
      self?.collectionViewDataSource?.apply(snapshot, animatingDifferences: true)
    }
  }
}

// MARK: - FollowerProtocol

extension FollowerListVC: FollowerProtocol {
  
  func updateUI() {
    updateData()
  }
}

// MARK: - AlertProtocol

extension FollowerListVC: AlertProtocol {
  
  func showAlert(_ alertItem: AlertItem) {
    presentGFAlert(alertItem)
  }
}

// 5:07
