//
//  Extension+Bundle.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/18.
//

import Foundation

extension Bundle {
  var omdbKey: String {
    guard let path = Bundle.main.url(forResource: "SecretInfo", withExtension: "plist") else {
      return ""
    }

    do {
      let data = try Data(contentsOf: path)

      guard let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
        return ""
      }

      guard let key = dict["OMDb_API_KEY"] as? String else {
        fatalError("SecretInfo.plist에 OMDb API Key를 설정해주세요.")
      }

      return key

    } catch {
      print(error)
      return ""
    }
  }

  var kobisKey: String {
    guard let path = Bundle.main.url(forResource: "SecretInfo", withExtension: "plist") else {
      return ""
    }

    do {
      let data = try Data(contentsOf: path)

      guard let dict = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String: Any] else {
        return ""
      }

      guard let key = dict["Kobis_API_KEY"] as? String else {
        fatalError("SecretInfo.plist에 Kobis API Key를 설정해주세요.")
      }

      return key

    } catch {
      print(error)
      return ""
    }
  }

}
