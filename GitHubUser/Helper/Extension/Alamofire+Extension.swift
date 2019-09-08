//
//  Alamofire+Extension.swift
//  GitHubUser
//
//  Created by Ellie Kwon on 2019/09/08.
//  Copyright © 2019 Ellie Kwon. All rights reserved.
//

import Alamofire

extension DataRequest {
	
	/// Adds a handler to be called once the request has finished.
	///
	/// - Parameters:
	///   - queue:              The queue on which the completion handler is dispatched.
	///   - keyPath:            The key path where object mapping should be performed
	///   - completionHandler:  A closure to be executed once the request has finished and the data has been decoded by JSONDecoder.
	/// - Returns:              The request.
	@discardableResult
	public func responseObject<T: Codable>(queue: DispatchQueue? = nil, keyPath: String? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
		return response(queue: queue, responseSerializer: DataRequest.ObjectSerializer(keyPath), completionHandler: completionHandler)
	}
	
	/// Codable Object Serializer
	public static func ObjectSerializer<T: Codable>(_ keyPath: String?) -> DataResponseSerializer<T> {
		return DataResponseSerializer { request, response, data, error in
			
			if let error = error {
				return .failure(error)
			}
			
			// JSONへの変換
			let JSONObject = processResponse(request: request, response: response, data: data, keyPath: keyPath)
			if let JSONObject = JSONObject, let newData = try? JSONSerialization.data(withJSONObject: JSONObject, options: [.prettyPrinted]) {
				
				// JSONのスネークケースをDecodable Objectのキャメルケースにマッピング
				let decoder = JSONDecoder()
				decoder.keyDecodingStrategy = .convertFromSnakeCase
		
				// リクエスト時に指定したDecodalbe Objectへの変換
				if let object = try? decoder.decode(T.self, from: newData) {
					return .success(object)
				}
				
				return .failure(ApiError.Json)
			} else {
				return .failure(ApiError.Json)
			}
		}
	}
	
	/// Utility function for extracting JSON from response
	internal static func processResponse(request: URLRequest?, response: HTTPURLResponse?, data: Data?, keyPath: String?) -> Any? {
		let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
		let result = jsonResponseSerializer.serializeResponse(request, response, data, nil)
		
		let JSON: Any?
		if let keyPath = keyPath, keyPath.isEmpty == false {
			JSON = (result.value as AnyObject?)?.value(forKeyPath: keyPath)
		} else {
			JSON = result.value
		}
		
		return JSON
	}
}
