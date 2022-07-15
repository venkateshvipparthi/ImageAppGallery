//
//  GalleryRepository.swift
//  ImageAppGallery
//
//  Created by Admin on 15/07/2022.


import Foundation

protocol GalleryRepository {
   func getImages(for url: String) async throws -> Data
}

protocol ImageCacher {
    func getImage(url:String)-> Data?
    func saveImage(url:String, data:Data)
}
