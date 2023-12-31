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
    collectionView = .init(frame: view.bounds, collectionViewLayout: UIHelper.customFlowLayout(view))
    guard let collectionView else { return }
    view.addSubview(collectionView)
    
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseIdentifier)
    collectionView.delegate = self
    configureCollectionViewDataSource()
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

// MARK: - UICollectionViewDelegate

extension FollowerListVC: UICollectionViewDelegate {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    viewModel.updateFollowers(scrollView)
  }
}

// MARK: - FollowerProtocol

extension FollowerListVC: FollowerProtocol {
  
  func updateUI() {
    updateData()
  }
  
  func showLoaderView(_ show: Bool) {
    if show {
      showLoaderView()
    } else {
      hideLoaderView()
    }
  }
}

// MARK: - AlertProtocol

extension FollowerListVC: AlertProtocol {
  
  func showAlert(_ alertItem: AlertItem) {
    presentGFAlert(alertItem)
  }
}
