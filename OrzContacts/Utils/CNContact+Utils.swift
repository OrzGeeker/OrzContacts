//
//  CNContact+Utils.swift
//  OrzContacts
//
//  Created by joker on 2023/9/28.
//

import Contacts

extension CNContact {
    
    typealias RefineFilter = (CNContact) -> Bool
    
    func refine(with filter: RefineFilter) -> CNContact? {
        
        guard filter(self) else {
            return nil
        }
        
        return self
    }
    
    typealias ModifyAction = (CNMutableContact) -> Void
    
    func modify(with Action: ModifyAction) -> CNMutableContact? {
        
        guard let mutableContact = self.mutableCopy() as? CNMutableContact
        else {
            return nil
        }
        
        Action(mutableContact)
        
        return mutableContact
        
    }
    
    open override var description: String {
        return "\(familyName) - \(givenName) - \(nickname)"
    }
    
    @discardableResult
    func log(prefix: String = "") -> CNContact {
        print(prefix + self.description)
        return self
    }
    
    static let store = CNContactStore()
}
