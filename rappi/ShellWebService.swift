//
//  ShellWebService.swift
//  rappi
//
//  Created by Leonardo Simoza on 28/1/17.
//  Copyright © 2017 Rappi. All rights reserved.
//
/*
import Foundation
import Alamofire
import SwiftyJSON
//import KVNProgress

class ShellWebService : Service {

    func selectWebService(service:String, params:[String:AnyObject]?, returnService: ((_ method: HTTPMethod, _ serviceUrl: String?, _ typeEncoding: ParameterEncoding) -> Void)){
        
        var app:App?
        
        switch service {
        case GlobalConstants.nameServices.getTopFreeApps:
            let limit = app?.limit
            let url = GlobalConstants.Dev.getTopFreeAppsWithLimit(limit: limit! as! String)
            returnService(.get,url, JSONEncoding())
            break
        default:
            break
        }
    }
    
    func settingHeader()->[String : String]?{
        
        let header:[String : String]? = nil
        
        return header
    }
    
    func editParameters(parameters: [String : AnyObject]?)->[String : AnyObject]?{
        
        var parametersEdited:[String : AnyObject] = [:]
        if parameters != nil{
            parametersEdited = parameters!
        }
        
        return parametersEdited
        
    }

    func callServiceObject(parameters:[String: AnyObject]?,service:String, withCompletionBlock: @escaping ((AnyObject?, _ error: NSError?) -> Void)){
        
        selectWebService(service: service, params:parameters,  returnService: { (method, url, typeEncoding) -> Void in
            
            let headers = settingHeader()
            let parametersEdited = self.editParameters(parameters: parameters)
            
            print("-----------------------")
            print(url ?? "nil")
            print(parametersEdited ?? "nil params")
            print(headers ?? "nil headers")
            print("-----------------------")
            
            
            Alamofire.request(url!, method: method, parameters: parametersEdited, encoding: typeEncoding, headers:headers)
                .validate(statusCode: 200..<500)
                .responseObject{ (response: DataResponse<JSONResponse>) in
                    print(response.response?.statusCode ?? "nil status code")
                    
                    
                    
                    
                    if let statusCode = response.response?.statusCode, statusCode == 401 && !self.isLogin {
                        let error:NSError = NSError(domain: GlobalConstants.errorDomain, code: statusCode, userInfo: ["message":"unathorized".localized])
                        withCompletionBlock(nil, error)
                        return
                    }
                    
                    switch response.result{
                    case .success:
                        let code = response.response!.statusCode
                        
                        if code <= 299{
                            withCompletionBlock(response.result.value,nil)
                        }else{
                            let error:NSError = NSError(domain: GlobalConstants.errorDomain, code: code, userInfo: ["message":response.result.value!.message!, "title" : response.result.value?.title ?? ""])
                            withCompletionBlock(nil,error)
                        }
                        break
                        
                    case .failure:
                        let code = (response.result.error as! NSError).code
                        print(response.result.error!.localizedDescription)
                        
                        let error:NSError = NSError(domain: GlobalConstants.errorDomain, code: code, userInfo: ["message": "serverError".localized])
                        
                        withCompletionBlock(nil,error)
                        break
                    }//Switch
            }//Alamofire
        })//SelectWebService
    }//Function
    
    /*
    func callServiceObject(url:String, method: HTTPMethod, parameters:[String: Any]?, headers:[String:String]?, withCompletionBlock:@escaping ((AnyObject?, NSError?) -> Void)) {
        
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: JSONEncoding(), headers: headers).responseJSON(completionHandler: { response in
            
            if let statusCode = response.response?.statusCode, statusCode == 401 {
                let error:NSError = NSError(domain: GlobalConstants.errorDomain, code: statusCode, userInfo: ["message":"unathorized"])
                withCompletionBlock(nil, error)
                return
            }
            
            switch response.result {
                
            case .success:
                guard let unwrappedData = response.data else {
                    var code = 500
                    if let unwrappedCode = response.response?.statusCode {
                        code = unwrappedCode
                    }
                    let error = NSError(domain: GlobalConstants.errorDomain, code: code, userInfo: ["message": "data is nil"])
                    withCompletionBlock(nil, error)
                    return
                }
                
                let json = try? JSONSerialization.jsonObject(with: unwrappedData)
                
                if let dictionary = json as? [String:AnyObject] {
                    withCompletionBlock(dictionary as AnyObject?, nil)
                    return
                } else if let array = json as? [AnyObject] {
                    withCompletionBlock(array as AnyObject?, nil)
                    return
                } else {
                    let error = NSError(domain: GlobalConstants.errorDomain, code: 500, userInfo: ["message": "json format not available"])
                    withCompletionBlock(nil, error)
                }
                break
            case .failure:
                let code = (response.result.error as! NSError).code
                print(response.result.error!.localizedDescription)
                let error:NSError = NSError(domain: GlobalConstants.errorDomain, code: code, userInfo: ["message": "errorServer".localized])
                withCompletionBlock(nil,error)
                break
                
            }
            
        })
        
    }*/
}*/
