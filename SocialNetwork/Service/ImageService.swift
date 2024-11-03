//
//  ImageService.swift
//  SocialNetwork
//
//  Created by mert alp on 31.10.2024.
//

import Foundation
import FirebaseStorage
import UIKit

class ImageService {
    private let storage = Storage.storage()
    
    // MARK: - Upload Image to Firebase Storage
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "Image Conversion Error", code: -1, userInfo: nil)))
            return
        }
        
        let imageName = UUID().uuidString
        let imageRef = storage.reference().child("images/\(imageName).jpg")
        
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                if let urlString = url?.absoluteString {
                    completion(.success(urlString))
                } else {
                    completion(.failure(NSError(domain: "URL Error", code: -1, userInfo: nil)))
                }
            }
        }
    }
    
    // MARK: - Get Image from URL
    func getImage(url: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let imageRef = storage.reference(forURL: url)
        
        imageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NSError(domain: "Image Download Error", code: -1, userInfo: nil)))
            }
        }
    }
}
