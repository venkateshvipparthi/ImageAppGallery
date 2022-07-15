//
//  SearchViewStates.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import Foundation

enum SearchViewStates: Equatable {
    case showActivityIndicator
    case showPhotosView
    case showError(String)
    case none
}

