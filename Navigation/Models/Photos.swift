//
//  Photos.swift
//  Navigation
//
//  Created by Алексей Самойлов on 27.03.2023.
//

import Foundation
import UIKit
protocol Photos {
    var photoName: String {get set}
    static func make() -> [PhotosForApp]
}

struct PhotosForApp: Photos {
    var photoName: String
    
    static func make() -> [PhotosForApp] {
        [
            PhotosForApp(photoName: "team0"),
            PhotosForApp(photoName: "team1"),
            PhotosForApp(photoName: "team2"),
            PhotosForApp(photoName: "team3"),
            PhotosForApp(photoName: "team4"),
            PhotosForApp(photoName: "team5"),
            PhotosForApp(photoName: "team6"),
            PhotosForApp(photoName: "team7"),
            PhotosForApp(photoName: "team8"),
            PhotosForApp(photoName: "team9"),
            PhotosForApp(photoName: "team10"),
            PhotosForApp(photoName: "team11"),
            PhotosForApp(photoName: "team12"),
            PhotosForApp(photoName: "team13"),
            PhotosForApp(photoName: "team14"),
            PhotosForApp(photoName: "team15"),
            PhotosForApp(photoName: "team16"),
            PhotosForApp(photoName: "team17"),
            PhotosForApp(photoName: "team18"),
            PhotosForApp(photoName: "team19")
        ]
    }
}

var newPhotoCollection: [UIImage] = []
func makeCollectionPhoto() {
    newPhotoCollection = (0...19).compactMap{UIImage(named: "team\($0)") }
}
