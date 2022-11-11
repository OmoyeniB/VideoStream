//
//  FirebaseManager.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 09/11/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    private let data_base = Firestore.firestore()
    var videoModel = [VideoModel]()
    var usersModel: UsersModel?
    private init() {}
    
    public func fetchDataFromFireBase(completionHandler: @escaping (Result<[VideoModel], Error>) -> Void) {
        data_base.collection("post").addSnapshotListener { [weak self] (querySnapshot, error) in
            
            if let self = self {
                guard let documents = querySnapshot?.documents else {
                    completionHandler(.failure(NetworkingError.invalidUrl))
                    return
                }
                
                self.videoModel = documents.map { (queryDocumentSnapshot) in
                    let data = queryDocumentSnapshot.data()
                    let bio = data["description"] as? String ?? ""
                    let photo = data["thumbnail"] as? String ?? ""
                    let id = data["userId"] as? String ?? ""
                    let timestamp = data["timestamp"] as? Int ?? 0
                    let username = data["username"] as? String ?? ""
                    let link = data["link"] as? String ?? ""
                    let isVideo = data["video"] as? Bool ?? false
                    
                    return VideoModel(decsription: bio, photo: photo, userID: id, timeStamp: timestamp, userName: username, videoLink: link, isVideo: isVideo)
                }
                DispatchQueue.main.async {
                    completionHandler(.success(self.videoModel))
                }
            }
            
        }
    }
    
    public func fetchUserDataFromRealm(completionHandler: @escaping (Result<UsersModel, Error>) -> Void) {
        data_base.collection("users").getDocuments() { [weak self] (snapshot, error) in
            if let error = error {
                completionHandler(.failure(error))
            } else {
                let documents = snapshot?.documents
                if let document = documents {
                    for documents in document {
                        let data = documents
                        let photo = data["photo"] as? String ?? ""
                        let bio = data["bio"] as? String ?? ""
                        let name = data["name"] as? String ?? ""
                        let id = data["userId"] as? String ?? ""
                        let username = data["username"] as? String ?? ""
                        let usermodel = UsersModel(photo: photo, bio: bio, name: name, id: id, username: username)
                        self?.usersModel = usermodel
                        
                    }
                    
                    DispatchQueue.main.async {
                        if let self = self, let usersModel = self.usersModel {
                            completionHandler(.success(usersModel))
                        }
                    }
                }
            }
        }
    }
    
  
    
}
