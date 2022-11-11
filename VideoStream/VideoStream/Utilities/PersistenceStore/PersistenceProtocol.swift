//
//  PersistenceProtocol.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 11/11/2022.
//

import Foundation
import RealmSwift

protocol PersistenceProtocol {

    func save<T: Object>(items: T)
    func fetchData<T: Object>( type: T.Type) -> [T]
}
