import Foundation
import Combine

public class LanguageManager: ObservableObject {
    // Singleton instance
    public static let shared = LanguageManager()

    @Published var languageData: [String: String] = [:]

    private init() {
        // Load ngôn ngữ mặc định khi ứng dụng được khởi chạy
        let preferredLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "en"
        loadLanguage(preferredLanguage)
    }

    // Hàm để tải ngôn ngữ
    public func loadLanguage(_ language: String) {
        let fileName = language == "th" ? "th.json" : "en.json"
        if let url = Bundle.main.url(forResource: fileName, withExtension: ""),
           let data = try? Data(contentsOf: url) {
            if let json = try? JSONDecoder().decode([String: String].self, from: data) {
                languageData = json
            }
        }
    }

    // Hàm lấy chuỗi theo key
    public func localizedString(forKey key: String) -> String {
        return languageData[key] ?? key
    }
}
