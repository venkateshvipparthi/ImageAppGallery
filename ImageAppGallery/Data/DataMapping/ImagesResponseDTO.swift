//
//  ImagesResponseDTO.swift
//  ImageAppGallery
//
//  Created by Admin on 15/07/2022.
//

import Foundation


struct ImagesResponseDTO: Codable {
    let photos: Photos
    let stat: String
}


struct Photos: Codable {
    let page, pages, perpage, total: Int
    let photo: [Photo]
}


struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}



// MARK: - Mappings to Domain

extension ImagesResponseDTO {
    func toDomain() -> [ImageRecord] {
        return Photo.map{ .init(id:$0.id , previewURL: $0 )}
    }
}
