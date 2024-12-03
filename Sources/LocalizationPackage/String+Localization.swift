//
//  File.swift
//  
//
//  Created by MrHoa on 3/12/24.
//

import Foundation

extension String {
    func localized() -> String {
        return LanguageManager.shared.localizedString(forKey: self)
    }
}
