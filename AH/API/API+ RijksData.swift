//
//  API+ RijksData.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import Foundation
import Alamofire

extension API {
    enum RijksData: RequestConvertible {
        case fetchCollection(parameters: BaseParameters)

        var path: String {
            switch self {
            case .fetchCollection(let parameters):
                return "/api/\((parameters.language ?? .en).rawValue)/collection"
            default:
                return ""
            }
        }
        
        var method: Network.Method {
            .get
        }
        
        var task: Network.Task {
            switch self {
            case .fetchCollection(let parameters):
                return .requestParameters(parameters: parameters.builder.make(), encoding: URLEncoding.queryString)
            default:
                return .requestPlain
            }
        }
    }
}
