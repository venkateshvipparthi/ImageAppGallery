//
//  SearchUseCase.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import Foundation

protocol SearchUseCase {
    func execute(for keyword: String) async throws -> [ImageRecord]
}

final class DefaultSearchUseCase: SearchUseCase {
    private var searchRepository: SearchRepository

    init(searchRepository: SearchRepository) {
        self.searchRepository = searchRepository
    }
    
    func execute(for keyword: String) async throws -> [ImageRecord] {
        do {
            return try await searchRepository.getImages(for: keyword)
        }catch {
          throw error
        }
    }
}
