//
//  ViewController.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import UIKit
import Combine

final class SearchViewController: UIViewController, Alertable {

    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var viewModel:SearchViewModel?
    
    private var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("search", comment:"")
        searchBar.delegate = self
        setupBinding()
        
    }


}

// MARK: - Search Bar Delegate

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(for: searchBar.text)
    }
}

// MARK: - Button Actions

extension SearchViewController {
    
    @IBAction private func searchNowButtonTapped(_ sender: Any) {
        search(for: searchBar.text)
    }
  
}

// MARK: - Private Methods

extension SearchViewController {
    private func search(for keyword:String?) {
        Task {
            await viewModel?.getGalleryImages(keyword:keyword )
        }
    }
    
    private func setupBinding() {
        viewModel?.$state.receive(on: RunLoop.main).sink(receiveValue: {[weak self] states in
            self?.searchBar.resignFirstResponder()
            switch states {
            case .showActivityIndicator:
                self?.showActivity()
            case .showPhotosView:
                self?.hideActivity()
                self?.navigateToGalleryView()
            case .showError( let message):
                self?.hideActivity()
                self?.showAlert(message:message)
            case .none:
                self?.hideActivity()
            }
        }).store(in: &bindings)
    }
        
    private func showActivity() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    private func hideActivity() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    
    private func navigateToGalleryView() {
        viewModel?.navigateToGallery()
    }
}


