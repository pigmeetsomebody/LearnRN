//
//  LookViewModel.swift
//  FashionInspiration
//
//  Created by 朱彦谕 on 2022/4/23.
//

import UIKit
import AFNetworking
import RealmSwift
class Observable<T> {
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T? = nil) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
//typealias APIFetchResultsCompletionHandler
class LookViewModel {
    var dataArray = Observable<Results<LookModel>>()
    func fetchDataFromLocalDBOrServer(_ isAPICall: Bool = false) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let realm = appDelegate.realm else { return }
        var data: Results<LookModel>?
        data = realm.objects(LookModel.self)
        if (data?.count ?? 0) > 0 {
            dataArray.value = data?.elements as? Results<LookModel>
            print(dataArray.value)
            
        }
        if isAPICall {
            fetchDataFromServer()
        }
    }
    
    func fetchDataFromServer() {
        let path = Bundle.main.path(forResource: "looks1056", ofType: "json")
        guard let path = path else {
            return
        }
        let json = FileManager.default.contents(atPath: path)
        guard let json = json else {
            return
        }
        let jsonArray = try? JSONSerialization.jsonObject(with: json, options: .fragmentsAllowed) as? [[String : Any]]
        print(jsonArray)
        try? LookModel.create(from: jsonArray ?? [])
        fetchDataFromLocalDBOrServer()
    }
}

extension Results {
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap { $0 as? T }
    }
}
