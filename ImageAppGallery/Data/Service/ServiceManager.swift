//
//  ServiceManager.swift
//  ImageAppGallery
//
//  Created by Venkat on 15/07/2022.
//

import Foundation

protocol Servieble {
    func get(apiRequest:ApiRequestType) async throws -> Data
}

class ServiceManager: Servieble {
    
    func get(apiRequest: ApiRequestType) async throws -> Data {
        guard let request = URLRequest.getURLRequest(for: apiRequest) else {
            throw APIError.requestFailed
        }
        do {
            let (data, _)  = try await URLSession.shared.data(for: request)
            return data
        }catch {
            throw APIError.invalidData
        }
    }
}
