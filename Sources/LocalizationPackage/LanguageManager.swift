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
        let fileName = language == "th" ? "th.json" : "en.json"
        if let url = Bundle.main.url(forResource: fileName, withExtension: ""),
           let data = try? Data(contentsOf: url) {
            if let json = try? JSONDecoder().decode([String: String].self, from: data) {
                languageData = json
            }
        }
    }

    public func localizedString(forKey key: String) -> String {
        return languageData[key] ?? key
    }
}
