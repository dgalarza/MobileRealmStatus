import Nimble

public func includeQueryString(queryString: String) -> NonNilMatcherFunc<NSURLRequest> {
    return NonNilMatcherFunc { actual, failure in
        let query = try actual.evaluate()?.URL?.query ?? ""

        failure.expected = "expected \(query)"
        failure.postfixMessage = "to include <\(queryString)>"
        failure.actualValue = .None

        return query.containsString(queryString)
    }
}
