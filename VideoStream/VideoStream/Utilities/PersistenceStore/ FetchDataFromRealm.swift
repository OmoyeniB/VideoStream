//
//   FetchDataFromRealm.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 11/11/2022.
//

import Foundation

final class FetchDataFromRealm {
    
    fileprivate let persistence = PersistenceStore()
    let data: [PersistedObject]
    init() {
        data = persistence.fetchData(type: PersistedObject.self)
    }
    
    
}
