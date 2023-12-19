//
//  RestApi.swift
//  RemoteHearingIOS
//
//  Created by 冯顺 on 2023/12/18.
//

import Foundation
import RxSwift
import RxCocoa
import ObjectMapper
import Moya
import Moya_ObjectMapper
import Alamofire

typealias MoyaError = Moya.MoyaError

enum ApiError: Error {
    case serverError(response: ErrorResponse)

    var title: String {
        switch self {
        case .serverError(let response): return response.message ?? ""
        }
    }

    var description: String {
        switch self {
        case .serverError(let response): return response.detail()
        }
    }
}

class RestApi: RemoteHearingAPI {
    let baseProvider: BaseNetworking
    
    init(baseProvider: BaseNetworking) {
        self.baseProvider = baseProvider
    }
}

extension RestApi {
    
}

extension RestApi {
    private func request(_ target: BaseAPI) -> Single<Any> {
        return baseProvider.request(target)
            .mapJSON()
            .observe(on: MainScheduler.instance)
            .asSingle()
    }

    private func requestWithoutMapping(_ target: BaseAPI) -> Single<Moya.Response> {
        return baseProvider.request(target)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }

    private func requestObject<T: BaseMappable>(_ target: BaseAPI, type: T.Type) -> Single<T> {
        return baseProvider.request(target)
            .mapObject(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }

    private func requestArray<T: BaseMappable>(_ target: BaseAPI, type: T.Type) -> Single<[T]> {
        return baseProvider.request(target)
            .mapArray(T.self)
            .observe(on: MainScheduler.instance)
            .asSingle()
    }
}
