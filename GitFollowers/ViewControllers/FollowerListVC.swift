//
//  FollowerListVC.swift
//  GitFollowers
//
//  Created by MAHESHWARAN on 30/12/23.
//

import UIKit

protocol FollowerListDelegate: AnyObject {
  func didRequestFollowers(for username: String)
}

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
    navigationItem.rightBarButtonItem = .init(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addButtonTapped))
    setupCollectionView()
    setupSearchBar()
  }
}

// MARK: - Search

extension FollowerListVC {
  
  func setupSearchBar() {
    let searchVC = UISearchController()
    searchVC.searchResultsUpdater = self
    searchVC.searchBar.delegate = self
    searchVC.searchBar.placeholder = "Search"
    searchVC.obscuresBackgroundDuringPresentation = false
    
    navigationItem.searchController = searchVC
    navigationItem.hidesSearchBarWhenScrolling = false
  }
}

extension FollowerListVC: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    viewModel.updateSearchResult()
  }
}

extension FollowerListVC: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    viewModel.updateSearchResult(searchController.searchBar.text)
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
  
  private func updateData(_ followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
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
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let profileVC = ProfileVC(using: viewModel.getFollower(indexPath.row))
    profileVC.delegate = self
    let navigationVC = UINavigationController(rootViewController: profileVC)
    present(navigationVC, animated: true)
  }
}

extension FollowerListVC {
  
  @objc private func addButtonTapped() {
    viewModel.addToFavorites { [weak self] error in
      self?.presentGFAlert(error)
    }
  }
}

// MARK: - FollowerProtocol

extension FollowerListVC: FollowerProtocol {
  
  func updateUI(_ showPlaceholder: Bool, followers: [Follower]) {
    guard !showPlaceholder else {
      let message = "This user don't have any followers. Go follow them! "
      showEmptyView(message)
      return
    }
    updateData(followers)
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

// MARK: - FollowerListDelegate

extension FollowerListVC: FollowerListDelegate {
  
  func didRequestFollowers(for username: String) {
    title = username
    viewModel.resetFollowers(username)
    collectionView?.setContentOffset(.zero, animated: true)
  }
}
