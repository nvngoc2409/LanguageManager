import Foundation
import Combine

public class LanguageManager: ObservableObject {
    public static let shared = LanguageManager()

    @Published var languageData: [String: String] = [:]

    private init() {
        let preferredLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
        loadLanguage(preferredLanguage)
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
          print("Loaded language data for \(language): \(json)")
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
}
