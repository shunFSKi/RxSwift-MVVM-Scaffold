//
//  BaseAPI.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/18.
//

import Foundation
import RxSwift
import Moya
import Alamofire

protocol ProductAPIType {
    var addXAuth: Bool { get }
}

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

enum BaseAPI {
//case <#case#>
}

extension BaseAPI: TargetType, ProductAPIType {
    var task: Moya.Task {
        return .requestPlain
    }
    
    var baseURL: URL {
        return Configs.Network.githubBaseUrl.url!
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var addXAuth: Bool {
        return false
    }
    
    
}
