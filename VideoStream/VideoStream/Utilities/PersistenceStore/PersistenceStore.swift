//
//  PersistenceStore.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 11/11/2022.
//

import Foundation
import RealmSwift

final class PersistenceStore: PersistenceProtocol {
    
    fileprivate let realm = try! Realm()
    
    func save<T: Object>(items: T) {
        do {
            try realm.write({
                realm.add(items)
            })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchData<T: Object>( type: T.Type) -> [T] {
        Array(realm.objects(type))
    }
    
}
