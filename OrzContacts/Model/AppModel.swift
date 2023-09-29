//
//  AppModel.swift
//  OrzContacts
//
//  Created by joker on 2023/9/28.
//

import SwiftUI
import Contacts

@Observable
final class AppModel {
    
    var contacts = [CNContact]()

    func fetchAllContacts() {
        
        CNContact.requestAuth { granted in
            
            guard granted else {
                return
            }
            
            CNContact.fetchAllContacts { contacts in
                self.contacts = contacts
            }
        }
    }
}

extension CNContact {
    
    static func requestAuth(completion: @escaping (Bool) -> Void) {
        
        guard CNContactStore.authorizationStatus(for: .contacts) == .authorized else {
            
            CNContactStore().requestAccess(for: .contacts) { granted, error in completion(granted) }
            
            return
        }
        
        completion(true)
        
    }
    
    static func fetchAllContacts(completion: @escaping ([CNContact]) -> Void) {
        DispatchQueue.global().async {
            let keys: [CNKeyDescriptor] = [
                CNContactGivenNameKey,
                CNContactMiddleNameKey,
                CNContactFamilyNameKey,
                CNContactNicknameKey
            ] as [CNKeyDescriptor];
            
            let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
            
            var contacts = [CNContact]()
            try? Self.store.enumerateContacts(with: fetchRequest) { contact, _ in
                contacts.append(contact)
            }
            completion(contacts)
        }
    }
}

extension CNContact {
    
    func refineGivenName() {
        refine { !$0.familyName.isEmpty && $0.givenName.hasPrefix($0.familyName) }?
            .log(prefix: "before: ")
            .modify(with: { newContact in
                newContact.givenName = self.givenName.replacingOccurrences(of: self.familyName, with: "")
            })?
            .log(prefix: "after: ")
    }
    
    func refineNickName() {
        refine { !$0.nickname.isEmpty}?
            .log(prefix: "before: ")
            .modify(with: { newContact in
                
            })?
            .log(prefix: "after: ")
    }
}

