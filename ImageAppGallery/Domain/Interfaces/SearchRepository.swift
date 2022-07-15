//
//  SearchRepository.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import Foundation

protocol SearchRepository {
    func getImages(for keyWord: String) async throws -> [ImageRecord]
}
