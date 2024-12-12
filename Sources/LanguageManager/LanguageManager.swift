import Foundation
import Combine

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

public class LanguageManager: ObservableObject {
  public static let shared = LanguageManager()

  @Published var languageData: [String: String] = [:]
  var currentLocale: String {
    didSet {
      DispatchQueue.main.async {
        UserDefaults.standard.set(self.currentLocale, forKey: "currentLocale")
        UserDefaults.standard.synchronize()
      }
    }
  }

  private init() {
    if let savedLocale = UserDefaults.standard.string(forKey: "currentLocale") {
      self.currentLocale = savedLocale
    } else {
      self.currentLocale = "en"
    }
    self.loadLanguage(self.value)
  }

  public func changeLanguage(to localeIdentifier: String) {
    DispatchQueue.main.async {
      self.currentLocale = localeIdentifier
      self.loadLanguage(self.value)
    }
  }

  public func loadLanguage(_ language: String) {
    let filePath = "languages/\(language)/lang.json"

    guard let resourcePath = Bundle.module.resourcePath,
          let fullPath = URL(string: resourcePath)?.appendingPathComponent(filePath).path else {
      print("Resource path not found")
      return
    }

    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: fullPath))
      if let json = try? JSONDecoder().decode([String: String].self, from: data) {
        languageData = json
      } else {
        print("Failed to decode language file: \(filePath)")
      }
    } catch {
      print("Error loading language file: \(error.localizedDescription)")
    }
  }

  public func localizedString(forKey key: String) -> String {
    return languageData[key] ?? key
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
