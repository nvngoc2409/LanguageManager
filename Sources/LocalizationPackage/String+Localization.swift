//
//  File.swift
//  
//
//  Created by MrHoa on 3/12/24.
//

import Foundation

extension String {
    public func localized() -> String {
        return LanguageManager.shared.localizedString(forKey: self)
    }
}
