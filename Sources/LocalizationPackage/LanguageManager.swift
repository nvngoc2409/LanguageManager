//
//  File.swift
//  
//
//  Created by MrHoa on 3/12/24.
//

import Foundation

public class LanguageManager: ObservableObject {
    @Published public var currentLanguage: String

    public init() {
        self.currentLanguage = UserDefaults.standard.stringArray(forKey: "AppleLanguages")?.first ?? "en"
        setLanguage(self.currentLanguage)
    }

    public func setLanguage(_ language: String) {
        self.currentLanguage = language

        // Lưu vào UserDefaults
        UserDefaults.standard.set([language], forKey: "AppleLanguages")
        UserDefaults.standard.synchronize()

        // Cập nhật bundle ngôn ngữ
        Bundle.setLanguage(language)
    }

  public func localizedString(forKey key: String) -> String {
    return Bundle.main.localizedString(forKey: key)
  }
}
