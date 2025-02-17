//
//  Send Command.swift
//  Mlem
//
//  Created by David Bureš on 03.05.2023.
//

import Foundation
import SwiftyJSON

enum ConnectionError: Error
{
    case failedToEncodeAddress, receivedInvalidResponseFormat, failedToSendRequest
}
internal enum EncodingFailure: Error
{
    case failedToConvertURLToComponents, failedToSendRequest, failedToEncodeJSON
}

/// Send an authorized GET command to a specified endpoint with specified parameters
@MainActor
func sendGetCommand(appState: AppState, account: SavedAccount, endpoint: String, parameters: [URLQueryItem]) async throws -> String
{
    var finalURL: URL = account.instanceLink.appendingPathComponent(endpoint, conformingTo: .url)
    var finalParameters: [URLQueryItem] = parameters
    
    guard var urlComponents = URLComponents(url: finalURL, resolvingAgainstBaseURL: true) else
    {
        throw EncodingFailure.failedToConvertURLToComponents
    }
    
    finalParameters.append(URLQueryItem(name: "auth", value: account.accessToken))
    
    urlComponents.queryItems = finalParameters
    
    print("Will try to send these parameters: \(finalParameters)")
    
    finalURL = urlComponents.url!
    
    print("Final URL: \(finalURL)")
    
    var request: URLRequest = URLRequest(url: finalURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 20)
    request.httpMethod = "GET"
    
    do
    {
        let (data, response) = try await AppConstants.urlSession.data(for: request)
        
        let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
        
        print("Received response code \(httpResponse.statusCode)")
        
        if httpResponse.statusCode != 200
        {
            throw ConnectionError.receivedInvalidResponseFormat
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    catch let requestError
    {
        print("Failed while sending GET request: \(requestError)")
        
        appState.alertTitle = "Couldn't connect to Lemmy"
        appState.alertMessage = "Your network conneciton is either not stable enough, or the Lemmy server you're connected to is overloaded.\nTry again later."
        appState.isShowingAlert.toggle()
        
        throw ConnectionError.failedToSendRequest
    }
}

/// Send a GET request to specific endpoint at a specific URL, without authorization
@MainActor
func sendGetCommand(appState: AppState, baseURL: URL, endpoint: String, parameters: [URLQueryItem]) async throws -> String
{
    var finalURL: URL = baseURL.appendingPathComponent(endpoint, conformingTo: .url)
    var finalParameters: [URLQueryItem] = parameters
    
    guard var urlComponents = URLComponents(url: finalURL, resolvingAgainstBaseURL: true) else
    {
        throw EncodingFailure.failedToConvertURLToComponents
    }
    
    urlComponents.queryItems = finalParameters
    
    print("Will try to send these parameters: \(finalParameters)")
    
    finalURL = urlComponents.url!
    
    print("Final URL: \(finalURL)")
    
    var request: URLRequest = URLRequest(url: finalURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 20)
    request.httpMethod = "GET"
    
    do
    {
        let (data, response) = try await AppConstants.urlSession.data(for: request)
        
        let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
        
        print("Received response code \(httpResponse.statusCode)")
        
        if httpResponse.statusCode != 200
        {
            throw ConnectionError.receivedInvalidResponseFormat
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    catch let requestError
    {
        print("Failed while sending GET request: \(requestError)")
        
        appState.alertTitle = "Couldn't connect to Lemmy"
        appState.alertMessage = "Your network conneciton is either not stable enough, or the Lemmy server you're connected to is overloaded.\nTry again later."
        appState.isShowingAlert.toggle()
        
        throw ConnectionError.failedToSendRequest
    }
}

/// Send an authorized POST command to a specified endpoint with specified arguments in the body
/// The arguments get serialized into JSON
@MainActor
func sendPostCommand(appState: AppState, account: SavedAccount, endpoint: String, arguments: [String: Any]) async throws -> String
{
    var finalURL: URL = account.instanceLink.appendingPathComponent(endpoint, conformingTo: .url)
    
    print("Request will be sent to url \(finalURL)")
    
    var finalArguments = arguments
    finalArguments.updateValue(account.accessToken, forKey: "auth") /// Add the "auth" field to the arguments
    
    var request: URLRequest = URLRequest(url: finalURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 20)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonData = try! JSONSerialization.data(withJSONObject: finalArguments)
    
    request.httpBody = jsonData as Data
    
    do
    {
        let (data, response) = try await AppConstants.urlSession.data(for: request)
        
        let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
        
        print("Received response code \(httpResponse.statusCode)")
        
        if httpResponse.statusCode != 200
        {
            throw ConnectionError.receivedInvalidResponseFormat
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    catch let requestError
    {
        print("Failed while sending POST request: \(requestError)")
        
        if requestError as! ConnectionError == ConnectionError.receivedInvalidResponseFormat
        {
            appState.alertTitle = "Request rejected by server"
            appState.alertMessage = "For some reason, the Lemmy server you're connected to rejected this request."
        }
        else
        {
            appState.alertTitle = "Couldn't connect to Lemmy"
            appState.alertMessage = "Your network conneciton is either not stable enough, or the Lemmy server you're connected to is overloaded.\nTry again later."
        }
        
        appState.isShowingAlert.toggle()
        
        throw ConnectionError.failedToSendRequest
    }
}

/// Send a POST command to a specified endpoint with specified arguments in the body, without authorization
@MainActor
func sendPostCommand(appState: AppState, baseURL: URL, endpoint: String, arguments: [String: Any]) async throws -> String
{
    var finalURL: URL = baseURL.appendingPathComponent(endpoint, conformingTo: .url)
    
    print("Request will be sent to url \(finalURL)")
    
    var request: URLRequest = URLRequest(url: finalURL, cachePolicy: .reloadRevalidatingCacheData, timeoutInterval: 20)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let jsonData = try! JSONSerialization.data(withJSONObject: arguments)
    
    print("Will use this JSON body: \(String(describing: String(data: jsonData, encoding: .utf8)))")
    
    request.httpBody = jsonData as Data
    
    do
    {
        let (data, response) = try await AppConstants.urlSession.data(for: request)
        
        let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
        
        print("Received response code \(httpResponse.statusCode)")
        
        if httpResponse.statusCode != 200
        {
            throw ConnectionError.receivedInvalidResponseFormat
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    catch let requestError
    {
        print("Failed while sending POST request: \(requestError)")
        
        appState.alertTitle = "Couldn't connect to Lemmy"
        appState.alertMessage = "Your network conneciton is either not stable enough, or the Lemmy server you're connected to is overloaded.\nTry again later."
        appState.isShowingAlert.toggle()
        
        throw ConnectionError.failedToSendRequest
    }
}
