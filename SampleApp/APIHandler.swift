//
//  APIHandler.swift
//  SampleApp
//

import Foundation

enum APIError: Error {
    case InvalidRequestURL
    case ResponseDataInNil
    case InvalidResponseData
    case reason(_ msg: String)
}

class APIHandler {
    func fetchAllCurrencies(withCompletion completion: @escaping ([Currency]?, Error?) -> ()) {
        let urlString = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json"
        ConnectionHandler().startConnection(withUrlString: urlString) { data, error in
            if let data = data {
                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: String] {
                        var currencies = [Currency]()
                        for (key, value) in dict {
                            currencies.append(Currency(code: key, name: value))
                        }
                        completion(currencies, nil)
                    } else {
                        completion(nil, APIError.InvalidResponseData)
                    }
                    
                } catch {
                    completion(nil, error)
                }
            }
        }
    }
    
    /// 
    func fetchCurrencyValues(forBaseCurrency currency: Currency, forDate date: Date?, completion: @escaping ([CurrencyValue]?, Date?, Error?) -> ()) {
        
        var dateStr = "latest"
        if let date = date {
            dateStr = date.toReverseString()
        }
        
        let urlString = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/\(dateStr)/currencies/\(currency.code).json"
        ConnectionHandler().startConnection(withUrlString: urlString) { data, error in
            if let data = data {
                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] {
                        Logger.debug("\(dict)")
                        var _date: Date?
                        if let dateStr = dict["date"] as? String {
                            _date = Date.fromString(dateStr)
                        }
                        var currencyValues = [CurrencyValue]()
                        if let values = dict["\(currency.code)"] as? [String: Double] {
                            for (key, value) in values {
                                currencyValues.append(CurrencyValue(code: key, value: value))
                            }
                        }
                        completion(currencyValues, _date, nil)
                    } else {
                        completion(nil, nil, APIError.InvalidResponseData)
                    }
                    
                } catch {
                    completion(nil, nil, error)
                }
            }
        }
    }
}

struct Currency {
    var code: String
    var name: String
}
class CurrencyValue {
    let code: String
    let value: Double
    
    var name: String = ""
    
    init(code: String, value: Double) {
        self.code = code
        self.value = value
    }
}

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: self)
    }
    func toReverseString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
    static func fromString(_ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: dateString)
    }
}
