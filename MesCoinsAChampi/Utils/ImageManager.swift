//
//  ImageManager.swift
//  MesCoinsAChampi
//
//  Created by Antoine Proux on 17/06/2019.
//  Copyright © 2019 Antoine Proux. All rights reserved.
//

import Foundation
import UIKit


struct ImageManager {
    
    static let shared = ImageManager()
    
    let fileManager = FileManager.default
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    func saveImage(image: UIImage, uid: String) -> String? {
       let imageName = uid + ".png"
        
        if let imageData = image.pngData() {
            do {
                let filePath = documentsPath.appendingPathComponent(imageName)
                try imageData.write(to: filePath)
                print("\(imageName) was saved.")
                
                return imageName
            } catch let error as NSError {
                print("\(imageName) could not be saved: \(error)")
                
                return nil
            }
        } else {
            print("Could not convert UIImage to png data")
            
            return nil
        }
    }
    
    
    func getImageFromPath(imageName: String, defaultImage: String) -> UIImage{
        let image: UIImage! = UIImage(named: defaultImage)
    
        let imagePath = documentsPath.appendingPathComponent(imageName).path
        
        guard fileManager.fileExists(atPath: imagePath) else {
            print("Image does not exist at path: \(imagePath)")
            
            return image
        }
        
        if let imageData = UIImage(contentsOfFile: imagePath) {
            return imageData
        } else {
            print("UIImage could not be created.")
            return image
        }
    }
    
    func deleteImage(imageName: String) {
        let imagePath = documentsPath.appendingPathComponent(imageName)
        
        guard fileManager.fileExists(atPath: imagePath.path) else {
            print("Image does not exist at path: \(imagePath)")
            
            return
        }
        do {
            try fileManager.removeItem(at: imagePath)
            print("\(imageName) was deleted.")
        } catch let error as NSError {
            print("Could not delete \(imageName): \(error)")
        }
    }
    
    
}


