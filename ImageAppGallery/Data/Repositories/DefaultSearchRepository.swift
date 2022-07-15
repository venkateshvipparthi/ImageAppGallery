//
//  DefaultSearchRepository.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import Foundation

final class DefaultSearchRepository {
    
    private var cachedResult: [String : [ImageRecord]] = [:]
    
    private let serviceManager: Servieble
    
    init(serviceManager:Servieble) {
        self.serviceManager = serviceManager
    }
        
    private func getCachedResponse(for keyword:String)-> [ImageRecord]? {
        return cachedResult[keyword]
    }
    
    private func getDecodedResopnse(from data: Data)-> PhotosResponseDTO? {
        guard let photosResponseDTO = try? JSONDecoder().decode(PhotosResponseDTO.self, from: data) else {
            return nil
        }
        return photosResponseDTO
    }
}

extension DefaultSearchRepository: SearchRepository {
    
    func getImages(for keyWord: String) async throws -> [ImageRecord] {
        
        if let cachedRecords = getCachedResponse(for: keyWord) {
            return cachedRecords
        }
        
        let  apiRequest = ApiRequest(baseUrl: EndPoint.baseUrl, path:"", params: ["q": keyWord])
        
        guard let data = try? await  self.serviceManager.get(apiRequest: apiRequest) else {
            throw APIError.invalidData
        }
        
        guard let photosResponseDTO = getDecodedResopnse(from: data) else {
            throw APIError.jsonParsingFailed
        }
        
        let photoRecords = photosResponseDTO.toDomain()
        
        if photoRecords.isEmpty {
            throw APIError.emptyRecords
        }
        
        self.cachedResult[keyWord] = photoRecords
        
        return photoRecords
    }
}
