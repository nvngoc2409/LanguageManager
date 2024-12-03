//
//  File.swift
//
//
//  Created by MrHoa on 3/12/24.
//

import Foundation

private var bundleKey: UInt8 = 0

extension Bundle {
  private class BundleToken {}

  static var localizedBundle: Bundle? {
    get { objc_getAssociatedObject(BundleToken.self, &bundleKey) as? Bundle }
    set { objc_setAssociatedObject(BundleToken.self, &bundleKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
  }

  static func setLanguage(_ language: String) {
    if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
      localizedBundle = Bundle(path: path)
    } else {
      localizedBundle = nil
    }
  }

  public func localizedString(forKey key: String) -> String {
    return Bundle.localizedBundle?.localizedString(forKey: key, value: nil, table: nil) ?? key
  }
}
