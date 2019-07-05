import XCTest
@testable import Globant3

class ModelUnitTests: XCTestCase {
    
    func testParseToModelNilWithIncorrectData() {
        //given
        let mock = MockNetworking()
        let expectation = XCTestExpectation(description: "Data parsed")
        mock.data = getDataInfo(from: "badInfo")
        
        //when
        mock.getModel() { model in
            if let _ = model {
                XCTFail()
            } else {
                XCTAssertNil(model)
            }
            expectation.fulfill()
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
