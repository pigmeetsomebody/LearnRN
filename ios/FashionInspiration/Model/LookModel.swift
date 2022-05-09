//
//  LookModel.swift
//  FashionInspiration
//
//  Created by 朱彦谕 on 2022/4/23.
//

import RealmSwift

@objcMembers
class UserInfo: Object {
    dynamic var username: String!
    dynamic var avatar: String!
    dynamic var homePage: String!
    
}

@objcMembers
class LookModel: Object {
    dynamic var userInfo: UserInfo?
    dynamic var lookID: String!
    dynamic var lookPhoto: String!
    dynamic var isFavourite: Bool!
    dynamic var hypeCount: Int = 0
    dynamic var hashTags: List<String>?
    override static func primaryKey() -> String? {
        return "lookID"
    }
}

extension LookModel {
    class func create(from jsonResponse: [[String : Any]]) throws {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let appDelegate = appDelegate, let realm = appDelegate.realm else { return }
        do {
            realm.beginWrite()
            for json in jsonResponse {
                appDelegate.realm?.create(LookModel.self, value: json, update: .all)
            }
            try realm.commitWrite()
        } catch {
            throw error
        }
    }
    
    class func updateFavourite(_ look: LookModel) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let appDelegate = appDelegate, let realm = appDelegate.realm else { return }
        try? realm.write({
            look.isFavourite.toggle()
            realm.add(look, update: .all)
        })
    }
    
    
}
