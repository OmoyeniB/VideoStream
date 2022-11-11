//
//  VideoPostViewModel.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 09/11/2022.
//

import UIKit

final class VideoPostViewModel {
    
    let persistence = PersistenceStore()
    let fetchDataFromRealm = FetchDataFromRealm().data
    var persitedData = [PersistedObject]()
    
    func saveDataToRealm(data: [VideoModel]) {
        for i in data {
            let itemsTosave = PersistedObject()
            itemsTosave.decsription = i.decsription
            itemsTosave.photo = i.photo
            itemsTosave.userID = i.userID
            itemsTosave.timeStamp = i.timeStamp
            itemsTosave.userName = i.userName
            itemsTosave.videoLink = i.videoLink
            itemsTosave.isVideo = i.isVideo
            
            if !fetchDataFromRealm.contains(where: {$0.userID == itemsTosave.userID}) {
                persistence.save(items: itemsTosave)
                persitedData.append(itemsTosave)
            }
        }
    }
    
    func fetchDataServiceClass(completion: @escaping ((Result<[PersistedObject], Error>) -> Void)) {
        FirebaseManager.shared.fetchDataFromFireBase(completionHandler: { [weak self] result in
            if let self = self {
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .success(let data):
                    self.saveDataToRealm(data: data)
                    completion(.success(self.fetchDataFromRealm))
                }
            }
        })
    }
    
    func fetchUsersDataFromServiceClass(completion: @escaping ((Result<UsersModel, Error>) -> Void)) {
        FirebaseManager.shared.fetchUserDataFromRealm(completionHandler: {results in
            switch results {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        })
    }
    
    func animateHeader(stackViewHeight: NSLayoutConstraint, headerHeight: NSLayoutConstraint, profileImageHeight: NSLayoutConstraint, view: UIView) {
        DispatchQueue.main.async {
            headerHeight.constant = 160
            stackViewHeight.constant = 81
            profileImageHeight.constant = 60
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
               view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
}
