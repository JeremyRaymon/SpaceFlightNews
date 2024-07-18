//
//  SavedArticle.swift
//  SpaceFlightNews
//
//  Created by Jeremy Raymond on 18/07/24.
//

import Foundation

public class SavedArticle: NSSecureUnarchiveFromDataTransformer {
    let id: Int
    let title: String
    let imageUrl: String
    let newsSite: String
    let summary: String
    let publishedAt: Date
    
    init(id: Int, title: String, imageUrl: String, newsSite: String, summary: String, publishedAt: Date) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.newsSite = newsSite
        self.summary = summary
        self.publishedAt = publishedAt
    }
}

@objc(SavedArticleTransformer)
class SavedArticleTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let savedArticle = value as? SavedArticle else {
            print("\(#function) cast issue")
            return nil
        }
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: savedArticle, requiringSecureCoding: true)
            return data
        } catch {
            print(error)
            return nil
        }
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {
            print("\(#function) cast issue")
            return nil
        }
        
        do {
            let savedArticle = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [SavedArticle.self], from: data)
            return savedArticle
        } catch {
            print(error)
            return nil
        }
    }
}

//class SavedArticleTransformer: ValueTransformer {
//    override func transformedValue(_ value: Any?) -> Any? {
//        guard let savedArticle = value as? SavedArticle else {
//            print("\(#function) cast issue")
//            return nil
//        }
//        
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: savedArticle, requiringSecureCoding: true)
//            return data
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//    
//    override func reverseTransformedValue(_ value: Any?) -> Any? {
//        guard let data = value as? Data else {
//            print("\(#function) cast issue")
//            return nil
//        }
//        
//        do {
//            let savedArticle = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [SavedArticle.self], from: data)
//            return savedArticle
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
