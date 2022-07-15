//
//  MainCoordinator.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func navigatToGallery(imageRecords:[ImageRecord])
}

class MainCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    init(navBarController: UINavigationController) {
        self.navController = navBarController
    }
    
    func start() {
        let serviceManager = ServiceManager()
        let searchRepository = DefaultSearchRepository(serviceManager: serviceManager)
        let searchUseCase = DefaultSearchUseCase(searchRepository: searchRepository)
        let  imageSearchViewModel =       SearchViewModel(searchUseCase: searchUseCase, coordinator: self)
        
        let searchViewController = SearchViewController.storyboardViewController()
        
        navController.viewControllers = [searchViewController]
        
        searchViewController.viewModel = imageSearchViewModel
        
    }
    
    func navigatToGallery(imageRecords: [ImageRecord]) {
                
        let galleryViewController = GalleryViewController.storyboardViewController()
        
        let serviceManager = ServiceManager()
        let galleryRepository = DefaultGalleryRepository(serviceManager: serviceManager)
        let galleryUseCase = DefualtGalleryUseCase(galleryRepository: galleryRepository)
        
        galleryViewController.galleryViewModel  = GalleryViewModel(imageRecodrs: imageRecords, galleryUseCase: galleryUseCase)
        
        navController.pushViewController(galleryViewController, animated: false)
        
    }
}
