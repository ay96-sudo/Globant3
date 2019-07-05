import XCTest
@testable import Globant3

class NetworkingUnitTests: XCTestCase {
    
    func testServiceResponseSuccess() {
        //given
        let session = MockURLSession()
        session.data = getDataInfo(from: "Info")
        session.response = HTTPURLResponse(url: URL(fileURLWithPath: "Info.json"), statusCode: 200, httpVersion: nil, headerFields: nil)
        session.error = nil
        let sut = Networking(session: session)
        let expectation = XCTestExpectation(description: "Loading")
        //when
        sut.getData(endpoint: "dummyEndpoint") { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            case .failure:
                XCTFail()
            }
        }
        //then
        wait(for: [expectation], timeout: 1)
    }
    
    func testNetworkingGetDataFetchError() {
        //given
        let session = MockURLSession()
        let expectation = XCTestExpectation(description: "Data not nil")
        session.data = nil
        session.error = nil
        guard let url = URL(string: "dummyURL") else {
            XCTFail("This is not an URL")
            return
        }
        session.response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let sut = Networking(session: session)
        //when
        sut.getData(endpoint: "dummyEndpoint") { result in
            switch result {
            case .success:
                XCTFail("The response should be a failure")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "fetch_error".localize())
                expectation.fulfill()
            }
        }
        //then
        wait(for: [expectation], timeout: 5)
    }
    
    func testLoadImageWithSuccess() {
        // given
        let sut = Networking()
        let expectation = XCTestExpectation(description: "Image load")
        guard let url = Bundle.main.url(forResource: "JW", withExtension: "jpg") else  {
            XCTFail()
            return
        }
        // when
        sut.getImage(from: url) { result in
            switch result {
            case .success:
                expectation.fulfill()
            case .failure:
                XCTFail("The image was corrupted")
            }
        }
        // then
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoadImageWithFailureInvalidData() {
        // given
        let mockSession = MockURLSession()
        let sut = Networking(session: mockSession)
        let expectation = XCTestExpectation(description: "Image load")
        guard let urlForInvalidImageData = Bundle.main.url(forResource: "Info", withExtension: "json") else  {
            XCTFail()
            return
        }
        // when
        sut.getImage(from: urlForInvalidImageData) { result in
            switch result {
            case .success:
                XCTFail("The image should not be returned")
            case .failure(let error):
                if error.localizedDescription == "invalid_error".localize() {
                    expectation.fulfill()
                }
                else {
                    XCTFail("This is not the expected error")
                }
            }
        }
        // then
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoadImageWithFailureFetchError() {
        // given
        let mockSession = MockURLSession()
        let sut = Networking(session: mockSession)
        let expectation = XCTestExpectation(description: "Image load")
        // when
        guard let url = URL(string: "http") else {
            XCTFail("The url is nil")
            return
        }
        sut.getImage(from: url) { result in
            switch result {
            case .success:
                XCTFail("The image should not be returned")
            case .failure(let error):
                if error.localizedDescription == "fetch_error".localize() {
                    expectation.fulfill()
                }
                else {
                    XCTFail("This is not the expected error")
                }
            }
        }
        // then
        wait(for: [expectation], timeout: 1)
    }
    
    func testDataTaskFailure() {
        //given
        let session = MockURLSession()
        session.data = nil
        session.response = nil
        session.error = NSError(domain: "Server error", code: 500, userInfo: nil)
        let network = Networking(session: session)
        let expectation = XCTestExpectation(description: "Loading")
        //when
        network.getData(endpoint: "dummyEndPoint"){ result in
            switch result {
            case .success:
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        //then
        wait(for: [expectation], timeout: 5)
    }

    
    // Helper methods
    func getDataInfo(from resource: String) -> Data {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else { fatalError() }
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        return data
    }
}
