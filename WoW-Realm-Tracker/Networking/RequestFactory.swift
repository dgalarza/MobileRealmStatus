import Foundation

let requestUrl = NSURL(string: "https://us.api.battle.net/wow/")

func baseRequest(endpoint endpoint: String, apiKey: String = BlizzardAPIKey) -> NSMutableURLRequest {
    let endpointWithApiToken = "\(endpoint)?apikey=\(apiKey)"
    let url = NSURL(string: endpointWithApiToken, relativeToURL: requestUrl)!
    let request = NSMutableURLRequest(URL: url)

    return request
}
