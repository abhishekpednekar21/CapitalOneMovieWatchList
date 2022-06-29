//
//  Repository.swift
//  MovieWatchListDemo
//
//  Created by Abdul Rahman on 2022-06-28.
//

import Foundation

protocol Repository {
    associatedtype T: Codable
    static var storageKey: String { get }
    func getAll() -> [T]
    func get(id: String) -> T?
    func set(record: T)
}

extension Repository {
    func getAll() -> [T] {
        let savedArray = UserDefaults.standard.object(forKey: Self.storageKey) ?? []
        if let typedArray = savedArray as? [T] {
            return typedArray
        } else if let dataArray = savedArray as? [Data] {
            let decoder = PropertyListDecoder()
            let decodedArray = dataArray.map({ try? decoder.decode(T.self, from: $0 ) })
            return (decodedArray as? [T]) ?? []
        }else if let data = savedArray as? Data{
            let decoder = PropertyListDecoder()
            guard let decodedArray = try? decoder.decode([Movies].self, from: data) else {
                    return []
                }
            return (decodedArray as? [T]) ?? []
        }
        return []
    }
}
