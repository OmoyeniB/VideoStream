//
//  VideoPostViewModel.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 09/11/2022.
//

import UIKit

final class VideoPostViewModel {
    
    //    private let firebaseManager =
    
    //    init(firebaseManager: FirebaseManager) {
    //        self.firebaseManager = firebaseManager
    //    }
    
    func fetchDataServiceClass(completion: @escaping ((Result<[VideoModel], Error>) -> Void)) {
        FirebaseManager.shared.fetchDataFromFireBase(completionHandler: { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
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
    
    func configureSegmentedControl(_ segmentedControl: UISegmentedView) {
        segmentedControl.frame = CGRect(x: segmentedControl.frame.minX, y:
                                            segmentedControl.frame.minY,
                                        width: segmentedControl.frame.width, height: 30)
        segmentedControl.highlightSelectedSegment()
    }
    
}
