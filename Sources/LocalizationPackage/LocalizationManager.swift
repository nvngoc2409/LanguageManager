//
//  File.swift
//  
//
//  Created by MrHoa on 3/12/24.
//

import Foundation
import SwiftUI

public enum HPLanguage: String, CaseIterable {
  case en
  case th

  public func name() -> String {
    switch self {
    case .en:
      return "English"
    case .th:
      return "Thai"
    }
  }

  public func value() -> String {
    switch self {
    case .en:
      return "en_US"
    case .th:
      return "th_TH"
    }
  }
}

public class LocalizationManager: ObservableObject {
  public static let shared = LocalizationManager()
  @Published var currentLocale: String {
    didSet {
      DispatchQueue.main.async {
        UserDefaults.standard.set(self.currentLocale, forKey: "currentLocale")
        UserDefaults.standard.synchronize()
      }
    }
  }

  public var locale: Locale {
    Locale(identifier: currentLocale)
  }

  private init() {
    if let savedLocale = UserDefaults.standard.string(forKey: "currentLocale") {
      self.currentLocale = savedLocale
    } else {
      self.currentLocale = "en"
    }
  }

  public func changeLanguage(to localeIdentifier: String) {
    DispatchQueue.main.async {
      self.currentLocale = localeIdentifier
    }
  }

  public func language() -> HPLanguage {
    return HPLanguage(rawValue: currentLocale) ?? .en
  }

  public var name: String {
    language().name()
  }

  public var value: String {
    language().value()
  }
}
