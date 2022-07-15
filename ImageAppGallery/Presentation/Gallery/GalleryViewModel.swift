//
//  GalleryViewModel.swift
//  ImageAppGallery
//
//  Created by Admin on 15/07/2022.
//

import Foundation

protocol GalleryViewModelInput {
    func downLoadImage(for index:Int)async -> Data?
}

protocol GalleryViewModelOutput {
    var numberOfRecords:Int {get}
}

protocol GalleryViewModelAction {
}

final class GalleryViewModel{
    private let imageRecords:[ImageRecord]
    private let galleryUseCase: GalleryUseCase
    
    init(imageRecodrs:[ImageRecord], galleryUseCase: GalleryUseCase) {
        self.imageRecords = imageRecodrs
        self.galleryUseCase = galleryUseCase
    }
}

extension GalleryViewModel: GalleryViewModelOutput {
    var numberOfRecords:Int {
        return imageRecords.count
    }
}

extension GalleryViewModel: GalleryViewModelInput {
    func downLoadImage(for index:Int)async -> Data? {
        let url = imageRecords[index].url
      
        return  try? await galleryUseCase.execute(for: url)
    }
}
