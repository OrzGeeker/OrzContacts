//
//  CNMutableContact+Utils.swift
//  OrzContacts
//
//  Created by joker on 2023/9/28.
//

import Contacts

extension CNMutableContact {
    
    func updateToStore() throws {
        
        let saveRequest = CNSaveRequest()
        saveRequest.update(self)
        
        try Self.store.execute(saveRequest)
    }
}
